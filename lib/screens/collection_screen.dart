import 'package:flutter/material.dart';
import '../data/lessons.dart';
import '../data/models/content_pack.dart';
import '../services/achievement_service.dart';
import '../services/pack_service.dart';
import '../services/progress_service.dart';

/// Zvěřinec — nálepkové album sběratelských odměn aktuálního jazyka.
/// Nezískané nálepky jsou šedé ❓.
class CollectionScreen extends StatefulWidget {
  final Language language;

  const CollectionScreen({super.key, required this.language});

  @override
  State<CollectionScreen> createState() => _CollectionScreenState();
}

class _CollectionScreenState extends State<CollectionScreen> {
  ContentPack? _pack;

  @override
  void initState() {
    super.initState();
    _loadPack();
  }

  @override
  void didUpdateWidget(covariant CollectionScreen oldWidget) {
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

  @override
  Widget build(BuildContext context) {
    final pack = _pack;
    final owned =
        pack == null ? const <String>[] : ProgressService.instance.collectibles(pack.id);

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
                child: Text('🏅', style: TextStyle(fontSize: 64)))
            : Column(
                children: [
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
                        const Text(
                          '🏅 Zvěřinec',
                          style: TextStyle(
                            fontFamily: 'Nunito',
                            fontSize: 16,
                            fontWeight: FontWeight.w900,
                            color: Color(0xFFFFD200),
                          ),
                        ),
                        const Spacer(),
                        Text(
                          '${owned.length}/${pack.units.length}',
                          style: const TextStyle(
                            fontFamily: 'Nunito',
                            fontSize: 13,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFFA0C4FF),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView(
                      padding: const EdgeInsets.all(16),
                      children: [
                        GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 110,
                        mainAxisSpacing: 12,
                        crossAxisSpacing: 12,
                      ),
                      itemCount: pack.units.length,
                      itemBuilder: (context, i) {
                        final reward = pack.units[i].reward;
                        final has = ProgressService.instance
                            .hasCollectible(pack.id, reward);
                        return Container(
                          decoration: BoxDecoration(
                            color:
                                Colors.white.withOpacity(has ? 0.1 : 0.04),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: has
                                  ? const Color(0xFFFFD200).withOpacity(0.5)
                                  : Colors.white.withOpacity(0.1),
                            ),
                          ),
                          alignment: Alignment.center,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Opacity(
                                opacity: has ? 1.0 : 0.4,
                                child: Text(
                                  has ? reward.emoji : '❓',
                                  style: const TextStyle(fontSize: 38),
                                ),
                              ),
                              if (has && reward.name.isNotEmpty)
                                Text(
                                  reward.name,
                                  style: TextStyle(
                                    fontFamily: 'Nunito',
                                    fontSize: 11,
                                    fontWeight: FontWeight.w800,
                                    color: Colors.white.withOpacity(0.7),
                                  ),
                                ),
                            ],
                          ),
                        );
                      },
                    ),
                        const SizedBox(height: 20),
                        const _BadgeShelf(),
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

/// Polička odznaků: získané barevně s názvem, ostatní šedě s podmínkou
/// (tu čte rodič; dítě pozná emoji).
class _BadgeShelf extends StatelessWidget {
  const _BadgeShelf();

  @override
  Widget build(BuildContext context) {
    final earned = ProgressService.instance.badges;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '🏅 Odznaky ${earned.length}/${GameBadge.values.length}',
          style: const TextStyle(
            fontFamily: 'Nunito',
            fontSize: 14,
            fontWeight: FontWeight.w900,
            color: Color(0xFFFFD200),
          ),
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            for (final b in GameBadge.values)
              _BadgeTile(badge: b, earned: earned.containsKey(b.name)),
          ],
        ),
      ],
    );
  }
}

class _BadgeTile extends StatelessWidget {
  final GameBadge badge;
  final bool earned;
  const _BadgeTile({required this.badge, required this.earned});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 104,
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: earned ? 0.1 : 0.04),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: earned
              ? const Color(0xFFFFD200).withValues(alpha: 0.5)
              : Colors.white.withValues(alpha: 0.1),
        ),
      ),
      child: Column(
        children: [
          Opacity(
            opacity: earned ? 1 : 0.35,
            child: Text(badge.emoji, style: const TextStyle(fontSize: 28)),
          ),
          const SizedBox(height: 4),
          Text(
            earned ? badge.title : badge.condition,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontFamily: 'Nunito',
              fontSize: 10,
              fontWeight: FontWeight.w800,
              color: Colors.white.withValues(alpha: earned ? 0.85 : 0.4),
            ),
          ),
        ],
      ),
    );
  }
}
