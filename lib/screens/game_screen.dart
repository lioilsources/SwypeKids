import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import '../data/keyboard_data.dart';
import '../data/lessons.dart';
import '../widgets/challenge_card.dart';
import '../widgets/keyboard_widget.dart';
import 'win_screen.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen>
    with SingleTickerProviderStateMixin {
  int _idx = 0;
  int _stars = 0;
  List<String> _path = [];
  GameStatus _status = GameStatus.idle;
  bool _shake = false;
  List<String> _newLetters = [];

  // Blikání nových písmen
  late AnimationController _newLetterCtrl;
  Timer? _timerNext;
  Timer? _timerShake;
  Timer? _timerNew;

  List<String> _prevUnlocked = [];

  @override
  void initState() {
    super.initState();
    _newLetterCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    )..repeat(reverse: true);
    _prevUnlocked = kLessons[0].unlocked;
    // Landscape preferred for keyboard
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
      DeviceOrientation.portraitUp,
    ]);
  }

  @override
  void dispose() {
    _newLetterCtrl.dispose();
    _timerNext?.cancel();
    _timerShake?.cancel();
    _timerNew?.cancel();
    super.dispose();
  }

  Lesson get _lesson => kLessons[_idx];

  void _onSwypeEnd(List<String> path) {
    if (_status != GameStatus.idle) return;
    setState(() => _path = path);

    final result = path.join('');
    if (result == _lesson.target) {
      HapticFeedback.mediumImpact();
      setState(() {
        _status = GameStatus.success;
        _stars++;
      });
      _timerNext = Timer(const Duration(milliseconds: 1600), _nextLesson);
    } else {
      HapticFeedback.vibrate();
      setState(() {
        _status = GameStatus.error;
        _shake = true;
      });
      _timerShake = Timer(const Duration(milliseconds: 500), () {
        if (mounted) setState(() => _shake = false);
      });
      _timerNext = Timer(const Duration(milliseconds: 900), () {
        if (mounted) setState(() {
          _status = GameStatus.idle;
          _path = [];
        });
      });
    }
  }

  void _nextLesson() {
    if (!mounted) return;
    final nextIdx = _idx + 1;
    if (nextIdx < kLessons.length) {
      final curr = kLessons[nextIdx].unlocked;
      final added = curr.where((l) => !_prevUnlocked.contains(l)).toList();
      setState(() {
        _idx = nextIdx;
        _status = GameStatus.idle;
        _path = [];
        _newLetters = added;
        _prevUnlocked = curr;
      });
      if (added.isNotEmpty) {
        _timerNew = Timer(const Duration(milliseconds: 2500), () {
          if (mounted) setState(() => _newLetters = []);
        });
      }
    } else {
      setState(() => _idx = nextIdx); // → WinScreen
    }
  }

  void _restart() {
    setState(() {
      _idx = 0;
      _stars = 0;
      _path = [];
      _status = GameStatus.idle;
      _shake = false;
      _newLetters = [];
      _prevUnlocked = kLessons[0].unlocked;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_idx >= kLessons.length) {
      return WinScreen(stars: _stars, onRestart: _restart);
    }

    final lesson = _lesson;
    final progress = _idx / kLessons.length;
    final isWord = lesson.target.length > 2;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF1A1A2E),
              Color(0xFF16213E),
              Color(0xFF0F3460),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // ── Top bar ──────────────────────────────────────────────
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 14, vertical: 6),
                child: Row(
                  children: [
                    _badge(isWord ? '🔤 SLOVO' : '🔡 SLABIKA'),
                    const Spacer(),
                    // Hvězdičky
                    Text(
                      '⭐' * _stars.clamp(0, 10),
                      style: const TextStyle(fontSize: 14),
                    ),
                    const Spacer(),
                    _badge('${_idx + 1}/${kLessons.length}'),
                  ],
                ),
              ),

              // Progress bar
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(99),
                  child: LinearProgressIndicator(
                    value: progress,
                    minHeight: 6,
                    backgroundColor: Colors.white.withOpacity(0.1),
                    valueColor: const AlwaysStoppedAnimation<Color>(
                      Color(0xFFFFD200),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),

              // ── Challenge card ────────────────────────────────────────
              ChallengeCard(
                lesson: lesson,
                path: _path,
                status: _status,
                shake: _shake,
              ),
              const SizedBox(height: 8),

              // ── Klávesnice ────────────────────────────────────────────
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  child: KeyboardWidget(
                    lesson: lesson,
                    newLetters: _newLetters,
                    onSwypeEnd: _onSwypeEnd,
                  ),
                ),
              ),

              // ── Legenda ───────────────────────────────────────────────
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 4, 8, 6),
                child: Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 5,
                  runSpacing: 4,
                  children: lesson.unlocked.map((l) {
                    final col = keyColor(l);
                    return Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.07),
                        borderRadius: BorderRadius.circular(99),
                        border: Border.all(
                            color: col.withOpacity(0.4), width: 1),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(keyEmoji(l),
                              style: const TextStyle(fontSize: 11)),
                          const SizedBox(width: 3),
                          Text(l,
                              style: GoogleFonts.nunito(
                                fontSize: 11,
                                fontWeight: FontWeight.w800,
                                color: col,
                              )),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _badge(String text) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.08),
          borderRadius: BorderRadius.circular(99),
        ),
        child: Text(
          text,
          style: GoogleFonts.nunito(
            fontSize: 11,
            fontWeight: FontWeight.w800,
            color: const Color(0xFFA0C4FF),
            letterSpacing: 0.5,
          ),
        ),
      );
}
