import 'dart:math';

import 'package:flutter/material.dart';

import 'world_clock.dart';
import '../ui/emoji_art.dart';

/// Kousek světa pro jednu jednotku na mapě: země biotopu zbarvená podle
/// období a denní doby, dekorace (stromy, zvířátka…) a mlha nad
/// neodemčenými jednotkami. Nově odemčená jednotka se z mlhy „rozsvítí".
class BiomeBand extends StatelessWidget {
  final Biome biome;
  final WorldTheme theme;

  /// Jednotka je zamčená → zahalená v mlze.
  final bool locked;

  /// Jednotka se právě odemkla → mlha se rozplyne (jednou), pak [onRevealed].
  final bool revealing;
  final VoidCallback? onRevealed;
  final Widget child;

  /// Něco schovaného v rohu kousku světa (tajná nálepka ✨).
  final Widget? hidden;

  /// Sezónní překvapení v levém dolním rohu (jen v daném období).
  final Widget? seasonal;

  const BiomeBand({
    super.key,
    required this.biome,
    required this.theme,
    required this.child,
    this.locked = false,
    this.revealing = false,
    this.onRevealed,
    this.hidden,
    this.seasonal,
  });

  static const Duration revealDuration = Duration(milliseconds: 1600);

  @override
  Widget build(BuildContext context) {
    final ground = theme.groundOf(biome);
    final reduceMotion = MediaQuery.of(context).disableAnimations;
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [ground.withValues(alpha: 0.0), ground.withValues(alpha: 0.55)],
          stops: const [0.0, 0.35],
        ),
        borderRadius: BorderRadius.circular(22),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(22),
        child: Stack(
          children: [
            Positioned.fill(child: _Decor(biome: biome, theme: theme)),
            child,
            if (hidden != null && !locked)
              Positioned(right: 14, bottom: 12, child: hidden!),
            if (seasonal != null && !locked)
              Positioned(left: 14, bottom: 12, child: seasonal!),
            if (locked)
              const Positioned.fill(child: _Fog())
            else if (revealing)
              Positioned.fill(
                child: TweenAnimationBuilder<double>(
                  key: ValueKey('reveal-${biome.name}'),
                  tween: Tween(begin: 1, end: 0),
                  duration: reduceMotion
                      ? const Duration(milliseconds: 150)
                      : revealDuration,
                  curve: Curves.easeInOut,
                  onEnd: onRevealed,
                  builder: (context, opacity, child) =>
                      Opacity(opacity: opacity, child: child),
                  child: const _Fog(),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

/// Dekorace biotopu podél spodního okraje; pozice deterministické, ať se
/// strom nepřesune při každém překreslení. V noci ztlumené.
class _Decor extends StatelessWidget {
  final Biome biome;
  final WorldTheme theme;
  const _Decor({required this.biome, required this.theme});

  @override
  Widget build(BuildContext context) {
    final rnd = Random(biome.index * 31);
    final items = [
      for (var i = 0; i < 7; i++)
        (
          biome.decor[rnd.nextInt(biome.decor.length)],
          rnd.nextDouble(),
          0.55 + rnd.nextDouble() * 0.45,
          18.0 + rnd.nextInt(14),
        ),
    ];
    return IgnorePointer(
      child: LayoutBuilder(builder: (context, box) {
        return Stack(
          clipBehavior: Clip.none,
          children: [
            for (final (emoji, x, y, size) in items)
              Positioned(
                left: x * (box.maxWidth - size),
                top: y * (box.maxHeight - size),
                child: Opacity(
                  opacity: theme.isNight ? 0.25 : 0.45,
                  child: EmojiArt(emoji, size: size, animate: false),
                ),
              ),
          ],
        );
      }),
    );
  }
}

/// Mlha nad neodemčeným kouskem světa.
class _Fog extends StatelessWidget {
  const _Fog();

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              const Color(0xFF9AA5B8).withValues(alpha: 0.55),
              const Color(0xFF6B7488).withValues(alpha: 0.7),
            ],
          ),
        ),
        child: const Center(
          child: Opacity(
            opacity: 0.5,
            child: Text('🌫️', style: TextStyle(fontSize: 40)),
          ),
        ),
      ),
    );
  }
}
