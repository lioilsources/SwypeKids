import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../data/keyboard_data.dart';

class KeyWidget extends StatelessWidget {
  final String letter;
  final bool active;
  final bool inPath;
  final bool isNew; // právě odemčené → bliká

  const KeyWidget({
    super.key,
    required this.letter,
    required this.active,
    required this.inPath,
    this.isNew = false,
  });

  @override
  Widget build(BuildContext context) {
    final col = keyColor(letter);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 130),
      curve: Curves.elasticOut,
      transform: Matrix4.identity()
        ..scale(inPath ? 1.12 : (isNew ? 1.05 : 1.0)),
      transformAlignment: Alignment.center,
      decoration: BoxDecoration(
        color: !active
            ? Colors.white.withOpacity(0.04)
            : inPath
                ? col
                : Colors.white.withOpacity(0.12),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: !active
              ? Colors.white.withOpacity(0.06)
              : inPath
                  ? Colors.transparent
                  : isNew
                      ? col.withOpacity(0.9)
                      : Colors.white.withOpacity(0.18),
          width: 1.5,
        ),
        boxShadow: active
            ? [
                BoxShadow(
                  color: inPath
                      ? col.withOpacity(0.55)
                      : Colors.black.withOpacity(0.25),
                  blurRadius: inPath ? 18 : 8,
                  offset: const Offset(0, 3),
                ),
              ]
            : null,
      ),
      child: active
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  keyEmoji(letter),
                  style: TextStyle(
                    fontSize: 18,
                    shadows: inPath
                        ? [
                            Shadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 4,
                            )
                          ]
                        : null,
                  ),
                ),
                const SizedBox(height: 1),
                Text(
                  letter,
                  style: GoogleFonts.nunito(
                    fontSize: 13,
                    fontWeight: FontWeight.w900,
                    color: inPath
                        ? Colors.white
                        : Colors.white.withOpacity(0.75),
                    height: 1,
                  ),
                ),
              ],
            )
          : Center(
              child: Text(
                letter,
                style: GoogleFonts.nunito(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: Colors.white.withOpacity(0.12),
                ),
              ),
            ),
    );
  }
}
