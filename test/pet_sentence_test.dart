import 'package:flutter_test/flutter_test.dart';
import 'package:swype_kids/data/lessons.dart';
import 'package:swype_kids/data/models/content_pack.dart';
import 'package:swype_kids/data/models/sentence.dart';
import 'package:swype_kids/pet/gift.dart';
import 'helpers.dart';

/// Pravidla vět ve světě zvířátka a ve Skládej větu. Úplný seznam vět
/// všech jazyků a stav jejich kontroly hlídá
/// `test/sentence_corpus_test.dart` (`review/sentences_<lang>.tsv`).
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  Gift giftOf(ContentPack pack, String id) {
    final o = pack.sentence.objects.firstWhere((o) => o.id == id);
    return Gift(id: o.id, emoji: o.emoji, object: o);
  }

  CollectibleReward rewardOf(ContentPack pack, String emoji) =>
      pack.units.firstWhere((u) => u.reward.emoji == emoji).reward;

  test('japonština: sloveso na konci, „ほしい" bere が', () async {
    final pack = await seedPack(Language.ja);
    final cat = rewardOf(pack, '🐱');
    expect(PetSentence.line(pack, cat, giftOf(pack, 'o2'))!.text,
        'ねこはりんごをたべます。');
    final d = pack.sentence;
    expect(
        ComposedSentence(
          subject: d.subjects.first,
          verb: d.verbs.firstWhere((v) => v.id == 'v1'),
          object: d.objects.firstWhere((o) => o.id == 'o2'),
          joiner: d.joiner,
          verbLast: true,
        ).text,
        'わたしはりんごがほしいです');
  });

  test('čeština: zvíře jí / pije / si hraje; předmět jen s tvarem', () async {
    final pack = await seedPack(Language.cs);
    final mouse = pack.units.first.reward;
    String? say(CollectibleReward r, Gift g) =>
        PetSentence.line(pack, r, g)?.text;
    expect(say(mouse, giftOf(pack, 'o2')), 'Myš jí jablko.');
    expect(say(mouse, giftOf(pack, 'mleko')), 'Myš pije mléko.');
    // Zvratné „si" stojí na druhém místě: „Myš si hraje", ne „hraje si".
    expect(say(mouse, giftOf(pack, 'hracka')), 'Myš si hraje s hračkou.');
    expect(say(mouse, giftOf(pack, 'kolo')), 'Myš si hraje s kolem.');
    // Dárek, který builder nezná → věta bez předmětu, nikdy špatný tvar.
    expect(say(mouse, const Gift(id: 'x', emoji: '💧')), 'Myš pije.');
    // Ema (člověk) jí jako zvířátko.
    expect(say(rewardOf(pack, '👧'), giftOf(pack, 'o2')), 'Ema jí jablko.');
  });

  test('čeština: věc má vlastní sloveso, nebo dárek jen pojmenuje', () async {
    final pack = await seedPack(Language.cs);
    String? say(String emoji, Gift g) =>
        PetSentence.line(pack, rewardOf(pack, emoji), g)?.text;
    // Oko se dívá, auto veze, ucho slyší jen to, co je slyšet.
    expect(say('👁️', giftOf(pack, 'kolo')), 'Oko se dívá na kolo.');
    expect(say('🚗', giftOf(pack, 'banan')), 'Auto veze banán.');
    expect(say('👂', giftOf(pack, 'vlak')), 'Ucho slyší vlak.');
    expect(say('👂', giftOf(pack, 'o2')), 'To je jablko.');
    // Banán vlastní sloveso nemá → pojmenuje dárek; žádné „Banán hraje…".
    expect(say('🍌', giftOf(pack, 'hracka')), 'To je hračka.');
    expect(say('🍌', const Gift(id: 'x', emoji: '🍪')), isNull);
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

  test('pravidla: nesmysly ani věty bez tvaru nejdou složit', () async {
    final pack = await seedPack(Language.cs);
    final d = pack.sentence;
    SentencePart v(String id) => d.verbs.firstWhere((x) => x.id == id);
    SentencePart o(String id) => d.objects.firstWhere((x) => x.id == id);
    bool ok(String verb, String object) =>
        SentenceRules.objectFits(v(verb), o(object));
    expect(ok('v2', 'o2'), isTrue); // jí jablko
    expect(ok('v2', 'o8'), isFalse); // jí nočník
    expect(ok('v3', 'o2'), isFalse); // pije jablko
    expect(ok('v5', 'o8'), isTrue); // jde na nočník
    expect(ok('v4', 'o8'), isFalse); // spí na nočníku
    expect(ok('v6', 'kolo'), isTrue); // hraje si s kolem
    expect(ok('v1', 'o5'), isFalse); // chce „venek"
    expect(ok('v1', 'nos'), isFalse); // chce nos
    final en = (await seedPack(Language.en)).sentence;
    bool okEn(String verb, String object) => SentenceRules.objectFits(
        en.verbs.firstWhere((x) => x.id == verb),
        en.objects.firstWhere((x) => x.id == object));
    expect(okEn('v4', 'o1'), isFalse); // „sleeps milk"
    expect(okEn('v5', 'o3'), isFalse); // „goes a toy"
    expect(okEn('v5', 'o7'), isTrue); // goes to bed
  });
}
