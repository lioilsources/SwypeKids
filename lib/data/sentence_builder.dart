import 'lessons.dart';

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

class SentencePart {
  final String emoji;
  final String text; // default tile label + fallback for composition
  final String ipa;

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
    required this.emoji,
    required this.text,
    this.ipa = '',
    this.forms,
    this.frame,
    this.person,
  });

  String formFor(String key) => forms?[key] ?? text;
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
}

const kSentenceData = <Language, SentenceCategories>{
  // ───────────────────────────── Czech ────────────────────────────────────
  Language.cs: SentenceCategories(
    subjects: [
      SentencePart(emoji: '👶', text: 'Já',     person: Person.firstSg),
      SentencePart(emoji: '👩', text: 'Máma',   person: Person.thirdSg),
      SentencePart(emoji: '👨', text: 'Táta',   person: Person.thirdSg),
      SentencePart(emoji: '👵', text: 'Bába',   person: Person.thirdSg),
      SentencePart(emoji: '🐶', text: 'Pejsek', person: Person.thirdSg),
    ],
    verbs: [
      SentencePart(emoji: '✋',  text: 'chci',  forms: {Person.thirdSg: 'chce'},  frame: Frame.acc),
      SentencePart(emoji: '🍽️', text: 'jím',   forms: {Person.thirdSg: 'jí'},    frame: Frame.acc),
      SentencePart(emoji: '🥛', text: 'piju',  forms: {Person.thirdSg: 'pije'},  frame: Frame.acc),
      SentencePart(emoji: '💤', text: 'spím',  forms: {Person.thirdSg: 'spí'},   frame: Frame.loc),
      SentencePart(emoji: '🚶', text: 'jdu',   forms: {Person.thirdSg: 'jde'},   frame: Frame.dir),
      SentencePart(emoji: '🎲', text: 'hraju', forms: {Person.thirdSg: 'hraje'}, frame: Frame.instr),
    ],
    objects: [
      SentencePart(emoji: '🥛',  text: 'mléko',   forms: {Frame.instr: 's mlékem',    Frame.loc: 'u mléka'}),
      SentencePart(emoji: '🍎',  text: 'jablko',  forms: {Frame.instr: 's jablkem',   Frame.loc: 'u jablka'}),
      SentencePart(emoji: '🧸',  text: 'hračka',  forms: {Frame.acc: 'hračku',        Frame.instr: 's hračkou', Frame.loc: 'u hračky', Frame.dir: 'pro hračku'}),
      SentencePart(emoji: '🚗',  text: 'auto',    forms: {Frame.instr: 's autem',     Frame.loc: 'v autě',      Frame.dir: 'do auta'}),
      SentencePart(emoji: '🚪',  text: 'ven',     forms: {Frame.acc: 'venek',         Frame.loc: 'venku',       Frame.instr: 's venkem'}),
      SentencePart(emoji: '🏠',  text: 'domů',    forms: {Frame.acc: 'dům',           Frame.loc: 'doma',        Frame.instr: 's domem'}),
      SentencePart(emoji: '🛏️', text: 'postýlka',forms: {Frame.acc: 'postýlku',      Frame.dir: 'do postýlky', Frame.loc: 'v postýlce', Frame.instr: 's postýlkou'}),
      SentencePart(emoji: '🚽',  text: 'nočník',  forms: {Frame.dir: 'na nočník',     Frame.loc: 'na nočníku',  Frame.instr: 's nočníkem'}),
    ],
  ),

  // ───────────────────────────── English ──────────────────────────────────
  Language.en: SentenceCategories(
    subjects: [
      SentencePart(emoji: '👶', text: 'I',      person: Person.firstSg),
      SentencePart(emoji: '👩', text: 'Mommy',  person: Person.thirdSg),
      SentencePart(emoji: '👨', text: 'Daddy',  person: Person.thirdSg),
      SentencePart(emoji: '👵', text: 'Granny', person: Person.thirdSg),
      SentencePart(emoji: '🐶', text: 'Doggie', person: Person.thirdSg),
    ],
    verbs: [
      SentencePart(emoji: '✋',  text: 'want',  forms: {Person.thirdSg: 'wants'},   frame: Frame.acc),
      SentencePart(emoji: '🍽️', text: 'eat',   forms: {Person.thirdSg: 'eats'},    frame: Frame.acc),
      SentencePart(emoji: '🥛', text: 'drink', forms: {Person.thirdSg: 'drinks'},  frame: Frame.acc),
      SentencePart(emoji: '💤', text: 'sleep', forms: {Person.thirdSg: 'sleeps'},  frame: Frame.loc),
      SentencePart(emoji: '🚶', text: 'go',    forms: {Person.thirdSg: 'goes'},    frame: Frame.dir),
      SentencePart(emoji: '🎲', text: 'play',  forms: {Person.thirdSg: 'plays'},   frame: Frame.instr),
    ],
    objects: [
      SentencePart(emoji: '🥛',  text: 'milk',      forms: {Frame.instr: 'with milk'}),
      SentencePart(emoji: '🍎',  text: 'an apple',  forms: {Frame.instr: 'with an apple'}),
      SentencePart(emoji: '🧸',  text: 'a toy',     forms: {Frame.instr: 'with a toy', Frame.loc: 'with a toy'}),
      SentencePart(emoji: '🚗',  text: 'the car',   forms: {Frame.dir: 'in the car', Frame.loc: 'in the car', Frame.instr: 'with the car'}),
      SentencePart(emoji: '🚪',  text: 'outside',   forms: {Frame.dir: 'outside',    Frame.loc: 'outside',    Frame.instr: 'outside'}),
      SentencePart(emoji: '🏠',  text: 'home',      forms: {Frame.dir: 'home',       Frame.loc: 'at home',    Frame.instr: 'at home'}),
      SentencePart(emoji: '🛏️', text: 'the bed',   forms: {Frame.dir: 'to bed',     Frame.loc: 'in bed',     Frame.instr: 'in bed'}),
      SentencePart(emoji: '🚽',  text: 'the potty', forms: {Frame.dir: 'to the potty', Frame.loc: 'on the potty', Frame.instr: 'on the potty'}),
    ],
  ),

  // ───────────────────────────── German ───────────────────────────────────
  Language.de: SentenceCategories(
    subjects: [
      SentencePart(emoji: '👶', text: 'Ich',    person: Person.firstSg),
      SentencePart(emoji: '👩', text: 'Mama',   person: Person.thirdSg),
      SentencePart(emoji: '👨', text: 'Papa',   person: Person.thirdSg),
      SentencePart(emoji: '👵', text: 'Oma',    person: Person.thirdSg),
      SentencePart(emoji: '🐶', text: 'Wauwau', person: Person.thirdSg),
    ],
    verbs: [
      SentencePart(emoji: '✋',  text: 'will',    forms: {Person.thirdSg: 'will'},     frame: Frame.acc),
      SentencePart(emoji: '🍽️', text: 'esse',    forms: {Person.thirdSg: 'isst'},     frame: Frame.acc),
      SentencePart(emoji: '🥛', text: 'trinke',  forms: {Person.thirdSg: 'trinkt'},   frame: Frame.acc),
      SentencePart(emoji: '💤', text: 'schlafe', forms: {Person.thirdSg: 'schläft'},  frame: Frame.loc),
      SentencePart(emoji: '🚶', text: 'gehe',    forms: {Person.thirdSg: 'geht'},     frame: Frame.dir),
      SentencePart(emoji: '🎲', text: 'spiele',  forms: {Person.thirdSg: 'spielt'},   frame: Frame.instr),
    ],
    objects: [
      SentencePart(emoji: '🥛',  text: 'Milch',     forms: {Frame.instr: 'mit Milch'}),
      SentencePart(emoji: '🍎',  text: 'einen Apfel', forms: {Frame.instr: 'mit einem Apfel'}),
      SentencePart(emoji: '🧸',  text: 'ein Spielzeug', forms: {Frame.instr: 'mit einem Spielzeug', Frame.loc: 'beim Spielzeug'}),
      SentencePart(emoji: '🚗',  text: 'das Auto',  forms: {Frame.dir: 'ins Auto',     Frame.loc: 'im Auto',     Frame.instr: 'mit dem Auto'}),
      SentencePart(emoji: '🚪',  text: 'raus',      forms: {Frame.dir: 'raus',         Frame.loc: 'draußen',     Frame.instr: 'draußen'}),
      SentencePart(emoji: '🏠',  text: 'heim',      forms: {Frame.dir: 'heim',         Frame.loc: 'zu Hause',    Frame.instr: 'zu Hause'}),
      SentencePart(emoji: '🛏️', text: 'das Bett',  forms: {Frame.dir: 'ins Bett',     Frame.loc: 'im Bett',     Frame.instr: 'im Bett'}),
      SentencePart(emoji: '🚽',  text: 'das Töpfchen', forms: {Frame.dir: 'aufs Töpfchen', Frame.loc: 'auf dem Töpfchen', Frame.instr: 'auf dem Töpfchen'}),
    ],
  ),

  // ───────────────────────────── Spanish ──────────────────────────────────
  Language.es: SentenceCategories(
    subjects: [
      SentencePart(emoji: '👶', text: 'Yo',      person: Person.firstSg),
      SentencePart(emoji: '👩', text: 'Mamá',    person: Person.thirdSg),
      SentencePart(emoji: '👨', text: 'Papá',    person: Person.thirdSg),
      SentencePart(emoji: '👵', text: 'Abuela',  person: Person.thirdSg),
      SentencePart(emoji: '🐶', text: 'Perrito', person: Person.thirdSg),
    ],
    verbs: [
      SentencePart(emoji: '✋',  text: 'quiero',  forms: {Person.thirdSg: 'quiere'}, frame: Frame.acc),
      SentencePart(emoji: '🍽️', text: 'como',    forms: {Person.thirdSg: 'come'},   frame: Frame.acc),
      SentencePart(emoji: '🥛', text: 'bebo',    forms: {Person.thirdSg: 'bebe'},   frame: Frame.acc),
      SentencePart(emoji: '💤', text: 'duermo',  forms: {Person.thirdSg: 'duerme'}, frame: Frame.loc),
      SentencePart(emoji: '🚶', text: 'voy',     forms: {Person.thirdSg: 'va'},     frame: Frame.dir),
      SentencePart(emoji: '🎲', text: 'juego',   forms: {Person.thirdSg: 'juega'},  frame: Frame.instr),
    ],
    objects: [
      SentencePart(emoji: '🥛',  text: 'leche',       forms: {Frame.instr: 'con leche'}),
      SentencePart(emoji: '🍎',  text: 'una manzana', forms: {Frame.instr: 'con una manzana'}),
      SentencePart(emoji: '🧸',  text: 'un juguete',  forms: {Frame.instr: 'con un juguete', Frame.loc: 'con un juguete'}),
      SentencePart(emoji: '🚗',  text: 'el coche',    forms: {Frame.dir: 'en coche',  Frame.loc: 'en el coche',  Frame.instr: 'con el coche'}),
      SentencePart(emoji: '🚪',  text: 'fuera',       forms: {Frame.dir: 'fuera',     Frame.loc: 'fuera',        Frame.instr: 'fuera'}),
      SentencePart(emoji: '🏠',  text: 'casa',        forms: {Frame.dir: 'a casa',    Frame.loc: 'en casa',      Frame.instr: 'en casa'}),
      SentencePart(emoji: '🛏️', text: 'la cama',     forms: {Frame.dir: 'a la cama', Frame.loc: 'en la cama',   Frame.instr: 'en la cama'}),
      SentencePart(emoji: '🚽',  text: 'el baño',     forms: {Frame.dir: 'al baño',   Frame.loc: 'en el baño',   Frame.instr: 'en el baño'}),
    ],
  ),

  // ───────────────────────────── Italian ──────────────────────────────────
  Language.it: SentenceCategories(
    subjects: [
      SentencePart(emoji: '👶', text: 'Io',       person: Person.firstSg),
      SentencePart(emoji: '👩', text: 'Mamma',    person: Person.thirdSg),
      SentencePart(emoji: '👨', text: 'Papà',     person: Person.thirdSg),
      SentencePart(emoji: '👵', text: 'Nonna',    person: Person.thirdSg),
      SentencePart(emoji: '🐶', text: 'Cucciolo', person: Person.thirdSg),
    ],
    verbs: [
      SentencePart(emoji: '✋',  text: 'voglio',  forms: {Person.thirdSg: 'vuole'},  frame: Frame.acc),
      SentencePart(emoji: '🍽️', text: 'mangio',  forms: {Person.thirdSg: 'mangia'}, frame: Frame.acc),
      SentencePart(emoji: '🥛', text: 'bevo',    forms: {Person.thirdSg: 'beve'},   frame: Frame.acc),
      SentencePart(emoji: '💤', text: 'dormo',   forms: {Person.thirdSg: 'dorme'},  frame: Frame.loc),
      SentencePart(emoji: '🚶', text: 'vado',    forms: {Person.thirdSg: 'va'},     frame: Frame.dir),
      SentencePart(emoji: '🎲', text: 'gioco',   forms: {Person.thirdSg: 'gioca'},  frame: Frame.instr),
    ],
    objects: [
      SentencePart(emoji: '🥛',  text: 'il latte',   forms: {Frame.instr: 'con il latte'}),
      SentencePart(emoji: '🍎',  text: 'una mela',   forms: {Frame.instr: 'con una mela'}),
      SentencePart(emoji: '🧸',  text: 'un gioco',   forms: {Frame.instr: 'con un gioco', Frame.loc: 'con un gioco'}),
      SentencePart(emoji: '🚗',  text: 'la macchina', forms: {Frame.dir: 'in macchina', Frame.loc: 'in macchina', Frame.instr: 'con la macchina'}),
      SentencePart(emoji: '🚪',  text: 'fuori',      forms: {Frame.dir: 'fuori',       Frame.loc: 'fuori',        Frame.instr: 'fuori'}),
      SentencePart(emoji: '🏠',  text: 'casa',       forms: {Frame.dir: 'a casa',      Frame.loc: 'a casa',       Frame.instr: 'a casa'}),
      SentencePart(emoji: '🛏️', text: 'il letto',   forms: {Frame.dir: 'a letto',     Frame.loc: 'a letto',      Frame.instr: 'a letto'}),
      SentencePart(emoji: '🚽',  text: 'il vasino',  forms: {Frame.dir: 'sul vasino',  Frame.loc: 'sul vasino',   Frame.instr: 'sul vasino'}),
    ],
  ),

  // ───────────────────────────── French ───────────────────────────────────
  Language.fr: SentenceCategories(
    subjects: [
      SentencePart(emoji: '👶', text: 'Je',     person: Person.firstSg),
      SentencePart(emoji: '👩', text: 'Maman',  person: Person.thirdSg),
      SentencePart(emoji: '👨', text: 'Papa',   person: Person.thirdSg),
      SentencePart(emoji: '👵', text: 'Mamie',  person: Person.thirdSg),
      SentencePart(emoji: '🐶', text: 'Toutou', person: Person.thirdSg),
    ],
    verbs: [
      SentencePart(emoji: '✋',  text: 'veux',  forms: {Person.thirdSg: 'veut'}, frame: Frame.acc),
      SentencePart(emoji: '🍽️', text: 'mange', forms: {Person.thirdSg: 'mange'}, frame: Frame.acc),
      SentencePart(emoji: '🥛', text: 'bois',  forms: {Person.thirdSg: 'boit'}, frame: Frame.acc),
      SentencePart(emoji: '💤', text: 'dors',  forms: {Person.thirdSg: 'dort'}, frame: Frame.loc),
      SentencePart(emoji: '🚶', text: 'vais',  forms: {Person.thirdSg: 'va'},   frame: Frame.dir),
      SentencePart(emoji: '🎲', text: 'joue',  forms: {Person.thirdSg: 'joue'}, frame: Frame.instr),
    ],
    objects: [
      SentencePart(emoji: '🥛',  text: 'du lait',     forms: {Frame.instr: 'avec du lait'}),
      SentencePart(emoji: '🍎',  text: 'une pomme',   forms: {Frame.instr: 'avec une pomme'}),
      SentencePart(emoji: '🧸',  text: 'un jouet',    forms: {Frame.instr: 'avec un jouet', Frame.loc: 'avec un jouet'}),
      SentencePart(emoji: '🚗',  text: 'la voiture',  forms: {Frame.dir: 'en voiture',  Frame.loc: 'dans la voiture', Frame.instr: 'avec la voiture'}),
      SentencePart(emoji: '🚪',  text: 'dehors',      forms: {Frame.dir: 'dehors',      Frame.loc: 'dehors',          Frame.instr: 'dehors'}),
      SentencePart(emoji: '🏠',  text: 'à la maison', forms: {Frame.dir: 'à la maison', Frame.loc: 'à la maison',     Frame.instr: 'à la maison'}),
      SentencePart(emoji: '🛏️', text: 'le lit',      forms: {Frame.dir: 'au lit',      Frame.loc: 'au lit',          Frame.instr: 'au lit'}),
      SentencePart(emoji: '🚽',  text: 'le pot',      forms: {Frame.dir: 'au pot',      Frame.loc: 'au pot',          Frame.instr: 'au pot'}),
    ],
  ),

  // ───────────────────────────── Chinese ──────────────────────────────────
  Language.zh: SentenceCategories(
    joiner: '',
    subjects: [
      SentencePart(emoji: '👶', text: '我',   ipa: 'wǒ'),
      SentencePart(emoji: '👩', text: '妈妈', ipa: 'māma'),
      SentencePart(emoji: '👨', text: '爸爸', ipa: 'bàba'),
      SentencePart(emoji: '👵', text: '奶奶', ipa: 'nǎinai'),
      SentencePart(emoji: '🐶', text: '狗狗', ipa: 'gǒugou'),
    ],
    verbs: [
      SentencePart(emoji: '✋',  text: '要', ipa: 'yào'),
      SentencePart(emoji: '🍽️', text: '吃', ipa: 'chī'),
      SentencePart(emoji: '🥛', text: '喝', ipa: 'hē'),
      SentencePart(emoji: '💤', text: '睡', ipa: 'shuì'),
      SentencePart(emoji: '🚶', text: '去', ipa: 'qù'),
      SentencePart(emoji: '🎲', text: '玩', ipa: 'wán'),
    ],
    objects: [
      SentencePart(emoji: '🥛',  text: '奶',    ipa: 'nǎi'),
      SentencePart(emoji: '🍎',  text: '苹果',  ipa: 'píngguǒ'),
      SentencePart(emoji: '🧸',  text: '玩具',  ipa: 'wánjù'),
      SentencePart(emoji: '🚗',  text: '车车',  ipa: 'chēche'),
      SentencePart(emoji: '🚪',  text: '外面',  ipa: 'wàimiàn'),
      SentencePart(emoji: '🏠',  text: '家',    ipa: 'jiā'),
      SentencePart(emoji: '🛏️', text: '床',    ipa: 'chuáng'),
      SentencePart(emoji: '🚽',  text: '上厕所', ipa: 'shàng cèsuǒ'),
    ],
  ),

  // ───────────────────────────── Japanese ─────────────────────────────────
  // -masu form is identical across persons; objects use particles based on frame.
  Language.ja: SentenceCategories(
    joiner: '',
    subjects: [
      SentencePart(emoji: '👶', text: 'わたしは', ipa: 'watashi wa'),
      SentencePart(emoji: '👩', text: 'ママは',   ipa: 'mama wa'),
      SentencePart(emoji: '👨', text: 'パパは',   ipa: 'papa wa'),
      SentencePart(emoji: '👵', text: 'おばあちゃんは', ipa: 'obaachan wa'),
      SentencePart(emoji: '🐶', text: 'わんわんは', ipa: 'wanwan wa'),
    ],
    verbs: [
      SentencePart(emoji: '✋',  text: 'ほしいです',   ipa: 'hoshii desu',   frame: Frame.acc),
      SentencePart(emoji: '🍽️', text: 'たべます',     ipa: 'tabemasu',      frame: Frame.acc),
      SentencePart(emoji: '🥛', text: 'のみます',     ipa: 'nomimasu',      frame: Frame.acc),
      SentencePart(emoji: '💤', text: 'ねます',       ipa: 'nemasu',        frame: Frame.loc),
      SentencePart(emoji: '🚶', text: 'いきます',     ipa: 'ikimasu',       frame: Frame.dir),
      SentencePart(emoji: '🎲', text: 'あそびます',   ipa: 'asobimasu',     frame: Frame.instr),
    ],
    objects: [
      SentencePart(emoji: '🥛',  text: 'ぎゅうにゅう', ipa: 'gyuunyuu',
          forms: {Frame.acc: 'ぎゅうにゅうを', Frame.instr: 'ぎゅうにゅうで'}),
      SentencePart(emoji: '🍎',  text: 'りんご',      ipa: 'ringo',
          forms: {Frame.acc: 'りんごを', Frame.instr: 'りんごで'}),
      SentencePart(emoji: '🧸',  text: 'おもちゃ',    ipa: 'omocha',
          forms: {Frame.acc: 'おもちゃを', Frame.instr: 'おもちゃで', Frame.loc: 'おもちゃで'}),
      SentencePart(emoji: '🚗',  text: 'くるま',      ipa: 'kuruma',
          forms: {Frame.acc: 'くるまを', Frame.dir: 'くるまに', Frame.loc: 'くるまで', Frame.instr: 'くるまで'}),
      SentencePart(emoji: '🚪',  text: 'そと',        ipa: 'soto',
          forms: {Frame.dir: 'そとへ', Frame.loc: 'そとで', Frame.instr: 'そとで'}),
      SentencePart(emoji: '🏠',  text: 'おうち',      ipa: 'ouchi',
          forms: {Frame.dir: 'おうちへ', Frame.loc: 'おうちで', Frame.instr: 'おうちで'}),
      SentencePart(emoji: '🛏️', text: 'ベッド',      ipa: 'beddo',
          forms: {Frame.dir: 'ベッドへ', Frame.loc: 'ベッドで', Frame.instr: 'ベッドで'}),
      SentencePart(emoji: '🚽',  text: 'おまる',      ipa: 'omaru',
          forms: {Frame.dir: 'おまるへ', Frame.loc: 'おまるで', Frame.instr: 'おまるで'}),
    ],
  ),

  // ─────────────────────── Brazilian Portuguese ───────────────────────────
  Language.pt: SentenceCategories(
    subjects: [
      SentencePart(emoji: '👶', text: 'Eu',         person: Person.firstSg),
      SentencePart(emoji: '👩', text: 'Mamãe',      person: Person.thirdSg),
      SentencePart(emoji: '👨', text: 'Papai',      person: Person.thirdSg),
      SentencePart(emoji: '👵', text: 'Vovó',       person: Person.thirdSg),
      SentencePart(emoji: '🐶', text: 'Cachorrinho',person: Person.thirdSg),
    ],
    verbs: [
      SentencePart(emoji: '✋',  text: 'quero', forms: {Person.thirdSg: 'quer'},  frame: Frame.acc),
      SentencePart(emoji: '🍽️', text: 'como',  forms: {Person.thirdSg: 'come'},  frame: Frame.acc),
      SentencePart(emoji: '🥛', text: 'bebo',  forms: {Person.thirdSg: 'bebe'},  frame: Frame.acc),
      SentencePart(emoji: '💤', text: 'durmo', forms: {Person.thirdSg: 'dorme'}, frame: Frame.loc),
      SentencePart(emoji: '🚶', text: 'vou',   forms: {Person.thirdSg: 'vai'},   frame: Frame.dir),
      SentencePart(emoji: '🎲', text: 'brinco',forms: {Person.thirdSg: 'brinca'},frame: Frame.instr),
    ],
    objects: [
      SentencePart(emoji: '🥛',  text: 'leite',         forms: {Frame.instr: 'com leite'}),
      SentencePart(emoji: '🍎',  text: 'uma maçã',      forms: {Frame.instr: 'com uma maçã'}),
      SentencePart(emoji: '🧸',  text: 'um brinquedo',  forms: {Frame.instr: 'com um brinquedo', Frame.loc: 'com um brinquedo'}),
      SentencePart(emoji: '🚗',  text: 'o carro',       forms: {Frame.dir: 'de carro', Frame.loc: 'no carro', Frame.instr: 'com o carro'}),
      SentencePart(emoji: '🚪',  text: 'fora',          forms: {Frame.dir: 'para fora', Frame.loc: 'lá fora', Frame.instr: 'lá fora'}),
      SentencePart(emoji: '🏠',  text: 'casa',          forms: {Frame.dir: 'para casa', Frame.loc: 'em casa', Frame.instr: 'em casa'}),
      SentencePart(emoji: '🛏️', text: 'a cama',        forms: {Frame.dir: 'para a cama', Frame.loc: 'na cama', Frame.instr: 'na cama'}),
      SentencePart(emoji: '🚽',  text: 'o peniquinho',  forms: {Frame.dir: 'no peniquinho', Frame.loc: 'no peniquinho', Frame.instr: 'no peniquinho'}),
    ],
  ),
};
