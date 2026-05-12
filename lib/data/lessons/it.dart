import '../lessons.dart';

// Sillabario – Italiano
// Metodo: sillabico (vocali prima, poi consonanti con ogni vocale).
// Ordine grafemi: M, A → I → P → N → O, L → T, E (9 grafemi).
const List<Lesson> kLessonsIt = [
  // ── Fase 1: M, A ──────────────────────────────────────────────────────────
  Lesson(unlocked: ['M','A'], target: 'MA', display: 'MA',
      hint: '👩', label: 'MAM-MA', info: 'Scorri: 🐭 → 🍎', ipa: 'ma'),
  Lesson(unlocked: ['M','A'], target: 'MA', display: 'MA',
      hint: '👩', label: 'MAM-MA', ipa: 'ma'),

  // ── Fase 2: +I ────────────────────────────────────────────────────────────
  Lesson(unlocked: ['M','A','I'], target: 'MI', display: 'MI',
      hint: '🐭', label: 'MI-MI', info: 'Nuovo: 🍦 I', ipa: 'mi'),
  Lesson(unlocked: ['M','A','I'], target: 'AMI', display: 'AMI',
      hint: '❤️', label: 'A-MI', ipa: 'ˈami'),
  Lesson(unlocked: ['M','A','I'], target: 'MAMI', display: 'MAMÌ',
      hint: '👩', label: 'MA-MÌ', ipa: 'maˈmi'),

  // ── Fase 3: +P ────────────────────────────────────────────────────────────
  Lesson(unlocked: ['M','A','I','P'], target: 'PA', display: 'PA',
      hint: '👨', label: 'PA-PÀ', info: 'Nuovo: 🥧 P', ipa: 'pa'),
  Lesson(unlocked: ['M','A','I','P'], target: 'PI', display: 'PI',
      hint: '🎵', label: 'PI-PI', ipa: 'pi'),
  Lesson(unlocked: ['M','A','I','P'], target: 'PIPA', display: 'PIPA',
      hint: '🚬', label: 'PI-PA', ipa: 'ˈpipa'),

  // ── Fase 4: +N ────────────────────────────────────────────────────────────
  Lesson(unlocked: ['M','A','I','P','N'], target: 'NA', display: 'NA',
      hint: '🎵', label: 'NA-NA', info: 'Nuovo: 🎵 N', ipa: 'na'),
  Lesson(unlocked: ['M','A','I','P','N'], target: 'NANA', display: 'NANNA',
      hint: '💤', label: 'NAN-NA', ipa: 'ˈnanna'),
  Lesson(unlocked: ['M','A','I','P','N'], target: 'MANI', display: 'MANI',
      hint: '🖐️', label: 'MA-NI', ipa: 'ˈmani'),

  // ── Fase 5: +O, L ─────────────────────────────────────────────────────────
  Lesson(unlocked: ['M','A','I','P','N','O','L'], target: 'LA', display: 'LA',
      hint: '🦁', label: 'LA-LA', info: 'Nuovo: 🍊 O, 🦁 L', ipa: 'la'),
  Lesson(unlocked: ['M','A','I','P','N','O','L'], target: 'LANA', display: 'LANA',
      hint: '🧶', label: 'LA-NA', ipa: 'ˈlana'),
  Lesson(unlocked: ['M','A','I','P','N','O','L'], target: 'MANO', display: 'MANO',
      hint: '✋', label: 'MA-NO', ipa: 'ˈmano'),
  Lesson(unlocked: ['M','A','I','P','N','O','L'], target: 'PALLA', display: 'PALLA',
      hint: '⚽', label: 'PAL-LA', ipa: 'ˈpalla'),

  // ── Fase 6: parole intere ────────────────────────────────────────────────
  Lesson(unlocked: ['M','A','I','P','N','O','L'], target: 'MAMMA', display: 'MAMMA',
      hint: '👩', label: 'MAMMA', info: 'Parole intere!', ipa: 'ˈmamma'),
  Lesson(unlocked: ['M','A','I','P','N','O','L'], target: 'PAPA', display: 'PAPÀ',
      hint: '👨', label: 'PAPÀ', ipa: 'paˈpa'),
  Lesson(unlocked: ['M','A','I','P','N','O','L'], target: 'NONNA', display: 'NONNA',
      hint: '👵', label: 'NONNA', ipa: 'ˈnɔnna'),
  Lesson(unlocked: ['M','A','I','P','N','O','L'], target: 'LANA', display: 'LANA',
      hint: '🧶', label: 'LANA', ipa: 'ˈlana'),
  Lesson(unlocked: ['M','A','I','P','N','O','L'], target: 'MANO', display: 'MANO',
      hint: '🖐️', label: 'MANO', ipa: 'ˈmano'),

  // ── Fase 7: +T, E ─────────────────────────────────────────────────────────
  Lesson(unlocked: ['M','A','I','P','N','O','L','T','E'], target: 'TE',
      display: 'TÈ', hint: '🍵', label: 'TÈ',
      info: 'Nuovo: 🌮 T, 🌳 E', ipa: 'tɛ'),
  Lesson(unlocked: ['M','A','I','P','N','O','L','T','E'], target: 'PANE',
      display: 'PANE', hint: '🍞', label: 'PA-NE', ipa: 'ˈpane'),
  Lesson(unlocked: ['M','A','I','P','N','O','L','T','E'], target: 'LATTE',
      display: 'LATTE', hint: '🥛', label: 'LAT-TE', ipa: 'ˈlatte'),
  Lesson(unlocked: ['M','A','I','P','N','O','L','T','E'], target: 'MATITA',
      display: 'MATITA', hint: '✏️', label: 'MA-TI-TA', ipa: 'maˈtita'),
  Lesson(unlocked: ['M','A','I','P','N','O','L','T','E'], target: 'PANNA',
      display: 'PANNA', hint: '🍦', label: 'PAN-NA', ipa: 'ˈpanna'),
];
