import 'dart:ui' show Color;

import '../lessons.dart';

/// Sběratelská odměna za dokončení jednotky (nálepka do Zvěřince).
class CollectibleReward {
  final String emoji;
  final String name;

  const CollectibleReward({required this.emoji, this.name = ''});

  factory CollectibleReward.fromJson(Map<String, dynamic> json) =>
      CollectibleReward(
        emoji: json['emoji'] as String,
        name: json['name'] as String? ?? '',
      );

  Map<String, dynamic> toJson() => {
        'emoji': emoji,
        if (name.isNotEmpty) 'name': name,
      };
}

/// Jednotka = 2–6 lekcí se stejnou sadou odemčených písmen, zakončená odměnou.
class Unit {
  final String id;
  final String title;
  final String icon;
  final CollectibleReward reward;
  final List<Lesson> lessons;

  const Unit({
    required this.id,
    required this.title,
    required this.icon,
    required this.reward,
    required this.lessons,
  });

  factory Unit.fromJson(Map<String, dynamic> json) => Unit(
        id: json['id'] as String,
        title: json['title'] as String? ?? '',
        icon: json['icon'] as String? ?? '⭐',
        reward: CollectibleReward.fromJson(
            (json['reward'] as Map).cast<String, dynamic>()),
        lessons: [
          for (final l in json['lessons'] as List)
            Lesson.fromJson((l as Map).cast<String, dynamic>()),
        ],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'icon': icon,
        'reward': reward.toJson(),
        'lessons': [for (final l in lessons) l.toJson()],
      };
}

/// Obsahový balíček jednoho jazyka (a kulturní varianty) — jednotky, lekce
/// a volitelné overrides emoji/barev klávesnice.
class ContentPack {
  final int schemaVersion;
  final String id; // např. 'cs-CZ'
  final Language language;
  final String culture; // např. 'CZ'
  final String title;
  final String method; // didaktická metoda (informativní)
  final Map<String, String> keyboardEmoji; // overrides nad kEmoji
  final Map<String, Color> keyboardColors; // overrides nad kColors
  final List<Unit> units;

  const ContentPack({
    required this.schemaVersion,
    required this.id,
    required this.language,
    this.culture = '',
    this.title = '',
    this.method = '',
    this.keyboardEmoji = const {},
    this.keyboardColors = const {},
    required this.units,
  });

  List<Lesson> get allLessons => [for (final u in units) ...u.lessons];

  factory ContentPack.fromJson(Map<String, dynamic> json) {
    final keyboard =
        (json['keyboard'] as Map?)?.cast<String, dynamic>() ?? const {};
    return ContentPack(
      schemaVersion: json['schemaVersion'] as int? ?? 1,
      id: json['id'] as String,
      language: Language.values.byName(json['language'] as String),
      culture: json['culture'] as String? ?? '',
      title: json['title'] as String? ?? '',
      method: json['method'] as String? ?? '',
      keyboardEmoji:
          ((keyboard['emoji'] as Map?) ?? const {}).cast<String, String>(),
      keyboardColors: {
        for (final e
            in ((keyboard['colors'] as Map?) ?? const {}).entries)
          e.key as String: _parseHexColor(e.value as String),
      },
      units: [
        for (final u in json['units'] as List)
          Unit.fromJson((u as Map).cast<String, dynamic>()),
      ],
    );
  }
}

/// '#RRGGBB' nebo '#AARRGGBB' → Color.
Color _parseHexColor(String hex) {
  var h = hex.replaceFirst('#', '');
  if (h.length == 6) h = 'FF$h';
  return Color(int.parse(h, radix: 16));
}
