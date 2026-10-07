import 'dart:async';

import 'package:flutter/material.dart';
import '../audio/audio_service.dart';
import '../characters/draggable_guide.dart';
import '../characters/mascot.dart';
import '../data/lessons.dart';
import '../data/models/content_pack.dart';
import '../services/achievement_service.dart';
import '../services/entitlement_service.dart';
import '../services/pack_service.dart';
import '../services/profile_service.dart';
import '../services/progress_service.dart';
import '../services/session_service.dart';
import '../services/tts_service.dart';
import '../widgets/badge_chip.dart';
import '../widgets/language_picker.dart';
import '../world/biome_band.dart';
import '../world/particle_layer.dart';
import '../world/world_backdrop.dart';
import '../world/world_clock.dart';
import 'game_screen.dart';
import 'unit_complete_screen.dart' show stickerHeroTag;
import '../ui/app_font.dart';
import '../ui/l10n.dart';
import '../ui/emoji_art.dart';

/// Mapa lekcí: svislá cesta jednotek a jejich uzlů (lekcí).
/// Vstupní obrazovka hry — tap na odemčený uzel spouští GameScreen.
class LessonMapScreen extends StatefulWidget {
  final Language language;
  final ValueChanged<Language> onLanguageChanged;

  /// Tap na batoh slov → builder vět.
  final VoidCallback? onOpenBag;

  const LessonMapScreen({
    super.key,
    required this.language,
    required this.onLanguageChanged,
    this.onOpenBag,
  });

  @override
  State<LessonMapScreen> createState() => LessonMapScreenState();
}

class LessonMapScreenState extends State<LessonMapScreen> {
  ContentPack? _pack;

  // Průvodce: zamává při příchodu, v noci spí; pozdraví jménem (jednou).
  MascotMood _mood = MascotMood.wave;
  bool _greeted = false;

  void _greet() {
    if (_greeted) return;
    _greeted = true;
    final world = WorldClockService.instance.theme;
    TtsService.speak(
      Mascot.greeting(
          widget.language, ProfileService.instance.addressIn(widget.language),
          night: world.isNight),
      widget.language,
    );
  }

  /// Ťuknutí na Pandičku = zamává (pokaždé znovu, i v noci).
  int _taps = 0;

  void _tickle() {
    AudioService.instance.play(Sfx.tap);
    setState(() {
      _mood = MascotMood.wave;
      _taps++;
    });
  }

  // Průvodce na ploše mapy — stejný jako ve hře ([DraggableGuide]): dá se
  // přetáhnout, uhne z lekcí, po chvíli čte, v noci spí. Po dojetí scrollu
  // se podívá, jestli mu pod nohy nepřijela lekce.
  int _scrollStops = 0;

  Widget _guide(BuildContext context) => Positioned.fill(
        child: SafeArea(
          child: DraggableGuide(
            place: 'map',
            mascotKey: const ValueKey('map-mascot'),
            mood: _mood,
            replay: _taps,
            layoutToken: _scrollStops,
            onTickle: _tickle,
            onSettled: () {
              if (mounted) setState(() => _mood = MascotMood.idle);
            },
          ),
        ),
      );

  // Tajná nálepka právě nalezená (čip ✨ na 3 s).
  String? _foundSecret;
  Timer? _secretTimer;

  // Odznaky za otevření mapy (noční sova, ranní ptáče, období, vytrvalec).
  List<GameBadge> _newBadges = const [];
  Timer? _badgeTimer;

  // Posun mapy pro parallax pozadí (mraky, hvězdy).
  final _scroll = ScrollController();
  final _scrollOffset = ValueNotifier<double>(0);

  /// Na tabletu a desktopu drží cesta rozumnou šířku uprostřed.
  static const double _maxContentWidth = 640;

  @override
  void initState() {
    super.initState();
    _loadPack();
    _scroll.addListener(() => _scrollOffset.value = _scroll.offset);
    WorldClockService.instance.addListener(_syncAmbient);
    SessionService.instance.addListener(_onSessionChanged);
  }

