class Lesson {
  final List<String> unlocked; // aktivní písmena
  final String target;         // co má dítě swypnout (velká bez diakritiky)
  final String display;        // zobrazovaný text
  final String hint;           // emoji pro challenge card
  final String label;          // název slova / slabiky
  final String info;           // info o novém písmenu

  const Lesson({
    required this.unlocked,
    required this.target,
    required this.display,
    required this.hint,
    required this.label,
    this.info = '',
  });
}

const List<Lesson> kLessons = [
  // ── Fáze 1: jen M, A ──────────────────────────────────────────────────────
  Lesson(unlocked: ['M','A'], target: 'MA', display: 'MA',
      hint: '👩', label: 'MÁ-MA', info: 'Přejeď: 🐭 → 🍎'),
  Lesson(unlocked: ['M','A'], target: 'MA', display: 'MA',
      hint: '👩', label: 'MÁ-MA'),

  // ── Fáze 2: +T ────────────────────────────────────────────────────────────
  Lesson(unlocked: ['M','A','T'], target: 'TA', display: 'TA',
      hint: '👨', label: 'TÁ-TA', info: 'Nové: 🐯 T'),
  Lesson(unlocked: ['M','A','T'], target: 'MA', display: 'MA',
      hint: '👩', label: 'MÁ-MA'),
  Lesson(unlocked: ['M','A','T'], target: 'TA', display: 'TA',
      hint: '👨', label: 'TÁ-TA'),

  // ── Fáze 3: +B ────────────────────────────────────────────────────────────
  Lesson(unlocked: ['M','A','T','B'], target: 'BA', display: 'BA',
      hint: '👵', label: 'BÁ-BA', info: 'Nové: 🍌 B'),
  Lesson(unlocked: ['M','A','T','B'], target: 'MA', display: 'MA',
      hint: '👩', label: 'MÁ-MA'),
  Lesson(unlocked: ['M','A','T','B'], target: 'BA', display: 'BA',
      hint: '👵', label: 'BÁ-BA'),
  Lesson(unlocked: ['M','A','T','B'], target: 'TA', display: 'TA',
      hint: '👨', label: 'TÁ-TA'),

  // ── Fáze 4: +E, L ─────────────────────────────────────────────────────────
  Lesson(unlocked: ['M','A','T','B','E','L'], target: 'ME', display: 'ME',
      hint: '🌀', label: 'ME-LE', info: 'Nové: 🐘 E, 🦁 L'),
  Lesson(unlocked: ['M','A','T','B','E','L'], target: 'LE', display: 'LE',
      hint: '🌀', label: 'ME-LE'),
  Lesson(unlocked: ['M','A','T','B','E','L'], target: 'MA', display: 'MA',
      hint: '👩', label: 'MÁ-MA'),
  Lesson(unlocked: ['M','A','T','B','E','L'], target: 'TA', display: 'TA',
      hint: '👨', label: 'TÁ-TA'),

  // ── Fáze 5: +O, K ─────────────────────────────────────────────────────────
  Lesson(unlocked: ['M','A','T','B','E','L','O','K'], target: 'KO', display: 'KO',
      hint: '🚲', label: 'KO-LO', info: 'Nové: 🐙 O, 🐱 K'),
  Lesson(unlocked: ['M','A','T','B','E','L','O','K'], target: 'LO', display: 'LO',
      hint: '🚲', label: 'KO-LO'),
  Lesson(unlocked: ['M','A','T','B','E','L','O','K'], target: 'ME', display: 'ME',
      hint: '🌀', label: 'ME-LE'),

  // ── Fáze 6: celá slova ────────────────────────────────────────────────────
  Lesson(unlocked: ['M','A','T','B','E','L','O','K'], target: 'MAMA',
      display: 'MÁMA', hint: '👩', label: 'MÁMA', info: 'Teď celé slovo!'),
  Lesson(unlocked: ['M','A','T','B','E','L','O','K'], target: 'TATA',
      display: 'TÁTA', hint: '👨', label: 'TÁTA'),
  Lesson(unlocked: ['M','A','T','B','E','L','O','K'], target: 'BABA',
      display: 'BÁBA', hint: '👵', label: 'BÁBA'),
  Lesson(unlocked: ['M','A','T','B','E','L','O','K'], target: 'MELE',
      display: 'MELE', hint: '🌀', label: 'MELE MASO'),
  Lesson(unlocked: ['M','A','T','B','E','L','O','K'], target: 'KOLO',
      display: 'KOLO', hint: '🚲', label: 'KOLO'),

  // ── Fáze 7: +S, N, P ──────────────────────────────────────────────────────
  Lesson(unlocked: ['M','A','T','B','E','L','O','K','S','N','P'], target: 'LES',
      display: 'LES', hint: '🌲', label: 'LES', info: 'Nové: ☀️ S, ✂️ N, 🐷 P'),
  Lesson(unlocked: ['M','A','T','B','E','L','O','K','S','N','P'], target: 'PES',
      display: 'PES', hint: '🐶', label: 'PES'),
  Lesson(unlocked: ['M','A','T','B','E','L','O','K','S','N','P'], target: 'NOS',
      display: 'NOS', hint: '👃', label: 'NOS'),
  Lesson(unlocked: ['M','A','T','B','E','L','O','K','S','N','P'], target: 'KOLO',
      display: 'KOLO', hint: '🚲', label: 'KOLO'),
  Lesson(unlocked: ['M','A','T','B','E','L','O','K','S','N','P'], target: 'LES',
      display: 'LES', hint: '🌲', label: 'LES'),
];
