// Jednorázový export Dart lekcí (lib/data/lessons/*.dart) do JSON content
// packů (assets/packs/*.json). Čistý Dart — spouštět z kořene repa:
//
//   dart run tool/export_lessons_to_json.dart
//
// Skript je idempotentní; po ručních úpravách JSONů ho už nespouštět naslepo
// (přepsal by je). Zdrojem pravdy se po iteraci 1 stávají JSONy.

import 'dart:convert';
import 'dart:io';

import 'package:swype_kids/data/keyboard_layout.dart';
import 'package:swype_kids/data/lessons.dart';

const Map<Language, String> _culture = {
  Language.cs: 'CZ',
  Language.en: 'US',
  Language.de: 'DE',
  Language.es: 'ES',
  Language.it: 'IT',
  Language.fr: 'FR',
  Language.zh: 'CN',
  Language.ja: 'JP',
  Language.pt: 'BR',
};

const Map<Language, String> _title = {
  Language.cs: 'Slabikář – Čeština',
  Language.en: 'Syllabary – English',
  Language.de: 'Silbenfibel – Deutsch',
  Language.es: 'Silabario – Español',
  Language.it: 'Sillabario – Italiano',
  Language.fr: 'Syllabaire – Français',
  Language.zh: '拼音入门 – 中文',
  Language.ja: 'にほんご – Japanese',
  Language.pt: 'Silabário – Português (Brasil)',
};

// Titulek jednotky „celá slova" (jednotka bez nových písmen, targety > 2).
const Map<Language, String> _wholeWords = {
  Language.cs: 'Celá slova',
  Language.en: 'Whole words',
  Language.de: 'Ganze Wörter',
  Language.es: 'Palabras enteras',
  Language.it: 'Parole intere',
  Language.fr: 'Mots entiers',
  Language.zh: '整个音节词',
  Language.ja: 'ことば',
  Language.pt: 'Palavras inteiras',
};

const Map<Language, String> _method = {
  Language.cs: 'analyticko-syntetická (Hláskovice / Nová škola)',
  Language.en: 'synthetic phonics (Jolly Phonics SATPIN-inspired)',
  Language.de: 'Mimi-Fibel / klassische analytisch-synthetische Fibel',
  Language.es: 'silábico (vocales primero, luego consonantes con cada vocal)',
  Language.it: 'sillabico (vocali prima, poi consonanti con ogni vocale)',
  Language.fr: 'syllabique (inspirée de la Méthode Boscher)',
  Language.zh: 'pinyin progression (Latin transcription, tones in display)',
  Language.ja: 'romaji → hiragana',
  Language.pt: 'silábico (vogais primeiro, depois consoantes em CV)',
};

void main() {
  final outDir = Directory('assets/packs');
  outDir.createSync(recursive: true);

  for (final entry in kLessonsByLang.entries) {
    final lang = entry.key;
    final lessons = entry.value;
    final pack = _buildPack(lang, lessons);
    final file = File('${outDir.path}/${lang.name}.json');
    file.writeAsStringSync(
        '${const JsonEncoder.withIndent('  ').convert(pack)}\n');
    final units = (pack['units'] as List).length;
    stdout.writeln('${file.path}: $units jednotek, ${lessons.length} lekcí');
  }
}

Map<String, dynamic> _buildPack(Language lang, List<Lesson> lessons) {
  // Hranice jednotky = změna množiny odemčených písmen (odpovídá „fázím").
  final phases = <List<Lesson>>[];
  Set<String>? prev;
  for (final l in lessons) {
    final set = l.unlocked.toSet();
    if (prev == null || set.length != prev.length || !set.containsAll(prev)) {
      phases.add([]);
    }
    phases.last.add(l);
    prev = set;
  }

  // Příliš dlouhé fáze (> 6 lekcí) rozdělit na přechodu slabiky → celá slova
  // (target délky > 2) — pedagogicky samostatná jednotka.
  final unitRanges = <List<Lesson>>[];
  for (final phase in phases) {
    if (phase.length <= 6) {
      unitRanges.add(phase);
      continue;
    }
    var current = <Lesson>[];
    for (final l in phase) {
      final isWord = l.target.length > 2;
      final prevIsWord =
          current.isNotEmpty && current.last.target.length > 2;
      if (current.isNotEmpty && isWord && !prevIsWord) {
        unitRanges.add(current);
        current = <Lesson>[];
      }
      current.add(l);
    }
    if (current.isNotEmpty) unitRanges.add(current);
  }

  final seenTargets = <String>{};
  final usedRewardLetters = <String>{};
  final units = <Map<String, dynamic>>[];
  var prevUnlocked = <String>{};

  for (var u = 0; u < unitRanges.length; u++) {
    final unitLessons = unitRanges[u];
    final unlocked = unitLessons.first.unlocked;
    // Nová písmena v pořadí, v jakém jsou v `unlocked` (u první jednotky vše).
    final added = [for (final l in unlocked) if (!prevUnlocked.contains(l)) l];
    // Odměna = emoji prvního dosud „nevyčerpaného" písmene, ať se nálepky
    // ve Zvěřinci neopakují ani u jednotek bez nových písmen.
    final rewardLetter = [...added, ...unlocked]
        .firstWhere((l) => !usedRewardLetters.contains(l), orElse: () => '');
    usedRewardLetters.add(rewardLetter);

    final lessonMaps = <Map<String, dynamic>>[];
    for (var i = 0; i < unitLessons.length; i++) {
      final l = unitLessons[i];
      final isReview = i == unitLessons.length - 1 && unitLessons.length > 1;
      // Poslechové kolo: od 3. jednotky u opakovacích lekcí (bez `info`,
      // target už dříve zazněl) — dítě slovo zná, zvládne ho podle sluchu.
      final isListen = u >= 2 && l.info.isEmpty && seenTargets.contains(l.target);
      seenTargets.add(l.target);
      lessonMaps.add(Lesson(
        id: '${lang.name}-u${u + 1}-l${i + 1}',
        type: isListen ? LessonType.listen : LessonType.swype,
        unlocked: l.unlocked,
        target: l.target,
        display: l.display,
        hint: l.hint,
        label: l.label,
        info: l.info,
        ipa: l.ipa,
        pinyin: l.pinyin,
        review: isReview,
      ).toJson());
    }

    final allWords = unitLessons.every((l) => l.target.length > 2);
    units.add({
      'id': '${lang.name}-u${u + 1}',
      'title': added.isNotEmpty
          ? added.join(', ')
          : (allWords ? _wholeWords[lang]! : unlocked.join(', ')),
      'icon': unitLessons.first.hint,
      'reward': {
        'emoji': kEmoji[rewardLetter] ?? '⭐',
        'name': rewardLetter,
      },
      'lessons': lessonMaps,
    });
    prevUnlocked = unlocked.toSet();
  }

  return {
    'schemaVersion': 1,
    'id': '${lang.name}-${_culture[lang]}',
    'language': lang.name,
    'culture': _culture[lang],
    'title': _title[lang],
    'method': _method[lang],
    'units': units,
  };
}
