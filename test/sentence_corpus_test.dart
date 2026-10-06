import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:swype_kids/data/lessons.dart';
import 'package:swype_kids/data/sentence_corpus.dart';

import '../tool/sentences/review_store.dart';
import 'helpers.dart';

/// Korpus vět (vše, co appka umí říct) ↔ stav kontroly v
/// `review/sentences_<lang>.tsv`. Plán: `docs/PLAN_VETY_KVALITA.md`.
///
/// Po změně vět (pack, pravidla): `UPDATE_SENTENCES=1 flutter test
/// test/sentence_corpus_test.dart` — nezměněné věty si stav kontroly
/// nechají, změněné a nové čekají znovu.
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  final update = Platform.environment['UPDATE_SENTENCES'] == '1';
  final status = <String>[];

  for (final lang in Language.values) {
    test('korpus vět — ${lang.name}', () async {
      final pack = await seedPack(lang);
      final corpus = SentenceCorpus.of(pack);
      expect(corpus, isNotEmpty);
      // Stabilní id jsou jedinečná, žádná věta není prázdná ani „null".
      expect(corpus.map((s) => s.id).toSet().length, corpus.length);
      for (final s in corpus) {
        expect(s.text.trim(), isNotEmpty, reason: s.id);
        expect(s.text, isNot(contains('null')), reason: s.id);
      }

      final old = ReviewStore.read(lang.name);
      final rows = ReviewStore.merge(corpus, old);
      if (update) {
        ReviewStore.write(lang.name, rows);
      } else {
        // TSV musí odpovídat korpusu: stejná id, stejné otisky, žádní sirotci.
        expect(old.keys.toSet(), corpus.map((s) => s.id).toSet(),
            reason: 'věty se změnily — UPDATE_SENTENCES=1');
        for (final s in corpus) {
          expect(old[s.id]!.hash, s.hash, reason: '${s.id}: ${s.text}');
        }
      }

      final fallback = corpus.where((s) => s.fallbacks
          .any((f) => f != 'acc?')); // tichý základní tvar (třída B)
      final blocked = rows.where((r) => r.blocked);
      final llmOk = rows.where((r) => r.llm == 'ok').length;
      final humanOk = rows.where((r) => r.human == 'ok').length;
      status.add('| ${lang.name} | ${corpus.length} | ${fallback.length} | '
          '$llmOk | $humanOk | ${blocked.length} |');
    });
  }

  tearDownAll(() {
    final table = [
      '| jazyk | vět | tichý základní tvar | stroj ok | člověk ok | blokováno |',
      '|---|---|---|---|---|---|',
      ...status,
    ].join('\n');
    // ignore: avoid_print
    print('\nSTAV VĚT\n$table\n');
    if (update) {
      File('review/STATUS.md').writeAsStringSync(
          '# Stav kontroly vět\n\nGenerováno `UPDATE_SENTENCES=1 flutter test '
          'test/sentence_corpus_test.dart` — needitovat ručně. Co sloupce '
          'znamenají: `docs/PLAN_VETY_KVALITA.md`.\n\n$table\n');
    }
  });
}
