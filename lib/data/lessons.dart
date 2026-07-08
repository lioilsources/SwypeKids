export 'lessons_index.dart' show kLessons, kLessonsByLang;

enum Language { cs, en, de, es, it, fr, zh, ja, pt }

/// Typ herního kola. Neznámý typ z JSON padá na [swype] (dopředná kompatibilita).
enum LessonType {
  /// Klasika: karta ukazuje text, dítě ho swypne.
  swype,

  /// Poslechové kolo: text je skrytý, hraje TTS; po prvním neúspěchu se odkryje.
  listen,
}

class Lesson {
  final String id;             // stabilní id z content packu ('' u Dart fallbacku)
  final LessonType type;
  final List<String> unlocked; // aktivní písmena
  final String target;         // co má dítě swypnout (velká, bez diakritiky)
  final String display;        // zobrazovaný text (může mít diakritiku / tóny)
  final String hint;           // emoji pro challenge card
  final String label;          // název slova / slabiky
  final String info;           // info o novém písmenu
  final String ipa;            // hrubý IPA přepis pro TTS / trumpetku
  final String pinyin;         // pinyin s číslem tónu (jen ZH; jinak '')
  final bool review;           // opakovací lekce na konci jednotky

  const Lesson({
    this.id = '',
    this.type = LessonType.swype,
    required this.unlocked,
    required this.target,
    required this.display,
    required this.hint,
    required this.label,
    this.info = '',
    this.ipa = '',
    this.pinyin = '',
    this.review = false,
  });

  factory Lesson.fromJson(Map<String, dynamic> json) => Lesson(
        id: json['id'] as String? ?? '',
        type: LessonType.values.asNameMap()[json['type'] as String? ?? ''] ??
            LessonType.swype,
        unlocked: (json['unlocked'] as List).cast<String>(),
        target: json['target'] as String,
        display: json['display'] as String,
        hint: json['hint'] as String,
        label: json['label'] as String,
        info: json['info'] as String? ?? '',
        ipa: json['ipa'] as String? ?? '',
        pinyin: json['pinyin'] as String? ?? '',
        review: json['review'] as bool? ?? false,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'type': type.name,
        'unlocked': unlocked,
        'target': target,
        'display': display,
        'hint': hint,
        'label': label,
        if (info.isNotEmpty) 'info': info,
        if (ipa.isNotEmpty) 'ipa': ipa,
        if (pinyin.isNotEmpty) 'pinyin': pinyin,
        if (review) 'review': review,
      };
}
