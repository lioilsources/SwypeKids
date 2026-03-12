import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WinScreen extends StatelessWidget {
  final int stars;
  final VoidCallback onRestart;

  const WinScreen({super.key, required this.stars, required this.onRestart});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF1A1A2E), Color(0xFFF6D365), Color(0xFFFDA085)],
            stops: [0.0, 0.5, 1.0],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('🏆', style: TextStyle(fontSize: 90)),
              const SizedBox(height: 12),
              Text(
                'Hotovo!\nJsi šampion!',
                textAlign: TextAlign.center,
                style: GoogleFonts.nunito(
                  fontSize: 36,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                  shadows: [
                    Shadow(
                      color: Colors.black.withOpacity(0.25),
                      blurRadius: 16,
                    )
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Získal jsi $stars hvězdiček!',
                style: GoogleFonts.nunito(
                  fontSize: 20,
                  color: Colors.white.withOpacity(0.9),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                '⭐' * stars.clamp(0, 15),
                style: const TextStyle(fontSize: 28),
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: onRestart,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: const Color(0xFFF7971E),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 40, vertical: 16),
                  shape: const StadiumBorder(),
                  textStyle: GoogleFonts.nunito(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                  ),
                  elevation: 8,
                ),
                child: const Text('Hrát znovu 🔄'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
