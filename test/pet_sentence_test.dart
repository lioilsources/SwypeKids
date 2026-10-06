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

  test('čeština: myš jí jablko, pije mléko, si hraje; věc větu nemá', () async {
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
    // Věc nejí, nepije ani si nehraje: dárek jí jen zajiskří, bez věty.
    final banana = pack.units.firstWhere((u) => u.reward.emoji == '🍌').reward;
    expect(say(banana, Gift(id: apple.id, emoji: '🍎', object: apple)), isNull);
    final toy = pack.sentence.objects.firstWhere((o) => o.emoji == '🧸');
    final toyGift = Gift(id: toy.id, emoji: '🧸', object: toy);
    expect(say(banana, toyGift), isNull);
    // Zvratné „si" stojí na druhém místě: „Myš si hraje", ne „hraje si".
    expect(say(mouse, toyGift), 'Myš si hraje s hračkou.');
    final bike = pack.sentence.objects.firstWhere((o) => o.id == 'kolo');
    expect(say(mouse, Gift(id: 'kolo', emoji: '🚲', object: bike)),
        'Myš si hraje s kolem.');
    // Ema (člověk) jí jako zvířátko.
    final ema = pack.units.firstWhere((u) => u.reward.emoji == '👧').reward;
    expect(say(ema, Gift(id: apple.id, emoji: '🍎', object: apple)),
        'Ema jí jablko.');
  });

  test('Skládej větu: „Já si hraju s autem", „Máma si hraje s autem"', () async {
    final pack = await seedPack(Language.cs);
    final d = pack.sentence;
    final play = d.verbs.firstWhere((v) => v.id == 'v6');
    final car = d.objects.firstWhere((o) => o.id == 'auto');
    String say(String subject) => ComposedSentence(
          subject: d.subjects.firstWhere((s) => s.id == subject),
          verb: play,
          object: car,
        ).text;
    expect(play.text, 'hraju si'); // nápis na dlaždici
    expect(say('s1'), 'Já si hraju s autem');
    expect(say('mama'), 'Máma si hraje s autem');
  });
}
