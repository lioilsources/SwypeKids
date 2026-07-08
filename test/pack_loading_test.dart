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

      final ids = <String>{};
      for (final unit in pack.units) {
        expect(ids.add(unit.id), isTrue,
            reason: 'duplicitní id jednotky ${unit.id}');
        expect(unit.reward.emoji, isNotEmpty);
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
}
