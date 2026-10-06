import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:swype_kids/ui/emoji_art.dart';
import 'package:swype_kids/ui/sticker_kind.dart';

void main() {
  test('druh nálepky podle emoji: zvíře, jídlo, pití, ostatní', () {
    expect(StickerKind.of('🐭'), StickerKind.animal);
    expect(StickerKind.of('🍌'), StickerKind.food);
    expect(StickerKind.of('🥛'), StickerKind.drink);
    expect(StickerKind.of('☀️'), StickerKind.other);
    expect(StickerKind.of('🐿️'), StickerKind.animal); // s FE0F
  });

  test('auto reakce: zvíře srdíčka, jídlo zmáčknutí, věc vždy nějaká', () {
    expect(EmojiArt.resolve('🐭', StickerReaction.auto), StickerReaction.hearts);
    expect(EmojiArt.resolve('🍌', StickerReaction.auto), StickerReaction.squash);
    expect(EmojiArt.resolve('🚗', StickerReaction.auto),
        isNot(anyOf(StickerReaction.auto, StickerReaction.none)));
    expect(EmojiArt.resolve('🚗', StickerReaction.spin), StickerReaction.spin);
  });

  /// Všechny transformace nálepky (posun, otočení, měřítko) jako text.
  Future<String> transformOf(WidgetTester t) async => [
        for (final w in t.widgetList<Transform>(find.descendant(
            of: find.byType(EmojiArt), matching: find.byType(Transform))))
          w.transform.storage.map((v) => v.toStringAsFixed(3)).join(','),
      ].join('|');

  testWidgets('dotyk nálepky v tlačítku: reaguje a rodič dostane ťuknutí',
      (t) async {
    var taps = 0;
    await t.pumpWidget(MaterialApp(
      home: Center(
        child: GestureDetector(
          onTap: () => taps++,
          child: const EmojiArt('🐭', size: 40, animate: false),
        ),
      ),
    ));
    final before = await transformOf(t);
    await t.tap(find.byType(EmojiArt));
    await t.pump();
    await t.pump(const Duration(milliseconds: 200));
    expect(taps, 1, reason: 'Listener nesmí ukrást ťuknutí rodiči');
    expect(await transformOf(t), isNot(before), reason: 'poskočila');
    expect(find.text('❤️'), findsWidgets, reason: 'zvířátko = srdíčka');
    await t.pump(const Duration(seconds: 1));
    expect(find.text('❤️'), findsNothing);
  });

  testWidgets('reakce na akci (trigger) a vlastní onTap', (t) async {
    var said = 0;
    Widget app(Object? trigger) => MaterialApp(
          home: Center(
            child: EmojiArt('🍌',
                size: 40,
                animate: false,
                trigger: trigger,
                onTap: () => said++),
          ),
        );
    await t.pumpWidget(app(null));
    final rest = await transformOf(t);
    await t.pumpWidget(app('hit'));
    await t.pump();
    await t.pump(const Duration(milliseconds: 250));
    expect(await transformOf(t), isNot(rest));
    await t.pump(const Duration(seconds: 1));
    await t.tap(find.byType(EmojiArt));
    expect(said, 1);
    await t.pump(const Duration(seconds: 1));
  });

  testWidgets('akce ve smyčce (jí) a redukce pohybu = stojí', (t) async {
    await t.pumpWidget(const MaterialApp(
      home: Center(
          child: EmojiArt('🐭', size: 40, action: StickerAction.sleep)),
    ));
    await t.pump(const Duration(milliseconds: 500));
    expect(find.text('💤'), findsOneWidget);

    await t.pumpWidget(const MaterialApp(
      home: MediaQuery(
        data: MediaQueryData(disableAnimations: true),
        child: Center(child: EmojiArt('🐭', size: 40)),
      ),
    ));
    final still = await transformOf(t);
    await t.tap(find.byType(EmojiArt));
    await t.pump(const Duration(milliseconds: 200));
    expect(await transformOf(t), still);
  });
}
