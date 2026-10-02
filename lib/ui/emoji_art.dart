import 'dart:math';

import 'package:flutter/material.dart';

import 'emoji_art_index.dart';

/// Obrázek místo emoji: ilustrovaná nálepka ve stylu průvodce
/// (`assets/emoji/<kódové body>.webp`), která jemně dýchá a při změně
/// „vyskočí". Pro emoji bez obrázku zůstane systémové emoji.
///
/// [size] odpovídá `fontSize` původního emoji. Při redukci pohybu stojí.
class EmojiArt extends StatefulWidget {
  final String emoji;
  final double size;

  /// Dýchání v klidu; v hustých mřížkách vypnout (šetří snímky).
  final bool animate;

  const EmojiArt(this.emoji, {super.key, required this.size, this.animate = true});

  /// Klíč assetu: kódové body hex bez variačního selektoru FE0F.
  static String keyFor(String emoji) => emoji.runes
      .where((r) => r != 0xFE0F)
      .map((r) => r.toRadixString(16))
      .join('-');

  static bool hasArt(String emoji) => kEmojiArt.contains(keyFor(emoji));

  static String assetFor(String emoji) => 'assets/emoji/${keyFor(emoji)}.webp';

  @override
  State<EmojiArt> createState() => _EmojiArtState();
}

class _EmojiArtState extends State<EmojiArt> with TickerProviderStateMixin {
  late final AnimationController _breath = AnimationController(
    vsync: this,
    duration: Duration(milliseconds: 2400 + widget.emoji.hashCode.abs() % 900),
  );
  late final AnimationController _pop = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 450),
    value: 1,
  );

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _sync();
  }

  @override
  void didUpdateWidget(covariant EmojiArt old) {
    super.didUpdateWidget(old);
    if (old.emoji != widget.emoji &&
        !MediaQuery.of(context).disableAnimations) {
      _pop.forward(from: 0);
    }
    _sync();
  }

  void _sync() {
    final run = widget.animate &&
        EmojiArt.hasArt(widget.emoji) &&
        !MediaQuery.of(context).disableAnimations;
    if (run && !_breath.isAnimating) {
      // Každá nálepka dýchá v jiné fázi, ať se nehoupou naráz.
      _breath.value = (widget.emoji.hashCode.abs() % 100) / 100;
      _breath.repeat(reverse: true);
    } else if (!run) {
      _breath.stop();
    }
  }

  @override
  void dispose() {
    _breath.dispose();
    _pop.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final emoji = widget.emoji;
    final size = widget.size;
    final fallback = Text(emoji, style: TextStyle(fontSize: size));
    if (!EmojiArt.hasArt(emoji)) return fallback;
    // Obrázek zabere zhruba výšku řádku emoji, ať se rozložení nehne.
    final box = size * 1.2;
    return AnimatedBuilder(
      animation: Listenable.merge([_breath, _pop]),
      builder: (context, child) {
        final b = Curves.easeInOut.transform(_breath.value);
        final pop = Curves.elasticOut.transform(_pop.value);
        return Transform.translate(
          offset: Offset(0, -box * 0.03 * b),
          child: Transform.scale(
            scale: (0.6 + 0.4 * pop) * (1 + 0.035 * b),
            child: Transform.rotate(angle: 0.025 * sin(b * pi * 2), child: child),
          ),
        );
      },
      child: Image.asset(
        EmojiArt.assetFor(emoji),
        key: ValueKey('emoji-art-${EmojiArt.keyFor(emoji)}'),
        width: box,
        height: box,
        filterQuality: FilterQuality.medium,
        semanticLabel: emoji,
        errorBuilder: (_, __, ___) => fallback,
      ),
    );
  }
}
