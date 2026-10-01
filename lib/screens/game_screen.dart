import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../audio/audio_service.dart';
import '../characters/mascot.dart';
import '../data/lessons.dart';
import '../data/models/content_pack.dart';
import '../data/models/sentence.dart';
import '../services/achievement_service.dart';
import '../services/pack_service.dart';
import '../services/progress_service.dart';
import '../services/tts_service.dart';
import '../widgets/challenge_card.dart';
import '../widgets/keyboard_widget.dart';
import '../widgets/badge_chip.dart';
import '../widgets/star_celebration.dart';
import 'unit_complete_screen.dart';
import 'word_sentence_screen.dart';
import 'win_screen.dart';

/// reviewMix → konkrétní lekce: nejslabší dříve naučené slovo, jehož písmena
/// jsou mezi `unlocked`. Id a `unlocked` zůstávají z reviewMix lekce (postup
/// na mapě se píše k ní). Když nic nepasuje, hraje se vlastní target.
Lesson resolveReviewMix(ContentPack pack, Lesson lesson) {
  if (lesson.type != LessonType.reviewMix) return lesson;
  final allowed = lesson.unlocked.toSet();
  final source = ProgressService.instance
      .weakestLearned(pack)
      .where((l) => allowed.containsAll(l.target.split('')))
      .firstOrNull;
  if (source == null) {
    return Lesson(
      id: lesson.id,
      unlocked: lesson.unlocked,
      target: lesson.target,
      display: lesson.display,
      hint: lesson.hint,
      label: lesson.label,
      vocab: lesson.vocab,
      parentNote: lesson.parentNote,
    );
  }
  return Lesson(
    id: lesson.id,
    type: source.type,
    unlocked: lesson.unlocked,
    target: source.target,
    display: source.display,
    hint: source.hint,
    label: source.label,
    info: source.info,
    ipa: source.ipa,
    pinyin: source.pinyin,
    vocab: source.vocab,
    gap: source.gap,
    parentNote: lesson.parentNote,
  );
}

/// Hraje jednu jednotku packu od [startLessonIndex] do konce.
/// Po dokončení jednotky uloží nálepku a přejde na UnitCompleteScreen
/// (resp. WinScreen, pokud je hotový celý pack).
class GameScreen extends StatefulWidget {
  final ContentPack pack;
  final int unitIndex;
  final int startLessonIndex;

  /// Procvičování: hraje tyto lekce místo jednotky packu. Nezapisuje
  /// dokončení ani nálepku — jen sílu slov a batoh.
  final Unit? practice;

