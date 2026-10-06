import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

import '../audio/audio_service.dart';
import '../characters/draggable_guide.dart';
import '../characters/mascot.dart';
import '../data/lessons.dart';
import '../data/models/content_pack.dart';
import '../data/models/sentence.dart';
import '../services/achievement_service.dart';
import '../services/progress_service.dart';
import '../services/session_service.dart';
import '../services/tts_service.dart';
import '../ui/app_font.dart';
import '../ui/emoji_art.dart';
import '../ui/sticker_kind.dart';
import '../widgets/badge_chip.dart';
import '../world/world_clock.dart';
import '../screens/game_screen.dart';
import '../services/settings_service.dart';
import 'gift.dart';
import 'wish.dart';

/// Svět zvířátka (Zvěřinec → řádek jednotky): obyvatel = nálepka jednotky
/// (+ tajná nálepka biotopu, když ji dítě našlo) v jejím biotopu. Dítě ho
/// hladí, šimrá, zvedá a dává mu dárky z tácku naučených slov; po dárku
/// se objeví věta („Myš jí jablko."), jde ji přečíst a uložit do knížky.
/// Žádný hlad, žádný časovač — zvířátko je vždycky rádo. V noci a po
/// vypršení času spí. Plán: `docs/PLAN_ZVERINEC_HRA.md`.
class PetScreen extends StatefulWidget {
  final ContentPack pack;
  final int unitIndex;

  const PetScreen({super.key, required this.pack, required this.unitIndex});

  @override
  State<PetScreen> createState() => _PetScreenState();
}

class _PetScreenState extends State<PetScreen> {
  ContentPack get _pack => widget.pack;
  Unit get _unit => _pack.units[widget.unitIndex];
  CollectibleReward get _resident => _unit.reward;
  Language get _language => _pack.language;
  Biome get _biome => Biome.parse(_unit.biome);

  late final List<Gift> _tray = Gift.trayFor(_pack);

  // Co obyvatel právě dělá (dárek, hlazení, šimrání).
  StickerAction? _action;
  String? _pose;
  Gift? _eating;
  Timer? _actionTimer;
  int _poke = 0; // reakce na akci (trigger EmojiArt)

  // Hlazení: dráha prstu po těle; šimrání: rychlá ťuknutí.
  double _stroke = 0;
  final List<DateTime> _quickTaps = [];

  // Zvednutí dlouhým stiskem.
  Offset? _lift;

  // Věta po dárku.
  ComposedSentence? _sentence;
  bool _saved = false;
  List<GameBadge> _newBadges = const [];
  Timer? _badgeTimer;
  bool _shh = false; // dárek v noci: „pšt"

  // Přání: obrázek slova v bublině, přednostně slabé slovo z batohu.
  Gift? _wish;
  String? _lastWish;
  static final _rng = Random();
  Timer? _wishTimer;

  // Průvodce (stejný jako na mapě a ve hře).
  MascotMood _mood = MascotMood.wave;
  int _taps = 0;

  bool get _asleep =>
      WorldClockService.instance.theme.isNight ||
      SessionService.instance.limitReached;

