import 'dart:async';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../data/keyboard_data.dart';
import '../data/lessons.dart';
import 'key_widget.dart';
import 'swype_painter.dart';

class KeyboardWidget extends StatefulWidget {
  final Lesson lesson;
  final List<String> newLetters;
  final void Function(List<String> path) onSwypeEnd;
  final void Function(List<String> path)? onSwypeUpdate;

  const KeyboardWidget({
    super.key,
    required this.lesson,
    required this.newLetters,
    required this.onSwypeEnd,
    this.onSwypeUpdate,
  });

  @override
  State<KeyboardWidget> createState() => _KeyboardWidgetState();
}

class _KeyboardWidgetState extends State<KeyboardWidget>
    with SingleTickerProviderStateMixin {
  // GlobalKey pro každou klávesu → pro zjištění pozice/velikosti
  final Map<String, GlobalKey> _keyGlobalKeys = {
    for (final l in kRows.expand((r) => r)) l: GlobalKey(),
  };

  List<String> _path = [];
  List<Offset> _hitPts = [];    // středy trefených kláves (globální)
  List<Offset> _fingerPts = []; // všechny pozice prstu (globální)
  bool _swyping = false;

  // Dwell time – písmeno se přidá až po krátkém setrvání prstu na klávese
  String? _candidateLetter;
  Timer? _dwellTimer;
  static const int _dwellMs = 100;

  // Trackpad scroll → swipe: akumulátor delta + timeout
  Offset? _scrollOrigin;
  Offset _scrollAccum = Offset.zero;
  Timer? _scrollEndTimer;

  // Fade-out animace čáry
  late AnimationController _fadeCtrl;
  late Animation<double> _fadeAnim;

  @override
  void initState() {
    super.initState();
    _fadeCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    _fadeAnim = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(parent: _fadeCtrl, curve: Curves.easeIn),
    )..addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _dwellTimer?.cancel();
    _scrollEndTimer?.cancel();
    _fadeCtrl.dispose();
    super.dispose();
  }

  // ── Zjistí, která aktivní klávesa leží pod globální souřadnicí ──────────
  String? _letterAt(Offset globalPos) {
    for (final letter in widget.lesson.unlocked) {
      final gk = _keyGlobalKeys[letter];
      if (gk == null) continue;
      final ctx = gk.currentContext;
      if (ctx == null) continue;
      final box = ctx.findRenderObject() as RenderBox?;
      if (box == null || !box.hasSize) continue;
      final local = box.globalToLocal(globalPos);
      if (box.paintBounds.contains(local)) return letter;
    }
    return null;
  }

  void _addLetter(String letter) {
    if (_path.isNotEmpty && _path.last == letter) return;
    final gk = _keyGlobalKeys[letter]!;
    final ctx = gk.currentContext!;
    final box = ctx.findRenderObject() as RenderBox;
    final center = box.localToGlobal(box.size.center(Offset.zero));
    setState(() {
      _path = [..._path, letter];
      _hitPts = [..._hitPts, center];
    });
    widget.onSwypeUpdate?.call(List.from(_path));
  }

  void _addFingerPoint(Offset globalPosition) {
    setState(() {
      _fingerPts = [..._fingerPts, globalPosition];
    });
  }

  // ── Sdílená logika pro zahájení / průběh / ukončení tahu ────────────────
  void _startSwype(Offset globalPosition) {
    _fadeCtrl.stop();
    _dwellTimer?.cancel();
    _candidateLetter = null;
    setState(() {
      _swyping = true;
      _path = [];
      _hitPts = [];
      _fingerPts = [globalPosition];
    });
    widget.onSwypeUpdate?.call([]);
    // První písmeno se přidá okamžitě – uživatel záměrně začal na této klávese
    final letter = _letterAt(globalPosition);
    if (letter != null) {
      _addLetter(letter);
      _candidateLetter = letter;
    }
  }

  void _updateSwype(Offset globalPosition) {
    if (!_swyping) return;
    _addFingerPoint(globalPosition);
    final letter = _letterAt(globalPosition);
    if (letter != _candidateLetter) {
      _dwellTimer?.cancel();
      _candidateLetter = letter;
      if (letter != null) {
        _dwellTimer = Timer(const Duration(milliseconds: _dwellMs), () {
          if (_swyping) _addLetter(letter);
        });
      }
    }
  }

  void _endSwype() {
    if (!_swyping) return;
    _dwellTimer?.cancel();
    _candidateLetter = null;
    setState(() => _swyping = false);
    widget.onSwypeEnd(List.from(_path));
    Future.delayed(const Duration(milliseconds: 1200), () {
      if (mounted) _fadeCtrl.forward(from: 0);
    });
  }

  // ── GestureDetector panely (klik + táhni / dotyk) ────────────────────────
  void _onPanStart(DragStartDetails d) {
    _scrollEndTimer?.cancel();
    _startSwype(d.globalPosition);
  }

  void _onPanUpdate(DragUpdateDetails d) => _updateSwype(d.globalPosition);
  void _onPanEnd(DragEndDetails d) => _endSwype();

  // ── Scroll events – dva prsty na trackpadu macOS ─────────────────────────
  void _onPointerSignal(PointerSignalEvent event) {
    if (event is! PointerScrollEvent) return;
    _scrollEndTimer?.cancel();

    if (!_swyping) {
      _scrollOrigin = event.position;
      _scrollAccum = Offset.zero;
      _startSwype(event.position);
    }

    // Scroll delta je opačný ke směru pohybu prstů → odečteme
    _scrollAccum -= event.scrollDelta;
    _updateSwype(_scrollOrigin! + _scrollAccum);

    _scrollEndTimer = Timer(const Duration(milliseconds: 300), () {
      _endSwype();
      _scrollOrigin = null;
    });
  }

  // ── Trackpad pan/zoom events (alternativní cesta na některých systémech) ─
  void _onPointerPanZoomStart(PointerPanZoomStartEvent event) {
    _scrollEndTimer?.cancel();
    _startSwype(event.position);
  }

  void _onPointerPanZoomUpdate(PointerPanZoomUpdateEvent event) {
    _updateSwype(event.position + event.pan);
  }

  void _onPointerPanZoomEnd(PointerPanZoomEndEvent event) => _endSwype();

  // Převede absolutní body čáry na lokální souřadnice vůči klávesnici
  List<Offset> _toLocal(List<Offset> globalPts) {
    final box = context.findRenderObject() as RenderBox?;
    if (box == null) return globalPts;
    return globalPts.map((p) => box.globalToLocal(p)).toList();
  }

  @override
  Widget build(BuildContext context) {
    final localFingerPts = _toLocal(_fingerPts);
    final localHitPts = _toLocal(_hitPts);
    final lineOpacity = _swyping ? 1.0 : (1.0 - _fadeAnim.value);
    final effectiveOpacity = _fadeCtrl.isAnimating ? lineOpacity : (_swyping ? 1.0 : lineOpacity);

    // Reference sizes for the keyboard (full-size layout)
    const double refWidth = 410;
    const double refHeight = 177;

    return Listener(
      onPointerSignal: _onPointerSignal,
      onPointerPanZoomStart: _onPointerPanZoomStart,
      onPointerPanZoomUpdate: _onPointerPanZoomUpdate,
      onPointerPanZoomEnd: _onPointerPanZoomEnd,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final scaleX = constraints.maxWidth / refWidth;
          final scaleY = constraints.maxHeight / refHeight;
          final scale = scaleX < scaleY ? scaleX : scaleY;

          return GestureDetector(
          onPanStart: _onPanStart,
          onPanUpdate: _onPanUpdate,
          onPanEnd: _onPanEnd,
          behavior: HitTestBehavior.opaque,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              // Klávesnice
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: kRows.asMap().entries.map((rowEntry) {
                  final ri = rowEntry.key;
                  final row = rowEntry.value;
                  return Padding(
                    padding: EdgeInsets.only(
                      left: (ri == 1 ? 16 : ri == 2 ? 32 : 0) * scale,
                      right: (ri == 1 ? 16 : ri == 2 ? 32 : 0) * scale,
                      bottom: 6 * scale,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: row.map((letter) {
                        final active = widget.lesson.unlocked.contains(letter);
                        final inPath = _path.contains(letter);
                        final isNew  = widget.newLetters.contains(letter);
                        return Padding(
                          padding: EdgeInsets.symmetric(horizontal: 2.5 * scale),
                          child: SizedBox(
                            width: (ri == 0 ? 34 : ri == 1 ? 37 : 42) * scale,
                            height: (ri == 0 ? 52 : ri == 1 ? 55 : 58) * scale,
                            child: KeyWidget(
                              key: _keyGlobalKeys[letter],
                              letter: letter,
                              active: active,
                              inPath: inPath,
                              isNew: isNew,
                              scale: scale,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  );
                }).toList(),
              ),

              // Stopa prstu + zvýrazněné trefené klávesy
              if (_fingerPts.isNotEmpty)
                Positioned.fill(
                  child: IgnorePointer(
                    child: CustomPaint(
                      painter: SwypePainter(
                        trail: localFingerPts,
                        hitPoints: localHitPts,
                        opacity: effectiveOpacity.clamp(0.0, 1.0),
                      ),
                    ),
                  ),
                ),
            ],
          ),
          );
        },
      ),
    );
  }
}
