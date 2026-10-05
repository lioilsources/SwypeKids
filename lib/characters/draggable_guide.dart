import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

import '../services/settings_service.dart';
import '../world/world_clock.dart';
import 'mascot.dart';

/// Překážka, které se průvodce vyhýbá; [weight] říká, jak moc vadí
/// (klávesy víc než karta).
typedef GuideObstacle = ({Rect rect, double weight});

/// Místo, kde průvodce nesmí zůstat stát (uzel lekce na mapě, lišta…).
/// Obalí widget a přihlásí ho [DraggableGuide] na stejné obrazovce.
class GuideAvoid extends StatefulWidget {
  final Widget child;
  final double weight;

  const GuideAvoid({super.key, required this.child, this.weight = 3});

  static final Set<_GuideAvoidState> _all = {};

  /// Překážky z obrazovky (route) [context] v globálních souřadnicích.
  static List<GuideObstacle> obstaclesIn(BuildContext context) {
    final route = ModalRoute.of(context);
    return [
      for (final s in _all)
        if (s.mounted && s._route == route)
          if (s.context.findRenderObject() case final RenderBox box
              when box.attached && box.hasSize)
            (
              rect: box.localToGlobal(Offset.zero) & box.size,
              weight: s.widget.weight
            ),
    ];
  }

  @override
  State<GuideAvoid> createState() => _GuideAvoidState();
}

class _GuideAvoidState extends State<GuideAvoid> {
  ModalRoute<Object?>? _route;

  @override
  void initState() {
    super.initState();
    GuideAvoid._all.add(this);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _route = ModalRoute.of(context);
  }

