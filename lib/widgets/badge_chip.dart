import 'package:flutter/material.dart';

import '../services/achievement_service.dart';
import '../ui/app_font.dart';

/// „🧭 Objevitel" — nově získaný odznak, naskočí s pružným zvětšením.
/// Používá se v oslavě kola i jednotky.
class BadgeChip extends StatelessWidget {
  final GameBadge badge;
  final double scale;

  const BadgeChip({super.key, required this.badge, this.scale = 1});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: const Duration(milliseconds: 600),
      curve: Curves.elasticOut,
      builder: (context, t, child) => Transform.scale(scale: t, child: child),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12 * scale, vertical: 6 * scale),
        decoration: BoxDecoration(
          color: const Color(0xFFFFD200),
          borderRadius: BorderRadius.circular(99),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFFFFD200).withValues(alpha: 0.5),
              blurRadius: 14,
            ),
          ],
        ),
        child: Text(
          '${badge.emoji} ${badge.title}',
          style: TextStyle(
            fontFamily: kFont,
            fontSize: 16 * scale,
            fontWeight: FontWeight.w900,
            color: const Color(0xFF3A2E1F),
          ),
        ),
      ),
    );
  }
}
