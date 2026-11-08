import 'dart:math';
import 'dart:ui' show PathMetric;

import 'package:flutter/material.dart';

import '../ui/emoji_art.dart';
import 'world_clock.dart';

/// Cestička mezi uzly lekcí jedné jednotky: vine se od uzlu k uzlu, kolem
/// kvete louka (kytky a tráva se vlní ve větru) a po okraji cupitají
/// zvířátka biotopu. Prošlá část cesty je prosvětlená.
///
/// Geometrie odpovídá sloupci uzlů v `_UnitBlock`: řádek [rowHeight], uzel
/// [nodeSize] zarovnaný střídavě na `±`[sway]. Nereaguje na dotyk. V noci
/// zvířátka spí a louka se nehýbe; při redukci pohybu je všechno v klidu.
class MeadowTrail extends StatefulWidget {
  final int count;

  /// Kolik lekcí je hotových — po tenhle uzel je cesta prošlá.
  final int walked;
  final Biome biome;
  final WorldTheme theme;

  /// Zamčená jednotka (v mlze): jen tichá cesta, žádná zvířátka.
  final bool active;

  final double rowHeight;
  final double nodeSize;
  final double sway;

  const MeadowTrail({
    super.key,
    required this.count,
    required this.walked,
    required this.biome,
    required this.theme,
    this.active = true,
    this.rowHeight = 92,
    this.nodeSize = 64,
    this.sway = 0.35,
  });

  /// Zvířátka, která po cestě běhají (`fly` = létá, jinak hopká).
  static List<(String, bool)> walkersOf(Biome b) => switch (b) {
        Biome.meadow => [('🐰', false), ('🦋', true)],
        Biome.forest => [('🦊', false), ('🦔', false)],
        Biome.pond => [('🦆', false), ('🐸', false)],
        Biome.garden => [('🐌', false), ('🐝', true)],
        Biome.farm => [('🐓', false), ('🐑', false)],
        Biome.city => [('🐶', false), ('🐦', true)],
        Biome.mountains => [('🐐', false), ('🦅', true)],
        Biome.beach => [('🦀', false), ('🐢', false)],
        Biome.orchard => [('🐿️', false), ('🐝', true)],
        Biome.snow => [('🐧', false), ('🐰', false)],
        Biome.jungle => [('🐒', false), ('🦜', true)],
        Biome.sky => [('🐦', true), ('🦋', true)],
      };

  /// Středy uzlů v ploše [size] (stejný výpočet jako `Align` v mapě).
  static List<Offset> nodeCenters(
      Size size, int count, double rowHeight, double nodeSize, double sway) {
    return [
      for (var i = 0; i < count; i++)
        Offset(
          (size.width - nodeSize) * ((i.isEven ? -sway : sway) + 1) / 2 +
              nodeSize / 2,
          i * rowHeight + 6 + nodeSize / 2,
        ),
    ];
  }

  @override
  State<MeadowTrail> createState() => _MeadowTrailState();
}

class _MeadowTrailState extends State<MeadowTrail>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 24),
  );

  bool get _moving =>
      widget.active &&
      !widget.theme.isNight &&
      !MediaQuery.of(context).disableAnimations;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _sync();
  }

  @override
  void didUpdateWidget(covariant MeadowTrail oldWidget) {
    super.didUpdateWidget(oldWidget);
    _sync();
  }

  void _sync() {
    if (_moving && !_ctrl.isAnimating) {
      _ctrl.repeat();
    } else if (!_moving && _ctrl.isAnimating) {
      _ctrl.stop();
    }
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: RepaintBoundary(
        child: LayoutBuilder(builder: (context, box) {
          final size = Size(box.maxWidth, box.maxHeight);
          final geo = _TrailGeometry.of(size, widget);
          return Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned.fill(
                child: CustomPaint(
                  painter: _TrailPainter(
                    geo: geo,
                    t: _ctrl,
                    theme: widget.theme,
                    biome: widget.biome,
                    walked: widget.walked,
                  ),
                ),
              ),
              if (widget.active && geo.length > 0)
                for (final (i, (emoji, fly))
                    in MeadowTrail.walkersOf(widget.biome).indexed)
                  _Walker(
                    key: ValueKey('trail-walker-$i'),
                    geo: geo,
                    t: _ctrl,
                    emoji: emoji,
                    fly: fly,
                    index: i,
                    asleep: widget.theme.isNight,
                  ),
            ],
          );
        }),
      ),
    );
  }
}

