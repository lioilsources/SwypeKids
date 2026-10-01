import 'dart:math';

import 'package:flutter/material.dart';

/// Oslava správného swype: 1–3 hvězdy spadnou z nebe na kartu a cinknou,
/// třetí hvězda odpálí konfety. Celé trvá < 1,6 s (odměna nezdržuje další
/// kolo). Při redukci pohybu se hvězdy jen objeví, bez pádu a konfet.
class StarCelebration extends StatefulWidget {
  final int stars;

  /// Svislá pozice dopadu hvězd (0 = nahoře, 1 = dole).
  final double landingY;

  /// Vodorovná pozice dopadu (0 = vlevo, 1 = vpravo); na šířku je karta vlevo.
  final double landingX;

  /// Hvězda [index] právě dopadla (zvuk).
  final ValueChanged<int>? onStarLanded;

  const StarCelebration({
    super.key,
    required this.stars,
    this.landingY = 0.3,
    this.landingX = 0.5,
    this.onStarLanded,
  });

  static const Duration duration = Duration(milliseconds: 1500);

  // Časování v rámci [duration] (0–1).
  static const double _stagger = 0.12;
  static const double _fall = 0.33;
  static const double _confettiStart = 2 * _stagger + _fall;

  @override
  State<StarCelebration> createState() => _StarCelebrationState();
}

class _StarCelebrationState extends State<StarCelebration>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl =
      AnimationController(vsync: this, duration: StarCelebration.duration);
  int _landed = 0;
  bool _reduceMotion = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _reduceMotion = MediaQuery.of(context).disableAnimations;
  }

  @override
  void initState() {
    super.initState();
    _ctrl.addListener(_checkLandings);
    _ctrl.forward();
  }

  void _checkLandings() {
    while (_landed < widget.stars && _ctrl.value >= _landAt(_landed)) {
      widget.onStarLanded?.call(_landed);
      _landed++;
    }
  }

  double _landAt(int i) => _reduceMotion
      ? i * StarCelebration._stagger
      : i * StarCelebration._stagger + StarCelebration._fall;

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: LayoutBuilder(builder: (context, box) {
        final size = box.biggest;
        final starSize = min(size.width, size.height) * 0.13;
        final landing =
            Offset(size.width * widget.landingX, size.height * widget.landingY);

        return AnimatedBuilder(
          animation: _ctrl,
          builder: (context, _) {
            final t = _ctrl.value;
            return Stack(
              children: [
                if (widget.stars >= 3 && !_reduceMotion)
                  Positioned.fill(
                    child: CustomPaint(
                      painter: _ConfettiPainter(
                        origin: landing,
                        progress: ((t - StarCelebration._confettiStart) /
                                (1 - StarCelebration._confettiStart))
                            .clamp(0.0, 1.0),
                      ),
                    ),
                  ),
                for (var i = 0; i < widget.stars; i++)
                  _star(i, t, landing, starSize),
              ],
            );
          },
        );
      }),
    );
  }

  Widget _star(int i, double t, Offset landing, double starSize) {
    final start = i * StarCelebration._stagger;
    final dx = (i - (widget.stars - 1) / 2) * starSize * 1.1;
    final target = landing + Offset(dx, 0);

    double y;
    double opacity;
    double scale;
    if (_reduceMotion) {
      y = target.dy;
      opacity = t >= start ? 1 : 0;
      scale = 1;
    } else {
      final fall = ((t - start) / StarCelebration._fall).clamp(0.0, 1.0);
      final eased = Curves.bounceOut.transform(fall);
      y = -starSize + (target.dy + starSize) * eased;
      opacity = t >= start ? 1 : 0;
      // Po dopadu krátce „pulzne".
      final since = t - start - StarCelebration._fall;
      scale = since > 0 && since < 0.1 ? 1 + 0.25 * sin(since / 0.1 * pi) : 1;
    }
    // Ke konci oslavy hvězdy zmizí, ať neruší další kolo.
    final fadeOut = ((1 - t) / 0.15).clamp(0.0, 1.0);

    return Positioned(
      left: target.dx - starSize / 2,
      top: y - starSize / 2,
      width: starSize,
      height: starSize,
      child: Opacity(
        opacity: opacity * fadeOut,
        child: Transform.scale(
          scale: scale,
          child: FittedBox(
            child: Text('⭐',
                style: TextStyle(
                  shadows: [
                    Shadow(
                      color: const Color(0xFFFFD200).withValues(alpha: 0.8),
                      blurRadius: 18,
                    ),
                  ],
                )),
          ),
        ),
      ),
    );
  }
}

class _ConfettiPainter extends CustomPainter {
  final Offset origin;
  final double progress;

  _ConfettiPainter({required this.origin, required this.progress});

  static const _colors = [
    Color(0xFFFF6B6B),
    Color(0xFFFFD200),
    Color(0xFF1DD1A1),
    Color(0xFF54A0FF),
    Color(0xFFFF9FF3),
    Color(0xFFFFA94D),
  ];
  static const _count = 42;

  @override
  void paint(Canvas canvas, Size size) {
    if (progress <= 0 || progress >= 1) return;
    final rnd = Random(7); // stejné konfety v každém snímku
    final reach = min(size.width, size.height) * 0.55;
    final paint = Paint();
    for (var i = 0; i < _count; i++) {
      final angle = -pi / 2 + (rnd.nextDouble() - 0.5) * pi * 1.6;
      final speed = reach * (0.5 + rnd.nextDouble() * 0.5);
      final spin = (rnd.nextDouble() - 0.5) * 12;
      final w = 5 + rnd.nextDouble() * 5;
      final color = _colors[i % _colors.length];

      final p = progress;
      final pos = origin +
          Offset(cos(angle) * speed * p,
              sin(angle) * speed * p + reach * 0.9 * p * p); // gravitace
      paint.color = color.withValues(alpha: (1 - p).clamp(0.0, 1.0));

      canvas.save();
      canvas.translate(pos.dx, pos.dy);
      canvas.rotate(spin * p);
      canvas.drawRect(
          Rect.fromCenter(center: Offset.zero, width: w, height: w * 0.5),
          paint);
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(_ConfettiPainter old) =>
      old.progress != progress || old.origin != origin;
}
