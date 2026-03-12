import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import '../data/keyboard_data.dart';
import '../data/lessons.dart';

enum GameStatus { idle, success, error }

class ChallengeCard extends StatelessWidget {
  final Lesson lesson;
  final List<String> path;
  final GameStatus status;
  final bool shake;

  const ChallengeCard({
    super.key,
    required this.lesson,
    required this.path,
    required this.status,
    required this.shake,
  });

  @override
  Widget build(BuildContext context) {
    final letters = lesson.target.split('');

    return AnimatedContainer(
      duration: const Duration(milliseconds: 80),
      transform: shake
          ? (Matrix4.identity()..translate(6.0))
          : Matrix4.identity(),
      margin: const EdgeInsets.symmetric(horizontal: 8),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.08),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withOpacity(0.13)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Hint emoji
          Text(lesson.hint, style: const TextStyle(fontSize: 40)),
          const SizedBox(height: 2),
          // Název slova
          Text(
            lesson.label,
            style: TextStyle(
              fontFamily: 'Nunito',
              fontSize: 22,
              fontWeight: FontWeight.w900,
              color: const Color(0xFFFFD200),
              letterSpacing: 5,
              shadows: [
                Shadow(
                  color: const Color(0xFFFFD200).withOpacity(0.4),
                  blurRadius: 16,
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),

          // Cílová písmena
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: letters.asMap().entries.map((e) {
              final i = e.key;
              final ch = e.value;
              final reached = path.length > i;
              final hit = reached && path[i] == ch;
              final miss = reached && path[i] != ch;
              final col = keyColor(ch);
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Column(
                  children: [
                    // Mini emoji nad písmenkem
                    AnimatedDefaultTextStyle(
                      duration: const Duration(milliseconds: 200),
                      style: TextStyle(
                        fontSize: hit ? 20 : 16,
                      ),
                      child: Text(miss ? '❌' : keyEmoji(ch)),
                    ),
                    const SizedBox(height: 3),
                    // Políčko s písmenkem
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 180),
                      curve: Curves.easeOutCubic,
                      width: hit ? 48 : 44,
                      height: hit ? 54 : 50,
                      decoration: BoxDecoration(
                        color: hit
                            ? col
                            : miss
                                ? const Color(0xFFE74C3C).withOpacity(0.25)
                                : Colors.white.withOpacity(0.08),
                        borderRadius: BorderRadius.circular(12),
                        border: miss
                            ? Border.all(
                                color: const Color(0xFFE74C3C), width: 2)
                            : null,
                        boxShadow: hit
                            ? [
                                BoxShadow(
                                  color: col.withOpacity(0.6),
                                  blurRadius: 14,
                                  spreadRadius: 1,
                                ),
                              ]
                            : null,
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        ch,
                        style: TextStyle(
                          fontFamily: 'Nunito',
                          fontSize: 26,
                          fontWeight: FontWeight.w900,
                          color: hit
                              ? Colors.white
                              : miss
                                  ? const Color(0xFFE74C3C)
                                  : Colors.white.withOpacity(0.2),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 8),

          // Status zpráva
          SizedBox(
            height: 24,
            child: _statusText(),
          ),
        ],
      ),
    );
  }

  Widget _statusText() {
    switch (status) {
      case GameStatus.success:
        return Text('🎉 Výborně!',
            style: TextStyle(
                fontFamily: 'Nunito',
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: const Color(0xFF2ECC71)));
      case GameStatus.error:
        return Text('❌ Zkus to znovu!',
            style: TextStyle(
                fontFamily: 'Nunito',
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: const Color(0xFFE74C3C)));
      case GameStatus.idle:
        if (path.isEmpty) {
          final isDesktop =
              Platform.isMacOS || Platform.isWindows || Platform.isLinux;
          return Text(
            isDesktop
                ? '🖱️ Přejeď dvěma prsty přes obrázky'
                : '☝️ Přejeď prstem přes obrázky',
            style: TextStyle(
                fontFamily: 'Nunito',
                fontSize: 13,
                color: Colors.white.withOpacity(0.35)),
          );
        }
        return const SizedBox.shrink();
    }
  }
}
