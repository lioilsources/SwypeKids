import '../lessons.dart';

// Syllabaire – Français
// Méthode : syllabique (inspirée de la Méthode Boscher), adaptée à un
// premier déchiffrage par syllabe CV.
// Ordre des graphèmes : M, A → P, I → L → T → N → O, U (9 graphèmes).
const List<Lesson> kLessonsFr = [
  // ── Phase 1 : M, A ────────────────────────────────────────────────────────
  Lesson(unlocked: ['M','A'], target: 'MA', display: 'MA',
      hint: '👩', label: 'MA-MAN', info: 'Glisse : 🐭 → 🍎', ipa: 'ma'),
  Lesson(unlocked: ['M','A'], target: 'MA', display: 'MA',
      hint: '👩', label: 'MA-MAN', ipa: 'ma'),

  // ── Phase 2 : +P, I ───────────────────────────────────────────────────────
  Lesson(unlocked: ['M','A','P','I'], target: 'PA', display: 'PA',
      hint: '👨', label: 'PA-PA', info: 'Nouveau : 🥧 P, 🍦 I', ipa: 'pa'),
  Lesson(unlocked: ['M','A','P','I'], target: 'PI', display: 'PI',
      hint: '🎵', label: 'PI-PI', ipa: 'pi'),
  Lesson(unlocked: ['M','A','P','I'], target: 'PAPA', display: 'PAPA',
      hint: '👨', label: 'PA-PA', ipa: 'paˈpa'),
  Lesson(unlocked: ['M','A','P','I'], target: 'AMI', display: 'AMI',
      hint: '🤝', label: 'A-MI', ipa: 'aˈmi'),

  // ── Phase 3 : +L ──────────────────────────────────────────────────────────
  Lesson(unlocked: ['M','A','P','I','L'], target: 'LA', display: 'LA',
      hint: '🦁', label: 'LA-LA', info: 'Nouveau : 🦁 L', ipa: 'la'),
  Lesson(unlocked: ['M','A','P','I','L'], target: 'LI', display: 'LI',
      hint: '🛏️', label: 'LI-LI', ipa: 'li'),
  Lesson(unlocked: ['M','A','P','I','L'], target: 'LILA', display: 'LILA',
      hint: '🟣', label: 'LI-LA', ipa: 'liˈla'),
  Lesson(unlocked: ['M','A','P','I','L'], target: 'MAL', display: 'MAL',
      hint: '🤕', label: 'MAL', ipa: 'mal'),

  // ── Phase 4 : +T ──────────────────────────────────────────────────────────
  Lesson(unlocked: ['M','A','P','I','L','T'], target: 'TA', display: 'TA',
      hint: '👨', label: 'TA-TA', info: 'Nouveau : 🌮 T', ipa: 'ta'),
  Lesson(unlocked: ['M','A','P','I','L','T'], target: 'TATA', display: 'TATA',
      hint: '👩‍🦱', label: 'TA-TA', ipa: 'taˈta'),
  Lesson(unlocked: ['M','A','P','I','L','T'], target: 'LIT', display: 'LIT',
      hint: '🛏️', label: 'LIT', ipa: 'li'),

  // ── Phase 5 : +N ──────────────────────────────────────────────────────────
  Lesson(unlocked: ['M','A','P','I','L','T','N'], target: 'NA', display: 'NA',
      hint: '🎵', label: 'NA-NA', info: 'Nouveau : 🎵 N', ipa: 'na'),
  Lesson(unlocked: ['M','A','P','I','L','T','N'], target: 'MAMAN',
      display: 'MAMAN', hint: '👩', label: 'MA-MAN', ipa: 'maˈmɑ̃'),
  Lesson(unlocked: ['M','A','P','I','L','T','N'], target: 'NANA',
      display: 'NANA', hint: '👵', label: 'NA-NA', ipa: 'naˈna'),

  // ── Phase 6 : mots entiers ────────────────────────────────────────────────
  Lesson(unlocked: ['M','A','P','I','L','T','N'], target: 'MAMAN',
      display: 'MAMAN', hint: '👩', label: 'MAMAN',
      info: 'Maintenant des mots entiers !', ipa: 'maˈmɑ̃'),
  Lesson(unlocked: ['M','A','P','I','L','T','N'], target: 'PAPA',
      display: 'PAPA', hint: '👨', label: 'PAPA', ipa: 'paˈpa'),
  Lesson(unlocked: ['M','A','P','I','L','T','N'], target: 'TATA',
      display: 'TATA', hint: '👩‍🦱', label: 'TATA', ipa: 'taˈta'),
  Lesson(unlocked: ['M','A','P','I','L','T','N'], target: 'LILA',
      display: 'LILA', hint: '🟣', label: 'LILA', ipa: 'liˈla'),

  // ── Phase 7 : +O, U ──────────────────────────────────────────────────────
  Lesson(unlocked: ['M','A','P','I','L','T','N','O','U'], target: 'AUTO',
      display: 'AUTO', hint: '🚗', label: 'AU-TO',
      info: 'Nouveau : 🍊 O, ☂️ U', ipa: 'oˈto'),
  Lesson(unlocked: ['M','A','P','I','L','T','N','O','U'], target: 'LOTO',
      display: 'LOTO', hint: '🎰', label: 'LO-TO', ipa: 'loˈto'),
  Lesson(unlocked: ['M','A','P','I','L','T','N','O','U'], target: 'NUL',
      display: 'NUL', hint: '0️⃣', label: 'NUL', ipa: 'nyl'),
  Lesson(unlocked: ['M','A','P','I','L','T','N','O','U'], target: 'TOI',
      display: 'TOI', hint: '👈', label: 'TOI', ipa: 'twa'),
  Lesson(unlocked: ['M','A','P','I','L','T','N','O','U'], target: 'MOTO',
      display: 'MOTO', hint: '🏍️', label: 'MO-TO', ipa: 'moˈto'),
];
