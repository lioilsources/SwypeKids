import 'package:flutter/material.dart';

class SwypePainter extends CustomPainter {
  /// Kontinuální stopa prstu (každý bod z pan/scroll update).
  final List<Offset> trail;

  /// Středy trefených kláves – zvýrazněné body na stopě.
  final List<Offset> hitPoints;

  final double opacity;

  SwypePainter({
    required this.trail,
    required this.hitPoints,
    required this.opacity,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (trail.isEmpty) return;

    // ── 1. Stopa prstu ─────────────────────────────────────────────────────
    if (trail.length == 1) {
      // Jediný bod → tečka
      final dotPaint = Paint()
        ..color = const Color(0xFFFFD700).withValues(alpha: opacity)
        ..style = PaintingStyle.fill;
      canvas.drawCircle(trail[0], 8, dotPaint);
    } else {
      final path = Path();
      path.moveTo(trail[0].dx, trail[0].dy);
      for (int i = 1; i < trail.length; i++) {
        path.lineTo(trail[i].dx, trail[i].dy);
      }

      // Zlatý glow (širší, rozmazaný)
      final glowPaint = Paint()
        ..color = const Color(0xFFFFD200).withValues(alpha: 0.3 * opacity)
        ..strokeWidth = 18
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round
        ..style = PaintingStyle.stroke
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8);
      canvas.drawPath(path, glowPaint);

      // Hlavní čára stopy
      final linePaint = Paint()
        ..color = Colors.white.withValues(alpha: 0.7 * opacity)
        ..strokeWidth = 4
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round
        ..style = PaintingStyle.stroke;
      canvas.drawPath(path, linePaint);
    }

    // ── 2. Zvýrazněné trefené klávesy ──────────────────────────────────────
    for (int i = 0; i < hitPoints.length; i++) {
      final pt = hitPoints[i];
      final isFirst = i == 0;

      // Glow kolem trefeného bodu
      final glowPaint = Paint()
        ..color = const Color(0xFFFFD200).withValues(alpha: 0.5 * opacity)
        ..style = PaintingStyle.fill
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 10);
      canvas.drawCircle(pt, isFirst ? 14 : 10, glowPaint);

      // Výplň bodu
      final dotPaint = Paint()
        ..color = (isFirst
                ? const Color(0xFFFFD700)
                : Colors.white.withValues(alpha: 0.95))
            .withValues(alpha: opacity)
        ..style = PaintingStyle.fill;
      canvas.drawCircle(pt, isFirst ? 10 : 7, dotPaint);

      // Okraj
      final borderPaint = Paint()
        ..color = const Color(0xFFFFB81E).withValues(alpha: 0.7 * opacity)
        ..strokeWidth = 2
        ..style = PaintingStyle.stroke;
      canvas.drawCircle(pt, isFirst ? 10 : 7, borderPaint);
    }
  }

  @override
  bool shouldRepaint(SwypePainter oldDelegate) =>
      oldDelegate.trail != trail ||
      oldDelegate.hitPoints != hitPoints ||
      oldDelegate.opacity != opacity;
}
