import '../lessons.dart';

// Syllabary – English
// Method: synthetic phonics (Jolly Phonics SATPIN-inspired). Starts from the
// natural family words MUM and DAD, then builds classic short CVC words.
// Grapheme order: M, A → U, D → T → P, I, N → O, G → C (11 graphemes).
const List<Lesson> kLessonsEn = [
  // ── Phase 1: M, A ─────────────────────────────────────────────────────────
  Lesson(unlocked: ['M','A'], target: 'MA', display: 'MA',
      hint: '👩', label: 'MA', info: 'Swipe: 🐭 → 🍎', ipa: 'mɑː'),
  Lesson(unlocked: ['M','A'], target: 'AM', display: 'AM',
      hint: '🙋', label: 'I AM', ipa: 'æm'),

  // ── Phase 2: +U, D ────────────────────────────────────────────────────────
  Lesson(unlocked: ['M','A','U','D'], target: 'DAD', display: 'DAD',
      hint: '👨', label: 'DAD', info: 'New: ☂️ U, 🥁 D', ipa: 'dæd'),
  Lesson(unlocked: ['M','A','U','D'], target: 'MUM', display: 'MUM',
      hint: '👩', label: 'MUM', ipa: 'mʌm'),
  Lesson(unlocked: ['M','A','U','D'], target: 'MUD', display: 'MUD',
      hint: '🟤', label: 'MUD', ipa: 'mʌd'),
  Lesson(unlocked: ['M','A','U','D'], target: 'MAD', display: 'MAD',
      hint: '😠', label: 'MAD', ipa: 'mæd'),

  // ── Phase 3: +T ───────────────────────────────────────────────────────────
  Lesson(unlocked: ['M','A','U','D','T'], target: 'AT', display: 'AT',
      hint: '📍', label: 'AT', info: 'New: 🐯 T', ipa: 'æt'),
  Lesson(unlocked: ['M','A','U','D','T'], target: 'MUM', display: 'MUM',
      hint: '👩', label: 'MUM', ipa: 'mʌm'),
  Lesson(unlocked: ['M','A','U','D','T'], target: 'MAT', display: 'MAT',
      hint: '🟫', label: 'MAT', ipa: 'mæt'),

  // ── Phase 4: +P, I, N ─────────────────────────────────────────────────────
  Lesson(unlocked: ['M','A','U','D','T','P','I','N'], target: 'PIN', display: 'PIN',
      hint: '📌', label: 'PIN', info: 'New: 🥧 P, 🍦 I, 🎵 N', ipa: 'pɪn'),
  Lesson(unlocked: ['M','A','U','D','T','P','I','N'], target: 'MAN', display: 'MAN',
      hint: '🧍', label: 'MAN', ipa: 'mæn'),
  Lesson(unlocked: ['M','A','U','D','T','P','I','N'], target: 'TIN', display: 'TIN',
      hint: '🥫', label: 'TIN', ipa: 'tɪn'),
  Lesson(unlocked: ['M','A','U','D','T','P','I','N'], target: 'DAD', display: 'DAD',
      hint: '👨', label: 'DAD', ipa: 'dæd'),
  Lesson(unlocked: ['M','A','U','D','T','P','I','N'], target: 'NAP', display: 'NAP',
      hint: '💤', label: 'NAP', ipa: 'næp'),
  Lesson(unlocked: ['M','A','U','D','T','P','I','N'], target: 'TAP', display: 'TAP',
      hint: '🚰', label: 'TAP', ipa: 'tæp'),

  // ── Phase 5: +O, G ────────────────────────────────────────────────────────
  Lesson(unlocked: ['M','A','U','D','T','P','I','N','O','G'], target: 'DOG',
      display: 'DOG', hint: '🐕', label: 'DOG',
      info: 'New: 🍊 O, 🦒 G', ipa: 'dɒɡ'),
  Lesson(unlocked: ['M','A','U','D','T','P','I','N','O','G'], target: 'PIG',
      display: 'PIG', hint: '🐷', label: 'PIG', ipa: 'pɪɡ'),
  Lesson(unlocked: ['M','A','U','D','T','P','I','N','O','G'], target: 'POT',
      display: 'POT', hint: '🍲', label: 'POT', ipa: 'pɒt'),
  Lesson(unlocked: ['M','A','U','D','T','P','I','N','O','G'], target: 'MUD',
      display: 'MUD', hint: '🟤', label: 'MUD', ipa: 'mʌd'),
  Lesson(unlocked: ['M','A','U','D','T','P','I','N','O','G'], target: 'TOP',
      display: 'TOP', hint: '🔝', label: 'TOP', ipa: 'tɒp'),

  // ── Phase 6: +C ───────────────────────────────────────────────────────────
  Lesson(unlocked: ['M','A','U','D','T','P','I','N','O','G','C'], target: 'CAT',
      display: 'CAT', hint: '🐱', label: 'CAT', info: 'New: 🐱 C', ipa: 'kæt'),
  Lesson(unlocked: ['M','A','U','D','T','P','I','N','O','G','C'], target: 'CUP',
      display: 'CUP', hint: '☕', label: 'CUP', ipa: 'kʌp'),
  Lesson(unlocked: ['M','A','U','D','T','P','I','N','O','G','C'], target: 'NAP',
      display: 'NAP', hint: '💤', label: 'NAP', ipa: 'næp'),
  Lesson(unlocked: ['M','A','U','D','T','P','I','N','O','G','C'], target: 'COT',
      display: 'COT', hint: '🛏️', label: 'COT', ipa: 'kɒt'),
  Lesson(unlocked: ['M','A','U','D','T','P','I','N','O','G','C'], target: 'CAP',
      display: 'CAP', hint: '🧢', label: 'CAP', ipa: 'kæp'),
];
