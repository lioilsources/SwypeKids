// Čistě dartová část klávesnice (bez Flutter importů),
// aby ji mohl používat i CLI skript tool/export_lessons_to_json.dart.

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
