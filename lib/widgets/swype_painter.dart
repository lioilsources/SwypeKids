import 'dart:math';

import 'package:flutter/material.dart';

class SwypePainter extends CustomPainter {
  /// Kontinuální stopa prstu (každý bod z pan/scroll update).
  final List<Offset> trail;

  /// Středy trefených kláves – zvýrazněné body na stopě.
  final List<Offset> hitPoints;

  final double opacity;

  /// Běžící čas (0–1, opakuje se) pro třpyt světlušek; null = bez světlušek
  /// (redukce pohybu).
  final Animation<double>? twinkle;

  SwypePainter({
    required this.trail,
    required this.hitPoints,
    required this.opacity,
    this.twinkle,
  }) : super(repaint: twinkle);

  // Světlušky: rozestup podél stopy a maximální odskok od ní.
  static const double _fireflySpacing = 16;
  static const double _fireflyDrift = 11;

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

    // ── 2. Světlušky podél stopy ──────────────────────────────────────────
    if (twinkle != null && trail.length > 1) _paintFireflies(canvas);

    // ── 3. Zvýrazněné trefené klávesy ──────────────────────────────────────
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

  void _paintFireflies(Canvas canvas) {
    final t = twinkle!.value;
    final glow = Paint()
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4);
    final core = Paint();
    var travelled = 0.0;
    var next = 0.0;
    var n = 0;
    for (int i = 1; i < trail.length; i++) {
      final a = trail[i - 1];
      final b = trail[i];
      final seg = (b - a).distance;
      while (next <= travelled + seg && seg > 0) {
        final p = Offset.lerp(a, b, (next - travelled) / seg)!;
        // Deterministický „náhodný" odskok a fáze pro každou světlušku,
        // ať se mezi snímky neteleportují.
        final h1 = _hash(n, 1), h2 = _hash(n, 2), h3 = _hash(n, 3);
        final wobble = 2 * pi * (t + h3);
        final pos = p +
            Offset(
              (h1 - 0.5) * 2 * _fireflyDrift + sin(wobble) * 3,
              (h2 - 0.5) * 2 * _fireflyDrift + cos(wobble * 1.3) * 3,
            );
        final blink = 0.35 + 0.65 * (0.5 + 0.5 * sin(wobble * 2));
        final alpha = (blink * opacity).clamp(0.0, 1.0);
        final r = 1.6 + h1 * 1.8;
        glow.color = const Color(0xFFFFF59D).withValues(alpha: 0.6 * alpha);
        canvas.drawCircle(pos, r * 2.6, glow);
        core.color = const Color(0xFFFFFDE7).withValues(alpha: alpha);
        canvas.drawCircle(pos, r, core);
        n++;
        next += _fireflySpacing;
      }
      travelled += seg;
    }
  }

  static double _hash(int i, int salt) {
    final x = sin(i * 12.9898 + salt * 78.233) * 43758.5453;
    return x - x.floorToDouble();
  }

  @override
  bool shouldRepaint(SwypePainter oldDelegate) =>
      oldDelegate.trail != trail ||
      oldDelegate.hitPoints != hitPoints ||
      oldDelegate.opacity != opacity ||
      oldDelegate.twinkle != twinkle;
}
