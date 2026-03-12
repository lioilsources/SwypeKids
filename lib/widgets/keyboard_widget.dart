import 'package:flutter/material.dart';
import '../data/keyboard_data.dart';
import '../data/lessons.dart';
import 'key_widget.dart';
import 'swype_painter.dart';

class KeyboardWidget extends StatefulWidget {
  final Lesson lesson;
  final List<String> newLetters;
  final void Function(List<String> path) onSwypeEnd;

  const KeyboardWidget({
    super.key,
    required this.lesson,
    required this.newLetters,
    required this.onSwypeEnd,
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
  List<Offset> _pathPts = []; // středy navštívených kláves (absolutní)
  bool _swyping = false;

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
    // Střed klávesy v globálních souřadnicích
    final center = box.localToGlobal(box.size.center(Offset.zero));
    setState(() {
      _path = [..._path, letter];
      _pathPts = [..._pathPts, center];
    });
  }

  void _onPanStart(DragStartDetails d) {
    _fadeCtrl.stop();
    setState(() {
      _swyping = true;
      _path = [];
      _pathPts = [];
    });
    final letter = _letterAt(d.globalPosition);
    if (letter != null) _addLetter(letter);
  }

  void _onPanUpdate(DragUpdateDetails d) {
    if (!_swyping) return;
    final letter = _letterAt(d.globalPosition);
    if (letter != null) _addLetter(letter);
  }

  void _onPanEnd(DragEndDetails d) {
    if (!_swyping) return;
    setState(() => _swyping = false);
    widget.onSwypeEnd(List.from(_path));
    // Spusť fade-out čáry po 1.2s
    Future.delayed(const Duration(milliseconds: 1200), () {
      if (mounted) _fadeCtrl.forward(from: 0);
    });
  }

  // Převede absolutní body čáry na lokální souřadnice vůči klávesnici
  List<Offset> _toLocal(List<Offset> globalPts) {
    final box = context.findRenderObject() as RenderBox?;
    if (box == null) return globalPts;
    return globalPts.map((p) => box.globalToLocal(p)).toList();
  }

  @override
  Widget build(BuildContext context) {
    final localPts = _toLocal(_pathPts);
    final lineOpacity = _swyping ? 1.0 : (1.0 - _fadeAnim.value);
    // Pokud fade ještě nezačal (forward nebyl spuštěn), držíme 1.0
    final effectiveOpacity = _fadeCtrl.isAnimating ? lineOpacity : (_swyping ? 1.0 : lineOpacity);

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
            children: kRows.asMap().entries.map((rowEntry) {
              final ri = rowEntry.key;
              final row = rowEntry.value;
              return Padding(
                padding: EdgeInsets.only(
                  left: ri == 1 ? 16 : ri == 2 ? 32 : 0,
                  right: ri == 1 ? 16 : ri == 2 ? 32 : 0,
                  bottom: 6,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: row.map((letter) {
                    final active = widget.lesson.unlocked.contains(letter);
                    final inPath = _path.contains(letter);
                    final isNew  = widget.newLetters.contains(letter);
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 2.5),
                      child: SizedBox(
                        width: ri == 0 ? 34 : ri == 1 ? 37 : 42,
                        height: ri == 0 ? 52 : ri == 1 ? 55 : 58,
                        child: KeyWidget(
                          key: _keyGlobalKeys[letter],
                          letter: letter,
                          active: active,
                          inPath: inPath,
                          isNew: isNew,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              );
            }).toList(),
          ),

          // SVG čára přes klávesnici
          if (_pathPts.isNotEmpty)
            Positioned.fill(
              child: IgnorePointer(
                child: CustomPaint(
                  painter: SwypePainter(
                    points: localPts,
                    opacity: effectiveOpacity.clamp(0.0, 1.0),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
