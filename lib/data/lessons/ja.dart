import '../lessons.dart';

// にほんご – Japanese (romaji → hiragana)
// Like the Chinese lessons, swype happens on a Latin (romaji) keyboard;
// `display` shows hiragana so the child connects sound to script.
// Grapheme order: M, A → P → I → N, E (5 graphemes).
const List<Lesson> kLessonsJa = [
  // ── ステージ1: M, A ──────────────────────────────────────────────────────
  Lesson(unlocked: ['M','A'], target: 'MA', display: 'ま',
      hint: '🐴', label: 'MA ま', info: 'スワイプ: 🐭 → 🍎', ipa: 'ma'),
  Lesson(unlocked: ['M','A'], target: 'MAMA', display: 'まま',
      hint: '👩', label: 'MAMA まま', ipa: 'mama'),

  // ── ステージ2: +P ────────────────────────────────────────────────────────
  Lesson(unlocked: ['M','A','P'], target: 'PA', display: 'ぱ',
      hint: '👨', label: 'PA ぱ', info: '新しい: 🥧 P', ipa: 'pa'),
  Lesson(unlocked: ['M','A','P'], target: 'PAPA', display: 'ぱぱ',
      hint: '👨', label: 'PAPA ぱぱ', ipa: 'papa'),

  // ── ステージ3: +I ────────────────────────────────────────────────────────
  Lesson(unlocked: ['M','A','P','I'], target: 'MI', display: 'み',
      hint: '👀', label: 'MI み', info: '新しい: 🍦 I', ipa: 'mi'),
  Lesson(unlocked: ['M','A','P','I'], target: 'MIMI', display: 'みみ',
      hint: '👂', label: 'MIMI みみ', ipa: 'mimi'),

  // ── ステージ4: +N, E ─────────────────────────────────────────────────────
  Lesson(unlocked: ['M','A','P','I','N','E'], target: 'NE', display: 'ね',
      hint: '🐱', label: 'NE ね', info: '新しい: 🎵 N, 🌳 E', ipa: 'ne'),
  Lesson(unlocked: ['M','A','P','I','N','E'], target: 'NEMA', display: 'ねま',
      hint: '🛏️', label: 'NE-MA ねま', ipa: 'nema'),
  Lesson(unlocked: ['M','A','P','I','N','E'], target: 'MAME', display: 'まめ',
      hint: '🫘', label: 'MAME まめ', ipa: 'mame'),
];
