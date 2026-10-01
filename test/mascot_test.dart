import 'package:flutter_test/flutter_test.dart';
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
}