  bool get _residentEats => StickerKind.of(_resident.emoji).eats;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_asleep && _resident.label.isNotEmpty) {
        TtsService.speak(_resident.label, _language);
      }
    });
    _scheduleWish(const Duration(milliseconds: 1500), always: true);
  }

  /// Za chvíli si zvířátko možná něco přeje (po dárku napůl náhodně).
  void _scheduleWish(Duration after, {bool always = false}) {
    _wishTimer?.cancel();
    _wishTimer = Timer(after, () {
      if (!mounted || _asleep || _wish != null) return;
      if (!always && _rng.nextBool()) return;
      final w = PetLearning.pickWish(_pack, _tray, last: _lastWish, rng: _rng);
      if (w == null) return;
      setState(() => _wish = w);
    });
  }

  void _showBadges(List<GameBadge> badges) {
    if (badges.isEmpty) return;
    setState(() => _newBadges = badges);
    _badgeTimer?.cancel();
    _badgeTimer = Timer(const Duration(seconds: 3), () {
      if (mounted) setState(() => _newBadges = const []);
    });
  }

  @override
  void dispose() {
    _actionTimer?.cancel();
    _badgeTimer?.cancel();
    _wishTimer?.cancel();
    super.dispose();
  }

  void _play(StickerAction? action, String? pose, Duration d,
      {Gift? eating}) {
    _actionTimer?.cancel();
    setState(() {
      _action = action;
      _pose = pose;
      _eating = eating;
    });
    _actionTimer = Timer(d, () {
      if (!mounted) return;
      setState(() {
        _action = null;
        _pose = null;
        _eating = null;
      });
    });
  }

  // ── Gesta na obyvateli ─────────────────────────────────────────────────

  /// Ťuknutí: řekne jméno; tři rychlá ťuknutí = šimrání (zachichotá se).
  void _onTap() {
    if (_asleep) {
      setState(() => _shh = true);
      return;
    }
    final now = DateTime.now();
    _quickTaps
      ..add(now)
      ..removeWhere((t) => now.difference(t) > const Duration(milliseconds: 700));
    if (_quickTaps.length >= 3) {
      _quickTaps.clear();
      AudioService.instance.play(Sfx.babble, volume: 0.7);
      _play(StickerAction.happy, 'happy', const Duration(milliseconds: 1400));
      return;
    }
    AudioService.instance.play(Sfx.tap);
    if (_resident.label.isNotEmpty) {
      TtsService.speak(_resident.label, _language);
    }
  }

  void _onStrokeStart(DragStartDetails _) => _stroke = 0;

  /// Hlazení = prst ujede po těle aspoň 80 px (jednou za tah).
  void _onStroke(DragUpdateDetails d) {
    final before = _stroke;
    _stroke += d.delta.distance;
    if (_asleep || before >= 80 || _stroke < 80) return;
    AudioService.instance.play(Sfx.babble, volume: 0.5);
    _play(StickerAction.happy, 'happy', const Duration(milliseconds: 1600));
    setState(() => _poke++);
    ProgressService.instance.recordPetting(_pack.id, _resident.emoji);
    _showBadges(AchievementService.instance.check(const PetAction(), _pack));
  }

  // ── Dárek ──────────────────────────────────────────────────────────────

  /// Dárek přistál na zvířátku. [written] = dítě slovo předtím napsalo
  /// (mini-kolo) → větší radost.
  void _give(Gift gift, {bool written = false}) {
    if (_asleep) {
      setState(() => _shh = true);
      return;
    }
    final isWish = _wish?.id == gift.id;
    AudioService.instance
        .play(isWish || written ? Sfx.success : Sfx.tap);
    if (isWish) {
      _lastWish = gift.id;
      setState(() => _wish = null);
    }
    ProgressService.instance
        .recordGift(_pack.id, _resident.emoji, wish: isWish);
    _showBadges(AchievementService.instance.check(const PetAction(), _pack));
    _scheduleWish(const Duration(seconds: 4));
    final kind = gift.kind;
    final eats = _residentEats;
    final (action, pose) = switch (kind) {
      StickerKind.food when eats => (StickerAction.eat, 'eat'),
      StickerKind.drink when eats => (StickerAction.drink, 'eat'),
      StickerKind.food || StickerKind.drink => (null, null),
      _ => (StickerAction.play, 'happy'),
    };
    _play(action ?? (isWish ? StickerAction.happy : null), pose,
        Duration(milliseconds: isWish || written ? 3200 : 2400),
        eating: gift);
    setState(() => _poke++);
    final sentence = PetSentence.compose(_pack, _resident, gift);
    setState(() {
      _sentence = sentence;
      _saved = false;
      _shh = false;
    });
    if (sentence != null) {
      Future.delayed(const Duration(milliseconds: 900), () {
        if (mounted && _sentence == sentence) _say();
      });
    }
  }

  void _say() {
    final s = _sentence;
    if (s == null) return;
    TtsService.speak(PetSentence.sentenceText(s, _language), _language);
  }

  /// ⭐ = věta do Mé knížky (jednou); odznaky za knížku platí i tady.
  void _save() {
    final s = _sentence;
    if (s == null || _saved) return;
    ProgressService.instance
        .addToBook(_pack.id, PetSentence.sentenceText(s, _language), s.emojis);
    AudioService.instance.play(Sfx.sticker);
    setState(() => _saved = true);
    _showBadges(
        AchievementService.instance.check(const ProgressChanged(), _pack));
  }

  /// Ťuknutí na dárek v tácku: slovo nahlas; u naučeného slova (a když
  /// to rodič nevypnul) nejdřív mini-kolo — napsané slovo dárek „oživí"
  /// a sám doletí ke zvířátku. Zpět = nic se neděje, dárek jde dál dát
  /// i přetažením.
  Future<void> _tapGift(Gift g) async {
    final text = g.lesson?.display ?? g.object?.text ?? '';
    if (text.isNotEmpty) TtsService.speak(text, _language);
    if (g.lesson == null || !SettingsService.instance.petRounds || _asleep) {
      return;
    }
    final stars = await Navigator.of(context).push<int>(MaterialPageRoute(
      builder: (_) => GameScreen(
        pack: _pack,
        unitIndex: widget.unitIndex,
        practice: PetLearning.roundUnit(_pack, g),
      ),
    ));
    if (!mounted || stars == null || stars <= 0) return;
    _give(g, written: true);
  }

  // ── Stavba ─────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListenableBuilder(
        listenable: Listenable.merge(
            [WorldClockService.instance, SessionService.instance]),
        builder: (context, _) {
          final night = _asleep;
          return Stack(
            children: [
              Positioned.fill(child: _backdrop(night)),
              SafeArea(
                child: Column(
                  children: [
                    _topBar(context),
                    Expanded(child: _scene(night)),
                    _sentenceBubble(),
                    GuideAvoid(weight: 4, child: _trayBar()),
                  ],
                ),
              ),
              if (_newBadges.isNotEmpty)
                Positioned(
                  top: 64,
                  left: 0,
                  right: 0,
                  child: Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 8,
                    children: [
                      for (final b in _newBadges) BadgeChip(badge: b),
                    ],
                  ),
                ),
              Positioned.fill(
                child: SafeArea(
                  child: DraggableGuide(
                    place: 'pet',
                    // Objevila se věta / přání → podívat se, jestli
                    // průvodce nezakrývá 🔊 ⭐ nebo bublinu.
                    layoutToken: Object.hash(_sentence?.text, _wish?.id, _shh),
                    mood: _mood,
                    replay: _taps,
                    onTickle: () => setState(() {
                      _mood = MascotMood.wave;
                      _taps++;
                    }),
                    onSettled: () {
                      if (mounted) setState(() => _mood = MascotMood.idle);
                    },
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _backdrop(bool night) => Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/pet/biome-${_biome.name}.webp',
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => Container(color: _biome.ground),
          ),
          // Noc: modrý závoj; den: nic.
          AnimatedContainer(
            duration: const Duration(milliseconds: 800),
            color: night
                ? const Color(0xFF0B1030).withValues(alpha: 0.55)
                : Colors.transparent,
          ),
        ],
      );

  Widget _topBar(BuildContext context) => GuideAvoid(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: Row(
            children: [
              IconButton(
                key: const ValueKey('pet-back'),
                icon: const Icon(Icons.arrow_back_rounded,
                    color: Colors.white, size: 26),
                onPressed: () => Navigator.of(context).pop(),
              ),
              EmojiArt(_biome.emoji, size: 22),
              const SizedBox(width: 8),
              Flexible(
                child: Text(
                  _resident.label,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontFamily: kFont,
                    fontFamilyFallback: kFontFallback,
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                    shadows: const [
                      Shadow(color: Colors.black54, blurRadius: 6),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );

  Widget _scene(bool night) {
    final secretOwned = ProgressService.instance
        .collectibles(_pack.id)
        .contains(_biome.secret);
    return LayoutBuilder(builder: (context, box) {
      final size = (box.biggest.shortestSide * 0.32).clamp(80.0, 220.0);
      final ground = box.maxHeight * 0.72;
      final lift = _lift ?? Offset.zero;
      return Stack(
        clipBehavior: Clip.none,
        children: [
          // Miska s jídlem a s vodou u nohou (póza spánku má vlastní polštář).
          Positioned(
            left: box.maxWidth / 2 - size * 1.25,
            top: ground + size * 0.05,
            child: _prop('bowl-food', size * 0.45),
          ),
          Positioned(
            left: box.maxWidth / 2 + size * 0.8,
            top: ground + size * 0.05,
            child: _prop('bowl-water', size * 0.45),
          ),
          // Tajná nálepka biotopu bydlí s ním.
          if (secretOwned)
            Positioned(
              left: box.maxWidth / 2 - size * 1.3,
              top: ground - size * 0.6,
              child: GuideAvoid(
                child: EmojiArt(
                  _biome.secret,
                  key: const ValueKey('pet-secret'),
                  size: size * 0.42,
                  action: night ? StickerAction.sleep : null,
                  pose: night ? 'sleep' : null,
                ),
              ),
            ),
          // Obyvatel.
          AnimatedPositioned(
            duration: _lift == null
                ? const Duration(milliseconds: 500)
                : Duration.zero,
            curve: Curves.elasticOut,
            left: box.maxWidth / 2 - size * 0.6 + lift.dx,
            top: ground - size * 0.9 + lift.dy,
            child: GuideAvoid(weight: 4, child: _residentWidget(size, night)),
          ),
          // Dárek u pusy, dokud ho jí / hraje si s ním.
          if (_eating case final g?)
            Positioned(
              left: box.maxWidth / 2 + size * 0.35,
              top: ground - size * 0.2,
              child: TweenAnimationBuilder<double>(
                key: ValueKey('eating-${g.id}-$_poke'),
                tween: Tween(begin: 1, end: g.kind.giftable &&
                        g.kind != StickerKind.toy && _residentEats
                    ? 0.0
                    : 1.0),
                duration: const Duration(milliseconds: 2200),
                builder: (context, t, child) =>
                    Transform.scale(scale: t, child: child),
                child: EmojiArt(g.emoji,
                    size: size * 0.3,
                    action: g.kind == StickerKind.toy
                        ? StickerAction.play
                        : StickerAction.eat),
              ),
            ),
          // Přání: bublina s obrázkem slova nad zvířátkem.
          if (_wish case final w? when !night)
            Positioned(
              left: box.maxWidth / 2 + size * 0.25,
              top: ground - size * 1.35,
              child: GestureDetector(
                onTap: () => TtsService.speak(
                    w.lesson?.display ?? w.object?.text ?? '', _language),
                child: _bubble(
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text('💭', style: TextStyle(fontSize: 22)),
                      const SizedBox(width: 4),
                      EmojiArt(w.emoji, size: 32),
                    ],
                  ),
                  key: const ValueKey('pet-wish'),
                ),
              ),
            ),
          if (_shh)
            Positioned(
              left: box.maxWidth / 2 + size * 0.2,
              top: ground - size * 1.25,
              child: _bubble(const Text('🤫 💤', style: TextStyle(fontSize: 26)),
                  key: const ValueKey('pet-shh')),
            ),
        ],
      );
    });
  }

  Widget _prop(String name, double size) => Image.asset(
        'assets/pet/prop-$name.webp',
        width: size,
        height: size,
        errorBuilder: (_, __, ___) => SizedBox(width: size, height: size),
      );

  Widget _residentWidget(double size, bool night) {
    final sleeping = night && _action == null;
    final resident = DragTarget<Gift>(
      onWillAcceptWithDetails: (_) => true,
      onAcceptWithDetails: (d) => _give(d.data),
      builder: (context, candidates, _) => AnimatedScale(
        // Dárek nad zvířátkem: natáhne se k němu.
        scale: candidates.isNotEmpty ? 1.12 : (_lift != null ? 1.15 : 1),
        duration: const Duration(milliseconds: 180),
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onPanStart: _onStrokeStart,
          onPanUpdate: _onStroke,
          onLongPressStart: (_) => setState(() => _lift = Offset.zero),
          onLongPressMoveUpdate: (d) =>
              setState(() => _lift = d.offsetFromOrigin),
          onLongPressEnd: (_) => setState(() => _lift = null),
          child: EmojiArt(
            _resident.emoji,
            key: const ValueKey('pet-resident'),
            size: size,
            action: sleeping ? StickerAction.sleep : _action,
            pose: sleeping ? 'sleep' : _pose,
            trigger: _poke,
            onTap: _onTap,
          ),
        ),
      ),
    );
    return resident;
  }

  Widget _bubble(Widget child, {Key? key}) => Container(
        key: key,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(color: Colors.black26, blurRadius: 10),
          ],
        ),
        child: child,
      );

  Widget _sentenceBubble() {
    final s = _sentence;
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: s == null
          ? const SizedBox(height: 8)
          : Padding(
              key: ValueKey(s.text),
              padding: const EdgeInsets.fromLTRB(16, 4, 16, 8),
              child: GuideAvoid(
                child: _bubble(
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      for (final p in [s.subject, s.verb, s.object])
                        if (p != null)
                          Padding(
                            padding: const EdgeInsets.only(right: 4),
                            child: EmojiArt(p.emoji, size: 22),
                          ),
                      const SizedBox(width: 6),
                      Flexible(
                        child: Text(
                          PetSentence.sentenceText(s, _language),
                          key: const ValueKey('pet-sentence'),
                          style: TextStyle(
                            fontFamily: kFont,
                            fontFamilyFallback: kFontFallback,
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                            color: const Color(0xFF2B2B44),
                          ),
                        ),
                      ),
                      IconButton(
                        key: const ValueKey('pet-say'),
                        onPressed: _say,
                        icon: const Text('🔊', style: TextStyle(fontSize: 22)),
                      ),
                      IconButton(
                        key: const ValueKey('pet-save'),
                        onPressed: _saved ? null : _save,
                        icon: AnimatedScale(
                          scale: _saved ? 1.25 : 1,
                          duration: const Duration(milliseconds: 250),
                          child: Text(_saved ? '📖' : '⭐',
                              style: const TextStyle(fontSize: 22)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  Widget _trayBar() => Container(
        height: 92,
        decoration: BoxDecoration(
          color: const Color(0xFF1A1A2E).withValues(alpha: 0.78),
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: ListView(
          key: const ValueKey('pet-tray'),
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          children: [
            for (final g in _tray)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6),
                child: Draggable<Gift>(
                  key: ValueKey('gift-${g.id}'),
                  data: g,
                  feedback: Material(
                    color: Colors.transparent,
                    child: EmojiArt(g.emoji, size: 56, animate: false),
                  ),
                  childWhenDragging: Opacity(
                    opacity: 0.3,
                    child: EmojiArt(g.emoji, size: 44, animate: false),
                  ),
                  child: EmojiArt(g.emoji,
                      size: 44, onTap: () => _tapGift(g)),
                ),
              ),
          ],
        ),
      );
}