/// Křivka cesty + předpočítaná místa pro kytky (deterministicky, ať se
/// louka mezi snímky nepřeskupuje).
class _TrailGeometry {
  final Path path;
  final PathMetric? metric;
  final List<double> nodeOffsets;
  final List<Offset> nodes;
  final List<_Bloom> blooms;

  _TrailGeometry(
      this.path, this.metric, this.nodeOffsets, this.nodes, this.blooms);

  double get length => metric?.length ?? 0;

  static final Map<(Size, int, Biome), _TrailGeometry> _cache = {};

  static _TrailGeometry of(Size size, MeadowTrail w) {
    final key = (size, w.count, w.biome);
    return _cache[key] ??= () {
      if (_cache.length > 64) _cache.clear();
      return _build(size, w);
    }();
  }

  static _TrailGeometry _build(Size size, MeadowTrail w) {
    final nodes =
        MeadowTrail.nodeCenters(size, w.count, w.rowHeight, w.nodeSize, w.sway);
    final mid = size.width / 2;
    final points = [Offset(mid, 0), ...nodes, Offset(mid, size.height)];
    final path = Path()..moveTo(points.first.dx, points.first.dy);
    final nodeOffsets = <double>[];
    var length = 0.0;
    for (var i = 1; i < points.length; i++) {
      final a = points[i - 1], b = points[i];
      final dy = (b.dy - a.dy) * 0.55;
      final seg = Path()
        ..moveTo(a.dx, a.dy)
        ..cubicTo(a.dx, a.dy + dy, b.dx, b.dy - dy, b.dx, b.dy);
      path.cubicTo(a.dx, a.dy + dy, b.dx, b.dy - dy, b.dx, b.dy);
      final m = seg.computeMetrics().toList();
      length += m.isEmpty ? 0 : m.first.length;
      if (i <= nodes.length) nodeOffsets.add(length);
    }
    final metrics = path.computeMetrics().toList();
    final metric = metrics.isEmpty ? null : metrics.first;

    final rnd = Random(w.biome.index * 7 + w.count);
    final blooms = <_Bloom>[];
    if (metric != null) {
      // Lem cesty: kytka nebo trs trávy každých ~18 px, střídavě po stranách.
      for (var d = 8.0; d < metric.length; d += 14 + rnd.nextDouble() * 10) {
        final tan = metric.getTangentForOffset(d);
        if (tan == null) continue;
        final normal = Offset(-tan.vector.dy, tan.vector.dx);
        final side = rnd.nextBool() ? 1.0 : -1.0;
        final p = tan.position + normal * side * (20 + rnd.nextDouble() * 18);
        if (_nearNode(p, nodes, w.nodeSize * 0.62)) continue;
        blooms.add(_Bloom.random(p, rnd));
      }
      // Volná louka kolem: pár dalších kytek, mimo uzly a mimo cestu.
      final extra = (size.width * size.height / 2600).round();
      for (var i = 0; i < extra; i++) {
        final p = Offset(
            rnd.nextDouble() * size.width, rnd.nextDouble() * size.height);
        if (_nearNode(p, nodes, w.nodeSize * 0.7)) continue;
        blooms.add(_Bloom.random(p, rnd, small: true));
      }
    }
    return _TrailGeometry(path, metric, nodeOffsets, nodes, blooms);
  }

  static bool _nearNode(Offset p, List<Offset> nodes, double r) =>
      nodes.any((n) => (n - p).distance < r);
}

class _Bloom {
  final Offset at;
  final bool flower;
  final int palette;
  final double size;
  final double phase;

  const _Bloom(this.at, this.flower, this.palette, this.size, this.phase);

  factory _Bloom.random(Offset at, Random rnd, {bool small = false}) => _Bloom(
        at,
        rnd.nextDouble() < 0.62,
        rnd.nextInt(4),
        (small ? 2.6 : 3.4) + rnd.nextDouble() * 2.2,
        rnd.nextDouble() * 2 * pi,
      );
}

