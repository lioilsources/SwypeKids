import '../lessons.dart';

// 拼音入门 – 中文 (Pinyin progression for Chinese)
// Phase 1: pinyin (Latin transcription) — the QWERTY swype maps to syllables;
// tones are shown in `display` and stored in `pinyin` (tone numbers).
// Phase 2 (future): map syllable → 汉字 via emoji.
// Grapheme order: M, A → B → I → P → N, E → H, O (9 graphemes).
const List<Lesson> kLessonsZh = [
  // ── 第一阶段: M, A ────────────────────────────────────────────────────────
  Lesson(unlocked: ['M','A'], target: 'MA', display: 'MĀ',
      hint: '👩', label: 'MĀ 妈', info: '滑动: 🐭 → 🍎',
      ipa: 'ma˥', pinyin: 'ma1'),
  Lesson(unlocked: ['M','A'], target: 'MA', display: 'MĀ',
      hint: '👩', label: 'MĀ 妈', ipa: 'ma˥', pinyin: 'ma1'),

  // ── 第二阶段: +B ──────────────────────────────────────────────────────────
  Lesson(unlocked: ['M','A','B'], target: 'BA', display: 'BÀ',
      hint: '👨', label: 'BÀ 爸', info: '新: 🐻 B',
      ipa: 'pa˥˩', pinyin: 'ba4'),
  Lesson(unlocked: ['M','A','B'], target: 'BABA', display: 'BÀBA',
      hint: '👨', label: 'BÀBA 爸爸', ipa: 'ˈpa˥˩pa', pinyin: 'ba4.ba'),
  Lesson(unlocked: ['M','A','B'], target: 'MAMA', display: 'MĀMA',
      hint: '👩', label: 'MĀMA 妈妈', ipa: 'ˈma˥ma', pinyin: 'ma1.ma'),

  // ── 第三阶段: +I ──────────────────────────────────────────────────────────
  Lesson(unlocked: ['M','A','B','I'], target: 'MI', display: 'MǏ',
      hint: '🍚', label: 'MǏ 米', info: '新: 🍦 I',
      ipa: 'mi˨˩˦', pinyin: 'mi3'),
  Lesson(unlocked: ['M','A','B','I'], target: 'BI', display: 'BǏ',
      hint: '✏️', label: 'BǏ 笔', ipa: 'pi˨˩˦', pinyin: 'bi3'),
  Lesson(unlocked: ['M','A','B','I'], target: 'MIMI', display: 'MĪMĪ',
      hint: '🐱', label: 'MĪMĪ 咪咪', ipa: 'mi˥mi˥', pinyin: 'mi1.mi1'),

  // ── 第四阶段: +P ──────────────────────────────────────────────────────────
  Lesson(unlocked: ['M','A','B','I','P'], target: 'PA', display: 'PÀ',
      hint: '😨', label: 'PÀ 怕', info: '新: 🥧 P',
      ipa: 'pʰa˥˩', pinyin: 'pa4'),
  Lesson(unlocked: ['M','A','B','I','P'], target: 'PI', display: 'PÍ',
      hint: '🍌', label: 'PÍ 皮', ipa: 'pʰi˧˥', pinyin: 'pi2'),
  Lesson(unlocked: ['M','A','B','I','P'], target: 'PIPA', display: 'PÍPA',
      hint: '🪕', label: 'PÍPA 琵琶', ipa: 'pʰi˧˥pa', pinyin: 'pi2.pa'),

  // ── 第五阶段: +N, E ──────────────────────────────────────────────────────
  Lesson(unlocked: ['M','A','B','I','P','N','E'], target: 'NE', display: 'NE',
      hint: '❓', label: 'NE 呢', info: '新: 🎵 N, 🌳 E',
      ipa: 'nə', pinyin: 'ne'),
  Lesson(unlocked: ['M','A','B','I','P','N','E'], target: 'ME', display: 'ME',
      hint: '❓', label: 'ME 么', ipa: 'mə', pinyin: 'me'),
  Lesson(unlocked: ['M','A','B','I','P','N','E'], target: 'BEI', display: 'BĒI',
      hint: '🥤', label: 'BĒI 杯', ipa: 'pei˥', pinyin: 'bei1'),

  // ── 第六阶段: 词语 (whole words) ─────────────────────────────────────────
  Lesson(unlocked: ['M','A','B','I','P','N','E'], target: 'MAMA', display: 'MĀMA',
      hint: '👩', label: '妈妈', info: '词语!',
      ipa: 'ˈma˥ma', pinyin: 'ma1.ma'),
  Lesson(unlocked: ['M','A','B','I','P','N','E'], target: 'BABA', display: 'BÀBA',
      hint: '👨', label: '爸爸', ipa: 'ˈpa˥˩pa', pinyin: 'ba4.ba'),
  Lesson(unlocked: ['M','A','B','I','P','N','E'], target: 'MIMI', display: 'MĪMĪ',
      hint: '🐱', label: '咪咪', ipa: 'mi˥mi˥', pinyin: 'mi1.mi1'),
  Lesson(unlocked: ['M','A','B','I','P','N','E'], target: 'PIPA', display: 'PÍPA',
      hint: '🪕', label: '琵琶', ipa: 'pʰi˧˥pa', pinyin: 'pi2.pa'),
  Lesson(unlocked: ['M','A','B','I','P','N','E'], target: 'BEIBEI', display: 'BÈIBEI',
      hint: '👶', label: '贝贝', ipa: 'pei˥˩pei', pinyin: 'bei4.bei'),

  // ── 第七阶段: +H, O ──────────────────────────────────────────────────────
  Lesson(unlocked: ['M','A','B','I','P','N','E','H','O'], target: 'HAO',
      display: 'HǍO', hint: '👍', label: 'HǍO 好',
      info: '新: ☀️ H, 🍊 O', ipa: 'xau˨˩˦', pinyin: 'hao3'),
  Lesson(unlocked: ['M','A','B','I','P','N','E','H','O'], target: 'BAO',
      display: 'BĀO', hint: '🥟', label: 'BĀO 包',
      ipa: 'pau˥', pinyin: 'bao1'),
  Lesson(unlocked: ['M','A','B','I','P','N','E','H','O'], target: 'MAO',
      display: 'MĀO', hint: '🐱', label: 'MĀO 猫',
      ipa: 'mau˥', pinyin: 'mao1'),
  Lesson(unlocked: ['M','A','B','I','P','N','E','H','O'], target: 'NIHAO',
      display: 'NǏHǍO', hint: '👋', label: 'NǏHǍO 你好',
      ipa: 'ni˨˩˦xau˨˩˦', pinyin: 'ni3.hao3'),
  Lesson(unlocked: ['M','A','B','I','P','N','E','H','O'], target: 'HAHA',
      display: 'HĀHA', hint: '😂', label: 'HĀHA 哈哈',
      ipa: 'xa˥xa', pinyin: 'ha1.ha'),
  Lesson(unlocked: ['M','A','B','I','P','N','E','H','O'], target: 'BOBO',
      display: 'BÓBO', hint: '👨', label: 'BÓBO 伯伯',
      ipa: 'po˧˥po', pinyin: 'bo2.bo'),
];
