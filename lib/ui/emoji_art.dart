import 'dart:math';

import 'package:flutter/material.dart';

import 'emoji_art_index.dart';
import 'sticker_kind.dart';

/// Krátká reakce nálepky na dotyk nebo na akci (≤ 600 ms).
enum StickerReaction {
  /// Podle druhu nálepky: zvířátko = srdíčka, jídlo = zmáčknutí, jinak
  /// poskok / zavrtění / kývnutí / zachvění / otočka (podle emoji).
  auto,
  none,
  bounce,
  wiggle,
  squash,
  spin,
  nod,
  shiver,
  hearts,
  sparkle,
}

/// Opakovaná „akce" nálepky — dokud je nastavená, běží ve smyčce
/// (svět zvířátka: jí, pije, hraje si, spí, raduje se).
enum StickerAction { eat, drink, play, sleep, happy }

/// Obrázek místo emoji: ilustrovaná nálepka ve stylu průvodce
/// (`assets/emoji/<kódové body>.webp`), která jemně dýchá, při změně
/// „vyskočí" a na dotyk zareaguje ([reaction]). Pro emoji bez obrázku
/// zůstane systémové emoji (reaguje taky).
///
/// Dotyk se čte přes [Listener], takže nálepka uvnitř tlačítka, klávesy
/// nebo lekce neukradne ťuknutí rodiči. Vlastní [onTap] přidá ťukání.
///
/// [size] odpovídá `fontSize` původního emoji. Při redukci pohybu stojí.
class EmojiArt extends StatefulWidget {
  final String emoji;
  final double size;

  /// Dýchání v klidu; v hustých mřížkách vypnout (šetří snímky).
  final bool animate;

  /// Reakce na dotyk; [StickerReaction.none] = nereaguje.
  final StickerReaction reaction;

  /// Ťuknutí (nálepka sama je tlačítko). Bez něj se jen reaguje.
  final VoidCallback? onTap;

  /// Změna hodnoty spustí reakci „na akci" (bez dotyku), např. když
  /// písmeno na klávese přibude do swype.
  final Object? trigger;

  /// Smyčka akce (svět zvířátka); `null` = jen dýchání.
  final StickerAction? action;

  const EmojiArt(
    this.emoji, {
    super.key,
    required this.size,
    this.animate = true,
    this.reaction = StickerReaction.auto,
    this.onTap,
    this.trigger,
    this.action,
  });

  /// Klíč assetu: kódové body hex bez variačního selektoru FE0F.
  static String keyFor(String emoji) => emoji.runes
      .where((r) => r != 0xFE0F)
      .map((r) => r.toRadixString(16))
      .join('-');

  static bool hasArt(String emoji) => kEmojiArt.contains(keyFor(emoji));

  static String assetFor(String emoji) => 'assets/emoji/${keyFor(emoji)}.webp';

  /// Jaká reakce se pro [emoji] použije při [StickerReaction.auto].
  static StickerReaction resolve(String emoji, StickerReaction r) {
    if (r != StickerReaction.auto) return r;
    return switch (StickerKind.of(emoji)) {
      StickerKind.animal => StickerReaction.hearts,
      StickerKind.food => StickerReaction.squash,
      StickerKind.drink => StickerReaction.nod,
      StickerKind.other => const [
          StickerReaction.bounce,
          StickerReaction.wiggle,
          StickerReaction.nod,
          StickerReaction.shiver,
          StickerReaction.spin,
          StickerReaction.sparkle,
        ][emoji.runes.fold(0, (a, b) => a + b) % 6],
    };
  }

  @override
  State<EmojiArt> createState() => EmojiArtState();
}

