
enum Language { cs, en, de, es, it, fr, zh, ja, pt }

/// Typ herního kola. Neznámý typ z JSON padá na [swype] (dopředná kompatibilita).
enum LessonType {
  /// Klasika: karta ukazuje text, dítě ho swypne.
  swype,

  /// Poslechové kolo: text je skrytý, hraje TTS; po prvním neúspěchu se odkryje.
  listen,

  /// Slovo s dírou (M?MA): jedno písmeno chybí, swypuje se celé slovo.
  missingLetter,

  /// Jen obrázek, žádný text — aktivní vybavení slova.
  pictureOnly,

  /// Opakování: za běhu se nahradí nejslabším dříve naučeným slovem, jehož
  /// písmena jsou v `unlocked`. Vlastní `target` je záloha.
  reviewMix,

  /// Průvodce řekne hlásku, dítě ťukne na správnou klávesu (target = 1 písmeno).
  letterHunt,

  /// Dvě slabiky (`parts`) přiletí, dítě je swypne za sebou jako celé slovo.
  syllableJoin,

  /// Ze tří obrázků (`options`) vyber, co se rýmuje s cílem (`answer`).
  rhymePick,
}

/// Možnost v rýmovém kole: obrázek + slovo.
class RhymeOption {
  final String emoji;
  final String display;

  const RhymeOption({required this.emoji, required this.display});

  factory RhymeOption.fromJson(Map<String, dynamic> json) => RhymeOption(
        emoji: json['emoji'] as String,
        display: json['display'] as String,
      );

  Map<String, dynamic> toJson() => {'emoji': emoji, 'display': display};
}

class Lesson {
  final String id;             // stabilní id z content packu
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
  final String vocab;          // id slova do batohu / dlaždice builderu ('' = žádné)
  final String parentNote;     // věta pro rodiče: co se procvičuje a proč
  final int? gap;              // missingLetter: index chybějícího písmene v target
  final List<String> parts;    // syllableJoin: slabiky, jak přiletí (s diakritikou)
  final List<RhymeOption> options; // rhymePick: tři obrázky
  final int answer;            // rhymePick: index správné možnosti

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
    this.vocab = '',
    this.parentNote = '',
    this.gap,
    this.parts = const [],
    this.options = const [],
    this.answer = 0,
  });

  /// Index díry pro missingLetter: z packu, jinak prostřední písmeno.
  int get gapIndex => gap ?? target.length ~/ 2;

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
        vocab: json['vocab'] as String? ?? '',
        parentNote: json['parentNote'] as String? ?? '',
        gap: json['gap'] as int?,
        parts: ((json['parts'] as List?) ?? const []).cast<String>(),
        options: [
          for (final o in (json['options'] as List?) ?? const [])
            RhymeOption.fromJson((o as Map).cast<String, dynamic>()),
        ],
        answer: json['answer'] as int? ?? 0,
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
        if (vocab.isNotEmpty) 'vocab': vocab,
        if (parentNote.isNotEmpty) 'parentNote': parentNote,
        if (gap != null) 'gap': gap,
        if (parts.isNotEmpty) 'parts': parts,
        if (options.isNotEmpty) 'options': [for (final o in options) o.toJson()],
        if (options.isNotEmpty) 'answer': answer,
      };
}
