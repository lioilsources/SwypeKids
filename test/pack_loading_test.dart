import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:swype_kids/data/keyboard_layout.dart';
import 'package:swype_kids/data/lessons.dart';
import 'package:swype_kids/data/models/content_pack.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  final keyboardLetters = kRows.expand((r) => r).toSet();

  for (final lang in Language.values) {
    test('pack ${lang.name}: načte se a je konzistentní', () async {
      final raw =
          await rootBundle.loadString('assets/packs/${lang.name}.json');
      final pack = ContentPack.fromJson(
          (jsonDecode(raw) as Map).cast<String, dynamic>());

      expect(pack.language, lang);
      expect(pack.id, isNotEmpty);
      expect(pack.units, isNotEmpty);

      // Lokalizovaná emoji mnemotechnika: pack definuje emoji pro každou
      // klávesu, hodnoty jsou neprázdné a unikátní (nálepky dedupují emoji).
      expect(pack.keyboardEmoji.keys.toSet(), keyboardLetters,
          reason: 'keyboard.emoji nepokrývá přesně všechny klávesy');
      expect(pack.keyboardEmoji.values.every((e) => e.isNotEmpty), isTrue);
      expect(pack.keyboardEmoji.values.toSet().length,
          pack.keyboardEmoji.length,
          reason: 'duplicitní emoji v keyboard.emoji');

      final ids = <String>{};
      for (final unit in pack.units) {
        expect(ids.add(unit.id), isTrue,
            reason: 'duplicitní id jednotky ${unit.id}');
        expect(unit.reward.emoji, isNotEmpty);
        if (unit.reward.name.isNotEmpty) {
          expect(unit.reward.emoji, pack.keyboardEmoji[unit.reward.name],
              reason:
                  'odměna ${unit.id} neodpovídá keyboard.emoji[${unit.reward.name}]');
        }
        expect(unit.lessons, isNotEmpty);
        for (final lesson in unit.lessons) {
          expect(ids.add(lesson.id), isTrue,
              reason: 'duplicitní id lekce ${lesson.id}');
          expect(lesson.hint, isNotEmpty);
          expect(lesson.target, isNotEmpty);
          final unlocked = lesson.unlocked.toSet();
          expect(keyboardLetters.containsAll(unlocked), isTrue,
              reason: '${lesson.id}: unlocked mimo klávesnici');
          expect(unlocked.containsAll(lesson.target.split('')), isTrue,
              reason: '${lesson.id}: target obsahuje neodemčené písmeno');
        }
      }

      // Hlídá drift mezi JSON packy a Dart lekcemi, dokud existují oba zdroje.
      expect(pack.allLessons.length, kLessonsByLang[lang]!.length,
          reason: 'počet lekcí v JSON neodpovídá lib/data/lessons/');
    });
  }

  test('kEmojiByLang pokrývá každý jazyk × všechna písmena klávesnice', () {
    for (final lang in Language.values) {
      final table = kEmojiByLang[lang];
      expect(table, isNotNull, reason: 'chybí tabulka pro ${lang.name}');
      expect(table!.keys.toSet(), keyboardLetters,
          reason: '${lang.name}: tabulka nepokrývá přesně klávesnici');
      expect(table.values.every((e) => e.isNotEmpty), isTrue);
      expect(table.values.toSet().length, table.length,
          reason: '${lang.name}: duplicitní emoji v tabulce');
    }
  });
}