class EmojiArtState extends State<EmojiArt> with TickerProviderStateMixin {
  late final AnimationController _breath = AnimationController(
    vsync: this,
    duration: Duration(milliseconds: 2400 + widget.emoji.hashCode.abs() % 900),
  );
  late final AnimationController _pop = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 450),
    value: 1,
  );
  late final AnimationController _react = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 600),
  );
  late final AnimationController _act = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 900),
  );

  bool get _reduceMotion => MediaQuery.of(context).disableAnimations;

  /// Spustí reakci (i zvenku, přes `GlobalKey<EmojiArtState>`).
  void react() {
    if (widget.reaction == StickerReaction.none || _reduceMotion) return;
    _react.forward(from: 0);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _sync();
  }

  @override
  void didUpdateWidget(covariant EmojiArt old) {
    super.didUpdateWidget(old);
    if (old.emoji != widget.emoji && !_reduceMotion) {
      _pop.forward(from: 0);
    }
    if (old.trigger != widget.trigger && widget.trigger != null) react();
    _sync();
  }

  void _sync() {
    final run = widget.animate && !_reduceMotion;
    if (run && widget.action == null && !_breath.isAnimating) {
      // Každá nálepka dýchá v jiné fázi, ať se nehoupou naráz.
      _breath.value = (widget.emoji.hashCode.abs() % 100) / 100;
      _breath.repeat(reverse: true);
    } else if (!run || widget.action != null) {
      _breath.stop();
    }
    final action = widget.action;
    if (action != null && !_reduceMotion) {
      _act.duration = Duration(
          milliseconds: switch (action) {
        StickerAction.eat => 420,
        StickerAction.drink => 700,
        StickerAction.play => 520,
        StickerAction.sleep => 2600,
        StickerAction.happy => 480,
      });
      if (!_act.isAnimating) _act.repeat();
    } else {
      _act.stop();
      _act.value = 0;
    }
  }

  @override
  void dispose() {
    _breath.dispose();
    _pop.dispose();
    _react.dispose();
    _act.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final emoji = widget.emoji;
    final size = widget.size;
    final art = EmojiArt.hasArt(emoji);
    // Obrázek zabere zhruba výšku řádku emoji, ať se rozložení nehne.
    final box = size * 1.2;
    final Widget face = art
        ? Image.asset(
            EmojiArt.assetFor(emoji),
            key: ValueKey('emoji-art-${EmojiArt.keyFor(emoji)}'),
            width: box,
            height: box,
            filterQuality: FilterQuality.medium,
            semanticLabel: emoji,
            errorBuilder: (_, __, ___) =>
                Text(emoji, style: TextStyle(fontSize: size)),
          )
        : Text(emoji, style: TextStyle(fontSize: size));
    final reaction = EmojiArt.resolve(emoji, widget.reaction);

    Widget moving = AnimatedBuilder(
      animation: Listenable.merge([_breath, _pop, _react, _act]),
      builder: (context, child) {
        final b = art ? Curves.easeInOut.transform(_breath.value) : 0.0;
        final pop = Curves.elasticOut.transform(_pop.value);
        var dx = 0.0, dy = -box * 0.03 * b, angle = 0.025 * sin(b * pi * 2);
        var sx = (0.6 + 0.4 * pop) * (1 + 0.035 * b), sy = sx;
        var pivot = Alignment.center;

        // Akce ve smyčce (svět zvířátka).
        final a = _act.value;
        switch (widget.action) {
          case StickerAction.eat:
            final c = sin(a * pi).abs();
            sy *= 1 - 0.14 * c;
            sx *= 1 + 0.08 * c;
            pivot = Alignment.bottomCenter;
          case StickerAction.drink:
            angle += 0.22 * sin(a * pi);
            pivot = Alignment.bottomCenter;
          case StickerAction.play:
            dy -= box * 0.22 * sin(a * pi);
            angle += 0.12 * sin(a * pi * 2);
          case StickerAction.sleep:
            final s = sin(a * pi * 2);
            sx *= 1 + 0.05 * s;
            sy *= 1 - 0.03 * s;
            pivot = Alignment.bottomCenter;
          case StickerAction.happy:
            dy -= box * 0.18 * sin(a * pi);
            sx *= 1 + 0.06 * sin(a * pi);
          case null:
            break;
        }

        // Reakce na dotyk / na akci.
        final t = _react.value;
        if (_react.isAnimating || (t > 0 && t < 1)) {
          final up = sin(pi * t);
          switch (reaction) {
            case StickerReaction.bounce ||
                  StickerReaction.hearts ||
                  StickerReaction.auto:
              dy -= box * 0.3 * up;
              sx *= 1 + 0.08 * up;
              sy *= 1 + 0.08 * up;
            case StickerReaction.wiggle:
              angle += 0.28 * sin(t * pi * 4) * (1 - t);
            case StickerReaction.squash:
              sx *= 1 + 0.25 * up;
              sy *= 1 - 0.2 * up;
              pivot = Alignment.bottomCenter;
            case StickerReaction.spin:
              angle += 2 * pi * Curves.easeOutBack.transform(t);
            case StickerReaction.nod:
              angle += 0.18 * sin(t * pi * 2) * (1 - t);
              pivot = Alignment.bottomCenter;
            case StickerReaction.shiver:
              dx += box * 0.07 * sin(t * pi * 10) * (1 - t);
            case StickerReaction.sparkle:
              sx *= 1 + 0.12 * up;
              sy *= 1 + 0.12 * up;
            case StickerReaction.none:
              break;
          }
        }
        return Transform.translate(
          offset: Offset(dx, dy),
          child: Transform.rotate(
            angle: angle,
            alignment: pivot,
            child: Transform(
              alignment: pivot,
              transform: Matrix4.diagonal3Values(sx, sy, 1),
              child: child,
            ),
          ),
        );
      },
      child: face,
    );

    // Částice: srdíčka (zvířátko), jiskry, 💤 při spaní.
    final particle = switch (reaction) {
      StickerReaction.hearts => '❤️',
      StickerReaction.sparkle => '✨',
      _ => null,
    };
    if (particle != null || widget.action == StickerAction.sleep ||
        widget.action == StickerAction.happy) {
      moving = Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          moving,
          if (particle != null)
            _Particles(anim: _react, emoji: particle, box: box),
          if (widget.action == StickerAction.happy)
            _Particles(anim: _act, emoji: '❤️', box: box, loop: true),
          if (widget.action == StickerAction.sleep)
            _Particles(anim: _act, emoji: '💤', box: box, loop: true, count: 1),
        ],
      );
    }

    if (widget.reaction == StickerReaction.none && widget.onTap == null) {
      return moving;
    }
    if (widget.onTap != null) {
      return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          react();
          widget.onTap!();
        },
        child: moving,
      );
    }
    // Jen reakce: Listener nesoutěží o gesto, rodič dostane ťuknutí dál.
    return Listener(onPointerDown: (_) => react(), child: moving);
  }
}

/// Pár malých emoji, které při reakci vyletí nahoru a zmizí.
class _Particles extends StatelessWidget {
  final Animation<double> anim;
  final String emoji;
  final double box;
  final bool loop;
  final int count;

  const _Particles({
    required this.anim,
    required this.emoji,
    required this.box,
    this.loop = false,
    this.count = 3,
  });

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: AnimatedBuilder(
        animation: anim,
        builder: (context, _) {
          final t = anim.value;
          if (!loop && (t <= 0 || t >= 1)) return const SizedBox.shrink();
          return SizedBox(
            width: box,
            height: box,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                for (var i = 0; i < count; i++)
                  Positioned(
                    left: box * (count == 1 ? 0.7 : 0.15 + 0.32 * i),
                    top: box * (0.1 - 0.55 * ((t + i * 0.27) % 1)),
                    child: Opacity(
                      opacity: (1 - ((t + i * 0.27) % 1)).clamp(0.0, 1.0),
                      child: Text(emoji,
                          style: TextStyle(fontSize: box * 0.26)),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
