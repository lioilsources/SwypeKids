// Data módu „Skládej větu" — součást content packu (`pack.sentence`, schéma v2).

// Person tags carried by subject tiles. Used to pick verb conjugation.
class Person {
  static const String firstSg = '1sg';
  static const String thirdSg = '3sg';
}

// Frame tags carried by verb tiles. Pick the matching object form.
//   acc  – direct object (accusative / nominative-as-object)
//   dir  – directional adverbial (kam? / куда?)
//   loc  – locative / static place (kde?)
//   instr – instrumental (s čím?)
class Frame {
  static const String acc = 'acc';
  static const String dir = 'dir';
  static const String loc = 'loc';
  static const String instr = 'instr';
}

/// Kdy je dlaždice v builderu k dispozici.
enum TileUnlock {
  /// Od začátku (základní slovesa, zájmena) — věta jde složit hned.
  always,

  /// Až dítě slovo swypne ve hře (slovo je v batohu, `lesson.vocab == id`).
  vocab,

  /// Až má dítě nálepku `emoji` ve Zvěřinci (zvířátko jako podmět).
  sticker,
}

class SentencePart {
  final String id; // stabilní id; u `vocab` dlaždic = lesson.vocab
  final String emoji;
  final String text; // default tile label + fallback for composition
  final String ipa;
  final TileUnlock unlockedBy;

  // For verbs: alternative inflected forms keyed by subject person, e.g.
  //   {Person.thirdSg: 'chce'}. The base [text] holds the 1sg form.
  // For objects: alternative case/preposition forms keyed by verb frame, e.g.
  //   {Frame.dir: 'domů', Frame.loc: 'doma'}.
  final Map<String, String>? forms;

  // For verbs only: which object frame this verb governs.
  final String? frame;

  // For subjects only: grammatical person used to select verb form.
  final String? person;

  /// Podmět: druh (`person`, `animal`, `thing`) — kdo může co dělat.
  final String? kind;

  /// Předmět: štítky (`food`, `drink`, `toy`, `vehicle`, `place`, `thing`…).
  final List<String> tags;

  /// Sloveso: jaké druhy podmětu a štítky předmětu bere (prázdné = vše).
  final List<String> subjectKinds;
  final List<String> objectTags;

  const SentencePart({
    required this.id,
    required this.emoji,
    required this.text,
    this.ipa = '',
    this.unlockedBy = TileUnlock.always,
    this.forms,
    this.frame,
    this.person,
    this.kind,
    this.tags = const [],
    this.subjectKinds = const [],
    this.objectTags = const [],
  });

  String formFor(String key) => forms?[key] ?? text;

  factory SentencePart.fromJson(Map<String, dynamic> json) => SentencePart(
        id: json['id'] as String,
        emoji: json['emoji'] as String,
        text: json['text'] as String,
        ipa: json['ipa'] as String? ?? '',
        unlockedBy:
            TileUnlock.values.asNameMap()[json['unlockedBy'] as String? ?? ''] ??
                TileUnlock.always,
        forms: (json['forms'] as Map?)?.cast<String, String>(),
        frame: json['frame'] as String?,
        person: json['person'] as String?,
        kind: json['kind'] as String?,
        tags: ((json['tags'] as List?) ?? const []).cast<String>(),
        subjectKinds: ((json['subject'] as List?) ?? const []).cast<String>(),
        objectTags: ((json['object'] as List?) ?? const []).cast<String>(),
      );
}

class SentenceCategories {
  final List<SentencePart> subjects;
  final List<SentencePart> verbs;
  final List<SentencePart> objects;
  // Joiner between parts: '' for ZH/JA, ' ' otherwise.
  final String joiner;

  /// Pořadí slov: `svo` (podmět–sloveso–předmět) nebo `sov` (japonština:
  /// sloveso na konci).
  final String order;

  /// Pojmenovací věta s `{nom}` („To je {nom}.") — vždy správně; pro věci
  /// ve světě zvířátka, které nemají vlastní sloveso.
  final String? naming;

  const SentenceCategories({
    required this.subjects,
    required this.verbs,
    required this.objects,
    this.joiner = ' ',
    this.order = 'svo',
    this.naming,
  });

  static const empty = SentenceCategories(subjects: [], verbs: [], objects: []);

  List<SentencePart> get all => [...subjects, ...verbs, ...objects];

  factory SentenceCategories.fromJson(Map<String, dynamic> json) {
    List<SentencePart> parts(String key) => [
          for (final p in (json[key] as List?) ?? const [])
            SentencePart.fromJson((p as Map).cast<String, dynamic>()),
        ];
    return SentenceCategories(
      subjects: parts('subjects'),
      verbs: parts('verbs'),
      objects: parts('objects'),
      joiner: json['joiner'] as String? ?? ' ',
      order: json['order'] as String? ?? 'svo',
      naming: json['naming'] as String?,
    );
  }
}

