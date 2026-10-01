import 'package:flutter/material.dart';
import '../audio/audio_service.dart';
import '../data/lessons.dart';
import '../data/models/content_pack.dart';
import '../services/pack_service.dart';
import '../services/progress_service.dart';
import '../widgets/language_picker.dart';
import '../world/biome_band.dart';
import '../world/particle_layer.dart';
import '../world/world_backdrop.dart';
import '../world/world_clock.dart';
import 'game_screen.dart';
import 'unit_complete_screen.dart' show stickerHeroTag;

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
  }

  @override
  void dispose() {
    WorldClockService.instance.removeListener(_syncAmbient);
    AudioService.instance.setAmbient(null);
    _scroll.dispose();
    _scrollOffset.dispose();
    super.dispose();
  }

  /// Ambient podle biotopu, kde dítě právě hraje (první nedokončená
  /// jednotka), a denní doby. Hraje jen dokud je mapa vidět.
  bool _ambientActive = true;

  void _syncAmbient() {
    final pack = _pack;
    if (!_ambientActive || pack == null) {
      AudioService.instance.setAmbient(null);
      return;
    }
    final at = ProgressService.instance.firstUncompletedIn(pack);
    final unit = pack.units[at?.unit ?? pack.units.length - 1];
    AudioService.instance.setAmbient(
        WorldClockService.instance.theme.ambientFor(Biome.parse(unit.biome)));
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

  Future<void> _loadPack() async {
    final pack = await PackService.instance.load(widget.language);
    if (mounted && pack.language == widget.language) {
      setState(() => _pack = pack);
      _syncAmbient();
    }
  }

  Future<void> _openLesson(int unitIndex, int lessonIndex) async {
    final pack = _pack!;
    AudioService.instance.play(Sfx.tap);
    AudioService.instance.setAmbient(null); // během kola je ticho (jen hra)
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

  Future<void> _openPractice(List<Lesson> lessons) async {
    AudioService.instance.play(Sfx.tap);
    AudioService.instance.setAmbient(null);
    await Navigator.of(context).push(MaterialPageRoute(
      builder: (_) => GameScreen(
        pack: _pack!,
        unitIndex: 0,
        practice: Unit(
          id: 'practice',
          title: 'Procvičování',
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
    // nebo ručního období.
    return ListenableBuilder(
      listenable: WorldClockService.instance,
      builder: (context, _) {
        final world = WorldClockService.instance.theme;
        return Stack(
          children: [
            Positioned.fill(
                child: WorldBackdrop(theme: world, scroll: _scrollOffset)),
            _content(context, world),
            Positioned.fill(child: ParticleLayer(kind: world.particles)),
          ],
        );
      },
    );
  }

  Widget _content(BuildContext context, WorldTheme world) {
    final pack = _pack;
    return SafeArea(
      child: pack == null
          ? const Center(child: Text('🎹', style: TextStyle(fontSize: 64)))
          : Column(
              children: [
                // ── Top bar ────────────────────────────────────────────
                Padding(
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
                          pack.title.isNotEmpty ? pack.title : '🎹 Swype Kids',
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontFamily: 'Nunito',
                            fontSize: 15,
                            fontWeight: FontWeight.w900,
                            color: Color(0xFFFFD200),
                          ),
                        ),
                      ),
                      if (pack.allLessons.any((l) => l.vocab.isNotEmpty)) ...[
                        _BagChip(
                          count:
                              ProgressService.instance.wordBag(pack.id).length,
                          onTap: widget.onOpenBag,
                        ),
                        const SizedBox(width: 8),
                      ],
                      Text(
                        '⭐ ${ProgressService.instance.totalStars(pack.id)}',
                        style: const TextStyle(
                          fontFamily: 'Nunito',
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

                // ── Cesta jednotek ─────────────────────────────────────
                Expanded(
                  child: Builder(builder: (context) {
                    final weakest = ProgressService.instance
                        .weakestLearned(pack, limit: _practiceSize);
                    final showPractice = weakest.length >= _practiceMinLearned;
                    final offset = showPractice ? 1 : 0;
                    return Center(
                      child: ConstrainedBox(
                        constraints:
                            const BoxConstraints(maxWidth: _maxContentWidth),
                        child: ListView.builder(
                          controller: _scroll,
                          padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
                          itemCount: pack.units.length + offset,
                          itemBuilder: (context, i) {
                            if (showPractice && i == 0) {
                              return _PracticeCard(
                                lessons: weakest,
                                onTap: () => _openPractice(weakest),
                              );
                            }
                            final u = i - offset;
                            return _UnitBlock(
                              pack: pack,
                              unitIndex: u,
                              world: world,
                              onLessonTap: (l) => _openLesson(u, l),
                            );
                          },
                        ),
                      ),
                    );
                  }),
                ),
              ],
            ),
    );
  }
}

/// Batoh slov: kolik celých slov dítě swyplo (a může použít ve větách).
void _showParentNote(BuildContext context, Lesson lesson) {
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
            Text(
              '👪 ${lesson.display}',
              style: const TextStyle(
                fontFamily: 'Nunito',
                fontSize: 18,
                fontWeight: FontWeight.w900,
                color: Color(0xFFFFD200),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              lesson.parentNote,
              style: TextStyle(
                fontFamily: 'Nunito',
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

  const _PracticeCard({required this.lessons, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(top: 6),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: const Color(0xFF1DD1A1).withOpacity(0.16),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFF1DD1A1).withOpacity(0.7)),
        ),
        child: Row(
          children: [
            const Text('🔁', style: TextStyle(fontSize: 26)),
            const SizedBox(width: 10),
            const Text(
              'Procvičování',
              style: TextStyle(
                fontFamily: 'Nunito',
                fontSize: 15,
                fontWeight: FontWeight.w900,
                color: Color(0xFF7BFFB2),
              ),
            ),
            const Spacer(),
            // Obrázky slov, ať dítě bez čtení ví, co ho čeká.
            Text(
              lessons.map((l) => l.hint).join(' '),
              style: const TextStyle(fontSize: 20),
            ),
          ],
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
          style: const TextStyle(
            fontFamily: 'Nunito',
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

  const _UnitBlock({
    required this.pack,
    required this.unitIndex,
    required this.world,
    required this.onLessonTap,
  });

  @override
  Widget build(BuildContext context) {
    final progress = ProgressService.instance;
    final unit = pack.units[unitIndex];
    final unitUnlocked = progress.isUnitUnlocked(pack, unitIndex);
    final unitCompleted = progress.isUnitCompleted(pack, unitIndex);
    final hasReward = progress.hasCollectible(pack.id, unit.reward);
    final revealed = progress.isUnitRevealed(pack.id, unit.id);

    // Každá jednotka je kousek světa: biotop z packu, mlha dokud je zamčená.
    return BiomeBand(
      biome: Biome.parse(unit.biome),
      theme: world,
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
                  Text(unit.icon,
                      style: TextStyle(
                          fontSize: 22,
                          color: Colors.white
                              .withOpacity(unitUnlocked ? 1.0 : 0.3))),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      unit.title,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontFamily: 'Nunito',
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
                          child: Text(
                            hasReward ? unit.reward.emoji : '❓',
                            style: const TextStyle(fontSize: 22),
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

    return Padding(
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
              child: Text(
                unlocked || completed
                    ? (lesson.type == LessonType.listen ? '🔊' : lesson.hint)
                    : '🔒',
                style: TextStyle(fontSize: unlocked ? 28 : 22),
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
    );
  }
}
