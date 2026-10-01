import 'dart:math';

import 'package:flutter/material.dart';

import 'world_clock.dart';

/// Částice světa přes celou mapu: květy (jaro), světlušky (letní večer),
/// listí (podzim), sníh (zima). Nereaguje na dotyk; při redukci pohybu
/// se nekreslí.
class ParticleLayer extends StatefulWidget {
  final ParticleKind kind;

  const ParticleLayer({super.key, required this.kind});

  @override
  State<ParticleLayer> createState() => _ParticleLayerState();
}

class _ParticleLayerState extends State<ParticleLayer>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 12),
  );

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _sync();
  }

  @override
  void didUpdateWidget(covariant ParticleLayer oldWidget) {
    super.didUpdateWidget(oldWidget);
    _sync();
  }

  void _sync() {
    final run = widget.kind != ParticleKind.none &&
        !MediaQuery.of(context).disableAnimations;
    if (run && !_ctrl.isAnimating) {
      _ctrl.repeat();
    } else if (!run) {
      _ctrl.stop();
    }
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.kind == ParticleKind.none ||
        MediaQuery.of(context).disableAnimations) {
      return const SizedBox.shrink();
    }
    return IgnorePointer(
      child: CustomPaint(
        painter: _ParticlePainter(kind: widget.kind, time: _ctrl),
        size: Size.infinite,
      ),
    );
  }
}

class _ParticlePainter extends CustomPainter {
  final ParticleKind kind;
  final Animation<double> time;

  _ParticlePainter({required this.kind, required this.time})
      : super(repaint: time);

  static const _count = 36;

  @override
  void paint(Canvas canvas, Size size) {
    final t = time.value;
    final rnd = Random(kind.index + 7);
    final paint = Paint();
    for (var i = 0; i < _count; i++) {
      final x0 = rnd.nextDouble();
      final offset = rnd.nextDouble();
      final speed = 0.5 + rnd.nextDouble();
      final sway = rnd.nextDouble() * 2 * pi;
      final sz = 2.0 + rnd.nextDouble() * 4;
      switch (kind) {
        case ParticleKind.fireflies:
          // Vznášejí se a blikají; každá má vlastní tempo.
          final x = (x0 + 0.04 * sin(2 * pi * (t * speed + sway))) * size.width;
          final y = (offset + 0.03 * cos(2 * pi * (t * speed * 1.3 + sway))) *
              size.height;
          final blink = max(0.0, sin(2 * pi * (t * speed * 2 + offset)));
          paint.color =
              const Color(0xFFFFF59D).withValues(alpha: 0.15 + 0.75 * blink);
          canvas.drawCircle(Offset(x, y), sz * 0.6 + blink * 1.5, paint);
        case ParticleKind.snow:
        case ParticleKind.petals:
        case ParticleKind.leaves:
          // Padají shora dolů s kolébáním; po dopadu se objeví znovu nahoře.
          final fall = (t * speed * 0.6 + offset) % 1.0;
          final x =
              (x0 + 0.05 * sin(2 * pi * (fall * 2 + sway))) * size.width;
          final y = fall * (size.height + 20) - 10;
          final c = Offset(x, y);
          switch (kind) {
            case ParticleKind.snow:
              paint.color = Colors.white.withValues(alpha: 0.85);
              canvas.drawCircle(c, sz * 0.7, paint);
            case ParticleKind.petals:
              paint.color = (i.isEven
                      ? const Color(0xFFFFB7C5)
                      : const Color(0xFFFFE0E9))
                  .withValues(alpha: 0.9);
              _oval(canvas, c, sz, fall * 6 + sway, paint);
            case ParticleKind.leaves:
              paint.color = (i % 3 == 0
                      ? const Color(0xFFE67E22)
                      : i % 3 == 1
                          ? const Color(0xFFD35400)
                          : const Color(0xFFF1C40F))
                  .withValues(alpha: 0.9);
              _oval(canvas, c, sz * 1.3, fall * 8 + sway, paint);
            default:
              break;
          }
        case ParticleKind.none:
          break;
      }
    }
  }

  void _oval(Canvas canvas, Offset c, double sz, double angle, Paint paint) {
    canvas.save();
    canvas.translate(c.dx, c.dy);
    canvas.rotate(angle);
    canvas.drawOval(
        Rect.fromCenter(center: Offset.zero, width: sz * 2, height: sz),
        paint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(_ParticlePainter old) => old.kind != kind;
}
