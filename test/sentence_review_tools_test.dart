import 'package:flutter_test/flutter_test.dart';

import '../tool/sentences/review_classes.dart';
import '../tool/sentences/review_rows.dart';

/// Zhuštěný pohled pro korektora (`tool/sentences/`): z čeho se věta
/// skládá a že každá věta korpusu patří aspoň do jedné položky.
void main() {
  test('části věty: sloveso + předmět podle osoby, podmět, jednotlivé věty',
      () {
    List<String> parts(String id) =>
        ReviewClasses.partsOf(id, firstPerson: 's1');
    expect(parts('cs:b:s1.v2.o2'), ['class:cs:1.v2.o2', 'subject:cs:s1']);
    expect(parts('cs:b:mama.v2.o2'), ['class:cs:3.v2.o2', 'subject:cs:mama']);
    // Svět zvířátka sdílí třídu 3. osoby se Skládej větu.
    expect(parts('cs:p:🐭.v2.o2'), ['class:cs:3.v2.o2', 'subject:cs:reward:🐭']);
    expect(parts('cs:p:🐭.v2.-'), ['class:cs:3.v2.-', 'subject:cs:reward:🐭']);
    // Vlastní sloveso věci a pojmenovací věta se posuzují každá zvlášť.
    expect(parts('cs:p:👁️.verb.kolo'), ['single:cs:p:👁️.verb.kolo']);
    expect(parts('cs:n:kolo'), ['single:cs:n:kolo']);
  });

  test('každá věta korpusu je pokrytá a položek je řádově méně než vět', () {
    for (final lang in ['cs', 'en', 'de', 'es', 'it', 'fr', 'pt', 'zh', 'ja']) {
      final rows = ReviewRows.read(lang);
      expect(rows, isNotEmpty, reason: lang);
      final first = rows.keys.first.split(':')[2].split('.').first;
      final classes =
          ReviewClasses.build(rows.values, firstPerson: first);
      final covered = {for (final c in classes.values) ...c.ids};
      expect(covered, rows.keys.toSet(), reason: lang);
      expect(classes.length * 2, lessThan(rows.length), reason: lang);
    }
  });
}
