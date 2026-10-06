import 'package:flutter_test/flutter_test.dart';
import 'package:swype_kids/data/lessons.dart';
import 'package:swype_kids/data/models/sentence.dart';
import 'package:swype_kids/pet/gift.dart';
import 'helpers.dart';

/// Pravidla vět ve světě zvířátka. Úplný seznam vět všech jazyků a stav
/// jejich kontroly hlídá `test/sentence_corpus_test.dart`
/// (`review/sentences_<lang>.tsv`).
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
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
