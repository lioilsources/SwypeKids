import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:swype_kids/data/lessons.dart';
import 'package:swype_kids/data/models/sentence.dart';
import 'package:swype_kids/pet/gift.dart';
import 'package:swype_kids/ui/sticker_kind.dart';
import 'helpers.dart';

/// Věty ze světa zvířátka pro všechny nálepky × základní dárky ve všech
/// jazycích. Výstup jde do `test/golden/pet_sentences_<lang>.txt` k revizi
/// rodilým mluvčím; test hlídá, že se nezmění bez vědomí.
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  final update = Platform.environment['UPDATE_PET_SENTENCES'] == '1';

  for (final lang in Language.values) {
    test('věty ve světě zvířátka — ${lang.name}', () async {
      final pack = await seedPack(lang);
      final gifts = [
        for (final o in pack.sentence.objects)
          if (o.unlockedBy == TileUnlock.always &&
              StickerKind.of(o.emoji).giftable)
            Gift(id: o.id, emoji: o.emoji, object: o),
        // dárek bez dlaždice builderu → věta bez předmětu
        const Gift(id: 'x-food', emoji: '🍌'),
        const Gift(id: 'x-drink', emoji: '💧'),
      ];
      final lines = <String>[];
      for (final u in pack.units) {
        for (final g in gifts) {
          final s = PetSentence.compose(pack, u.reward, g);
          if (s == null) {
            lines.add('${u.reward.emoji} + ${g.emoji} → ✨');
            continue;
          }
          final text = PetSentence.sentenceText(s, lang);
          expect(text, isNot(contains('null')));
          expect(s.verb, isNotNull, reason: 'v2/v3/v6 v packu ${lang.name}');
          lines.add('${u.reward.emoji} + ${g.emoji} → $text');
        }
      }
      final file = File('test/golden/pet_sentences_${lang.name}.txt');
      final out = '${lines.join('\n')}\n';
      if (update || !file.existsSync()) {
        file.writeAsStringSync(out);
      } else {
        expect(out, file.readAsStringSync(),
            reason: 'změna vět — přegeneruj UPDATE_PET_SENTENCES=1');
      }
    });
  }

  test('japonština: sloveso na konci', () async {
    final pack = await seedPack(Language.ja);
    final cat = pack.units.firstWhere((u) => u.reward.emoji == '🐱').reward;
    final apple = pack.sentence.objects.firstWhere((o) => o.emoji == '🍎');
    final s = PetSentence.compose(
        pack, cat, Gift(id: apple.id, emoji: '🍎', object: apple))!;
    expect(PetSentence.sentenceText(s, Language.ja), 'ねこはりんごをたべます。');
  });

  test('čeština: myš jí jablko, pije mléko, věc si jen hraje', () async {
    final pack = await seedPack(Language.cs);
    final mouse = pack.units.first.reward;
    final apple = pack.sentence.objects.firstWhere((o) => o.emoji == '🍎');
    String? say(reward, Gift g) {
      final s = PetSentence.compose(pack, reward, g);
      return s == null ? null : PetSentence.sentenceText(s, Language.cs);
    }

    expect(say(mouse, Gift(id: apple.id, emoji: '🍎', object: apple)),
        'Myš jí jablko.');
    expect(say(mouse, const Gift(id: 'x', emoji: '💧')), 'Myš pije.');
    // Věc nejí: jablko banánu jen zajiskří, hračka = hraje si.
    final banana = pack.units.firstWhere((u) => u.reward.emoji == '🍌').reward;
    expect(say(banana, Gift(id: apple.id, emoji: '🍎', object: apple)), isNull);
    final toy = pack.sentence.objects.firstWhere((o) => o.emoji == '🧸');
    expect(say(banana, Gift(id: toy.id, emoji: '🧸', object: toy)),
        'Banán hraje s hračkou.');
    // Ema (člověk) jí jako zvířátko.
    final ema = pack.units.firstWhere((u) => u.reward.emoji == '👧').reward;
    expect(say(ema, Gift(id: apple.id, emoji: '🍎', object: apple)),
        'Ema jí jablko.');
  });
}
