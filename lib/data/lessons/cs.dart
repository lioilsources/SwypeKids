import '../lessons.dart';

// Slabikář – Čeština
// Metoda: analyticko-syntetická (Hláskovice / Nová škola), fáze 1–7.
// Posloupnost grafémů: M, A → T → B → E, L → O, K → S, N, P (11 grafémů).
const List<Lesson> kLessonsCs = [
  // ── Fáze 1: jen M, A ──────────────────────────────────────────────────────
  Lesson(unlocked: ['M','A'], target: 'MA', display: 'MA',
      hint: '👩', label: 'MÁ-MA', info: 'Přejeď: 🐭 → 🍎', ipa: 'maː'),
  Lesson(unlocked: ['M','A'], target: 'MA', display: 'MA',
      hint: '👩', label: 'MÁ-MA', ipa: 'maː'),

  // ── Fáze 2: +T ────────────────────────────────────────────────────────────
  Lesson(unlocked: ['M','A','T'], target: 'TA', display: 'TA',
      hint: '👨', label: 'TÁ-TA', info: 'Nové: 🐯 T', ipa: 'taː'),
  Lesson(unlocked: ['M','A','T'], target: 'MA', display: 'MA',
      hint: '👩', label: 'MÁ-MA', ipa: 'maː'),
  Lesson(unlocked: ['M','A','T'], target: 'TA', display: 'TA',
      hint: '👨', label: 'TÁ-TA', ipa: 'taː'),

  // ── Fáze 3: +B ────────────────────────────────────────────────────────────
  Lesson(unlocked: ['M','A','T','B'], target: 'BA', display: 'BA',
      hint: '👵', label: 'BÁ-BA', info: 'Nové: 🍌 B', ipa: 'baː'),
  Lesson(unlocked: ['M','A','T','B'], target: 'MA', display: 'MA',
      hint: '👩', label: 'MÁ-MA', ipa: 'maː'),
  Lesson(unlocked: ['M','A','T','B'], target: 'BA', display: 'BA',
      hint: '👵', label: 'BÁ-BA', ipa: 'baː'),
  Lesson(unlocked: ['M','A','T','B'], target: 'TA', display: 'TA',
      hint: '👨', label: 'TÁ-TA', ipa: 'taː'),

  // ── Fáze 4: +E, L ─────────────────────────────────────────────────────────
  Lesson(unlocked: ['M','A','T','B','E','L'], target: 'ME', display: 'ME',
      hint: '🌀', label: 'ME-LE', info: 'Nové: 🐘 E, 🦁 L', ipa: 'mɛ'),
  Lesson(unlocked: ['M','A','T','B','E','L'], target: 'LE', display: 'LE',
      hint: '🌀', label: 'ME-LE', ipa: 'lɛ'),
  Lesson(unlocked: ['M','A','T','B','E','L'], target: 'MA', display: 'MA',
      hint: '👩', label: 'MÁ-MA', ipa: 'maː'),
  Lesson(unlocked: ['M','A','T','B','E','L'], target: 'TA', display: 'TA',
      hint: '👨', label: 'TÁ-TA', ipa: 'taː'),

  // ── Fáze 5: +O, K ─────────────────────────────────────────────────────────
  Lesson(unlocked: ['M','A','T','B','E','L','O','K'], target: 'KO', display: 'KO',
      hint: '🚲', label: 'KO-LO', info: 'Nové: 🐙 O, 🐱 K', ipa: 'ko'),
  Lesson(unlocked: ['M','A','T','B','E','L','O','K'], target: 'LO', display: 'LO',
      hint: '🚲', label: 'KO-LO', ipa: 'lo'),
  Lesson(unlocked: ['M','A','T','B','E','L','O','K'], target: 'ME', display: 'ME',
      hint: '🌀', label: 'ME-LE', ipa: 'mɛ'),

  // ── Fáze 6: celá slova ────────────────────────────────────────────────────
  Lesson(unlocked: ['M','A','T','B','E','L','O','K'], target: 'MAMA',
      display: 'MÁMA', hint: '👩', label: 'MÁMA',
      info: 'Teď celé slovo!', ipa: 'ˈmaːma'),
  Lesson(unlocked: ['M','A','T','B','E','L','O','K'], target: 'TATA',
      display: 'TÁTA', hint: '👨', label: 'TÁTA', ipa: 'ˈtaːta'),
  Lesson(unlocked: ['M','A','T','B','E','L','O','K'], target: 'BABA',
      display: 'BÁBA', hint: '👵', label: 'BÁBA', ipa: 'ˈbaːba'),
  Lesson(unlocked: ['M','A','T','B','E','L','O','K'], target: 'MELE',
      display: 'MELE', hint: '🌀', label: 'MELE MASO', ipa: 'ˈmɛlɛ'),
  Lesson(unlocked: ['M','A','T','B','E','L','O','K'], target: 'KOLO',
      display: 'KOLO', hint: '🚲', label: 'KOLO', ipa: 'ˈkolo'),

  // ── Fáze 7: +S, N, P ──────────────────────────────────────────────────────
  Lesson(unlocked: ['M','A','T','B','E','L','O','K','S','N','P'], target: 'LES',
      display: 'LES', hint: '🌲', label: 'LES',
      info: 'Nové: ☀️ S, ✂️ N, 🐷 P', ipa: 'lɛs'),
  Lesson(unlocked: ['M','A','T','B','E','L','O','K','S','N','P'], target: 'PES',
      display: 'PES', hint: '🐶', label: 'PES', ipa: 'pɛs'),
  Lesson(unlocked: ['M','A','T','B','E','L','O','K','S','N','P'], target: 'NOS',
      display: 'NOS', hint: '👃', label: 'NOS', ipa: 'nos'),
  Lesson(unlocked: ['M','A','T','B','E','L','O','K','S','N','P'], target: 'KOLO',
      display: 'KOLO', hint: '🚲', label: 'KOLO', ipa: 'ˈkolo'),
  Lesson(unlocked: ['M','A','T','B','E','L','O','K','S','N','P'], target: 'LES',
      display: 'LES', hint: '🌲', label: 'LES', ipa: 'lɛs'),
];