class _TrailPainter extends CustomPainter {
  final _TrailGeometry geo;
  final Animation<double> t;
  final WorldTheme theme;
  final Biome biome;
  final int walked;

  _TrailPainter({
    required this.geo,
    required this.t,
    required this.theme,
    required this.biome,
    required this.walked,
  }) : super(repaint: t);

  static const _spring = [
    Color(0xFFFFB3D1),
    Color(0xFFFFFFFF),
    Color(0xFFFFE066),
    Color(0xFFD7B4FF)
  ];
  static const _summer = [
    Color(0xFFFF6B6B),
    Color(0xFFFFD93D),
    Color(0xFF6BCBFF),
    Color(0xFFC78BFF)
  ];
  static const _autumn = [
    Color(0xFFFF9F43),
    Color(0xFFE8B04B),
    Color(0xFFD9653B),
    Color(0xFFB98A5E)
  ];
  static const _winter = [
    Color(0xFFFFFFFF),
    Color(0xFFE3F0FF),
    Color(0xFFCFE3F7),
    Color(0xFFFFFFFF)
  ];

  Color get _pathColor => switch (biome) {
        Biome.beach => const Color(0xFFF1DEAE),
        Biome.city => const Color(0xFFB9BCC8),
        Biome.snow => const Color(0xFFEAF2FA),
        Biome.pond || Biome.jungle => const Color(0xFFC9A877),
        _ => const Color(0xFFDDBE8A),
      };

  @override
  void paint(Canvas canvas, Size size) {
    final metric = geo.metric;
    if (metric == null) return;
    final dim = theme.isNight ? 0.45 : (theme.isDark ? 0.7 : 1.0);
    final time = t.value * 2 * pi;

    // Cesta: tmavší lem, světlý povrch, kamínky.
    final base = Color.lerp(_pathColor, const Color(0xFF0B1020),
        theme.isNight ? 0.55 : (theme.isDark ? 0.3 : 0.0))!;
    canvas.drawPath(
      geo.path,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round
        ..strokeWidth = 22
        ..color = Color.lerp(base, Colors.black, 0.3)!.withValues(alpha: 0.35),
    );
    canvas.drawPath(
      geo.path,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round
        ..strokeWidth = 16
        ..color = base.withValues(alpha: 0.55),
    );
    // Prošlá část: teplé zlatavé světlo.
    final walkedTo = walked <= 0
        ? 0.0
        : walked >= geo.nodeOffsets.length
            ? metric.length
            : geo.nodeOffsets[walked];
    if (walkedTo > 0) {
      canvas.drawPath(
        metric.extractPath(0, walkedTo),
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeCap = StrokeCap.round
          ..strokeWidth = 10
          ..color = const Color(0xFFFFE08A).withValues(alpha: 0.45 * dim),
      );
    }
    final pebble = Paint()
      ..color = Color.lerp(base, Colors.white, 0.4)!.withValues(alpha: 0.5);
    for (var d = 10.0; d < metric.length; d += 26) {
      final tan = metric.getTangentForOffset(d);
      if (tan == null) continue;
      final n = Offset(-tan.vector.dy, tan.vector.dx);
      final side = ((d / 26).floor().isEven ? 1 : -1) * 3.5;
      canvas.drawOval(
          Rect.fromCenter(
              center: tan.position + n * side, width: 5, height: 3.4),
          pebble);
    }

    // Louka: v zimě jen sněhové chomáčky, jinak kytky a tráva ve větru.
    final palette = switch (theme.season) {
      Season.spring => _spring,
      Season.summer => _summer,
      Season.autumn => _autumn,
      Season.winter => _winter,
    };
    final grass = Paint()
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 1.6
      ..color =
          Color.lerp(theme.groundOf(biome), const Color(0xFFB8F28A), 0.45)!
              .withValues(alpha: 0.75 * dim);
    final petal = Paint();
    final heart = Paint()
      ..color = const Color(0xFFFFC93C).withValues(alpha: 0.9 * dim);
    for (final b in geo.blooms) {
      final wind = sin(time * 3 + b.phase + b.at.dx * 0.02) * 0.22;
      if (theme.season == Season.winter) {
        canvas.drawCircle(b.at, b.size * 0.9,
            Paint()..color = Colors.white.withValues(alpha: 0.35 * dim));
        continue;
      }
      canvas.save();
      canvas.translate(b.at.dx, b.at.dy);
      canvas.rotate(wind);
      if (!b.flower) {
        // Trs trávy: tři stébla.
        for (final a in const [-0.45, 0.0, 0.45]) {
          canvas.drawLine(Offset.zero,
              Offset(sin(a) * b.size * 2, -cos(a) * b.size * 2.6), grass);
        }
      } else {
        final stem = b.size * 2.2;
        canvas.drawLine(Offset.zero, Offset(0, -stem), grass);
        // Kytka se lehce „nadechuje" — otevírá a zavírá okvětí.
        final open = 1 + sin(time * 2 + b.phase) * 0.08;
        petal.color = palette[b.palette].withValues(alpha: 0.9 * dim);
        for (var k = 0; k < 5; k++) {
          final a = k * 2 * pi / 5 + b.phase;
          canvas.drawCircle(
              Offset(cos(a), sin(a)) * b.size * 0.75 * open + Offset(0, -stem),
              b.size * 0.55,
              petal);
        }
        canvas.drawCircle(Offset(0, -stem), b.size * 0.4, heart);
      }
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant _TrailPainter old) =>
      old.geo != geo ||
      old.theme != theme ||
      old.biome != biome ||
      old.walked != walked;
}

/// Zvířátko na cestě: tam a zpátky podél okraje, hopká (nebo poletuje),
/// otáčí se po směru chůze. V noci spí na svém místě.
class _Walker extends StatelessWidget {
  final _TrailGeometry geo;
  final Animation<double> t;
  final String emoji;
  final bool fly;
  final int index;
  final bool asleep;

