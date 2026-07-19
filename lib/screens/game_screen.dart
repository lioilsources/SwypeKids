import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../data/lessons.dart';
import '../data/models/content_pack.dart';
import '../services/pack_service.dart';
import '../services/progress_service.dart';
import '../services/tts_service.dart';
import '../widgets/challenge_card.dart';
import '../widgets/keyboard_widget.dart';
import 'unit_complete_screen.dart';
import 'win_screen.dart';

/// Hraje jednu jednotku packu od [startLessonIndex] do konce.
/// Po dokončení jednotky uloží nálepku a přejde na UnitCompleteScreen
/// (resp. WinScreen, pokud je hotový celý pack).
class GameScreen extends StatefulWidget {
  final ContentPack pack;
  final int unitIndex;
  final int startLessonIndex;

  const GameScreen({
    super.key,
    required this.pack,
    required this.unitIndex,
    this.startLessonIndex = 0,
  });

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen>
    with SingleTickerProviderStateMixin {
  late int _idx = widget.startLessonIndex;
  int _sessionStars = 0;
  int _attempts = 0; // pokusy o aktuální lekci (1. pokus = 3⭐, 2. = 2⭐, pak 1⭐)
  bool _revealed = false; // poslechové kolo: text odkrytý po neúspěchu
  List<String> _path = [];
  List<String> _livePath = [];
  GameStatus _status = GameStatus.idle;
  bool _shake = false;
  List<String> _newLetters = [];

  // Blikání nových písmen
  late AnimationController _newLetterCtrl;
  Timer? _timerNext;
  Timer? _timerShake;
  Timer? _timerNew;

  List<String> _prevUnlocked = [];

  Unit get _unit => widget.pack.units[widget.unitIndex];
  List<Lesson> get _lessons => _unit.lessons;
  Lesson get _lesson => _lessons[_idx];
  Language get _language => widget.pack.language;

  String _emojiFor(String letter) =>
      PackService.instance.keyEmojiFor(widget.pack, letter);

  @override
  void initState() {
    super.initState();
    _newLetterCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    )..repeat(reverse: true);
    _prevUnlocked = _lesson.unlocked;
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
      DeviceOrientation.portraitUp,
    ]);
    _startLesson();
  }

  @override
  void dispose() {
    _newLetterCtrl.dispose();
    _timerNext?.cancel();
    _timerShake?.cancel();
    _timerNew?.cancel();
    super.dispose();
  }

  void _startLesson() {
    _attempts = 0;
    _revealed = false;
    if (_lesson.type == LessonType.listen) {
      TtsService.speak(_lesson.display, _language);
    }
  }

  void _replayAudio() => TtsService.speak(_lesson.display, _language);

  void _onSwypeUpdate(List<String> path) {
    if (_status != GameStatus.idle) return;
    setState(() => _livePath = path);
  }

  void _onSwypeEnd(List<String> path) {
    if (_status != GameStatus.idle) return;
    setState(() {
      _path = path;
      _livePath = [];
    });

    _attempts++;
    final result = path.join('');
    if (result == _lesson.target) {
      final stars = _attempts == 1 ? 3 : (_attempts == 2 ? 2 : 1);
      ProgressService.instance
          .markCompleted(widget.pack.id, _lesson.id, stars);
      HapticFeedback.mediumImpact();
      setState(() {
        _status = GameStatus.success;
        _sessionStars += stars;
      });
      _timerNext = Timer(const Duration(milliseconds: 1600), _nextLesson);
    } else {
      HapticFeedback.vibrate();
      setState(() {
        _status = GameStatus.error;
        _shake = true;
        _revealed = true; // poslechové kolo: po chybě text odkrýt (scaffolding)
      });
      _timerShake = Timer(const Duration(milliseconds: 500), () {
        if (mounted) setState(() => _shake = false);
      });
      _timerNext = Timer(const Duration(milliseconds: 900), () {
        if (!mounted) return;
        setState(() {
          _status = GameStatus.idle;
          _path = [];
          _livePath = [];
        });
      });
    }
  }

  void _nextLesson() {
    if (!mounted) return;
    final nextIdx = _idx + 1;
    if (nextIdx < _lessons.length) {
      final curr = _lessons[nextIdx].unlocked;
      final added = curr.where((l) => !_prevUnlocked.contains(l)).toList();
      setState(() {
        _idx = nextIdx;
        _status = GameStatus.idle;
        _path = [];
        _livePath = [];
        _newLetters = added;
        _prevUnlocked = curr;
      });
      _startLesson();
      if (added.isNotEmpty) {
        _timerNew = Timer(const Duration(milliseconds: 2500), () {
          if (mounted) setState(() => _newLetters = []);
        });
      }
    } else {
      _finishUnit();
    }
  }

  void _finishUnit() {
    final progress = ProgressService.instance;
    progress.addCollectible(widget.pack.id, _unit.reward.emoji);

    final isLastUnit = widget.unitIndex == widget.pack.units.length - 1;
    final packDone = isLastUnit &&
        List.generate(widget.pack.units.length, (u) => u)
            .every((u) => progress.isUnitCompleted(widget.pack, u));

    if (packDone) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (ctx) => WinScreen(
          stars: progress.totalStars(widget.pack.id),
          onRestart: () => Navigator.of(ctx).pop(),
        ),
      ));
    } else {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (_) => UnitCompleteScreen(
          reward: _unit.reward,
          stars: _sessionStars,
        ),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    final lesson = _lesson;
    final progress = (_idx + 1) / _lessons.length;
    final isWord = lesson.target.length > 2;
    final isListen = lesson.type == LessonType.listen && !_revealed;

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
                    horizontal: 8, vertical: 4),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back_rounded,
                          color: Color(0xFFA0C4FF), size: 22),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                    const SizedBox(width: 8),
                    _badge(lesson.type == LessonType.listen
                        ? '🔊 POSLECH'
                        : (isWord ? '🔤 SLOVO' : '🔡 SLABIKA')),
                    const Spacer(),
                    Text(
                      '⭐ $_sessionStars',
                      style: const TextStyle(
                        fontFamily: 'Nunito',
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFFFFD200),
                      ),
                    ),
                    const Spacer(),
                    _badge('${_unit.icon} ${_idx + 1}/${_lessons.length}'),
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
                path: _livePath.isNotEmpty && _status == GameStatus.idle
                    ? _livePath
                    : _path,
                status: _status,
                shake: _shake,
                hidden: isListen,
                emojiFor: _emojiFor,
                onReplayAudio:
                    lesson.type == LessonType.listen ? _replayAudio : null,
              ),
              const SizedBox(height: 8),

              // ── Klávesnice ────────────────────────────────────────────
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  child: KeyboardWidget(
                    lesson: lesson,
                    newLetters: _newLetters,
                    emojiFor: _emojiFor,
                    onSwypeEnd: _onSwypeEnd,
                    onSwypeUpdate: _onSwypeUpdate,
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
                    final col =
                        PackService.instance.keyColorFor(widget.pack, l);
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
                          Text(
                              PackService.instance
                                  .keyEmojiFor(widget.pack, l),
                              style: const TextStyle(fontSize: 11)),
                          const SizedBox(width: 3),
                          Text(l,
                              style: TextStyle(
                                fontFamily: 'Nunito',
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
          style: const TextStyle(
            fontFamily: 'Nunito',
            fontSize: 11,
            fontWeight: FontWeight.w800,
            color: Color(0xFFA0C4FF),
            letterSpacing: 0.5,
          ),
        ),
      );
}
