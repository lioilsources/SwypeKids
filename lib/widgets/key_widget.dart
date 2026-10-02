import 'package:cute_kid_fonts/cute_kid_fonts.dart';
import 'package:flutter/material.dart';
import '../data/keyboard_data.dart';
import '../services/settings_service.dart';
import '../ui/app_font.dart';
import '../ui/emoji_art.dart';

class KeyWidget extends StatefulWidget {
  final String letter;
  final String emoji; // per-jazyková mnemotechnika (PackService.keyEmojiFor)
  final bool active;
  final bool inPath;
  final bool isNew; // právě odemčené → bliká
  final double scale;

  const KeyWidget({
    super.key,
    required this.letter,
    required this.emoji,
    required this.active,
    required this.inPath,
    this.isNew = false,
    this.scale = 1.0,
  });

  @override
  State<KeyWidget> createState() => _KeyWidgetState();
}

class _KeyWidgetState extends State<KeyWidget>
    with SingleTickerProviderStateMixin {
  // Nadskočení klávesy, když ji prst přidá do tahu.
  late final AnimationController _bounce = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 320),
  );
  late final Animation<double> _bounceScale = TweenSequence<double>([
    TweenSequenceItem(
        tween: Tween(begin: 1.0, end: 1.22)
            .chain(CurveTween(curve: Curves.easeOut)),
        weight: 35),
    TweenSequenceItem(
        tween: Tween(begin: 1.22, end: 0.96)
            .chain(CurveTween(curve: Curves.easeInOut)),
        weight: 35),
    TweenSequenceItem(
        tween: Tween(begin: 0.96, end: 1.0)
            .chain(CurveTween(curve: Curves.easeOut)),
        weight: 30),
  ]).animate(_bounce);

  @override
  void didUpdateWidget(covariant KeyWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.inPath &&
        !oldWidget.inPath &&
        !MediaQuery.of(context).disableAnimations) {
      _bounce.forward(from: 0);
    }
  }

  @override
  void dispose() {
    _bounce.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(scale: _bounceScale, child: _buildKey());
  }

  Widget _buildKey() {
    final letter = widget.letter;
    final emoji = widget.emoji;
    final active = widget.active;
    final inPath = widget.inPath;
    final isNew = widget.isNew;
    final scale = widget.scale;
    final col = keyColor(letter);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 130),
      curve: Curves.easeOutCubic,
      transform: Matrix4.identity()
        ..scale(inPath ? 1.12 : (isNew ? 1.05 : 1.0)),
      transformAlignment: Alignment.center,
      decoration: BoxDecoration(
        color: !active
            ? Colors.white.withOpacity(0.04)
            : inPath
                ? col
                : Colors.white.withOpacity(0.12),
        borderRadius: BorderRadius.circular(14 * scale),
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
                EmojiArt(emoji, size: 18 * scale),
                const SizedBox(height: 1),
                // Baculaté písmo z CuteKidFonts; OpenDyslexic (rodičovské
                // nastavení) má přednost a zůstává jako plochý text.
                if (SettingsService.instance.dyslexiaFont)
                  Text(
                    letter,
                    style: TextStyle(
                      fontFamily: kFont,
                      fontSize: 13 * scale,
                      fontWeight: FontWeight.w900,
                      color: inPath
                          ? Colors.white
                          : Colors.white.withOpacity(0.75),
                      height: 1,
                    ),
                  )
                else
                  KidKeyLabel(
                    letter,
                    size: 18 * scale,
                    boxWidth: 30 * scale,
                    boxHeight: 22 * scale,
                  ),
              ],
            )
          : Center(
              child: Text(
                letter,
                style: TextStyle(
                  fontFamily: kFont,
                  fontSize: 14 * scale,
                  fontWeight: FontWeight.w700,
                  color: Colors.white.withOpacity(0.12),
                ),
              ),
            ),
    );
  }
}
