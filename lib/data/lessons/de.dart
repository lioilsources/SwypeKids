import '../lessons.dart';

// Silbenfibel – Deutsch
// Methode: Mimi-Fibel / klassische analytisch-synthetische Fibel.
// Reihenfolge der Grapheme: M, A → I → L → O → P → T, U, E (9 Grapheme).
const List<Lesson> kLessonsDe = [
  // ── Phase 1: M, A ─────────────────────────────────────────────────────────
  Lesson(unlocked: ['M','A'], target: 'MA', display: 'MA',
      hint: '👩', label: 'MA-MA', info: 'Wisch: 🐭 → 🍎', ipa: 'maː'),
  Lesson(unlocked: ['M','A'], target: 'MA', display: 'MA',
      hint: '👩', label: 'MA-MA', ipa: 'maː'),

  // ── Phase 2: +I ───────────────────────────────────────────────────────────
  Lesson(unlocked: ['M','A','I'], target: 'MI', display: 'MI',
      hint: '🐭', label: 'MI-MI', info: 'Neu: 🍦 I', ipa: 'miː'),
  Lesson(unlocked: ['M','A','I'], target: 'MIMI', display: 'MIMI',
      hint: '🐭', label: 'MIMI', ipa: 'ˈmiːmi'),
  Lesson(unlocked: ['M','A','I'], target: 'MA', display: 'MA',
      hint: '👩', label: 'MA-MA', ipa: 'maː'),

  // ── Phase 3: +L ───────────────────────────────────────────────────────────
  Lesson(unlocked: ['M','A','I','L'], target: 'LA', display: 'LA',
      hint: '🎵', label: 'LA-LA', info: 'Neu: 🦁 L', ipa: 'laː'),
  Lesson(unlocked: ['M','A','I','L'], target: 'LI', display: 'LI',
      hint: '🎵', label: 'LI-LI', ipa: 'liː'),
  Lesson(unlocked: ['M','A','I','L'], target: 'LILA', display: 'LILA',
      hint: '🟣', label: 'LILA', ipa: 'ˈliːla'),
  Lesson(unlocked: ['M','A','I','L'], target: 'MAL', display: 'MAL',
      hint: '🖍️', label: 'MAL', ipa: 'maːl'),

  // ── Phase 4: +O ───────────────────────────────────────────────────────────
  Lesson(unlocked: ['M','A','I','L','O'], target: 'MO', display: 'MO',
      hint: '🐮', label: 'MO', info: 'Neu: 🍊 O', ipa: 'moː'),
  Lesson(unlocked: ['M','A','I','L','O'], target: 'LO', display: 'LO',
      hint: '🔔', label: 'LO', ipa: 'loː'),
  Lesson(unlocked: ['M','A','I','L','O'], target: 'OMI', display: 'OMI',
      hint: '👵', label: 'OMI', ipa: 'ˈoːmi'),
  Lesson(unlocked: ['M','A','I','L','O'], target: 'LOLA', display: 'LOLA',
      hint: '👧', label: 'LOLA', ipa: 'ˈloːla'),

  // ── Phase 5: +P ───────────────────────────────────────────────────────────
  Lesson(unlocked: ['M','A','I','L','O','P'], target: 'PA', display: 'PA',
      hint: '👨', label: 'PA-PA', info: 'Neu: 🥧 P', ipa: 'paː'),
  Lesson(unlocked: ['M','A','I','L','O','P'], target: 'PAPA', display: 'PAPA',
      hint: '👨', label: 'PAPA', ipa: 'ˈpapa'),
  Lesson(unlocked: ['M','A','I','L','O','P'], target: 'OPA', display: 'OPA',
      hint: '👴', label: 'OPA', ipa: 'ˈoːpa'),
  Lesson(unlocked: ['M','A','I','L','O','P'], target: 'PIPI', display: 'PIPI',
      hint: '💧', label: 'PIPI', ipa: 'ˈpiːpi'),

  // ── Phase 6: ganze Wörter ────────────────────────────────────────────────
  Lesson(unlocked: ['M','A','I','L','O','P'], target: 'MAMA', display: 'MAMA',
      hint: '👩', label: 'MAMA', info: 'Jetzt ganze Wörter!', ipa: 'ˈmama'),
  Lesson(unlocked: ['M','A','I','L','O','P'], target: 'OMA', display: 'OMA',
      hint: '👵', label: 'OMA', ipa: 'ˈoːma'),
  Lesson(unlocked: ['M','A','I','L','O','P'], target: 'OPA', display: 'OPA',
      hint: '👴', label: 'OPA', ipa: 'ˈoːpa'),
  Lesson(unlocked: ['M','A','I','L','O','P'], target: 'PAPA', display: 'PAPA',
      hint: '👨', label: 'PAPA', ipa: 'ˈpapa'),
  Lesson(unlocked: ['M','A','I','L','O','P'], target: 'LILA', display: 'LILA',
      hint: '🟣', label: 'LILA', ipa: 'ˈliːla'),

  // ── Phase 7: +T, U, E ─────────────────────────────────────────────────────
  Lesson(unlocked: ['M','A','I','L','O','P','T','U','E'], target: 'TEE',
      display: 'TEE', hint: '🍵', label: 'TEE',
      info: 'Neu: 🌮 T, ☂️ U, 🌳 E', ipa: 'teː'),
  Lesson(unlocked: ['M','A','I','L','O','P','T','U','E'], target: 'AUTO',
      display: 'AUTO', hint: '🚗', label: 'AUTO', ipa: 'ˈaʊto'),
  Lesson(unlocked: ['M','A','I','L','O','P','T','U','E'], target: 'OPI',
      display: 'OPI', hint: '👴', label: 'OPI', ipa: 'ˈoːpi'),
  Lesson(unlocked: ['M','A','I','L','O','P','T','U','E'], target: 'LATTE',
      display: 'LATTE', hint: '🥛', label: 'LATTE', ipa: 'ˈlatə'),
];
