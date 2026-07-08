import 'package:flutter/material.dart';
import '../data/lessons.dart';
import '../data/models/content_pack.dart';
import '../services/pack_service.dart';
import '../services/progress_service.dart';
import '../widgets/language_picker.dart';
import 'game_screen.dart';

/// Mapa lekcí: svislá cesta jednotek a jejich uzlů (lekcí).
/// Vstupní obrazovka hry — tap na odemčený uzel spouští GameScreen.
class LessonMapScreen extends StatefulWidget {
  final Language language;
  final ValueChanged<Language> onLanguageChanged;

  const LessonMapScreen({
    super.key,
    required this.language,
    required this.onLanguageChanged,
  });

  @override
  State<LessonMapScreen> createState() => _LessonMapScreenState();
}

class _LessonMapScreenState extends State<LessonMapScreen> {
  ContentPack? _pack;

  @override
  void initState() {
    super.initState();
    _loadPack();
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
    }
  }

  Future<void> _openLesson(int unitIndex, int lessonIndex) async {
    final pack = _pack!;
    await Navigator.of(context).push(MaterialPageRoute(
      builder: (_) => GameScreen(
        pack: pack,
        unitIndex: unitIndex,
        startLessonIndex: lessonIndex,
      ),
    ));
    if (mounted) setState(() {}); // po návratu překreslit postup
  }

  @override
  Widget build(BuildContext context) {
    final pack = _pack;
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF1A1A2E), Color(0xFF16213E), Color(0xFF0F3460)],
        ),
      ),
      child: SafeArea(
        child: pack == null
            ? const Center(
                child: Text('🎹', style: TextStyle(fontSize: 64)))
            : Column(
                children: [
                  // ── Top bar ────────────────────────────────────────────
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 4),
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
                            style: const TextStyle(
                              fontFamily: 'Nunito',
                              fontSize: 15,
                              fontWeight: FontWeight.w900,
                              color: Color(0xFFFFD200),
                            ),
                          ),
                        ),
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
                    child: ListView.builder(
                      padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
                      itemCount: pack.units.length,
                      itemBuilder: (context, u) => _UnitBlock(
                        pack: pack,
                        unitIndex: u,
                        onLessonTap: (l) => _openLesson(u, l),
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

class _UnitBlock extends StatelessWidget {
  final ContentPack pack;
  final int unitIndex;
  final ValueChanged<int> onLessonTap;

  const _UnitBlock({
    required this.pack,
    required this.unitIndex,
    required this.onLessonTap,
  });

  @override
  Widget build(BuildContext context) {
    final progress = ProgressService.instance;
    final unit = pack.units[unitIndex];
    final unitUnlocked = progress.isUnitUnlocked(pack, unitIndex);
    final unitCompleted = progress.isUnitCompleted(pack, unitIndex);
    final hasReward =
        progress.collectibles(pack.id).contains(unit.reward.emoji);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Hlavička jednotky
        Container(
          margin: const EdgeInsets.only(top: 14, bottom: 10),
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
              Opacity(
                opacity: hasReward ? 1.0 : 0.45,
                child: Text(
                  hasReward ? unit.reward.emoji : '❓',
                  style: const TextStyle(fontSize: 22),
                ),
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
            progress.isCompleted(
                pack.id, unit.lessons[lessonIndex - 1].id));
    final isCurrent = unlocked && !completed;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: GestureDetector(
        onTap: unlocked ? onTap : null,
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
