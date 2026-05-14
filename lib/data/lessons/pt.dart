import '../lessons.dart';

// Silabário – Português (Brasil)
// Método: silábico, vogais primeiro, depois consoantes em CV.
// Ordem de grafemas: M, A → I → P → V, O → E (7 grafemas).
const List<Lesson> kLessonsPt = [
  // ── Fase 1: M, A ─────────────────────────────────────────────────────────
  Lesson(unlocked: ['M','A'], target: 'MA', display: 'MA',
      hint: '👩', label: 'MA-MÃE', info: 'Deslize: 🐭 → 🍎', ipa: 'ma'),
  Lesson(unlocked: ['M','A'], target: 'MAMA', display: 'MAMA',
      hint: '👩', label: 'MA-MA', ipa: 'ˈmama'),

  // ── Fase 2: +I ───────────────────────────────────────────────────────────
  Lesson(unlocked: ['M','A','I'], target: 'MI', display: 'MI',
      hint: '🐭', label: 'MI-MI', info: 'Novo: 🍦 I', ipa: 'mi'),
  Lesson(unlocked: ['M','A','I'], target: 'AMA', display: 'AMA',
      hint: '❤️', label: 'A-MA', ipa: 'ˈama'),

  // ── Fase 3: +P ───────────────────────────────────────────────────────────
  Lesson(unlocked: ['M','A','I','P'], target: 'PA', display: 'PA',
      hint: '👨', label: 'PA-PAI', info: 'Novo: 🥧 P', ipa: 'pa'),
  Lesson(unlocked: ['M','A','I','P'], target: 'PAPA', display: 'PAPA',
      hint: '👨', label: 'PA-PA', ipa: 'ˈpapa'),
  Lesson(unlocked: ['M','A','I','P'], target: 'PIPA', display: 'PIPA',
      hint: '🪁', label: 'PI-PA', ipa: 'ˈpipa'),

  // ── Fase 4: +V, O ────────────────────────────────────────────────────────
  Lesson(unlocked: ['M','A','I','P','V','O'], target: 'VO', display: 'VÔ',
      hint: '👴', label: 'VÔ', info: 'Novo: 🐮 V, 🍊 O', ipa: 'vo'),
  Lesson(unlocked: ['M','A','I','P','V','O'], target: 'VOVO', display: 'VOVÓ',
      hint: '👵', label: 'VO-VÓ', ipa: 'voˈvɔ'),
  Lesson(unlocked: ['M','A','I','P','V','O'], target: 'POMA', display: 'POMA',
      hint: '🍎', label: 'PO-MA', ipa: 'ˈpoma'),

  // ── Fase 5: +E ───────────────────────────────────────────────────────────
  Lesson(unlocked: ['M','A','I','P','V','O','E'], target: 'MAMAE', display: 'MAMÃE',
      hint: '👩', label: 'MA-MÃE', info: 'Novo: 🌳 E', ipa: 'maˈmɐ̃j'),
  Lesson(unlocked: ['M','A','I','P','V','O','E'], target: 'PAPAI', display: 'PAPAI',
      hint: '👨', label: 'PA-PAI', ipa: 'paˈpaj'),
];
