import 'review_rows.dart';

/// Zhuštěný pohled pro korektora (docs/PLAN_VETY_KVALITA.md §3.4): místo
/// každé věty zvlášť se kontroluje
/// - **dvojice sloveso + předmět** pro 1. osobu a pro 3. osobu,
/// - **podmět** (jak stojí na začátku věty),
/// - věty, které se takhle rozložit nedají (vlastní slovesa věcí,
///   pojmenovací věty) — každá zvlášť.
/// Věta je v pořádku, když jsou v pořádku všechny její části.
class ReviewClasses {
  /// Klíče částí, ze kterých se věta [id] skládá. Id:
  /// `<lang>:b:<podmět>.<sloveso>.<předmět>`, `<lang>:p:<emoji>.<sloveso>.<předmět|->`,
  /// `<lang>:p:<emoji>.verb.<předmět>`, `<lang>:n:<předmět>`.
  static List<String> partsOf(String id, {required String firstPerson}) {
    final c = id.split(':');
    final lang = c[0], source = c[1], rest = c.sublist(2).join(':');
    final p = rest.split('.');
    if (source == 'b') {
      final person = p[0] == firstPerson ? '1' : '3';
      return ['class:$lang:$person.${p[1]}.${p[2]}', 'subject:$lang:${p[0]}'];
    }
    if (source == 'p' && p[1] != 'verb') {
      return ['class:$lang:3.${p[1]}.${p[2]}', 'subject:$lang:reward:${p[0]}'];
    }
    return ['single:$id'];
  }

  /// Položky k posouzení: klíč části → příkladová věta a všechna id vět,
  /// kterých se část týká.
  static Map<String, ({String example, List<String> ids})> build(
      Iterable<ReviewRow> rows,
      {required String firstPerson}) {
    final out = <String, ({String example, List<String> ids})>{};
    for (final r in rows) {
      for (final key in partsOf(r.id, firstPerson: firstPerson)) {
        final had = out[key];
        out[key] = (example: had?.example ?? r.text, ids: [...?had?.ids, r.id]);
      }
    }
    return out;
  }
}
