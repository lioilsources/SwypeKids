export 'lessons_index.dart' show kLessons, kLessonsByLang;

enum Language { cs, en, de, es, it, fr, zh, ja, pt }

class Lesson {
  final List<String> unlocked; // aktivní písmena
  final String target;         // co má dítě swypnout (velká, bez diakritiky)
  final String display;        // zobrazovaný text (může mít diakritiku / tóny)
  final String hint;           // emoji pro challenge card
  final String label;          // název slova / slabiky
  final String info;           // info o novém písmenu
  final String ipa;            // hrubý IPA přepis pro TTS / trumpetku
  final String pinyin;         // pinyin s číslem tónu (jen ZH; jinak '')

  const Lesson({
    required this.unlocked,
    required this.target,
    required this.display,
    required this.hint,
    required this.label,
    this.info = '',
    this.ipa = '',
    this.pinyin = '',
  });
}
