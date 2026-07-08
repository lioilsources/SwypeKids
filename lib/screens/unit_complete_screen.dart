import 'package:flutter/material.dart';
import '../data/models/content_pack.dart';

/// Oslava dokončené jednotky: nová nálepka do Zvěřince + hvězdy z běhu.
/// Otevírá se přes pushReplacement z GameScreen — jeden pop vrací na mapu.
class UnitCompleteScreen extends StatelessWidget {
  final CollectibleReward reward;
  final int stars;

  const UnitCompleteScreen({
    super.key,
    required this.reward,
    required this.stars,
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
                child: Text(reward.emoji,
                    style: const TextStyle(fontSize: 96)),
              ),
              const SizedBox(height: 16),
              Text(
                'Máš novou nálepku!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Nunito',
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
                '+$stars hvězdiček',
                style: TextStyle(
                  fontFamily: 'Nunito',
                  fontSize: 17,
                  fontWeight: FontWeight.w800,
                  color: Colors.white.withOpacity(0.85),
                ),
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: const Color(0xFF0F3460),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 40, vertical: 16),
                  shape: const StadiumBorder(),
                  textStyle: const TextStyle(
                    fontFamily: 'Nunito',
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                  ),
                  elevation: 8,
                ),
                child: const Text('Zpět na mapu 🗺️'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