  @override
  void dispose() {
    WorldClockService.instance.removeListener(_syncAmbient);
    SessionService.instance.removeListener(_onSessionChanged);
    AudioService.instance.setAmbient(null);
    AudioService.instance.setMusic(false);
    _badgeTimer?.cancel();
    _secretTimer?.cancel();
    _scroll.dispose();
    _scrollOffset.dispose();
    super.dispose();
  }

  /// Dítě našlo ✨ v kousku světa: nálepka biotopu do Zvěřince.
  /// Časový limit: průvodce spí, nic se nespouští, „dobrou noc" nahlas (jednou).
  bool get _bedtime => SessionService.instance.limitReached;
  bool _saidGoodNight = false;

  void _onSessionChanged() {
    if (!mounted) return;
    setState(() {});
    if (_bedtime && !_saidGoodNight) {
      _saidGoodNight = true;
      TtsService.speak(
        Mascot.greeting(
            widget.language, ProfileService.instance.addressIn(widget.language),
            night: true),
        widget.language,
      );
    }
    if (!_bedtime) _saidGoodNight = false;
  }

  /// Sezónní nálepka: schovaná na právě rozehrané jednotce, jen v tomhle
  /// období (zimní překvapení jde najít jen v zimě).
  void _findSeasonal(Season season) => _findSecret(null, seasonal: season);

  /// Dítě našlo ✨ v kousku světa: nálepka biotopu (nebo sezónní) do Zvěřince.
  void _findSecret(Biome? biome, {Season? seasonal}) {
    final pack = _pack;
    if (pack == null || _bedtime) return;
    final emoji = seasonal?.secret ?? biome!.secret;
    ProgressService.instance.addCollectible(pack.id, emoji);
    AudioService.instance.play(Sfx.sticker);
    _secretTimer?.cancel();
    setState(() => _foundSecret = emoji);
    _secretTimer = Timer(const Duration(seconds: 3), () {
      if (mounted) setState(() => _foundSecret = null);
    });
    _showBadges(
        AchievementService.instance.check(const ProgressChanged(), pack));
  }

  void _showBadges(List<GameBadge> badges) {
    if (badges.isEmpty) return;
    _badgeTimer?.cancel();
    setState(() => _newBadges = badges);
    _badgeTimer = Timer(const Duration(seconds: 4), () {
      if (mounted) setState(() => _newBadges = const []);
    });
  }

  /// Ambient podle biotopu, kde dítě právě hraje (první nedokončená
  /// jednotka), a denní doby. Hraje jen dokud je mapa vidět.
  bool _ambientActive = true;

  void _syncAmbient() {
    final pack = _pack;
    final audio = AudioService.instance;
    if (!_ambientActive || pack == null) {
      audio.setAmbient(null);
      audio.setMusic(false);
      return;
    }
    final theme = WorldClockService.instance.theme;
    final at = ProgressService.instance.firstUncompletedIn(pack);
    final unit = pack.units[at?.unit ?? pack.units.length - 1];
    audio.setAmbient(theme.ambientFor(Biome.parse(unit.biome)));
    audio.setMusic(true, quiet: theme.isNight);
  }

  /// HomeShell: mapa je / není v popředí (jiný pohled, appka na pozadí).
  void setAmbientActive(bool active) {
    _ambientActive = active;
    _syncAmbient();
  }

