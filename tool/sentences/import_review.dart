// Načte odpovědi rodilého mluvčího (TSV stažené ze stránky z
// `export_review.dart`) do `review/sentences_<lang>.tsv`.
//
//   dart run tool/sentences/import_review.dart swypekids-review-de.tsv
//
// Věta je `ok`, když jsou `ok` všechny její části (sloveso + předmět,
// podmět); jinak přebírá nejhorší verdikt a poznámky korektora. Části,
// které korektor neposoudil, nechávají větu čekat.
import 'dart:convert';
import 'dart:io';

import 'review_classes.dart';
import 'review_rows.dart';

void main(List<String> args) {
  if (args.isEmpty || !File(args.first).existsSync()) {
    stderr.writeln('Použití: dart run tool/sentences/import_review.dart '
        '<odpovědi.tsv>');
    exitCode = 2;
    return;
  }
  final answers = <String, ({String verdict, String note, String who})>{};
  for (final line in File(args.first).readAsLinesSync().skip(1)) {
    if (line.trim().isEmpty) continue;
    final c = line.split('\t');
    String at(int i) => i < c.length ? c[i] : '';
    if (!const {'ok', 'fix', 'nonsense'}.contains(at(1))) continue;
    answers[at(0)] = (verdict: at(1), note: at(2), who: at(3));
  }
  if (answers.isEmpty) {
    stderr.writeln('V souboru nejsou žádné odpovědi.');
    exitCode = 2;
    return;
  }
  final lang = answers.keys.first.split(':')[1];
  final pack = jsonDecode(File('assets/packs/$lang.json').readAsStringSync())
      as Map<String, dynamic>;
  final firstPerson =
      (((pack['sentence'] as Map)['subjects'] as List).first as Map)['id']
          as String;
  final rows = ReviewRows.read(lang);
  final today = DateTime.now().toIso8601String().substring(0, 10);
  const rank = {'ok': 0, 'fix': 1, 'nonsense': 2};
  var ok = 0, bad = 0, waiting = 0;
  for (final r in rows.values) {
    final parts = ReviewClasses.partsOf(r.id, firstPerson: firstPerson);
    final got = [for (final p in parts) answers[p]];
    final judged = got.whereType<({String verdict, String note, String who})>();
    if (judged.isEmpty) continue; // tahle věta nebyla v balíčku
    final worst = judged.reduce(
        (a, b) => rank[a.verdict]! >= rank[b.verdict]! ? a : b);
    if (worst.verdict == 'ok' && got.contains(null)) {
      waiting++; // část ok, část zatím neposouzená → čeká dál
      continue;
    }
    r
      ..human = worst.verdict
      ..humanNote = judged
          .where((a) => a.verdict != 'ok' && a.note.isNotEmpty)
          .map((a) => a.note)
          .toSet()
          .join(' | ')
      ..reviewer = worst.who
      ..date = today;
    worst.verdict == 'ok' ? ok++ : bad++;
  }
  ReviewRows.write(lang, rows.values);
  final pending = rows.values.where((r) => r.human == 'pending').length;
  stdout.writeln('$lang: $ok vět v pořádku, $bad k opravě, '
      '$waiting čeká na další část; celkem čeká $pending z ${rows.length}.');
  if (bad > 0) {
    stdout.writeln('Opravit v packu (tool/sentences/migrate_rules.py), pak '
        'UPDATE_SENTENCES=1 flutter test test/sentence_corpus_test.dart — '
        'do té doby test korpusu neprojde.');
  }
}
