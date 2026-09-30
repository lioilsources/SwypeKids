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

  const SentencePart({
    required this.id,
    required this.emoji,
    required this.text,
    this.ipa = '',
    this.unlockedBy = TileUnlock.always,
    this.forms,
    this.frame,
    this.person,
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
      );
}

class SentenceCategories {
  final List<SentencePart> subjects;
  final List<SentencePart> verbs;
  final List<SentencePart> objects;
  // Joiner between parts: '' for ZH/JA, ' ' otherwise.
  final String joiner;

  const SentenceCategories({
    required this.subjects,
    required this.verbs,
    required this.objects,
    this.joiner = ' ',
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

  const ComposedSentence({
    this.subject,
    this.verb,
    this.object,
    this.joiner = ' ',
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

  String get text => [subjectText, verbText, objectText]
      .whereType<String>()
      .join(joiner);
}
