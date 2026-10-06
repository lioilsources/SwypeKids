import 'package:swype_kids/data/sentence_corpus.dart';

import 'review_rows.dart';

export 'review_rows.dart';

/// Sloučení stavu kontroly s aktuálním korpusem.
class ReviewStore {
  static Map<String, ReviewRow> read(String lang) => ReviewRows.read(lang);

  static void write(String lang, Iterable<ReviewRow> rows) =>
      ReviewRows.write(lang, rows);

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