  @override
  void dispose() {
    GuideAvoid._all.remove(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.child;
}

/// Průvodce na ploše (mapa i hra — všude se chová stejně):
/// - dítě ho může prstem přesunout kamkoli; když ho pustí přes kartu,
///   klávesy nebo lekci, pomalu odejde na nejbližší volné místo;
/// - ťuknutí = zamává (řeší volající přes [onTickle] + [replay]);
/// - po chvíli klidu si sedne a čte, v noci spí.
/// Pozice (podíl šířky/výšky) se pamatuje pro každé místo [place]
/// v [SettingsService].
///
/// Patří do `Stack` přes celou obrazovku (vyplní ho sám).
class DraggableGuide extends StatefulWidget {
  final MascotMood mood;
  final VoidCallback? onSettled;
  final VoidCallback? onTickle;

  /// Viz [Mascot.replay].
  final int replay;

  /// Překážky v globálních souřadnicích navíc k [GuideAvoid]; čtou se po
  /// každém layoutu.
  final List<GuideObstacle> Function()? obstacles;

  /// Pod jakým klíčem se pamatuje pozice (`game`, `map`).
  final String place;

  /// Klíč vnitřního [Mascot] (testy).
  final Key? mascotKey;

  /// Změna hodnoty (např. index lekce) = rozložení se mohlo změnit,
  /// průvodce se znovu podívá, jestli nepřekáží.
  final Object? layoutToken;

  const DraggableGuide({
    super.key,
    required this.mood,
    required this.place,
    this.obstacles,
    this.mascotKey,
    this.onSettled,
    this.onTickle,
    this.replay = 0,
    this.layoutToken,
  });

  /// Velikost postavy podle kratší strany: telefon ~78 px, tablet až 110 px.
  static double sizeFor(Size screen) =>
      (screen.shortestSide * 0.2).clamp(60.0, 110.0);

  /// Rozměr boxu widgetu [Mascot] pro danou velikost.
  static Size boxFor(double size) => Size(size * 1.5, size * 1.2);

  /// Nejlepší místo pro box [box] na ploše [area]: zůstane na [from], pokud
  /// skoro nic nezakrývá, jinak nejbližší místo s nejmenším překryvem.
  static Offset resolve({
    required Offset from,
    required Size box,
    required Size area,
    required List<GuideObstacle> obstacles,
  }) {
    final maxX = max(0.0, area.width - box.width);
    final maxY = max(0.0, area.height - box.height);
    Offset clamp(Offset p) =>
        Offset(p.dx.clamp(0.0, maxX), p.dy.clamp(0.0, maxY));

    double cover(Offset p) {
      final r = p & box;
      var sum = 0.0;
      for (final o in obstacles) {
        final i = r.intersect(o.rect);
        if (i.width > 0 && i.height > 0) sum += i.width * i.height * o.weight;
      }
      return sum;
    }

    final start = clamp(from);
    // Drobné zavadění okrajem nevadí (≤ 3 % plochy).
    if (cover(start) <= box.width * box.height * 0.03) return start;

    const step = 12.0;
    var best = start;
    var bestCost = double.infinity;
    for (var y = 0.0; y <= maxY + 0.1; y += step) {
      for (var x = 0.0; x <= maxX + 0.1; x += step) {
        final p = Offset(min(x, maxX), min(y, maxY));
        final cost = cover(p) * 1000 + (p - start).distance;
        if (cost < bestCost) {
          bestCost = cost;
          best = p;
        }
      }
    }
    return best;
  }

  @override
  State<DraggableGuide> createState() => _DraggableGuideState();
}

class _DraggableGuideState extends State<DraggableGuide> {
  Offset? _pos; // levý horní roh v souřadnicích plochy
  bool _dragging = false;
  bool _slow = false; // probíhá pomalé uhnutí
  Size _area = Size.zero;

  @override
  void didUpdateWidget(covariant DraggableGuide old) {
    super.didUpdateWidget(old);
    if (old.layoutToken != widget.layoutToken) _scheduleResolve(slow: true);
    if (old.mood != widget.mood || old.replay != widget.replay) _restartIdle();
  }

  void _scheduleResolve({required bool slow}) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted && !_dragging) _resolve(slow: slow);
    });
  }

  Size get _box => DraggableGuide.boxFor(DraggableGuide.sizeFor(_area));

  // Po chvíli klidu si sedne a čte (jako na mapě, tak ve hře).
  static const readAfter = Duration(seconds: 20);
  Timer? _readTimer;
  bool _reading = false;

  void _restartIdle() {
    _readTimer?.cancel();
    _reading = false;
    if (widget.mood != MascotMood.idle) return;
    _readTimer = Timer(readAfter, () {
      if (mounted) setState(() => _reading = true);
    });
  }

  @override
  void initState() {
    super.initState();
    _restartIdle();
  }

  @override
  void dispose() {
    _readTimer?.cancel();
    super.dispose();
  }

  /// Co postava právě ukazuje: reakce má přednost; v klidu v noci spí,
  /// jinak po chvíli čte.
  MascotMood _shownMood(bool night) {
    if (widget.mood != MascotMood.idle) return widget.mood;
    if (night) return MascotMood.sleep;
    return _reading ? MascotMood.read : MascotMood.idle;
  }

  void _resolve({required bool slow}) {
    final me = context.findRenderObject() as RenderBox?;
    final pos = _pos;
    if (me == null || !me.hasSize || pos == null) return;
    final origin = me.localToGlobal(Offset.zero);
    final obstacles = [
      for (final o in [
        ...?widget.obstacles?.call(),
        ...GuideAvoid.obstaclesIn(context),
      ])
        (rect: o.rect.shift(-origin), weight: o.weight),
    ];
    final next = DraggableGuide.resolve(
        from: pos, box: _box, area: _area, obstacles: obstacles);
    if (next == pos) return;
    setState(() {
      _slow = slow;
      _pos = next;
    });
    _save();
  }

  void _save() {
    final pos = _pos;
    if (pos == null) return;
    final free = Size(max(1.0, _area.width - _box.width),
        max(1.0, _area.height - _box.height));
    SettingsService.instance.setGuidePosition(
        widget.place, Offset(pos.dx / free.width, pos.dy / free.height));
  }

  @override
  Widget build(BuildContext context) {
    final reduceMotion = MediaQuery.of(context).disableAnimations;
    return LayoutBuilder(builder: (context, constraints) {
      final area = constraints.biggest;
      if (area != _area) {
        _area = area;
        // První umístění podle uložené pozice (výchozí vpravo dole); po
        // layoutu (i po otočení) se ověří, že nepřekáží.
        final f = SettingsService.instance.guidePositionFor(widget.place) ??
            const Offset(1, 1);
        _pos = Offset(f.dx * max(0.0, area.width - _box.width),
            f.dy * max(0.0, area.height - _box.height));
        _slow = false;
        _scheduleResolve(slow: false);
      }
      final size = DraggableGuide.sizeFor(area);
      final pos = _pos!;
      return Stack(
        children: [
          AnimatedPositioned(
            duration: _dragging || !_slow || reduceMotion
                ? Duration.zero
                : const Duration(milliseconds: 1400),
            curve: Curves.easeInOut,
            onEnd: () => _slow = false,
            left: pos.dx,
            top: pos.dy,
            child: GestureDetector(
              key: const ValueKey('guide-drag'),
              behavior: HitTestBehavior.opaque,
              onPanStart: (_) => setState(() => _dragging = true),
              onPanUpdate: (d) => setState(() {
                final maxX = max(0.0, _area.width - _box.width);
                final maxY = max(0.0, _area.height - _box.height);
                final p = _pos! + d.delta;
                _pos = Offset(p.dx.clamp(0.0, maxX), p.dy.clamp(0.0, maxY));
              }),
              onPanEnd: (_) {
                setState(() => _dragging = false);
                _save();
                _scheduleResolve(slow: true);
              },
              child: AnimatedScale(
                // Zvednutá postava je o kousek větší.
                scale: _dragging ? 1.12 : 1,
                duration: const Duration(milliseconds: 150),
                child: ListenableBuilder(
                  listenable: WorldClockService.instance,
                  builder: (context, _) => Mascot(
                    key: widget.mascotKey,
                    mood: _shownMood(WorldClockService.instance.theme.isNight),
                    size: size,
                    onSettled: widget.onSettled,
                    onTickle: widget.onTickle,
                    replay: widget.replay,
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    });
  }
}