/// Věta z vybraných dlaždic: sloveso se časuje podle osoby podmětu, předmět
/// skloňuje podle rámce slovesa. Chybějící části se vynechají.
class ComposedSentence {
  final SentencePart? subject;
  final SentencePart? verb;
  final SentencePart? object;
  final String joiner;

  /// Sloveso na konci (japonština), viz [SentenceCategories.order].
  final bool verbLast;

  const ComposedSentence({
    this.subject,
    this.verb,
    this.object,
    this.joiner = ' ',
    this.verbLast = false,
  });

  String? get subjectText => subject?.text;

  String? get verbText {
    final v = verb;
    if (v == null) return null;
    final person = subject?.person;
    return person != null ? v.formFor(person) : v.text;
  }

  String? get objectText {
    final o = object;
    if (o == null) return null;
    final frame = verb?.frame;
    return frame != null ? o.formFor(frame) : o.text;
  }

  bool get isEmpty => subject == null && verb == null && object == null;
  bool get isComplete => subject != null && verb != null && object != null;

  /// Obrázková řádka věty (pro Mou knížku).
  String get emojis =>
      [subject?.emoji, verb?.emoji, object?.emoji].whereType<String>().join(' ');

  String get text => (verbLast
          ? [subjectText, objectText, verbText]
          : [subjectText, verbText, objectText])
      .whereType<String>()
      .join(joiner);
}

/// Pravidla skládání vět — jediné místo, které rozhoduje, co se smí
/// nabídnout (Skládej větu, věta po novém slově, svět zvířátka).
/// Plán: `docs/PLAN_VETY_KVALITA.md`.
///
/// Věta je platná, když
/// - sloveso bere druh podmětu (`subject` slovesa × `kind` podmětu),
/// - sloveso bere štítek předmětu (`object` slovesa × `tags` předmětu),
/// - předmět má **výslovný** tvar pro rámec slovesa (žádný tichý základní
///   tvar: bez tvaru se kombinace nenabídne),
/// - sloveso má tvar pro osobu podmětu (1. osoba = nápis na dlaždici).
class SentenceRules {
  /// Smí se tahle (i neúplná) kombinace nabídnout? Chybějící části se
  /// nekontrolují — „Máma + jí" je v pořádku, dokud není vybraný předmět.
  static bool allows(
    SentenceCategories data, {
    SentencePart? subject,
    SentencePart? verb,
    SentencePart? object,
  }) {
    if (subject != null && verb != null && !subjectFits(subject, verb)) {
      return false;
    }
    if (verb != null && object != null && !objectFits(verb, object)) {
      return false;
    }
    return true;
  }

  static bool subjectFits(SentencePart subject, SentencePart verb) {
    if (verb.subjectKinds.isNotEmpty &&
        !verb.subjectKinds.contains(subject.kind)) {
      return false;
    }
    // Sloveso s tvary podle osoby musí mít tvar pro osobu podmětu; 1. osoba
    // smí chybět (= nápis na dlaždici), pokud tvary nevyjmenovává sloveso
    // jen pro ni (ja „ほしいです" → jen „já").
    final person = subject.person;
    final forms = verb.forms;
    if (person == null || forms == null || forms.containsKey(person)) {
      return true;
    }
    return person == Person.firstSg && !forms.containsKey(Person.firstSg);
  }

  static bool objectFits(SentencePart verb, SentencePart object) {
    if (verb.objectTags.isNotEmpty &&
        !object.tags.any(verb.objectTags.contains)) {
      return false;
    }
    final frame = verb.frame;
    return frame == null || (object.forms?.containsKey(frame) ?? false);
  }

  /// Kde by věta potichu použila základní tvar místo výslovného — po
  /// zavedení pravidel musí být u každé nabízené věty prázdné.
  static List<String> fallbacks(
      SentencePart subject, SentencePart verb, SentencePart? object) {
    final out = <String>[];
    final person = subject.person;
    if (person != null &&
        verb.forms != null &&
        !verb.forms!.containsKey(person) &&
        person != Person.firstSg) {
      out.add('verb:$person');
    }
    final frame = verb.frame;
    if (object != null &&
        frame != null &&
        !(object.forms?.containsKey(frame) ?? false)) {
      out.add('object:$frame');
    }
    return out;
  }

  /// Pojmenovací věta pro předmět („To je jablko."), když má 1. pád.
  static String? naming(SentenceCategories data, SentencePart object) {
    final template = data.naming;
    final nom = object.forms?['nom'];
    if (template == null || nom == null) return null;
    return template.replaceAll('{nom}', nom);
  }
}
