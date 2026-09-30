import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:swype_kids/data/keyboard_layout.dart';
import 'package:swype_kids/data/lessons.dart';
import 'package:swype_kids/data/models/content_pack.dart';
import 'package:swype_kids/data/models/sentence.dart';

/// Jazyky s kompletními poznámkami pro rodiče (roadmap v2.3: cs + en).
const _withParentNotes = {Language.cs, Language.en};

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
          if (lesson.type == LessonType.missingLetter ||
              lesson.type == LessonType.pictureOnly) {
            expect(lesson.target.length, greaterThan(2),
                reason: '${lesson.id}: ${lesson.type.name} jen pro celá slova');
          }
          if (lesson.gap != null) {
            expect(lesson.type, LessonType.missingLetter,
                reason: '${lesson.id}: gap bez missingLetter');
            expect(lesson.gap, inInclusiveRange(0, lesson.target.length - 1),
                reason: '${lesson.id}: gap mimo target');
          }
        }
      }

      // ── Schéma v2: builder vět + batoh slov ──────────────────────────
      expect(pack.schemaVersion, 2);
      final sentence = pack.sentence;
      expect(sentence.subjects, isNotEmpty);
      expect(sentence.verbs, isNotEmpty);
      expect(sentence.objects, isNotEmpty);
      final tileIds = <String>{};
      for (final tile in sentence.all) {
        expect(tileIds.add(tile.id), isTrue,
            reason: 'duplicitní id dlaždice ${tile.id}');
      }
      // Věta musí jít složit od začátku, i s prázdným batohem.
      for (final cat in [sentence.subjects, sentence.verbs, sentence.objects]) {
        expect(cat.any((t) => t.unlockedBy == TileUnlock.always), isTrue,
            reason: 'kategorie builderu bez základní dlaždice');
      }
      final vocabTiles = {
        for (final t in sentence.all)
          if (t.unlockedBy == TileUnlock.vocab) t.id,
      };
      final lessonVocab = <String>{};
      for (final lesson in pack.allLessons) {
        if (lesson.vocab.isEmpty) continue;
        lessonVocab.add(lesson.vocab);
        expect(vocabTiles, contains(lesson.vocab),
            reason: '${lesson.id}: vocab ${lesson.vocab} nemá vocab dlaždici');
        // Do batohu patří celá slova, ne izolované slabiky (pásmo A).
        expect(lesson.target.length, greaterThan(2),
            reason: '${lesson.id}: vocab u slabiky');
      }
      expect(lessonVocab, containsAll(vocabTiles),
          reason: 'vocab dlaždice, kterou žádná lekce neodemkne');

      // Poznámky pro rodiče: jazyky, které je mají, je mají u každé lekce.
      if (_withParentNotes.contains(lang)) {
        for (final lesson in pack.allLessons) {
          expect(lesson.parentNote.trim(), isNotEmpty,
              reason: '${lesson.id}: chybí parentNote');
        }
      }
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
