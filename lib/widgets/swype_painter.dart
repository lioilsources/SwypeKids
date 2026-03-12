import 'package:flutter/material.dart';

class SwypePainter extends CustomPainter {
  final List<Offset> points;
  final double opacity;

  SwypePainter({required this.points, required this.opacity});

  @override
  void paint(Canvas canvas, Size size) {
    if (points.length < 2) {
      // Nakreslíme alespoň tečku na prvním bodě
      if (points.length == 1) {
        final dotPaint = Paint()
          ..color = const Color(0xFFFFD700).withOpacity(opacity)
          ..style = PaintingStyle.fill;
        canvas.drawCircle(points[0], 11, dotPaint);
      }
      return;
    }

    final path = Path();
    path.moveTo(points[0].dx, points[0].dy);
    for (int i = 1; i < points.length; i++) {
      path.lineTo(points[i].dx, points[i].dy);
    }

    // Zlatý glow
    final glowPaint = Paint()
      ..color = const Color(0xFFFFD200).withOpacity(0.4 * opacity)
      ..strokeWidth = 24
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..style = PaintingStyle.stroke
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 10);
    canvas.drawPath(path, glowPaint);

    // Bílá čára
    final linePaint = Paint()
      ..color = Colors.white.withOpacity(0.95 * opacity)
      ..strokeWidth = 7
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..style = PaintingStyle.stroke;
    canvas.drawPath(path, linePaint);

    // Tečky na zastávkách
    for (int i = 0; i < points.length; i++) {
      final isFirst = i == 0;
      final dotPaint = Paint()
        ..color = (isFirst
                ? const Color(0xFFFFD700)
                : Colors.white.withOpacity(0.9))
            .withOpacity(opacity)
        ..style = PaintingStyle.fill;
      final borderPaint = Paint()
        ..color = const Color(0xFFFFB81E).withOpacity(0.7 * opacity)
        ..strokeWidth = 2.5
        ..style = PaintingStyle.stroke;
      final r = isFirst ? 12.0 : 7.0;
      canvas.drawCircle(points[i], r, dotPaint);
      canvas.drawCircle(points[i], r, borderPaint);
    }
  }

  @override
  bool shouldRepaint(SwypePainter oldDelegate) =>
      oldDelegate.points != points || oldDelegate.opacity != opacity;
}
