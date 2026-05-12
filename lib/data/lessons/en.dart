import '../lessons.dart';

// Syllabary – English
// Method: synthetic phonics (Jolly Phonics SATPIN-inspired, adapted to a
// CV-syllable swype intro to keep the flow parallel with the Czech primer).
// Grapheme order: M, A → T → P → I, N → D, U → O, G, C (11 graphemes).
const List<Lesson> kLessonsEn = [
  // ── Phase 1: M, A ─────────────────────────────────────────────────────────
  Lesson(unlocked: ['M','A'], target: 'MA', display: 'MA',
      hint: '👩', label: 'MA-MA', info: 'Swipe: 🐭 → 🍎', ipa: 'mɑː'),
  Lesson(unlocked: ['M','A'], target: 'MA', display: 'MA',
      hint: '👩', label: 'MA-MA', ipa: 'mɑː'),

  // ── Phase 2: +T ───────────────────────────────────────────────────────────
  Lesson(unlocked: ['M','A','T'], target: 'TA', display: 'TA',
      hint: '👨', label: 'TA-TA', info: 'New: 🌮 T', ipa: 'tɑː'),
  Lesson(unlocked: ['M','A','T'], target: 'AT', display: 'AT',
      hint: '📍', label: 'AT', ipa: 'æt'),
  Lesson(unlocked: ['M','A','T'], target: 'MAT', display: 'MAT',
      hint: '🟫', label: 'MAT', ipa: 'mæt'),

  // ── Phase 3: +P ───────────────────────────────────────────────────────────
  Lesson(unlocked: ['M','A','T','P'], target: 'PA', display: 'PA',
      hint: '👨', label: 'PA-PA', info: 'New: 🥧 P', ipa: 'pɑː'),
  Lesson(unlocked: ['M','A','T','P'], target: 'TAP', display: 'TAP',
      hint: '🚰', label: 'TAP', ipa: 'tæp'),
  Lesson(unlocked: ['M','A','T','P'], target: 'PAT', display: 'PAT',
      hint: '✋', label: 'PAT', ipa: 'pæt'),

  // ── Phase 4: +I, N ────────────────────────────────────────────────────────
  Lesson(unlocked: ['M','A','T','P','I','N'], target: 'PIN', display: 'PIN',
      hint: '📌', label: 'PIN', info: 'New: 🍦 I, 🎵 N', ipa: 'pɪn'),
  Lesson(unlocked: ['M','A','T','P','I','N'], target: 'MAN', display: 'MAN',
      hint: '🧍', label: 'MAN', ipa: 'mæn'),
  Lesson(unlocked: ['M','A','T','P','I','N'], target: 'TIN', display: 'TIN',
      hint: '🥫', label: 'TIN', ipa: 'tɪn'),
  Lesson(unlocked: ['M','A','T','P','I','N'], target: 'NAP', display: 'NAP',
      hint: '💤', label: 'NAP', ipa: 'næp'),

  // ── Phase 5: +D, U ────────────────────────────────────────────────────────
  Lesson(unlocked: ['M','A','T','P','I','N','D','U'], target: 'MUM', display: 'MUM',
      hint: '👩', label: 'MUM', info: 'New: 🥁 D, ☂️ U', ipa: 'mʌm'),
  Lesson(unlocked: ['M','A','T','P','I','N','D','U'], target: 'DAD', display: 'DAD',
      hint: '👨', label: 'DAD', ipa: 'dæd'),
  Lesson(unlocked: ['M','A','T','P','I','N','D','U'], target: 'MUD', display: 'MUD',
      hint: '🟤', label: 'MUD', ipa: 'mʌd'),
  Lesson(unlocked: ['M','A','T','P','I','N','D','U'], target: 'PUP', display: 'PUP',
      hint: '🐶', label: 'PUP', ipa: 'pʌp'),

  // ── Phase 6: whole words ──────────────────────────────────────────────────
  Lesson(unlocked: ['M','A','T','P','I','N','D','U'], target: 'MAP', display: 'MAP',
      hint: '🗺️', label: 'MAP', info: 'Now whole words!', ipa: 'mæp'),
  Lesson(unlocked: ['M','A','T','P','I','N','D','U'], target: 'PAN', display: 'PAN',
      hint: '🍳', label: 'PAN', ipa: 'pæn'),
  Lesson(unlocked: ['M','A','T','P','I','N','D','U'], target: 'NUN', display: 'NUN',
      hint: '🙏', label: 'NUN', ipa: 'nʌn'),

  // ── Phase 7: +O, G, C ─────────────────────────────────────────────────────
  Lesson(unlocked: ['M','A','T','P','I','N','D','U','O','G','C'], target: 'DOG',
      display: 'DOG', hint: '🐕', label: 'DOG',
      info: 'New: 🍊 O, 🦒 G, 🐱 C', ipa: 'dɒɡ'),
  Lesson(unlocked: ['M','A','T','P','I','N','D','U','O','G','C'], target: 'CAT',
      display: 'CAT', hint: '🐱', label: 'CAT', ipa: 'kæt'),
  Lesson(unlocked: ['M','A','T','P','I','N','D','U','O','G','C'], target: 'GOT',
      display: 'GOT', hint: '✊', label: 'GOT', ipa: 'ɡɒt'),
  Lesson(unlocked: ['M','A','T','P','I','N','D','U','O','G','C'], target: 'COT',
      display: 'COT', hint: '🛏️', label: 'COT', ipa: 'kɒt'),
  Lesson(unlocked: ['M','A','T','P','I','N','D','U','O','G','C'], target: 'CUP',
      display: 'CUP', hint: '☕', label: 'CUP', ipa: 'kʌp'),
];