  const GameScreen({
    super.key,
    required this.pack,
    required this.unitIndex,
    this.startLessonIndex = 0,
    this.practice,
  });

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen>
    with SingleTickerProviderStateMixin {
  late int _idx = widget.startLessonIndex;
  int _sessionStars = 0;
  int _lessonStars = 0; // hvězdy za právě dohrané kolo (oslava)
  String? _newWord; // slovo, které právě přibylo do batohu (oslava)
  SentencePart? _wordForSentence; // po oslavě: slovo hned do věty
  int _attempts = 0; // pokusy o aktuální lekci (1. pokus = 3⭐, 2. = 2⭐, pak 1⭐)
  bool _allThreeStars = true; // celý běh jednotky bez chyby (odznak 💎)
  List<GameBadge> _newBadges = const []; // odznaky z právě dohraného kola
  bool _revealed =
      false; // skryté kolo (poslech/obrázek/díra): odkryto po chybě
  List<String> _path = [];
  List<String> _livePath = [];
  GameStatus _status = GameStatus.idle;
  MascotMood _mood = MascotMood.wave; // průvodce: zamává při příchodu
  bool _shake = false;
  List<String> _newLetters = [];

  // Blikání nových písmen
  late AnimationController _newLetterCtrl;
  Timer? _timerNext;
  Timer? _timerShake;
  Timer? _timerNew;

  List<String> _prevUnlocked = [];

  Unit get _unit => widget.practice ?? widget.pack.units[widget.unitIndex];
  bool get _isPractice => widget.practice != null;
  List<Lesson> get _lessons => _unit.lessons;
  Lesson get _lesson => _lessonAt(_idx);

  // reviewMix se rozhodne jednou, při prvním použití lekce.
  final Map<int, Lesson> _resolved = {};
  Lesson _lessonAt(int i) =>
      _resolved[i] ??= resolveReviewMix(widget.pack, _lessons[i]);
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
      final progress = ProgressService.instance;
      if (!_isPractice) {
        progress.markCompleted(widget.pack.id, _lesson.id, stars);
      }
      progress.recordAttempt(widget.pack.id, _lesson.target, success: true);
      final gotWord = progress.addWord(widget.pack.id, _lesson.vocab);
      if (stars < 3) _allThreeStars = false;
      final badges = AchievementService.instance.check(
        LessonDone(type: _lesson.type, stars: stars),
        widget.pack,
      );
      HapticFeedback.mediumImpact();
      AudioService.instance.play(Sfx.success);
      setState(() {
        _status = GameStatus.success;
        _mood = MascotMood.cheer;
        _sessionStars += stars;
        _lessonStars = stars;
        _newBadges = badges;
        _newWord = gotWord ? _lesson.display : null;
      });
      _wordForSentence = gotWord
          ? WordSentenceScreen.tileFor(widget.pack, _lesson.vocab)
          : null;
      _timerNext = Timer(const Duration(milliseconds: 1600), _afterSuccess);
    } else {
      HapticFeedback.vibrate();
      AudioService.instance.play(Sfx.error);
      ProgressService.instance
          .recordAttempt(widget.pack.id, _lesson.target, success: false);
      setState(() {
        _status = GameStatus.error;
        _mood = MascotMood.oops;
        _shake = true;
        _revealed = true; // skryté kolo: po chybě text odkrýt (scaffolding)
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

  /// Po oslavě: nové slovo nejdřív do věty (dá se přeskočit), pak dál.
  Future<void> _afterSuccess() async {
    final word = _wordForSentence;
    _wordForSentence = null;
    if (word != null && mounted) {
      await Navigator.of(context).push(MaterialPageRoute<String>(
        builder: (_) => WordSentenceScreen(pack: widget.pack, word: word),
      ));
    }
    _nextLesson();
  }

  void _nextLesson() {
    if (!mounted) return;
    final nextIdx = _idx + 1;
    if (nextIdx < _lessons.length) {
      final curr = _lessonAt(nextIdx).unlocked;
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
    if (_isPractice) {
      // Procvičování nemá nálepku; oslava proběhla po každém kole.
      Navigator.of(context).pop(_sessionStars);
      return;
    }
    final progress = ProgressService.instance;
    progress.addCollectible(widget.pack.id, _unit.reward.emoji);
    AudioService.instance.play(Sfx.sticker);
    final unitBadges = AchievementService.instance.check(
      UnitDone(allThreeStars: _allThreeStars && widget.startLessonIndex == 0),
      widget.pack,
    );

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
          heroTag: stickerHeroTag(widget.pack.id, widget.unitIndex),
          newBadges: unitBadges,
        ),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    final lesson = _lesson;
    final progress = (_idx + 1) / _lessons.length;
    final isWord = lesson.target.length > 2;
    final mode = _revealed
        ? CardMode.full
        : switch (lesson.type) {
            LessonType.listen => CardMode.listen,
            LessonType.pictureOnly => CardMode.picture,
            LessonType.missingLetter => CardMode.gap,
            LessonType.swype || LessonType.reviewMix => CardMode.full,
          };

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
        child: LayoutBuilder(builder: (context, box) {
          // Na šířku (tablet, telefon otočený) karta vlevo, klávesnice vpravo;
          // na výšku pod sebou.
          final landscape = box.maxWidth > box.maxHeight * 1.25;
          return _withCelebration(
              landscape: landscape,
              SafeArea(
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
                          // Průvodce reaguje na každý výsledek kola.
                          Mascot(
                            mood: _mood,
                            size: 26,
                            onSettled: () {
                              if (mounted) {
                                setState(() => _mood = MascotMood.idle);
                              }
                            },
                          ),
                          const SizedBox(width: 6),
                          _badge(switch (lesson.type) {
                            LessonType.listen => '🔊 POSLECH',
                            LessonType.pictureOnly => '🖼️ OBRÁZEK',
                            LessonType.missingLetter => '🧩 DOPLŇ',
                            LessonType.reviewMix => '🔁 OPAKOVÁNÍ',
                            LessonType.swype =>
                              isWord ? '🔤 SLOVO' : '🔡 SLABIKA',
                          }),
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
                          _badge(
                              '${_unit.icon} ${_idx + 1}/${_lessons.length}'),
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

                    if (landscape)
                      Expanded(
                        child: Row(
                          children: [
                            Expanded(
                              flex: 5,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  _card(lesson, mode),
                                  const SizedBox(height: 8),
                                  _legend(lesson),
                                ],
                              ),
                            ),
                            Expanded(flex: 7, child: _keyboard(lesson)),
                          ],
                        ),
                      )
                    else ...[
                      _card(lesson, mode),
                      const SizedBox(height: 8),
                      Expanded(child: _keyboard(lesson)),
                      _legend(lesson),
                    ],
                  ],
                ),
              ));
        }),
      ),
    );
  }

  Widget _card(Lesson lesson, CardMode mode) => ChallengeCard(
        lesson: lesson,
        path: _livePath.isNotEmpty && _status == GameStatus.idle
            ? _livePath
            : _path,
        status: _status,
        shake: _shake,
        mode: mode,
        emojiFor: _emojiFor,
        onReplayAudio: lesson.type == LessonType.listen ? _replayAudio : null,
      );

  Widget _keyboard(Lesson lesson) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6),
        child: KeyboardWidget(
          lesson: lesson,
          newLetters: _newLetters,
          emojiFor: _emojiFor,
          onSwypeEnd: _onSwypeEnd,
          onSwypeUpdate: _onSwypeUpdate,
          onLetter: AudioService.instance.playKeyTone,
        ),
      );

  Widget _legend(Lesson lesson) => Padding(
        padding: const EdgeInsets.fromLTRB(8, 4, 8, 6),
        child: Wrap(
          alignment: WrapAlignment.center,
          spacing: 5,
          runSpacing: 4,
          children: lesson.unlocked.map((l) {
            final col = PackService.instance.keyColorFor(widget.pack, l);
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.07),
                borderRadius: BorderRadius.circular(99),
                border: Border.all(color: col.withOpacity(0.4), width: 1),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(PackService.instance.keyEmojiFor(widget.pack, l),
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
      );

  /// Přes hru položí oslavu správného swype (padající hvězdy + konfety).
  Widget _withCelebration(Widget game, {required bool landscape}) => Stack(
        children: [
          game,
          if (_status == GameStatus.success)
            Positioned.fill(
              child: StarCelebration(
                key: ValueKey('celebration-$_idx'),
                stars: _lessonStars,
                landingY: landscape ? 0.4 : 0.28,
                landingX: landscape ? 0.21 : 0.5,
                onStarLanded: AudioService.instance.playStar,
              ),
            ),
          if (_status == GameStatus.success && _newBadges.isNotEmpty)
            Positioned(
              bottom: 24,
              left: 0,
              right: 0,
              child: Wrap(
                alignment: WrapAlignment.center,
                spacing: 8,
                children: [
                  for (final b in _newBadges)
                    BadgeChip(key: ValueKey('badge-${b.name}-$_idx'), badge: b),
                ],
              ),
            ),
          if (_status == GameStatus.success && _newWord != null)
            Positioned(
              top: 56,
              right: 16,
              child: _WordBagChip(key: ValueKey('bag-$_idx'), word: _newWord!),
            ),
        ],
      );

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

/// „🎒 MÁMA" — slovo právě přibylo do batohu (a tím do builderu vět).
class _WordBagChip extends StatelessWidget {
  final String word;
  const _WordBagChip({super.key, required this.word});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: const Duration(milliseconds: 500),
      curve: Curves.elasticOut,
      builder: (context, t, child) => Transform.scale(scale: t, child: child),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: const Color(0xFF1DD1A1),
          borderRadius: BorderRadius.circular(99),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF1DD1A1).withValues(alpha: 0.5),
              blurRadius: 14,
            ),
          ],
        ),
        child: Text(
          '🎒 $word',
          style: const TextStyle(
            fontFamily: 'Nunito',
            fontSize: 16,
            fontWeight: FontWeight.w900,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
