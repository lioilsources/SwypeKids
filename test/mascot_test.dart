import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:swype_kids/characters/draggable_guide.dart';
import 'package:swype_kids/characters/mascot.dart';
import 'package:swype_kids/data/lessons.dart';

void main() {
  test('pozdrav jménem v každém jazyce, bez jména bez oslovení, v noci dobrou noc', () {
    expect(Mascot.greeting(Language.cs, 'Ema'), 'Ahoj, Ema!');
    expect(Mascot.greeting(Language.cs, ''), 'Ahoj!');
    expect(Mascot.greeting(Language.cs, 'Ema', night: true),
        'Dobrou noc, Ema, zítra zase.');
    expect(Mascot.greeting(Language.en, 'Tom'), 'Hi, Tom!');
    expect(Mascot.greeting(Language.zh, '小明'), '你好，小明！');
    expect(Mascot.greeting(Language.ja, 'ゆい'), 'ゆい、こんにちは！');
    expect(Mascot.greeting(Language.ja, ''), 'こんにちは！');
    for (final l in Language.values) {
      expect(Mascot.greeting(l, 'X'), contains('X'));
      expect(Mascot.greeting(l, '').contains('{name}'), isFalse);
    }
  });

  test('jméno průvodce = zdrobnělina zvířete v každém jazyce', () {
    expect(Mascot.name(Language.cs), 'Pandička');
    for (final l in Language.values) {
      expect(Mascot.name(l), isNotEmpty, reason: l.name);
    }
  });

  test('každý stav i každá varianta jásotu má obrázek', () {
    for (final m in MascotMood.values) {
      for (var v = 0; v < Mascot.cheerVariants.length; v++) {
        final path = Mascot.imageFor(m, variant: v);
        expect(File(path).existsSync(), isTrue, reason: path);
      }
    }
  });

  group('DraggableGuide.resolve', () {
    const box = Size(100, 80);
    const area = Size(400, 800);
    const keys = (rect: Rect.fromLTRB(0, 400, 400, 600), weight: 4.0);
    const card = (rect: Rect.fromLTRB(0, 60, 400, 300), weight: 2.0);

    test('na volném místě zůstane', () {
      const p = Offset(150, 310);
      expect(
          DraggableGuide.resolve(
              from: p, box: box, area: area, obstacles: [keys, card]),
          p);
    });

    test('puštěný na klávesy odejde na nejbližší volné místo', () {
      final p = DraggableGuide.resolve(
          from: const Offset(150, 430),
          box: box,
          area: area,
          obstacles: [keys, card]);
      final r = p & box;
      expect(r.overlaps(keys.rect), isFalse);
      expect(r.overlaps(card.rect), isFalse);
      // Nejbližší je mezera nad klávesami (300–400), ne až dole.
      expect(p.dy, lessThan(400));
    });

    test('mimo plochu se vrátí dovnitř', () {
      final p = DraggableGuide.resolve(
          from: const Offset(900, 900), box: box, area: area, obstacles: []);
      expect(p, const Offset(300, 720));
    });

    test('když volné místo není, vybere nejmenší překážku (kartu, ne klávesy)',
        () {
      final p = DraggableGuide.resolve(
          from: const Offset(0, 0),
          box: box,
          area: const Size(400, 400),
          obstacles: [
            (rect: const Rect.fromLTRB(0, 0, 400, 200), weight: 2.0),
            (rect: const Rect.fromLTRB(0, 200, 400, 400), weight: 4.0),
          ]);
      expect((p & box).bottom, lessThanOrEqualTo(200));
    });
  });
}