  @override
  void didUpdateWidget(covariant LessonMapScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.language != widget.language) {
      setState(() => _pack = null);
      _loadPack();
    }
  }

  /// Chyba načtení packu (nebo timeout) — místo věčného 🎹 karta s
  /// „Zkusit znovu" a textem chyby pro diagnostiku.
  String? _loadError;

  Future<void> _loadPack() async {
    if (_loadError != null) setState(() => _loadError = null);
    final ContentPack pack;
    try {
      pack = await PackService.instance
          .load(widget.language)
          .timeout(const Duration(seconds: 8));
    } catch (e) {
      // ignore: avoid_print
      print('LessonMapScreen: pack load failed: $e');
      if (mounted) setState(() => _loadError = '$e');
      return;
    }
    // Pack jiného jazyka (fallback en) raději ukázat než nechat mapu na 🎹;
    // jen když mezitím dítě přepnulo jazyk, výsledek zahodit.
    final stillWanted = pack.language == widget.language ||
        PackService.instance.cached(widget.language) == null;
    if (mounted && stillWanted) {
      setState(() => _pack = pack);
      _syncAmbient();
      _greet();
      _showBadges(
          AchievementService.instance.check(const SessionStart(), pack));
    }
  }

  Future<void> _openLesson(int unitIndex, int lessonIndex) async {
    if (_bedtime) return;
    final pack = _pack!;
    if (!EntitlementService.instance.unlocked(pack, pack.units[unitIndex])) {
      return;
    }
    AudioService.instance.play(Sfx.tap);
    AudioService.instance.setAmbient(null); // během kola je ticho (jen hra)
    AudioService.instance.setMusic(false);
    await Navigator.of(context).push(MaterialPageRoute(
      builder: (_) => GameScreen(
        pack: pack,
        unitIndex: unitIndex,
        startLessonIndex: lessonIndex,
      ),
    ));
    if (mounted) {
      setState(() {}); // po návratu překreslit postup
      _syncAmbient();
    }
  }

  /// Kolik slov má procvičování a od kolika naučených se nabízí.
  static const _practiceSize = 5;
  static const _practiceMinLearned = 3;

  /// Týdenní výprava: 8 nejslabších slov, od 10 naučených, jednou za 7 dní.
  static const _expeditionSize = 8;
  static const _expeditionMinLearned = 10;

  Future<void> _openExpedition(List<Lesson> lessons) async {
    if (_bedtime) return;
    AudioService.instance.play(Sfx.tap);
    AudioService.instance.setAmbient(null);
    AudioService.instance.setMusic(false);
    final stars = await Navigator.of(context).push<int>(MaterialPageRoute(
      builder: (_) => GameScreen(
        pack: _pack!,
        unitIndex: 0,
        practice: Unit(
          id: 'expedition',
          title: context.l.expeditionTitle,
          icon: '🧭',
          reward: const CollectibleReward(emoji: '🧭'),
          lessons: lessons,
        ),
      ),
    ));
    if (!mounted) return;
    if (stars != null) {
      // Dohráno celé → výprava se počítá, odznak při první.
      ProgressService.instance.markExpedition(WorldClockService.instance.now());
      AudioService.instance.play(Sfx.sticker);
      _showBadges(
          AchievementService.instance.check(const ProgressChanged(), _pack!));
    }
    setState(() {});
    _syncAmbient();
  }

  Future<void> _openPractice(List<Lesson> lessons) async {
    if (_bedtime) return;
    AudioService.instance.play(Sfx.tap);
    AudioService.instance.setAmbient(null);
    AudioService.instance.setMusic(false);
    await Navigator.of(context).push(MaterialPageRoute(
      builder: (_) => GameScreen(
        pack: _pack!,
        unitIndex: 0,
        practice: Unit(
          id: 'practice',
          title: context.l.practiceTitle,
          icon: '🔁',
          reward: const CollectibleReward(emoji: '🔁'),
          lessons: lessons,
        ),
      ),
    ));
    if (mounted) {
      setState(() {});
      _syncAmbient();
    }
  }

  @override
  Widget build(BuildContext context) {
    // Svět (obloha, částice, biotopy) se překreslí při změně denní doby
    // nebo ručního období; mapa i při změně odemčení (rodič v koutku).
    return ListenableBuilder(
      listenable: Listenable.merge(
          [WorldClockService.instance, EntitlementService.instance]),
      builder: (context, _) {
        final world = WorldClockService.instance.theme;
        return Stack(
          children: [
            Positioned.fill(
                child: WorldBackdrop(theme: world, scroll: _scrollOffset)),
            NotificationListener<ScrollEndNotification>(
              onNotification: (_) {
                setState(() => _scrollStops++);
                return false;
              },
              child: _content(context, world),
            ),
            Positioned.fill(child: ParticleLayer(kind: world.particles)),
            if (_pack != null && !_bedtime) _guide(context),
            if (_foundSecret != null)
              Positioned(
                top: 64,
                left: 0,
                right: 0,
                child: Center(child: _SecretChip(emoji: _foundSecret!)),
              ),
            if (_newBadges.isNotEmpty)
              Positioned(
                bottom: 24,
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
          ],
        );
      },
    );
  }

  Widget _content(BuildContext context, WorldTheme world) {
    final pack = _pack;
    return SafeArea(
      child: pack == null
          ? (_loadError != null
              ? _LoadErrorCard(error: _loadError!, onRetry: _loadPack)
              : const Center(child: Text('🎹', style: TextStyle(fontSize: 64))))
          : Column(
              children: [
                // ── Top bar ────────────────────────────────────────────
                GuideAvoid(
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    child: Row(
                      children: [
                        Builder(
                          builder: (ctx) => IconButton(
                            icon: const Icon(Icons.menu,
                                color: Color(0xFFA0C4FF), size: 22),
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                            onPressed: () => Scaffold.of(ctx).openDrawer(),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            pack.title.isNotEmpty
                                ? pack.title
                                : '🎹 Swype Kids',
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontFamily: kFont,
                              fontFamilyFallback: kFontFallback,
                              fontSize: 15,
                              fontWeight: FontWeight.w900,
                              color: Color(0xFFFFD200),
                            ),
                          ),
                        ),
                        if (pack.allLessons.any((l) => l.vocab.isNotEmpty)) ...[
                          _BagChip(
                            count: ProgressService.instance
                                .wordBag(pack.id)
                                .length,
                            onTap: widget.onOpenBag,
                          ),
                          const SizedBox(width: 8),
                        ],
                        Text(
                          '⭐ ${ProgressService.instance.totalStars(pack.id)}',
                          style: TextStyle(
                            fontFamily: kFont,
                            fontFamilyFallback: kFontFallback,
                            fontSize: 14,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFFFFD200),
                          ),
                        ),
                        const SizedBox(width: 6),
                        LanguagePicker(
                          value: widget.language,
                          onChanged: widget.onLanguageChanged,
                        ),
                      ],
                    ),
                  ),
                ),

                // ── Cesta jednotek ─────────────────────────────────────
                Expanded(
                  child: Stack(
                    children: [
                      Positioned.fill(child: Builder(builder: (context) {
                        final progress = ProgressService.instance;
                        final learned = progress.weakestLearned(pack);
                        final expedition =
                            learned.length >= _expeditionMinLearned &&
                                progress.isExpeditionDue(
                                    WorldClockService.instance.now());
                        final weakest = learned.take(_practiceSize).toList();
                        final showPractice = !expedition &&
                            weakest.length >= _practiceMinLearned;
                        final offset = (showPractice || expedition) ? 1 : 0;
                        // Jen jednotky, které dítě smí hrát; za nimi nejvýš
                        // jeden další ostrov v mlze (bez obchodu celý pack).
                        final playable =
                            EntitlementService.instance.playableUnits(pack);
                        final fogged = [
                          for (var u = 0; u < pack.units.length; u++)
                            if (!playable.contains(u)) u,
                        ];
                        final current = playable
                            .where((u) => !progress.isUnitCompleted(pack, u))
                            .firstOrNull;
                        return Center(
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(
                                maxWidth: _maxContentWidth),
                            child: ListView.builder(
                              controller: _scroll,
                              // Dole místo pro průvodce, ať jde poslední lekce
                              // odscrollovat nad něj.
                              padding: EdgeInsets.fromLTRB(
                                  16,
                                  8,
                                  16,
                                  24 +
                                      DraggableGuide.boxFor(
                                              DraggableGuide.sizeFor(
                                                  MediaQuery.sizeOf(context)))
                                          .height),
                              itemCount: playable.length +
                                  offset +
                                  (fogged.isEmpty ? 0 : 1),
                              itemBuilder: (context, i) {
                                if (expedition && i == 0) {
                                  final trip =
                                      learned.take(_expeditionSize).toList();
                                  return _PracticeCard(
                                    key: const ValueKey('expedition'),
                                    lessons: trip,
                                    expedition: true,
                                    onTap: () => _openExpedition(trip),
                                  );
                                }
                                if (showPractice && i == 0) {
                                  return _PracticeCard(
                                    lessons: weakest,
                                    onTap: () => _openPractice(weakest),
                                  );
                                }
                                if (i - offset >= playable.length) {
                                  return _IslandInFog(
                                    biome: Biome.parse(
                                        pack.units[fogged.first].biome),
                                    world: world,
                                  );
                                }
                                final u = playable[i - offset];
                                return _UnitBlock(
                                  pack: pack,
                                  unitIndex: u,
                                  world: world,
                                  onLessonTap: (l) => _openLesson(u, l),
                                  onSecret: (b) => _findSecret(b),
                                  onSeasonal: _findSeasonal,
                                  isCurrent: current == u,
                                );
                              },
                            ),
                          ),
                        );
                      })),
                      if (_bedtime)
                        Positioned.fill(
                            child: _BedtimeCard(language: widget.language)),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}

/// Po časovém limitu: průvodce spí, mapa nepustí další lekci. Menu zůstává
/// dostupné — rodič prodlouží jen z koutku.
class _BedtimeCard extends StatelessWidget {
  final Language language;

  const _BedtimeCard({required this.language});

  @override
  Widget build(BuildContext context) {
    return Container(
      key: const ValueKey('bedtime'),
      color: const Color(0xFF0B1020).withValues(alpha: 0.6),
      alignment: Alignment.center,
      child: Container(
        margin: const EdgeInsets.all(24),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        decoration: BoxDecoration(
          color: const Color(0xFF1A1A2E),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: Colors.white.withValues(alpha: 0.15)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Mascot(mood: MascotMood.sleep, size: 72),
            const SizedBox(height: 8),
            const Text('🌙 💤', style: TextStyle(fontSize: 32)),
            const SizedBox(height: 6),
            Text(
              context.l.bedtimeText(Mascot.name(language)),
              style: TextStyle(
                fontFamily: kFont,
                fontFamilyFallback: kFontFallback,
                fontSize: 16,
                fontWeight: FontWeight.w800,
                color: Colors.white.withValues(alpha: 0.85),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LoadErrorCard extends StatelessWidget {
  final String error;
  final VoidCallback onRetry;
  const _LoadErrorCard({required this.error, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('🎹 😕', style: TextStyle(fontSize: 56)),
            const SizedBox(height: 10),
            Text(
              context.l.mapLoadFailed,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: kFont,
                fontFamilyFallback: kFontFallback,
                fontSize: 18,
                fontWeight: FontWeight.w900,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 14),
            ElevatedButton(
              key: const ValueKey('retry-load'),
              onPressed: onRetry,
              child: Text(context.l.retry),
            ),
            const SizedBox(height: 14),
            // Text chyby pro rodiče / vývojáře (screenshot do hlášení).
            Text(
              error,
              textAlign: TextAlign.center,
              maxLines: 6,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 11,
                color: Colors.white.withValues(alpha: 0.6),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// „✨ 🐞" — tajná nálepka právě nalezená.
class _SecretChip extends StatelessWidget {
  final String emoji;
  const _SecretChip({required this.emoji});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: const Duration(milliseconds: 600),
      curve: Curves.elasticOut,
      builder: (context, t, child) => Transform.scale(scale: t, child: child),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        decoration: BoxDecoration(
          color: const Color(0xFFFFD200),
          borderRadius: BorderRadius.circular(99),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFFFFD200).withValues(alpha: 0.5),
              blurRadius: 16,
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('✨', style: TextStyle(fontSize: 24)),
            const SizedBox(width: 6),
            EmojiArt(emoji, size: 24),
          ],
        ),
      ),
    );
  }
}

/// Batoh slov: kolik celých slov dítě swyplo (a může použít ve větách).
void _showParentNote(BuildContext context, Lesson lesson) {
  final language = Language.values.firstWhere(
      (l) => lesson.id.startsWith('${l.name}-'),
      orElse: () => Language.cs);
  showModalBottomSheet<void>(
    context: context,
    backgroundColor: const Color(0xFF1A1A2E),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) => SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 18, 20, 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    '👪 ${lesson.display}',
                    style: TextStyle(
                      fontFamily: kFont,
                      fontFamilyFallback: kFontFallback,
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                      color: const Color(0xFFFFD200),
                    ),
                  ),
                ),
                // „Přečti mi to" — rodič si poznámku nechá přečíst (TTS).
                IconButton(
                  key: const ValueKey('read-note'),
                  icon: const Text('🔊', style: TextStyle(fontSize: 24)),
                  onPressed: () =>
                      TtsService.speak(lesson.parentNote, language),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              lesson.parentNote,
              style: TextStyle(
                fontFamily: kFont,
                fontFamilyFallback: kFontFallback,
                fontSize: 15,
                fontWeight: FontWeight.w700,
                height: 1.4,
                color: Colors.white.withOpacity(0.9),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

/// „Dnešní procvičování": nejslabší naučená slova (2–3 minuty hry).
class _PracticeCard extends StatelessWidget {
  final List<Lesson> lessons;
  final VoidCallback onTap;

  /// Týdenní výprava: zlatá, s kompasem — speciální uzel na mapě.
  final bool expedition;

  const _PracticeCard({
    super.key,
    required this.lessons,
    required this.onTap,
    this.expedition = false,
  });

  Color get _accent =>
      expedition ? const Color(0xFFFFD200) : const Color(0xFF1DD1A1);

  @override
  Widget build(BuildContext context) {
    return GuideAvoid(
      weight: 3,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          margin: const EdgeInsets.only(top: 6),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            color: _accent.withOpacity(0.16),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: _accent.withOpacity(0.7)),
          ),
          child: Row(
            children: [
              EmojiArt(expedition ? '🧭' : '🔁', size: 26),
              const SizedBox(width: 10),
              Flexible(
                child: Text(
                  expedition
                      ? context.l.expeditionTitle
                      : context.l.practiceTitle,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontFamily: kFont,
                    fontFamilyFallback: kFontFallback,
                    fontSize: 15,
                    fontWeight: FontWeight.w900,
                    color: expedition
                        ? const Color(0xFFFFD200)
                        : const Color(0xFF7BFFB2),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              // Obrázky slov, ať dítě bez čtení ví, co ho čeká; na úzkém
              // displeji se řádek zkrátí, místo aby přetekl.
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  reverse: true,
                  physics: const NeverScrollableScrollPhysics(),
                  child: Row(
                    children: [
                      for (final l in lessons)
                        Padding(
                          padding: const EdgeInsets.only(left: 2),
                          child: EmojiArt(l.hint, size: 20, animate: false),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Další ostrov za vodou: kousek světa v mlze s loďkou. Dítě na něj
/// nemůže ťuknout a nic o nákupu tu není — ostrov otevírá rodič v koutku
/// (`docs/MONETIZATION.md` §1, zásady 1 a 4).
class _IslandInFog extends StatelessWidget {
  final Biome biome;
  final WorldTheme world;

  const _IslandInFog({required this.biome, required this.world});

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      key: const ValueKey('island-in-fog'),
      child: ExcludeSemantics(
        child: BiomeBand(
          biome: biome,
          theme: world,
          locked: true,
          child: const SizedBox(
            height: 132,
            child: Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  EmojiArt('⛵', size: 30, animate: false),
                  SizedBox(width: 18),
                  EmojiArt('🏝️', size: 44, animate: false),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _BagChip extends StatelessWidget {
  final int count;
  final VoidCallback? onTap;

  const _BagChip({required this.count, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.08),
          borderRadius: BorderRadius.circular(99),
          border: Border.all(
              color:
                  const Color(0xFF1DD1A1).withOpacity(count > 0 ? 0.6 : 0.2)),
        ),
        child: Text(
          '🎒 $count',
          style: TextStyle(
            fontFamily: kFont,
            fontFamilyFallback: kFontFallback,
            fontSize: 13,
            fontWeight: FontWeight.w800,
            color: Color(0xFF7BFFB2),
          ),
        ),
      ),
    );
  }
}

class _UnitBlock extends StatelessWidget {
  final ContentPack pack;
  final int unitIndex;
  final WorldTheme world;
  final ValueChanged<int> onLessonTap;
  final ValueChanged<Biome> onSecret;
  final ValueChanged<Season> onSeasonal;

  /// Jednotka, kde dítě právě hraje — jen tam je sezónní překvapení.
  final bool isCurrent;

  const _UnitBlock({
    required this.pack,
    required this.unitIndex,
    required this.world,
    required this.onLessonTap,
    required this.onSecret,
    required this.onSeasonal,
    this.isCurrent = false,
  });

  @override
  Widget build(BuildContext context) {
    final progress = ProgressService.instance;
    final unit = pack.units[unitIndex];
    final unitUnlocked =
        EntitlementService.instance.unitOpen(pack, unitIndex);
    final unitCompleted = progress.isUnitCompleted(pack, unitIndex);
    final hasReward = progress.hasCollectible(pack.id, unit.reward);
    final revealed = progress.isUnitRevealed(pack.id, unit.id);
    final biome = Biome.parse(unit.biome);
    final secretFound = progress.collectibles(pack.id).contains(biome.secret);
    final seasonFound =
        progress.collectibles(pack.id).contains(world.season.secret);

    // Každá jednotka je kousek světa: biotop z packu, mlha dokud je zamčená.
    return BiomeBand(
      biome: biome,
      theme: world,
      // Tajná nálepka: nenápadné ✨, po nalezení zmizí (žádný text — průzkum).
      seasonal: isCurrent && !seasonFound
          ? GestureDetector(
              key: ValueKey('seasonal-${unit.id}'),
              onTap: () => onSeasonal(world.season),
              child: Opacity(
                opacity: 0.6,
                child: Text(world.season.emoji,
                    style: const TextStyle(fontSize: 16)),
              ),
            )
          : null,
      hidden: secretFound
          ? null
          : GestureDetector(
              key: ValueKey('secret-${unit.id}'),
              onTap: () => onSecret(biome),
              child: const Opacity(
                opacity: 0.55,
                child: Text('✨', style: TextStyle(fontSize: 18)),
              ),
            ),
      locked: !unitUnlocked,
      revealing: unitUnlocked && !revealed,
      onRevealed: () => progress.markUnitRevealed(pack.id, unit.id),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Hlavička jednotky
            Container(
              margin: const EdgeInsets.only(top: 10, bottom: 10),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(unitUnlocked ? 0.08 : 0.04),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: unitCompleted
                      ? const Color(0xFFFFD200).withOpacity(0.5)
                      : Colors.white.withOpacity(0.1),
                ),
              ),
              child: Row(
                children: [
                  Opacity(
                      opacity: unitUnlocked ? 1.0 : 0.3,
                      child:
                          EmojiArt(unit.icon, size: 22, animate: unitUnlocked)),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      unit.title,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontFamily: kFont,
                        fontFamilyFallback: kFontFallback,
                        fontSize: 15,
                        fontWeight: FontWeight.w900,
                        color: unitUnlocked
                            ? Colors.white.withOpacity(0.9)
                            : Colors.white.withOpacity(0.3),
                      ),
                    ),
                  ),
                  // Odměna jednotky
                  // Místo přistání nálepky z UnitCompleteScreen (Hero).
                  Hero(
                    tag: stickerHeroTag(pack.id, unitIndex),
                    child: Opacity(
                      opacity: hasReward ? 1.0 : 0.45,
                      child: SizedBox(
                        width: 28,
                        height: 28,
                        child: FittedBox(
                          child: EmojiArt(
                            hasReward ? unit.reward.emoji : '❓',
                            size: 22,
                            animate: false,
                          ),
                        ),
                      ),
                    ),
                  ),
                  // V noci zvířátka spí — signál „už je čas spát".
                  if (hasReward && world.isNight)
                    const Padding(
                      padding: EdgeInsets.only(left: 2),
                      child: Text('💤', style: TextStyle(fontSize: 14)),
                    ),
                ],
              ),
            ),

            // Uzly lekcí — hadovitě odsazené
            for (var l = 0; l < unit.lessons.length; l++)
              Align(
                alignment: l.isEven
                    ? const Alignment(-0.35, 0)
                    : const Alignment(0.35, 0),
                child: _LessonNode(
                  key: ValueKey('lesson-${unit.lessons[l].id}'),
                  pack: pack,
                  unitIndex: unitIndex,
                  lessonIndex: l,
                  unitUnlocked: unitUnlocked,
                  onTap: () => onLessonTap(l),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _LessonNode extends StatelessWidget {
  final ContentPack pack;
  final int unitIndex;
  final int lessonIndex;
  final bool unitUnlocked;
  final VoidCallback onTap;

  const _LessonNode({
    super.key,
    required this.pack,
    required this.unitIndex,
    required this.lessonIndex,
    required this.unitUnlocked,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final progress = ProgressService.instance;
    final unit = pack.units[unitIndex];
    final lesson = unit.lessons[lessonIndex];
    final stars = progress.starsFor(pack.id, lesson.id);
    final completed = stars > 0;
    final unlocked = unitUnlocked &&
        (lessonIndex == 0 ||
            progress.isCompleted(pack.id, unit.lessons[lessonIndex - 1].id));
    final isCurrent = unlocked && !completed;

    return GuideAvoid(
      weight: 4,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: GestureDetector(
          onTap: unlocked ? onTap : null,
          // Dlouhý stisk = poznámka pro rodiče (do v3.1 rodičovského koutku).
          onLongPress: lesson.parentNote.isEmpty
              ? null
              : () => _showParentNote(context, lesson),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: completed
                      ? const Color(0xFF1DD1A1).withOpacity(0.25)
                      : unlocked
                          ? const Color(0xFF54A0FF).withOpacity(0.25)
                          : Colors.white.withOpacity(0.05),
                  border: Border.all(
                    width: isCurrent ? 3 : 2,
                    color: completed
                        ? const Color(0xFF1DD1A1)
                        : isCurrent
                            ? const Color(0xFFFFD200)
                            : Colors.white.withOpacity(0.15),
                  ),
                  boxShadow: isCurrent
                      ? [
                          BoxShadow(
                            color: const Color(0xFFFFD200).withOpacity(0.4),
                            blurRadius: 16,
                            spreadRadius: 1,
                          ),
                        ]
                      : null,
                ),
                alignment: Alignment.center,
                child: EmojiArt(
                  unlocked || completed
                      ? (lesson.type == LessonType.listen ? '🔊' : lesson.hint)
                      : '🔒',
                  size: unlocked ? 28 : 22,
                  animate: unlocked || completed,
                ),
              ),
              SizedBox(
                height: 16,
                child: Text(
                  completed ? '⭐' * stars : '',
                  style: const TextStyle(fontSize: 10),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
