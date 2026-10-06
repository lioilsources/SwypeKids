import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swype_kids/data/lessons.dart';
import 'package:swype_kids/data/models/content_pack.dart';
import 'package:swype_kids/data/models/sentence.dart';
import 'package:swype_kids/data/sentence_corpus.dart';
import 'package:swype_kids/pet/gift.dart';
import 'package:swype_kids/screens/sentence_builder_screen.dart';
import 'package:swype_kids/services/progress_service.dart';
import 'package:swype_kids/ui/sticker_kind.dart';
import 'helpers.dart';

/// Hlídači pravidel vět (`docs/PLAN_VETY_KVALITA.md` §4, T1–T8) nad
/// všemi packy. T4 (stav kontroly) a T6 (snímek) jsou v
/// `sentence_corpus_test.dart`.
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  const kinds = {'person', 'animal', 'thing'};
  const tags = {'food', 'drink', 'toy', 'vehicle', 'place', 'thing', 'body'};

  for (final lang in Language.values) {
    group(lang.name, () {
      late ContentPack pack;
      late SentenceCategories d;
      setUp(() async {
        pack = await seedPack(lang);
        d = pack.sentence;
      });

      test('T1 data jsou úplná: druhy, štítky, co sloveso bere, pojmenování',
          () {
        for (final s in d.subjects) {
          expect(kinds, contains(s.kind), reason: 'podmět ${s.id}');
        }
        for (final o in d.objects) {
          expect(o.tags, isNotEmpty, reason: 'předmět ${o.id}');
          expect(tags.containsAll(o.tags), isTrue, reason: '${o.id} ${o.tags}');
        }
        for (final v in d.verbs) {
          expect(v.subjectKinds, isNotEmpty, reason: 'sloveso ${v.id}');
          expect(v.objectTags, isNotEmpty, reason: 'sloveso ${v.id}');
          expect(v.frame, isNotNull, reason: 'sloveso ${v.id}');
        }
        expect(d.naming, contains('{nom}'));
        for (final u in pack.units) {
          expect(kinds, contains(u.reward.kind), reason: u.reward.emoji);
          expect(u.reward.subject, isNotEmpty, reason: u.reward.emoji);
        }
      });

      test('T2 žádná nabízená věta nepoužije tichý základní tvar', () {
        for (final s in SentenceCorpus.of(pack)) {
          expect(s.fallbacks, isEmpty, reason: '${s.id}: ${s.text}');
        }
      });

      test('T5 věta se stejným slovesem a předmětem se liší jen podmětem '
          '(zhuštěný pohled pro korektora platí)', () {
        final tails = <String, String>{};
        final subjects = [...d.subjects, ...PetSentence.stickerSubjects(pack)];
        for (final s in subjects) {
          for (final v in d.verbs) {
            for (final o in d.objects) {
              if (!SentenceRules.allows(d, subject: s, verb: v, object: o)) {
                continue;
              }
              final c = ComposedSentence(
                  subject: s,
                  verb: v,
                  object: o,
                  joiner: d.joiner,
                  verbLast: d.order == 'sov');
              expect(c.text, startsWith(s.text));
              final tail = c.text.substring(s.text.length);
              final key = '${s.person ?? '-'}|${v.id}|${o.id}';
              expect(tails.putIfAbsent(key, () => tail), tail, reason: key);
            }
          }
        }
      });

      test('T7 je co skládat: každé sloveso má aspoň 2 věty, každý '
          'předmět jde použít nebo aspoň pojmenovat', () {
        for (final v in d.verbs) {
          final n = d.objects.where((o) => SentenceRules.objectFits(v, o));
          expect(n.length, greaterThanOrEqualTo(2), reason: 'sloveso ${v.id}');
        }
        for (final o in d.objects) {
          final usable = d.verbs.any((v) => SentenceRules.objectFits(v, o)) ||
              SentenceRules.naming(d, o) != null;
          expect(usable, isTrue, reason: 'předmět ${o.id}');
        }
      });

      test('T8 druh nálepky v packu souhlasí s tabulkou emoji', () {
        for (final u in pack.units) {
          final byEmoji = switch (StickerKind.of(u.reward.emoji)) {
            StickerKind.animal => 'animal',
            StickerKind.person => 'person',
            _ => 'thing',
          };
          expect(u.reward.kind, byEmoji, reason: u.reward.emoji);
        }
        for (final s in d.subjects) {
          final byEmoji = switch (StickerKind.of(s.emoji)) {
            StickerKind.animal => 'animal',
            _ => 'person',
          };
          expect(s.kind, byEmoji, reason: s.id);
        }
      });
    });
  }

  testWidgets('T3 Skládej větu nabídne jen věty z korpusu (náhodné klikání)',
      (tester) async {
    SharedPreferences.setMockInitialValues({});
    await ProgressService.init();
    final pack = await tester.runAsync(() => seedPack(Language.cs));
    final p = ProgressService.instance;
    // Všechno odemčené: slova v batohu, všechny nálepky.
    for (final t in pack!.sentence.all) {
      p.addWord(pack.id, t.id);
    }
    for (final u in pack.units) {
      p.addCollectible(pack.id, u.reward.emoji);
    }
    final corpus = {for (final s in SentenceCorpus.of(pack)) s.text};
    final d = pack.sentence;
    final subjects = [...d.subjects, ...PetSentence.stickerSubjects(pack)];

    tester.view.physicalSize = const Size(1400, 4000);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(localizedApp(
      home: Scaffold(
        body: SentenceBuilderScreen(
            language: Language.cs, onLanguageChanged: (_) {}),
      ),
    ));
    await tester.pump();
    await tester.pump();

    final rng = Random(7);
    Future<void> tapTile(SentencePart part) async {
      final on = find.byKey(ValueKey('tile-${part.id}'));
      final off = find.byKey(ValueKey('tile-${part.id}-off'));
      await tester.tap(on.evaluate().isNotEmpty ? on : off,
          warnIfMissed: false);
      await tester.pump();
    }

    var saved = 0;
    for (var i = 0; i < 120; i++) {
      // Náhodné pořadí: dítě ťuká, na co chce (i na zešedlé dlaždice).
      final picks = [
        subjects[rng.nextInt(subjects.length)],
        d.verbs[rng.nextInt(d.verbs.length)],
        // pár pokusů o předmět — většina se k slovesu nehodí a zešedne
        for (var k = 0; k < 4; k++) d.objects[rng.nextInt(d.objects.length)],
      ]..shuffle(rng);
      for (final part in picks) {
        await tapTile(part);
      }
      final save = find.byKey(const ValueKey('save-book'));
      if (save.evaluate().isEmpty) continue;
      final before = p.book(pack.id).length;
      await tester.tap(save);
      await tester.pump();
      final book = p.book(pack.id);
      if (book.length > before) {
        saved++;
        expect(corpus, contains('${book.last.text}.'),
            reason: 'věta mimo korpus: ${book.last.text}');
      }
    }
    expect(saved, greaterThan(10), reason: 'náhodné klikání složilo věty');
    await settle(tester);
  });
}
