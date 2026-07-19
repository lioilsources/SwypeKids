import 'dart:convert';
import 'dart:ui' show Color;

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart' show rootBundle;

import '../data/keyboard_data.dart';
import '../data/lessons.dart';
import '../data/models/content_pack.dart';

/// Načítá content packy z assets/packs/{lang}.json s in-memory cache.
/// Když asset chybí nebo je rozbitý, syntetizuje pack z Dart lekcí
/// (kLessonsByLang) — záchranná síť během přechodu na JSON.
class PackService {
  PackService._();
  static final PackService instance = PackService._();

  final Map<Language, ContentPack> _cache = {};

  ContentPack? cached(Language lang) => _cache[lang];

  Future<ContentPack> load(Language lang) async {
    final hit = _cache[lang];
    if (hit != null) return hit;
    ContentPack pack;
    try {
      final raw = await rootBundle.loadString('assets/packs/${lang.name}.json');
      pack = ContentPack.fromJson(
          (jsonDecode(raw) as Map).cast<String, dynamic>());
    } catch (e) {
      debugPrint('PackService: fallback na Dart lekce pro ${lang.name}: $e');
      pack = _fromDartLessons(lang);
    }
    _cache[lang] = pack;
    return pack;
  }

  /// Emoji klávesy s ohledem na per-pack override.
  String keyEmojiFor(ContentPack pack, String letter) =>
      pack.keyboardEmoji[letter] ?? keyEmoji(letter);

  /// Barva klávesy s ohledem na per-pack override.
  Color keyColorFor(ContentPack pack, String letter) =>
      pack.keyboardColors[letter] ?? keyColor(letter);

  /// Fallback: jednotky odvodí ze změn množiny `unlocked` (stejná logika
  /// jako tool/export_lessons_to_json.dart, bez jemností).
  ContentPack _fromDartLessons(Language lang) {
    final lessons = kLessonsByLang[lang]!;
    final ranges = <List<Lesson>>[];
    Set<String>? prev;
    for (final l in lessons) {
      final set = l.unlocked.toSet();
      if (prev == null ||
          set.length != prev.length ||
          !set.containsAll(prev)) {
        ranges.add([]);
      }
      ranges.last.add(l);
      prev = set;
    }

    final usedRewards = <String>{};
    var prevUnlocked = <String>{};
    final units = <Unit>[];
    for (var u = 0; u < ranges.length; u++) {
      final unlocked = ranges[u].first.unlocked;
      final added =
          [for (final l in unlocked) if (!prevUnlocked.contains(l)) l];
      final rewardLetter = [...added, ...unlocked]
          .firstWhere((l) => !usedRewards.contains(l), orElse: () => '');
      usedRewards.add(rewardLetter);
      units.add(Unit(
        id: '${lang.name}-u${u + 1}',
        title: (added.isNotEmpty ? added : unlocked).join(', '),
        icon: ranges[u].first.hint,
        reward: CollectibleReward(
            emoji: kEmojiByLang[lang]![rewardLetter] ?? keyEmoji(rewardLetter),
            name: rewardLetter),
        lessons: [
          for (var i = 0; i < ranges[u].length; i++)
            Lesson(
              id: '${lang.name}-u${u + 1}-l${i + 1}',
              type: ranges[u][i].type,
              unlocked: ranges[u][i].unlocked,
              target: ranges[u][i].target,
              display: ranges[u][i].display,
              hint: ranges[u][i].hint,
              label: ranges[u][i].label,
              info: ranges[u][i].info,
              ipa: ranges[u][i].ipa,
              pinyin: ranges[u][i].pinyin,
              review: i == ranges[u].length - 1 && ranges[u].length > 1,
            ),
        ],
      ));
      prevUnlocked = unlocked.toSet();
    }

    return ContentPack(
      schemaVersion: 1,
      id: lang.name,
      language: lang,
      keyboardEmoji: kEmojiByLang[lang]!,
      units: units,
    );
  }
}
