import 'lessons.dart';

class SentencePart {
  final String emoji;
  final String text;  // jak se zobrazí + co řekne TTS
  final String ipa;   // pomocné, zatím nepoužité v UI
  const SentencePart({
    required this.emoji,
    required this.text,
    this.ipa = '',
  });
}

class SentenceCategories {
  final List<SentencePart> subjects;
  final List<SentencePart> verbs;
  final List<SentencePart> objects;
  // Oddělovač mezi částmi: '' pro ZH, ' ' jinde.
  final String joiner;
  const SentenceCategories({
    required this.subjects,
    required this.verbs,
    required this.objects,
    this.joiner = ' ',
  });
}

const kSentenceData = <Language, SentenceCategories>{
  Language.cs: SentenceCategories(
    subjects: [
      SentencePart(emoji: '👶', text: 'Já'),
      SentencePart(emoji: '👩', text: 'Máma'),
      SentencePart(emoji: '👨', text: 'Táta'),
      SentencePart(emoji: '👵', text: 'Bába'),
      SentencePart(emoji: '🐶', text: 'Pejsek'),
    ],
    verbs: [
      SentencePart(emoji: '✋', text: 'chci'),
      SentencePart(emoji: '🍽️', text: 'jíst'),
      SentencePart(emoji: '🥛', text: 'pít'),
      SentencePart(emoji: '💤', text: 'spát'),
      SentencePart(emoji: '🚶', text: 'jít'),
      SentencePart(emoji: '🎲', text: 'hrát si'),
    ],
    objects: [
      SentencePart(emoji: '🥛', text: 'mléko'),
      SentencePart(emoji: '🍎', text: 'jablko'),
      SentencePart(emoji: '🧸', text: 'hračku'),
      SentencePart(emoji: '🚗', text: 'auto'),
      SentencePart(emoji: '🚪', text: 'ven'),
      SentencePart(emoji: '🏠', text: 'domů'),
      SentencePart(emoji: '🛏️', text: 'do postýlky'),
      SentencePart(emoji: '🚽', text: 'na nočník'),
    ],
  ),
  Language.en: SentenceCategories(
    subjects: [
      SentencePart(emoji: '👶', text: 'I'),
      SentencePart(emoji: '👩', text: 'Mommy'),
      SentencePart(emoji: '👨', text: 'Daddy'),
      SentencePart(emoji: '👵', text: 'Granny'),
      SentencePart(emoji: '🐶', text: 'Doggie'),
    ],
    verbs: [
      SentencePart(emoji: '✋', text: 'want'),
      SentencePart(emoji: '🍽️', text: 'to eat'),
      SentencePart(emoji: '🥛', text: 'to drink'),
      SentencePart(emoji: '💤', text: 'to sleep'),
      SentencePart(emoji: '🚶', text: 'to go'),
      SentencePart(emoji: '🎲', text: 'to play'),
    ],
    objects: [
      SentencePart(emoji: '🥛', text: 'milk'),
      SentencePart(emoji: '🍎', text: 'an apple'),
      SentencePart(emoji: '🧸', text: 'a toy'),
      SentencePart(emoji: '🚗', text: 'in the car'),
      SentencePart(emoji: '🚪', text: 'outside'),
      SentencePart(emoji: '🏠', text: 'home'),
      SentencePart(emoji: '🛏️', text: 'to bed'),
      SentencePart(emoji: '🚽', text: 'to the potty'),
    ],
  ),
  Language.de: SentenceCategories(
    subjects: [
      SentencePart(emoji: '👶', text: 'Ich'),
      SentencePart(emoji: '👩', text: 'Mama'),
      SentencePart(emoji: '👨', text: 'Papa'),
      SentencePart(emoji: '👵', text: 'Oma'),
      SentencePart(emoji: '🐶', text: 'Wauwau'),
    ],
    verbs: [
      SentencePart(emoji: '✋', text: 'will'),
      SentencePart(emoji: '🍽️', text: 'essen'),
      SentencePart(emoji: '🥛', text: 'trinken'),
      SentencePart(emoji: '💤', text: 'schlafen'),
      SentencePart(emoji: '🚶', text: 'gehen'),
      SentencePart(emoji: '🎲', text: 'spielen'),
    ],
    objects: [
      SentencePart(emoji: '🥛', text: 'Milch'),
      SentencePart(emoji: '🍎', text: 'Apfel'),
      SentencePart(emoji: '🧸', text: 'Spielzeug'),
      SentencePart(emoji: '🚗', text: 'ins Auto'),
      SentencePart(emoji: '🚪', text: 'raus'),
      SentencePart(emoji: '🏠', text: 'heim'),
      SentencePart(emoji: '🛏️', text: 'ins Bett'),
      SentencePart(emoji: '🚽', text: 'aufs Töpfchen'),
    ],
  ),
  Language.es: SentenceCategories(
    subjects: [
      SentencePart(emoji: '👶', text: 'Yo'),
      SentencePart(emoji: '👩', text: 'Mamá'),
      SentencePart(emoji: '👨', text: 'Papá'),
      SentencePart(emoji: '👵', text: 'Abuela'),
      SentencePart(emoji: '🐶', text: 'Perrito'),
    ],
    verbs: [
      SentencePart(emoji: '✋', text: 'quiero'),
      SentencePart(emoji: '🍽️', text: 'comer'),
      SentencePart(emoji: '🥛', text: 'beber'),
      SentencePart(emoji: '💤', text: 'dormir'),
      SentencePart(emoji: '🚶', text: 'ir'),
      SentencePart(emoji: '🎲', text: 'jugar'),
    ],
    objects: [
      SentencePart(emoji: '🥛', text: 'leche'),
      SentencePart(emoji: '🍎', text: 'una manzana'),
      SentencePart(emoji: '🧸', text: 'un juguete'),
      SentencePart(emoji: '🚗', text: 'en coche'),
      SentencePart(emoji: '🚪', text: 'fuera'),
      SentencePart(emoji: '🏠', text: 'a casa'),
      SentencePart(emoji: '🛏️', text: 'a la cama'),
      SentencePart(emoji: '🚽', text: 'al baño'),
    ],
  ),
  Language.it: SentenceCategories(
    subjects: [
      SentencePart(emoji: '👶', text: 'Io'),
      SentencePart(emoji: '👩', text: 'Mamma'),
      SentencePart(emoji: '👨', text: 'Papà'),
      SentencePart(emoji: '👵', text: 'Nonna'),
      SentencePart(emoji: '🐶', text: 'Cucciolo'),
    ],
    verbs: [
      SentencePart(emoji: '✋', text: 'voglio'),
      SentencePart(emoji: '🍽️', text: 'mangiare'),
      SentencePart(emoji: '🥛', text: 'bere'),
      SentencePart(emoji: '💤', text: 'dormire'),
      SentencePart(emoji: '🚶', text: 'andare'),
      SentencePart(emoji: '🎲', text: 'giocare'),
    ],
    objects: [
      SentencePart(emoji: '🥛', text: 'il latte'),
      SentencePart(emoji: '🍎', text: 'una mela'),
      SentencePart(emoji: '🧸', text: 'un gioco'),
      SentencePart(emoji: '🚗', text: 'in macchina'),
      SentencePart(emoji: '🚪', text: 'fuori'),
      SentencePart(emoji: '🏠', text: 'a casa'),
      SentencePart(emoji: '🛏️', text: 'a letto'),
      SentencePart(emoji: '🚽', text: 'sul vasino'),
    ],
  ),
  Language.fr: SentenceCategories(
    subjects: [
      SentencePart(emoji: '👶', text: 'Moi'),
      SentencePart(emoji: '👩', text: 'Maman'),
      SentencePart(emoji: '👨', text: 'Papa'),
      SentencePart(emoji: '👵', text: 'Mamie'),
      SentencePart(emoji: '🐶', text: 'Toutou'),
    ],
    verbs: [
      SentencePart(emoji: '✋', text: 'veux'),
      SentencePart(emoji: '🍽️', text: 'manger'),
      SentencePart(emoji: '🥛', text: 'boire'),
      SentencePart(emoji: '💤', text: 'dormir'),
      SentencePart(emoji: '🚶', text: 'aller'),
      SentencePart(emoji: '🎲', text: 'jouer'),
    ],
    objects: [
      SentencePart(emoji: '🥛', text: 'du lait'),
      SentencePart(emoji: '🍎', text: 'une pomme'),
      SentencePart(emoji: '🧸', text: 'un jouet'),
      SentencePart(emoji: '🚗', text: 'en voiture'),
      SentencePart(emoji: '🚪', text: 'dehors'),
      SentencePart(emoji: '🏠', text: 'à la maison'),
      SentencePart(emoji: '🛏️', text: 'au lit'),
      SentencePart(emoji: '🚽', text: 'au pot'),
    ],
  ),
  Language.zh: SentenceCategories(
    joiner: '',
    subjects: [
      SentencePart(emoji: '👶', text: '我', ipa: 'wǒ'),
      SentencePart(emoji: '👩', text: '妈妈', ipa: 'māma'),
      SentencePart(emoji: '👨', text: '爸爸', ipa: 'bàba'),
      SentencePart(emoji: '👵', text: '奶奶', ipa: 'nǎinai'),
      SentencePart(emoji: '🐶', text: '狗狗', ipa: 'gǒugou'),
    ],
    verbs: [
      SentencePart(emoji: '✋', text: '要', ipa: 'yào'),
      SentencePart(emoji: '🍽️', text: '吃', ipa: 'chī'),
      SentencePart(emoji: '🥛', text: '喝', ipa: 'hē'),
      SentencePart(emoji: '💤', text: '睡', ipa: 'shuì'),
      SentencePart(emoji: '🚶', text: '去', ipa: 'qù'),
      SentencePart(emoji: '🎲', text: '玩', ipa: 'wán'),
    ],
    objects: [
      SentencePart(emoji: '🥛', text: '奶', ipa: 'nǎi'),
      SentencePart(emoji: '🍎', text: '苹果', ipa: 'píngguǒ'),
      SentencePart(emoji: '🧸', text: '玩具', ipa: 'wánjù'),
      SentencePart(emoji: '🚗', text: '车车', ipa: 'chēche'),
      SentencePart(emoji: '🚪', text: '外面', ipa: 'wàimiàn'),
      SentencePart(emoji: '🏠', text: '家', ipa: 'jiā'),
      SentencePart(emoji: '🛏️', text: '床', ipa: 'chuáng'),
      SentencePart(emoji: '🚽', text: '上厕所', ipa: 'shàng cèsuǒ'),
    ],
  ),
};
