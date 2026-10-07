import 'dart:convert';

import 'dart:ui' show Locale;

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:swype_kids/data/keyboard_layout.dart';
import 'package:swype_kids/data/lessons.dart';
import 'package:swype_kids/data/models/content_pack.dart';
import 'package:swype_kids/data/models/sentence.dart';
import 'package:swype_kids/services/pack_service.dart';
import 'package:swype_kids/store/catalog.dart';
import 'package:swype_kids/ui/l10n.dart';
import 'package:swype_kids/world/world_clock.dart';

/// Jazyky s kompletními poznámkami pro rodiče (roadmap v2.3: cs + en).
const _withParentNotes = {Language.cs, Language.en};

const _diacritics = {
  'Á': 'A', 'É': 'E', 'Ě': 'E', 'Í': 'I', 'Ó': 'O', 'Ú': 'U', 'Ů': 'U', 'Ý': 'Y',
  'Š': 'S', 'Č': 'C', 'Ř': 'R', 'Ž': 'Z', 'Ť': 'T', 'Ď': 'D', 'Ň': 'N',
};
String _stripDiacritics(String s) =>
    s.split('').map((c) => _diacritics[c] ?? c).join();

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
        expect(unit.reward.label.trim(), isNotEmpty,
            reason: '${unit.id}: nálepka bez jména (reward.label)');
        expect(Biome.isKnown(unit.biome), isTrue,
            reason: '${unit.id}: neznámý biotop „${unit.biome}“');
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
          if (lesson.type == LessonType.reviewMix) {
            // Musí mít z čeho vybírat: dřívější lekce z odemčených písmen.
            final earlier = pack.allLessons
                .takeWhile((l) => l.id != lesson.id)
                .where((l) => l.type != LessonType.reviewMix)
                .where((l) => unlocked.containsAll(l.target.split('')));
            expect(earlier, isNotEmpty,
                reason: '${lesson.id}: reviewMix bez dřívějších slov');
          }
          switch (lesson.type) {
            case LessonType.letterHunt:
              expect(lesson.target.length, 1,
                  reason: '${lesson.id}: letterHunt má jedno písmeno');
            case LessonType.syllableJoin:
              expect(lesson.parts.length, greaterThanOrEqualTo(2),
                  reason: '${lesson.id}: syllableJoin potřebuje parts');
              expect(_stripDiacritics(lesson.parts.join()).toUpperCase(),
                  lesson.target,
                  reason: '${lesson.id}: parts neodpovídají target');
            case LessonType.rhymePick:
              expect(lesson.options.length, 3,
                  reason: '${lesson.id}: rhymePick má tři možnosti');
              expect(lesson.answer, inInclusiveRange(0, 2));
              expect(lesson.options.map((o) => o.display).toSet().length, 3,
                  reason: '${lesson.id}: duplicitní možnosti');
              expect(lesson.options.map((o) => o.emoji).toSet().length, 3);
            default:
              expect(lesson.parts, isEmpty);
              expect(lesson.options, isEmpty);
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

  test('katalog obchodu: unikátní id, výslovné unlocks, produkty §3 pro '
      'všech 9 jazyků', () async {
    final catalog = await StoreCatalog.load();
    expect(catalog.products, isNotEmpty,
        reason: '${StoreCatalog.assetPath} se nenačetl (pubspec assets?)');

    final ids = <String>{};
    for (final p in catalog.products) {
      expect(ids.add(p.id), isTrue, reason: 'duplicitní produkt ${p.id}');
      expect(p.unlocks.isEmpty, isFalse,
          reason: '${p.id}: chybí unlocks (co produkt odemyká)');
      expect(kBands.toSet().containsAll(p.unlocks.bands), isTrue,
          reason: '${p.id}: neznámé pásmo ${p.unlocks.bands}');
      switch (p.type) {
        case ProductType.island || ProductType.language:
          // Ostrovy a jazyky se prodávají po jazycích.
          expect(p.language, isNotNull, reason: '${p.id}: právě jeden jazyk');
          expect(p.band, isNotNull, reason: '${p.id}: právě jedno pásmo');
        case ProductType.theme:
          // Tematický balíček = jedna položka pro všechny jazyky (§8).
          expect(RegExp(r'^theme\.[a-z0-9-]+$').hasMatch(p.id), isTrue,
              reason: '${p.id}: id tematického balíčku je theme.<name>');
          expect(p.unlocks.languages, isEmpty,
              reason: '${p.id}: tematický balíček není po jazycích');
          expect(p.unlocks.tags, isNotEmpty);
        case ProductType.bundle:
          expect(p.unlocks.all, isTrue);
        case ProductType.voice:
          fail('${p.id}: hlas do katalogu až po ověření licence (§10)');
        case ProductType.parent:
          expect(p.unlocks.features, isNotEmpty);
      }
      // Název a popis existují v každém jazyce UI.
      for (final lang in Language.values) {
        final l = lookupAppLocalizations(Locale(lang.name));
        expect(p.title(l).trim(), isNotEmpty, reason: '${p.id} / ${lang.name}');
        if (p.type != ProductType.theme) {
          expect(p.description(l).trim(), isNotEmpty,
              reason: '${p.id} / ${lang.name}');
        }
      }
    }

    for (final lang in Language.values) {
      final language = catalog.byId(StoreCatalog.languageProductId(lang));
      expect(language?.type, ProductType.language, reason: lang.name);
      expect(language!.unlocks.coversBand(lang, 'a'), isTrue);
      expect(language.unlocks.coversBand(lang, 'b'), isFalse);
      for (final band in ['b', 'c']) {
        final island = catalog.byId(StoreCatalog.islandProductId(lang, band));
        expect(island?.type, ProductType.island, reason: '${lang.name} $band');
        expect(island!.unlocks.coversBand(lang, band), isTrue);
        expect(island.unlocks.coversBand(lang, 'a'), isFalse);
        expect(
            Language.values
                .where((other) => island.unlocks.coversBand(other, band)),
            [lang],
            reason: '${island.id} odemyká jen svůj jazyk');
      }
    }
    expect(catalog.byId('all.forever')?.type, ProductType.bundle);
  });

  test('packy: každé pásmo je známé a každý product je v katalogu', () async {
    final catalog = await StoreCatalog.load();
    for (final lang in Language.values) {
      final raw =
          await rootBundle.loadString('assets/packs/${lang.name}.json');
      final pack = ContentPack.fromJson(
          (jsonDecode(raw) as Map).cast<String, dynamic>());
      for (final unit in pack.units) {
        expect(kBands, contains(unit.band),
            reason: '${unit.id}: neznámé pásmo „${unit.band}“');
        if (unit.product.isNotEmpty) {
          expect(catalog.knowsTag(unit.product), isTrue,
              reason: '${unit.id}: product „${unit.product}“ není v katalogu');
        }
      }
    }
  });

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

  test('PackService.load dokončí načtení (bez cache) i souběžná volání', () async {
    final a = PackService.instance.load(Language.de);
    final b = PackService.instance.load(Language.de);
    final packs = await Future.wait([a, b]).timeout(const Duration(seconds: 10));
    expect(packs[0].language, Language.de);
    expect(identical(packs[0], packs[1]), isTrue);
    // a znovu z cache
    expect((await PackService.instance.load(Language.de)).language, Language.de);
  });
}
