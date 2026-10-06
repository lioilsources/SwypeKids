import 'dart:io';

import 'package:swype_kids/data/sentence_corpus.dart';

/// Stav kontroly jedné věty (`review/sentences_<lang>.tsv`).
class ReviewRow {
  final String id;
  String text;
  String hash;

  /// Strojová korektura: `` (ještě ne) | `ok` | `flag`.
  String llm;
  String llmNote;

  /// Rodilý mluvčí: `pending` | `ok` | `fix` | `nonsense`.
  String human;
  String humanNote;
  String reviewer;
  String date;

  ReviewRow({
    required this.id,
    required this.text,
    required this.hash,
    this.llm = '',
    this.llmNote = '',
    this.human = 'pending',
    this.humanNote = '',
    this.reviewer = '',
    this.date = '',
  });

  /// Smí věta ven? Člověk má poslední slovo: `human: ok` přehlasuje stroj.
  bool get blocked =>
      human == 'fix' || human == 'nonsense' || (llm == 'flag' && human != 'ok');
}

/// Čtení, zápis a sloučení stavu kontroly s aktuálním korpusem.
class ReviewStore {
  static const header =
      'id\ttext\thash\tllm\tllm_note\thuman\thuman_note\treviewer\tdate';

  static File fileFor(String lang) => File('review/sentences_$lang.tsv');

  static String _clean(String s) => s.replaceAll(RegExp(r'[\t\r\n]+'), ' ');

  static Map<String, ReviewRow> read(String lang) {
    final f = fileFor(lang);
    final rows = <String, ReviewRow>{};
    if (!f.existsSync()) return rows;
    for (final line in f.readAsLinesSync().skip(1)) {
      if (line.trim().isEmpty) continue;
      final c = line.split('\t');
      String at(int i) => i < c.length ? c[i] : '';
      rows[at(0)] = ReviewRow(
        id: at(0),
        text: at(1),
        hash: at(2),
        llm: at(3),
        llmNote: at(4),
        human: at(5).isEmpty ? 'pending' : at(5),
        humanNote: at(6),
        reviewer: at(7),
        date: at(8),
      );
    }
    return rows;
  }

  static void write(String lang, Iterable<ReviewRow> rows) {
    final b = StringBuffer()..writeln(header);
    for (final r in rows) {
      b.writeln([
        r.id,
        r.text,
        r.hash,
        r.llm,
        r.llmNote,
        r.human,
        r.humanNote,
        r.reviewer,
        r.date
      ].map(_clean).join('\t'));
    }
    fileFor(lang)
      ..createSync(recursive: true)
      ..writeAsStringSync(b.toString());
  }

  /// Aktuální korpus + dosavadní stav: nezměněná věta si stav nechá,
  /// změněná (jiný otisk) se vrací na „čeká" u stroje i člověka, věta,
  /// která z korpusu zmizela, zmizí i odsud (žádní sirotci).
  static List<ReviewRow> merge(
      List<CorpusSentence> corpus, Map<String, ReviewRow> old) {
    return [
      for (final s in corpus)
        if (old[s.id] case final r? when r.hash == s.hash)
          r
        else
          ReviewRow(id: s.id, text: s.text, hash: s.hash),
    ];
  }
}
