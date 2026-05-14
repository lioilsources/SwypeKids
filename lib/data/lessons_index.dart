import 'lessons.dart';
import 'lessons/cs.dart';
import 'lessons/en.dart';
import 'lessons/de.dart';
import 'lessons/es.dart';
import 'lessons/it.dart';
import 'lessons/fr.dart';
import 'lessons/zh.dart';
import 'lessons/ja.dart';
import 'lessons/pt.dart';

const Map<Language, List<Lesson>> kLessonsByLang = {
  Language.cs: kLessonsCs,
  Language.en: kLessonsEn,
  Language.de: kLessonsDe,
  Language.es: kLessonsEs,
  Language.it: kLessonsIt,
  Language.fr: kLessonsFr,
  Language.zh: kLessonsZh,
  Language.ja: kLessonsJa,
  Language.pt: kLessonsPt,
};

// Výchozí jazyk pro game_screen, dokud se nepřidá UI přepínač.
const List<Lesson> kLessons = kLessonsCs;
