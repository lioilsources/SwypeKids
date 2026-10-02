import 'package:flutter/material.dart';
import '../audio/audio_service.dart';
import '../data/lessons.dart';
import '../data/models/content_pack.dart';
import '../services/achievement_service.dart';
import '../services/pack_service.dart';
import '../services/progress_service.dart';
import '../services/tts_service.dart';
import '../world/biome_band.dart';
import '../world/world_clock.dart';
import '../ui/app_font.dart';
import '../ui/l10n.dart';
import '../ui/emoji_art.dart';

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

  /// Ťuknutí na nálepku: jméno nahlas (dítě se učí i to).
  void _say(String text) {
    if (text.isEmpty) return;
    AudioService.instance.play(Sfx.tap);
    TtsService.speak(text, widget.language);
  }

  @override
  Widget build(BuildContext context) {
    final pack = _pack;
    final owned = pack == null
        ? const <String>[]
        : ProgressService.instance.collectibles(pack.id);

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
            ? const Center(child: Text('🏅', style: TextStyle(fontSize: 64)))
            : Column(
                children: [
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
                        Text(
                          '🏅 ${context.l.zooTitle}',
                          style: TextStyle(
                            fontFamily: kFont,
                            fontSize: 16,
                            fontWeight: FontWeight.w900,
                            color: Color(0xFFFFD200),
                          ),
                        ),
                        const Spacer(),
                        Text(
                          '${owned.length}/${pack.units.length}',
                          style: TextStyle(
                            fontFamily: kFont,
                            fontSize: 13,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFFA0C4FF),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListenableBuilder(
                      listenable: WorldClockService.instance,
                      builder: (context, _) {
                        final world = WorldClockService.instance.theme;
                        return Center(
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 640),
                            child: ListView(
                              padding: const EdgeInsets.all(16),
                              children: [
                                // Ostrov: každá jednotka = kousek světa se
                                // svým zvířátkem (a tajnou nálepkou, když ji
                                // dítě našlo).
                                for (var i = 0; i < pack.units.length; i++)
                                  _IslandPiece(
                                    pack: pack,
                                    unit: pack.units[i],
                                    world: world,
                                    onSay: _say,
                                  ),
                                const SizedBox(height: 20),
                                _SeasonShelf(pack: pack),
                                const SizedBox(height: 20),
                                const _BadgeShelf(),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

/// Kousek ostrova jedné jednotky: biotop, zvířátko (nebo ❓) a nalezená
/// tajná nálepka. Ťuknutí na získané zvířátko řekne jeho jméno.
class _IslandPiece extends StatelessWidget {
  final ContentPack pack;
  final Unit unit;
  final WorldTheme world;
  final ValueChanged<String> onSay;

  const _IslandPiece({
    required this.pack,
    required this.unit,
    required this.world,
    required this.onSay,
  });

  @override
  Widget build(BuildContext context) {
    final progress = ProgressService.instance;
    final biome = Biome.parse(unit.biome);
    final has = progress.hasCollectible(pack.id, unit.reward);
    final secret = progress.collectibles(pack.id).contains(biome.secret);
    final unlocked = progress.isUnitUnlocked(pack, pack.units.indexOf(unit));

    return BiomeBand(
      biome: biome,
      theme: world,
      locked: !unlocked,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(14, 10, 14, 12),
        child: Row(
          children: [
            EmojiArt(biome.emoji, size: 22, animate: false),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                unit.title,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontFamily: kFont,
                  fontSize: 13,
                  fontWeight: FontWeight.w800,
                  color: Colors.white.withValues(alpha: 0.7),
                ),
              ),
            ),
            if (secret)
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: _Sticker(
                  key: ValueKey('secret-${unit.id}'),
                  emoji: biome.secret,
                  label: '✨',
                  owned: true,
                  onTap: () => onSay(''),
                ),
              ),
            _Sticker(
              key: ValueKey('sticker-${unit.id}'),
              emoji: has ? unit.reward.emoji : '❓',
              label: has ? unit.reward.label : '',
              owned: has,
              onTap: () => onSay(unit.reward.label),
            ),
          ],
        ),
      ),
    );
  }
}

class _Sticker extends StatefulWidget {
  final String emoji;
  final String label;
  final bool owned;
  final VoidCallback onTap;

  const _Sticker({
    super.key,
    required this.emoji,
    required this.label,
    required this.owned,
    required this.onTap,
  });

  @override
  State<_Sticker> createState() => _StickerState();
}

class _StickerState extends State<_Sticker>
    with SingleTickerProviderStateMixin {
  // Poskočení při ťuknutí (bez Rive zatím jen scale bounce).
  late final AnimationController _bounce = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 350),
  );

  @override
  void dispose() {
    _bounce.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.owned
          ? () {
              if (!MediaQuery.of(context).disableAnimations) {
                _bounce.forward(from: 0);
              }
              widget.onTap();
            }
          : null,
      child: ScaleTransition(
        scale: TweenSequence<double>([
          TweenSequenceItem(tween: Tween(begin: 1.0, end: 1.25), weight: 40),
          TweenSequenceItem(tween: Tween(begin: 1.25, end: 1.0), weight: 60),
        ]).animate(CurvedAnimation(parent: _bounce, curve: Curves.easeOut)),
        child: Container(
          width: 84,
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: widget.owned ? 0.12 : 0.05),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: widget.owned
                  ? const Color(0xFFFFD200).withValues(alpha: 0.5)
                  : Colors.white.withValues(alpha: 0.1),
            ),
          ),
          child: Column(
            children: [
              Opacity(
                opacity: widget.owned ? 1 : 0.4,
                child: EmojiArt(widget.emoji, size: 36, animate: widget.owned),
              ),
              if (widget.label.isNotEmpty) ...[
                const SizedBox(height: 2),
                Text(
                  widget.label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontFamily: kFont,
                    fontSize: 11,
                    fontWeight: FontWeight.w800,
                    color: Colors.white.withValues(alpha: 0.85),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

/// Sezónní nálepky: jedna za každé období, schovaná na mapě jen v něm.
class _SeasonShelf extends StatelessWidget {
  final ContentPack pack;
  const _SeasonShelf({required this.pack});

  @override
  Widget build(BuildContext context) {
    final owned = ProgressService.instance.collectibles(pack.id);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '🗓️ ${context.l.seasonStickersTitle}',
          style: TextStyle(
            fontFamily: kFont,
            fontSize: 14,
            fontWeight: FontWeight.w900,
            color: const Color(0xFFFFD200),
          ),
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 10,
          children: [
            for (final s in Season.values)
              Container(
                key: ValueKey('season-sticker-${s.name}'),
                width: 72,
                padding: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(
                      alpha: owned.contains(s.secret) ? 0.12 : 0.05),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: owned.contains(s.secret)
                        ? const Color(0xFFFFD200).withValues(alpha: 0.5)
                        : Colors.white.withValues(alpha: 0.1),
                  ),
                ),
                child: Column(
                  children: [
                    Opacity(
                      opacity: owned.contains(s.secret) ? 1 : 0.35,
                      child: EmojiArt(owned.contains(s.secret) ? s.secret : '❓',
                          size: 30, animate: owned.contains(s.secret)),
                    ),
                    EmojiArt(s.emoji, size: 14, animate: false),
                  ],
                ),
              ),
          ],
        ),
      ],
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
          '🏅 ${context.l.badgesTitle(earned.length, GameBadge.values.length)}',
          style: TextStyle(
            fontFamily: kFont,
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
            earned ? badge.title(context.l) : badge.condition(context.l),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontFamily: kFont,
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