  const _Walker({
    super.key,
    required this.geo,
    required this.t,
    required this.emoji,
    required this.fly,
    required this.index,
    required this.asleep,
  });

  static const double size = 26;

  /// Kde zvířátko v noci spí: v půli cesty mezi dvěma uzly, ne v nich.
  double _bed(double length) {
    final o = geo.nodeOffsets;
    if (o.length < 2) return length * (0.15 + index * 0.7);
    final k = (index * 2) % (o.length - 1);
    return (o[k] + o[k + 1]) / 2;
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: t,
      builder: (context, child) {
        final metric = geo.metric!;
        final laps = 1 + index; // druhé zvířátko běhá svižněji
        final u = (t.value * laps + index * 0.37) % 1.0;
        final forward = u < 0.5;
        final along = asleep
            ? _bed(metric.length)
            : metric.length * (forward ? u * 2 : (1 - u) * 2);
        final tan = metric
            .getTangentForOffset(along.clamp(0.0, metric.length).toDouble())!;
        final n = Offset(-tan.vector.dy, tan.vector.dx);
        final side = index.isEven ? 1.0 : -1.0;
        final phase = t.value * 2 * pi * 18 * laps;
        final lift = asleep
            ? 0.0
            : fly
                ? 10 + sin(phase * 0.5) * 8
                : sin(phase).abs() * 6;
        final p = tan.position + n * side * 15 - Offset(0, lift);
        // Směr chůze ve vodorovné ose → otočit obrázek.
        final dx = tan.vector.dx * (forward ? 1 : -1);
        final flip = asleep ? false : dx > 0.05;
        // U uzlu lekce zvířátko zmizí do trávy, ať nepřekrývá obrázek.
        final near = geo.nodes.isEmpty
            ? double.infinity
            : geo.nodes.map((c) => (c - p).distance).reduce(min);
        final visible = ((near - 30) / 14).clamp(0.0, 1.0).toDouble();
        return Positioned(
          left: p.dx - size / 2,
          top: p.dy - size / 2,
          child: Opacity(
            opacity: visible,
            child: Transform(
              alignment: Alignment.center,
              transform: Matrix4.diagonal3Values(flip ? -1 : 1, 1, 1),
              child: child,
            ),
          ),
        );
      },
      child: Opacity(
        opacity: asleep ? 0.75 : 1,
        child: EmojiArt(
          emoji,
          size: size,
          animate: false,
          reaction: StickerReaction.none,
          pose: asleep ? 'sleep' : null,
        ),
      ),
    );
  }
}
