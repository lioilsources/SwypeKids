import '../lessons.dart';

// Silabario – Español
// Método: silábico (vocales primero, luego consonantes con cada vocal).
// Orden de grafemas: M, A → I → P → S, O → L → E, T, N (10 grafemas).
const List<Lesson> kLessonsEs = [
  // ── Fase 1: M, A ──────────────────────────────────────────────────────────
  Lesson(unlocked: ['M','A'], target: 'MA', display: 'MA',
      hint: '👩', label: 'MA-MÁ', info: 'Desliza: 🐭 → 🍎', ipa: 'ma'),
  Lesson(unlocked: ['M','A'], target: 'MA', display: 'MA',
      hint: '👩', label: 'MA-MÁ', ipa: 'ma'),

  // ── Fase 2: +I ────────────────────────────────────────────────────────────
  Lesson(unlocked: ['M','A','I'], target: 'MI', display: 'MI',
      hint: '🐭', label: 'MI-MI', info: 'Nuevo: 🍦 I', ipa: 'mi'),
  Lesson(unlocked: ['M','A','I'], target: 'AMA', display: 'AMA',
      hint: '❤️', label: 'A-MA', ipa: 'ˈama'),
  Lesson(unlocked: ['M','A','I'], target: 'MAMI', display: 'MAMI',
      hint: '👩', label: 'MA-MI', ipa: 'ˈmami'),

  // ── Fase 3: +P ────────────────────────────────────────────────────────────
  Lesson(unlocked: ['M','A','I','P'], target: 'PA', display: 'PA',
      hint: '👨', label: 'PA-PÁ', info: 'Nuevo: 🥧 P', ipa: 'pa'),
  Lesson(unlocked: ['M','A','I','P'], target: 'PI', display: 'PI',
      hint: '🎵', label: 'PI-PI', ipa: 'pi'),
  Lesson(unlocked: ['M','A','I','P'], target: 'PAPA', display: 'PAPÁ',
      hint: '👨', label: 'PA-PÁ', ipa: 'paˈpa'),

  // ── Fase 4: +S, O ─────────────────────────────────────────────────────────
  Lesson(unlocked: ['M','A','I','P','S','O'], target: 'SA', display: 'SA',
      hint: '🐍', label: 'SA-SA', info: 'Nuevo: 🐍 S, 🍊 O', ipa: 'sa'),
  Lesson(unlocked: ['M','A','I','P','S','O'], target: 'SO', display: 'SO',
      hint: '☀️', label: 'SO', ipa: 'so'),
  Lesson(unlocked: ['M','A','I','P','S','O'], target: 'OSO', display: 'OSO',
      hint: '🐻', label: 'O-SO', ipa: 'ˈoso'),
  Lesson(unlocked: ['M','A','I','P','S','O'], target: 'SOPA', display: 'SOPA',
      hint: '🥣', label: 'SO-PA', ipa: 'ˈsopa'),

  // ── Fase 5: +L ────────────────────────────────────────────────────────────
  Lesson(unlocked: ['M','A','I','P','S','O','L'], target: 'LA', display: 'LA',
      hint: '🦁', label: 'LA-LA', info: 'Nuevo: 🦁 L', ipa: 'la'),
  Lesson(unlocked: ['M','A','I','P','S','O','L'], target: 'ALA', display: 'ALA',
      hint: '🪽', label: 'A-LA', ipa: 'ˈala'),
  Lesson(unlocked: ['M','A','I','P','S','O','L'], target: 'LOLA', display: 'LOLA',
      hint: '👧', label: 'LO-LA', ipa: 'ˈlola'),
  Lesson(unlocked: ['M','A','I','P','S','O','L'], target: 'LISA', display: 'LISA',
      hint: '👧', label: 'LI-SA', ipa: 'ˈlisa'),

  // ── Fase 6: palabras enteras ─────────────────────────────────────────────
  Lesson(unlocked: ['M','A','I','P','S','O','L'], target: 'MAMA', display: 'MAMÁ',
      hint: '👩', label: 'MAMÁ', info: '¡Palabras enteras!', ipa: 'maˈma'),
  Lesson(unlocked: ['M','A','I','P','S','O','L'], target: 'PAPA', display: 'PAPÁ',
      hint: '👨', label: 'PAPÁ', ipa: 'paˈpa'),
  Lesson(unlocked: ['M','A','I','P','S','O','L'], target: 'OSO', display: 'OSO',
      hint: '🐻', label: 'OSO', ipa: 'ˈoso'),
  Lesson(unlocked: ['M','A','I','P','S','O','L'], target: 'SOPA', display: 'SOPA',
      hint: '🥣', label: 'SOPA', ipa: 'ˈsopa'),

  // ── Fase 7: +E, T, N ──────────────────────────────────────────────────────
  Lesson(unlocked: ['M','A','I','P','S','O','L','E','T','N'], target: 'NENE',
      display: 'NENE', hint: '👶', label: 'NE-NE',
      info: 'Nuevo: 🌳 E, 🌮 T, 🎵 N', ipa: 'ˈnene'),
  Lesson(unlocked: ['M','A','I','P','S','O','L','E','T','N'], target: 'TIA',
      display: 'TÍA', hint: '👩‍🦱', label: 'TÍ-A', ipa: 'ˈtia'),
  Lesson(unlocked: ['M','A','I','P','S','O','L','E','T','N'], target: 'PATA',
      display: 'PATA', hint: '🦆', label: 'PA-TA', ipa: 'ˈpata'),
  Lesson(unlocked: ['M','A','I','P','S','O','L','E','T','N'], target: 'TOMATE',
      display: 'TOMATE', hint: '🍅', label: 'TO-MA-TE', ipa: 'toˈmate'),
  Lesson(unlocked: ['M','A','I','P','S','O','L','E','T','N'], target: 'PELOTA',
      display: 'PELOTA', hint: '⚽', label: 'PE-LO-TA', ipa: 'peˈlota'),
];
