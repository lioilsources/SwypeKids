import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'world_clock.dart';

/// Pozadí mapy: obloha podle denní doby a období, slunce/měsíc, hvězdy v noci
/// a mraky s parallaxem (pohybují se pomaleji než obsah mapy).
class WorldBackdrop extends StatefulWidget {
  final WorldTheme theme;

  /// Posun scrollu mapy (parallax); null = bez parallaxu.
  final ValueListenable<double>? scroll;

  const WorldBackdrop({super.key, required this.theme, this.scroll});

  @override
  State<WorldBackdrop> createState() => _WorldBackdropState();
}

class _WorldBackdropState extends State<WorldBackdrop>
    with SingleTickerProviderStateMixin {
  // Pomalý běh mraků a třpyt hvězd — jeden ticker pro obojí.
  late final AnimationController _drift = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 90),
  );

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (MediaQuery.of(context).disableAnimations) {
      _drift.stop();
    } else if (!_drift.isAnimating) {
      _drift.repeat();
    }
  }

  @override
  void dispose() {
    _drift.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = widget.theme;
    final reduceMotion = MediaQuery.of(context).disableAnimations;
    return AnimatedContainer(
      duration: const Duration(seconds: 3),
      curve: Curves.easeInOut,
      decoration: BoxDecoration(gradient: theme.gradient),
      child: LayoutBuilder(builder: (context, box) {
        final size = box.biggest;
        return ListenableBuilder(
          listenable: Listenable.merge(
              [_drift, if (widget.scroll != null) widget.scroll!]),
          builder: (context, _) {
            final scroll = widget.scroll?.value ?? 0;
            final t = reduceMotion ? 0.0 : _drift.value;
            return Stack(
              clipBehavior: Clip.none,
              children: [
                if (theme.isNight)
                  Positioned.fill(
                    child: CustomPaint(
                      painter: _StarsPainter(twinkle: t, scroll: scroll),
                    ),
                  ),
                // Slunce / měsíc — vysoko, kousek parallaxu.
                Positioned(
                  right: 18,
                  top: 48 - scroll * 0.15,
                  child: _Glow(
                    color: theme.isNight
                        ? const Color(0xFFE8F0FF)
                        : const Color(0xFFFFD200),
                    child: Text(theme.celestial,
                        style: const TextStyle(fontSize: 44)),
                  ),
                ),
                for (var i = 0; i < 4; i++)
                  _cloud(i, t, scroll, size, theme),
              ],
            );
          },
        );
      }),
    );
  }

  Widget _cloud(int i, double t, double scroll, Size size, WorldTheme theme) {
    // Každý mrak má vlastní výšku, rychlost a fázi; plují zprava doleva.
    final speed = 0.6 + 0.35 * i;
    final x = (1.3 - ((t * speed + i * 0.27) % 1.3)) * size.width - 60;
    final y = 70.0 + i * 95 - scroll * (0.25 + 0.05 * i);
    return Positioned(
      left: x,
      top: y,
      child: Opacity(
        opacity: theme.isNight ? 0.25 : 0.55,
        child: Text('☁️', style: TextStyle(fontSize: 34 + 10.0 * (i % 2))),
      ),
    );
  }
}

class _Glow extends StatelessWidget {
  final Color color;
  final Widget child;
  const _Glow({required this.color, required this.child});

  @override
  Widget build(BuildContext context) => Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(color: color.withValues(alpha: 0.35), blurRadius: 36),
          ],
        ),
        child: child,
      );
}

/// Hvězdy: deterministická pozice, třpyt s fází, mírný parallax.
class _StarsPainter extends CustomPainter {
  final double twinkle;
  final double scroll;

  _StarsPainter({required this.twinkle, required this.scroll});

  static const _count = 70;

  @override
  void paint(Canvas canvas, Size size) {
    final rnd = Random(42);
    final paint = Paint();
    for (var i = 0; i < _count; i++) {
      final x = rnd.nextDouble() * size.width;
      final baseY = rnd.nextDouble() * size.height * 1.4;
      final r = 0.8 + rnd.nextDouble() * 1.4;
      final phase = rnd.nextDouble();
      final y = (baseY - scroll * 0.1) % (size.height + 20) - 10;
      final blink = 0.45 + 0.55 * (0.5 + 0.5 * sin(2 * pi * (twinkle * 6 + phase)));
      paint.color = Colors.white.withValues(alpha: blink);
      canvas.drawCircle(Offset(x, y), r, paint);
    }
  }

  @override
  bool shouldRepaint(_StarsPainter old) =>
      old.twinkle != twinkle || old.scroll != scroll;
}
