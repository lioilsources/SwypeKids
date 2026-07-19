// Čistě dartová část klávesnice (bez Flutter importů),
// aby ji mohl používat i CLI skript tool/export_lessons_to_json.dart.

import 'lessons.dart' show Language;

// ─── QWERTY řady ──────────────────────────────────────────────────────────────
const List<List<String>> kRows = [
  ['Q','W','E','R','T','Y','U','I','O','P'],
  ['A','S','D','F','G','H','J','K','L'],
  ['Z','X','C','V','B','N','M'],
];

// ─── Emoji pro každé písmeno ──────────────────────────────────────────────────
const Map<String, String> kEmoji = {
  'M': '🐭', 'A': '🍎', 'T': '🐯', 'B': '🍌',
  'E': '🐘', 'L': '🦁', 'O': '🐙', 'K': '🐱',
  'S': '☀️', 'N': '✂️', 'P': '🐷', 'R': '🐟',
  'D': '🍩', 'I': '🌈', 'U': '🦆', 'V': '🐺',
  'G': '🍇', 'H': '🏠', 'J': '🍓', 'F': '🍟',
  'C': '🥕', 'Z': '🦓', 'X': '🎸', 'Y': '🪁',
  'W': '🐸', 'Q': '👑',
};

// ─── Emoji mnemotechnika per jazyk ────────────────────────────────────────────
// Pravidlo: emoji, jehož běžné dětské slovo v daném jazyce začíná písmenem
// (zh: pinyin iniciála, ja: romaji). Písmena bez přirozeného slova drží
// hodnotu z kEmoji — v lekcích daného jazyka se nikdy neodemknou.
// Emoji jsou unikátní v rámci jazyka (nálepky se dedupují podle emoji).
const Map<Language, Map<String, String>> kEmojiByLang = {
  Language.cs: {
    'A': '🚗', // auto
    'B': '🍌', // banán
    'C': '🍋', // citron
    'D': '🏠', // dům
    'E': '👧', // Ema („Ema má maso")
    'F': '⚽', // fotbal
    'G': '🦍', // gorila
    'H': '🐍', // had
    'I': '🌈',
    'J': '🍎', // jablko
    'K': '🐱', // kočka
    'L': '🦁', // lev
    'M': '🐭', // myš
    'N': '✂️', // nůžky
    'O': '👁️', // oko
    'P': '🐷', // prase
    'Q': '👑',
    'R': '🐟', // ryba
    'S': '☀️', // slunce
    'T': '🐯', // tygr
    'U': '👂', // ucho
    'V': '🐺', // vlk
    'W': '🐸',
    'X': '🎸',
    'Y': '🪁',
    'Z': '🦓', // zebra
  },
  Language.en: {
    'A': '🍎', // apple
    'B': '🍌', // banana
    'C': '🐱', // cat
    'D': '🥁', // drum
    'E': '🥚', // egg
    'F': '🐸', // frog
    'G': '🦒', // giraffe
    'H': '🏠', // house
    'I': '🍦', // ice cream
    'J': '🧃', // juice
    'K': '🪁', // kite
    'L': '🦁', // lion
    'M': '🐭', // mouse
    'N': '🎵', // note
    'O': '🍊', // orange
    'P': '🥧', // pie
    'Q': '👑', // queen
    'R': '🌈', // rainbow
    'S': '☀️', // sun
    'T': '🐯', // tiger
    'U': '☂️', // umbrella
    'V': '🎻', // violin
    'W': '🐳', // whale
    'X': '🎸',
    'Y': '🪀', // yo-yo
    'Z': '🦓', // zebra
  },
  Language.de: {
    'A': '🍎', // Apfel
    'B': '🍌', // Banane
    'C': '🤡', // Clown
    'D': '🐉', // Drache
    'E': '🐘', // Elefant
    'F': '🐸', // Frosch
    'G': '🦒', // Giraffe
    'H': '🏠', // Haus
    'I': '🦔', // Igel
    'J': '🪀', // Jo-Jo
    'K': '🐱', // Katze
    'L': '🦁', // Löwe
    'M': '🐭', // Maus
    'N': '👃', // Nase
    'O': '🍊', // Orange
    'P': '🐧', // Pinguin
    'Q': '👑',
    'R': '🌈', // Regenbogen
    'S': '☀️', // Sonne
    'T': '🐯', // Tiger
    'U': '⌚', // Uhr
    'V': '🐦', // Vogel
    'W': '🐳', // Wal
    'X': '🎸',
    'Y': '⛵', // Yacht
    'Z': '🦓', // Zebra
  },
  Language.es: {
    'A': '🌳', // árbol
    'B': '🐳', // ballena
    'C': '🏠', // casa
    'D': '🦕', // dinosaurio
    'E': '🐘', // elefante
    'F': '🌸', // flor
    'G': '🐱', // gato
    'H': '🍦', // helado
    'I': '🏝️', // isla
    'J': '🦒', // jirafa
    'K': '🐨', // koala
    'L': '🦁', // león
    'M': '🐵', // mono
    'N': '🍊', // naranja
    'O': '🐻', // oso
    'P': '🐶', // perro
    'Q': '🧀', // queso
    'R': '🐭', // ratón
    'S': '🐍', // serpiente
    'T': '🐢', // tortuga
    'U': '🍇', // uvas
    'V': '🐮', // vaca
    'W': '🐸',
    'X': '🎸',
    'Y': '🪀', // yoyó
    'Z': '🦊', // zorro
  },
  Language.it: {
    'A': '🐝', // ape
    'B': '🍌', // banana
    'C': '🏠', // casa
    'D': '🎲', // dado
    'E': '🐘', // elefante
    'F': '🌸', // fiore
    'G': '🐱', // gatto
    'H': '🏨', // hotel
    'I': '🏝️', // isola
    'J': '🍓',
    'K': '🐨', // koala
    'L': '🦁', // leone
    'M': '🍎', // mela
    'N': '👃', // naso
    'O': '🐻', // orso
    'P': '🍕', // pizza
    'Q': '🖼️', // quadro
    'R': '🐸', // rana
    'S': '☀️', // sole
    'T': '🐯', // tigre
    'U': '🍇', // uva
    'V': '🌋', // vulcano
    'W': '🌊', // (kEmoji 🐸 koliduje s R=rana)
    'X': '🎸',
    'Y': '🪁',
    'Z': '🦓', // zebra
  },
  Language.fr: {
    'A': '✈️', // avion
    'B': '🍌', // banane
    'C': '🐱', // chat
    'D': '🐬', // dauphin
    'E': '🐘', // éléphant
    'F': '🌸', // fleur
    'G': '🎂', // gâteau
    'H': '🦉', // hibou
    'I': '🏝️', // île
    'J': '🧃', // jus
    'K': '🦘', // kangourou
    'L': '🦁', // lion
    'M': '🏠', // maison
    'N': '🎵', // note
    'O': '🍊', // orange
    'P': '🍎', // pomme
    'Q': '🎳', // quille
    'R': '🦊', // renard
    'S': '☀️', // soleil
    'T': '🐯', // tigre
    'U': '🏭', // usine
    'V': '🐮', // vache
    'W': '🚃', // wagon
    'X': '🎸',
    'Y': '🪀', // yoyo
    'Z': '🦓', // zèbre
  },
  Language.pt: {
    'A': '🍍', // abacaxi
    'B': '🍌', // banana
    'C': '🐶', // cachorro
    'D': '🎲', // dado
    'E': '🐘', // elefante
    'F': '🌸', // flor
    'G': '🐱', // gato
    'H': '🦛', // hipopótamo
    'I': '🏝️', // ilha
    'J': '🐊', // jacaré
    'K': '🐨', // koala
    'L': '🦁', // leão
    'M': '🐵', // macaco
    'N': '☁️', // nuvem
    'O': '🥚', // ovo
    'P': '🦆', // pato
    'Q': '🧀', // queijo
    'R': '🐭', // rato
    'S': '☀️', // sol
    'T': '🐯', // tigre
    'U': '🍇', // uva
    'V': '🐮', // vaca
    'W': '🐸',
    'X': '☕', // xícara
    'Y': '🪁',
    'Z': '🦓', // zebra
  },
  Language.zh: {
    'A': '❤️', // ài 爱
    'B': '👨', // bàba 爸爸
    'C': '🍓', // cǎoméi 草莓
    'D': '🐘', // dàxiàng 大象
    'E': '🦢', // é 鹅
    'F': '✈️', // fēijī 飞机
    'G': '🐶', // gǒu 狗
    'H': '🌸', // huā 花
    'I': '1️⃣', // yī 一
    'J': '🐔', // jī 鸡
    'K': '🦕', // kǒnglóng 恐龙
    'L': '🐯', // lǎohǔ 老虎
    'M': '🐴', // mǎ 马
    'N': '🐮', // niú 牛
    'O': '🕊️', // ōu 鸥
    'P': '🍎', // píngguǒ 苹果
    'Q': '🎈', // qìqiú 气球
    'R': '☀️', // rì 日
    'S': '☂️', // sǎn 伞
    'T': '🐰', // tùzi 兔子
    'U': '5️⃣', // wǔ 五
    'V': '🐟', // yú 鱼 (ü)
    'W': '🐌', // wōniú 蜗牛
    'X': '🐼', // xióngmāo 熊猫
    'Y': '🌙', // yuè 月
    'Z': '⚽', // zúqiú 足球
  },
  Language.ja: {
    'A': '🍬', // ame あめ
    'B': '🍌', // banana バナナ
    'C': '🧀', // chīzu チーズ
    'D': '🍩', // dōnatsu ドーナツ
    'E': '✏️', // enpitsu えんぴつ
    'F': '⛵', // fune ふね
    'G': '🦍', // gorira ゴリラ
    'H': '🌸', // hana はな
    'I': '🐶', // inu いぬ
    'J': '🧃', // jūsu ジュース
    'K': '☂️', // kasa かさ
    'L': '🦁',
    'M': '🍊', // mikan みかん
    'N': '🐱', // neko ねこ
    'O': '🍙', // onigiri おにぎり
    'P': '🐼', // panda パンダ
    'Q': '👑',
    'R': '🍎', // ringo りんご
    'S': '🐟', // sakana さかな
    'T': '🐙', // tako たこ
    'U': '🐰', // usagi うさぎ
    'V': '🐺',
    'W': '🐊', // wani わに
    'X': '🎸',
    'Y': '⛰️', // yama やま
    'Z': '🐘', // zō ぞう
  },
};
