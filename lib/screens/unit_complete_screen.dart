import 'package:flutter/material.dart';
import '../data/models/content_pack.dart';
import '../services/achievement_service.dart';
import '../widgets/badge_chip.dart';
import '../ui/app_font.dart';
import '../ui/l10n.dart';
import '../ui/emoji_art.dart';

/// Hero tag nálepky jednotky: po oslavě nálepka odletí na své místo na mapě.
String stickerHeroTag(String packId, int unitIndex) =>
    'sticker-$packId-$unitIndex';

/// Oslava dokončené jednotky: nová nálepka do Zvěřince + hvězdy z běhu.
/// Otevírá se přes pushReplacement z GameScreen — jeden pop vrací na mapu.
class UnitCompleteScreen extends StatelessWidget {
  final CollectibleReward reward;
  final int stars;
  final Object? heroTag;

  /// Odznaky získané touto jednotkou (oslava je ukáže pod hvězdami).
  final List<GameBadge> newBadges;

  const UnitCompleteScreen({
    super.key,
    required this.reward,
    required this.stars,
    this.heroTag,
    this.newBadges = const [],
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF1A1A2E), Color(0xFF0F3460), Color(0xFF1DD1A1)],
            stops: [0.0, 0.55, 1.0],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Nálepka naskočí s pružným zvětšením
              TweenAnimationBuilder<double>(
                tween: Tween(begin: 0.0, end: 1.0),
                duration: const Duration(milliseconds: 700),
                curve: Curves.elasticOut,
                builder: (context, scale, child) =>
                    Transform.scale(scale: scale, child: child),
                child: _hero(SizedBox(
                  width: 120,
                  height: 120,
                  child: FittedBox(
                    child: EmojiArt(reward.emoji, size: 96),
                  ),
                )),
              ),
              const SizedBox(height: 16),
              Text(
                context.l.newSticker,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: kDisplayFont,
                  fontFamilyFallback: kFontFallback,
                  fontSize: 30,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                  shadows: [
                    Shadow(
                      color: Colors.black.withOpacity(0.25),
                      blurRadius: 16,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Text(
                '⭐' * (stars ~/ 3).clamp(1, 10),
                style: const TextStyle(fontSize: 26),
              ),
              Text(
                context.l.starsGained(stars),
                style: TextStyle(
                  fontFamily: kFont,
                  fontFamilyFallback: kFontFallback,
                  fontSize: 17,
                  fontWeight: FontWeight.w800,
                  color: Colors.white.withOpacity(0.85),
                ),
              ),
              if (newBadges.isNotEmpty) ...[
                const SizedBox(height: 16),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  alignment: WrapAlignment.center,
                  children: [for (final b in newBadges) BadgeChip(badge: b)],
                ),
              ],
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: const Color(0xFF0F3460),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 40, vertical: 16),
                  shape: const StadiumBorder(),
                  textStyle: TextStyle(
                    fontFamily: kDisplayFont,
                    fontFamilyFallback: kFontFallback,
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                  ),
                  elevation: 8,
                ),
                child: Text('${context.l.backToMap} 🗺️'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _hero(Widget child) =>
      heroTag == null ? child : Hero(tag: heroTag!, child: child);
}
