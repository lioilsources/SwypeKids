// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hebrew (`he`).
class AppLocalizationsHe extends AppLocalizations {
  AppLocalizationsHe([String locale = 'he']) : super(locale);

  @override
  String get appTitle => 'SwypeKids';

  @override
  String get menuSyllabary => 'אלף־בית (סוייפ)';

  @override
  String get menuSentence => 'בנו משפט';

  @override
  String get menuZoo => 'גן חיות';

  @override
  String get menuBook => 'הספר שלי';

  @override
  String get menuParents => 'להורים';

  @override
  String get practiceTitle => 'תרגול';

  @override
  String bedtimeText(String guide) {
    return '$guide ישן עכשיו. נתראה מחר!';
  }

  @override
  String get typeListen => 'האזנה';

  @override
  String get typePicture => 'תמונה';

  @override
  String get typeGap => 'השלמה';

  @override
  String get typeReview => 'חזרה';

  @override
  String get typeWord => 'מילה';

  @override
  String get typeSyllable => 'הברה';

  @override
  String get promptListen => 'הקשיבו והחליקו את מה ששמעתם';

  @override
  String get promptPicture => 'מה בתמונה? כתבו';

  @override
  String get promptGap => 'איזו אות חסרה? החליקו את המילה כולה';

  @override
  String get promptSwipeTouch => 'החליקו אצבע על התמונות';

  @override
  String get promptSwipeTrackpad => 'החליקו בשתי אצבעות על התמונות';

  @override
  String get successText => 'כל הכבוד!';

  @override
  String get errorText => 'נסו שוב!';

  @override
  String get newSticker => 'קיבלת מדבקה חדשה!';

  @override
  String starsGained(int count) {
    return '+$count כוכבים';
  }

  @override
  String get backToMap => 'חזרה למפה';

  @override
  String get winTitle => 'סיימת!\nאתה אלוף!';

  @override
  String winStars(int count) {
    return 'הרווחת $count כוכבים!';
  }

  @override
  String get playAgain => 'שחקו שוב';

  @override
  String get builderBadge => 'משפט';

  @override
  String get who => 'מי';

  @override
  String get whatDoes => 'מה עושה';

  @override
  String get whatWhere => 'מה / לאן';

  @override
  String get newLabel => 'חדש';

  @override
  String get clear => 'נקה';

  @override
  String get bookTitle => 'הספר שלי';

  @override
  String get bookEmptyHint => 'בנו משפט ושמרו אותו בספר';

  @override
  String get zooTitle => 'גן חיות';

  @override
  String badgesTitle(int earned, int total) {
    return 'אותות $earned/$total';
  }

  @override
  String get badgeFirstSwype => 'החלקה ראשונה';

  @override
  String get badgeFirstSwypeHow => 'ההחלקה הנכונה הראשונה';

  @override
  String get badgeNoMistake => 'בלי טעויות';

  @override
  String get badgeNoMistakeHow => 'יחידה שלמה בשלושה כוכבים';

  @override
  String get badgeExplorer => 'חוקר';

  @override
  String get badgeExplorerHow => 'המדבקה הראשונה';

  @override
  String get badgeCollectorHalf => 'אספן';

  @override
  String get badgeCollectorHalfHow => 'חצי מגן החיות';

  @override
  String get badgeCollectorAll => 'אספן גדול';

  @override
  String get badgeCollectorAllHow => 'כל גן החיות';

  @override
  String get badgeNightOwl => 'ינשוף לילה';

  @override
  String get badgeNightOwlHow => 'שיחק בלילה';

  @override
  String get badgeEarlyBird => 'ציפור מוקדמת';

  @override
  String get badgeEarlyBirdHow => 'שיחק בבוקר';

  @override
  String get badgeFourSeasons => 'ארבע עונות';

  @override
  String get badgeFourSeasonsHow => 'שיחק בכל עונה';

  @override
  String get badgeWordsmith10 => 'מילונאי';

  @override
  String get badgeWordsmith10How => '10 מילים בתיק';

  @override
  String get badgeWordsmith25 => 'מילונאי גדול';

  @override
  String get badgeWordsmith25How => '25 מילים בתיק';

  @override
  String get badgeWordsmith50 => 'אמן המילים';

  @override
  String get badgeWordsmith50How => '50 מילים בתיק';

  @override
  String get badgePoet => 'משורר';

  @override
  String get badgePoetHow => '10 משפטים בספר שלי';

  @override
  String get badgeListener => 'מאזין';

  @override
  String get badgeListenerHow => '10 סבבי האזנה בשלושה כוכבים';

  @override
  String get badgePersistent => 'מתמיד';

  @override
  String get badgePersistentHow => '7 ימי משחק';

  @override
  String get parentTitle => 'להורים';

  @override
  String gateQuestion(int a, int b) {
    return 'כמה זה $a × $b?';
  }

  @override
  String get backToGame => 'חזרה למשחק';

  @override
  String get sectionOverview => 'סקירה';

  @override
  String get sectionLetters => 'אותיות';

  @override
  String get sectionTips => 'המלצות לבית';

  @override
  String get sectionMethod => 'איך האפליקציה מלמדת';

  @override
  String get sectionSettings => 'הגדרות';

  @override
  String get statProfile => 'פרופיל';

  @override
  String get statPlayDays => 'ימי משחק';

  @override
  String get statLessons => 'שיעורים';

  @override
  String get statStars => 'כוכבים';

  @override
  String get statWords => 'מילים בתיק';

  @override
  String get statSentences => 'משפטים בספר שלי';

  @override
  String get statBadges => 'אותות';

  @override
  String get lettersLegend => '🟢 נשלטות · 🟡 בתרגול · ⚪ עוד לא נפגשו';

  @override
  String troubleWords(String letter, String words) {
    return 'מילים עם $letter שמתבלבלות: $words';
  }

  @override
  String get tipNoData => 'עדיין אין מה לתרגל. המלצות יופיעו אחרי כמה שיעורים.';

  @override
  String tipWeakest(String words) {
    return 'המילים החלשות ביותר: $words. נסו בבית למחוא כף לפי הברות ולחפש דברים שמתחילים בהן.';
  }

  @override
  String tipLetter(String letter) {
    return 'האות $letter עוד מתייצבת: חפשו יחד בבית דברים שמתחילים ב$letter.';
  }

  @override
  String get tipLongPress =>
      'לחיצה ארוכה על שיעור במפה תראה מה מתרגלים בו ולמה.';

  @override
  String methodLabel(String method) {
    return 'שיטה: $method';
  }

  @override
  String get methodText =>
      'הילד מחליק אצבע על האותיות בסדר שבו הוא שומע את ההברה או המילה. קודם הברות פתוחות (MA, TA), אחר כך מילים שלמות, סבבי האזנה בלי טקסט, סבבי השלמה וחזרה על המילים החלשות ביותר. טעות אף פעם לא חוסמת התקדמות — הכרטיס רק מזדעזע ורומז. מילים שנלמדו נכנסות מיד למשפט (בונה המשפטים) ואפשר לשמור אותן בספר שלי.';

  @override
  String get settingSounds => 'צלילים';

  @override
  String get settingAmbient => 'צלילי העולם';

  @override
  String get settingMusic => 'מוזיקה';

  @override
  String get settingLeftHanded => 'שמאלי (מקלדת הפוכה)';

  @override
  String get settingDyslexiaFont => 'גופן ידידותי לדיסלקציה (OpenDyslexic)';

  @override
  String get settingSeason => 'עונה במפה';

  @override
  String get seasonAuto => 'לפי לוח השנה';

  @override
  String get seasonSpring => 'אביב';

  @override
  String get seasonSummer => 'קיץ';

  @override
  String get seasonAutumn => 'סתיו';

  @override
  String get seasonWinter => 'חורף';

  @override
  String get settingTimeLimit => 'מגבלת זמן משחק יומית';

  @override
  String get noLimit => 'בלי מגבלה';

  @override
  String minutes(int n) {
    return '$n דק׳';
  }

  @override
  String playedToday(int played) {
    return 'שוחק היום: $played דק׳';
  }

  @override
  String playedTodayOf(int played, int limit) {
    return 'שוחק היום: $played מתוך $limit דק׳';
  }

  @override
  String get guideAsleep => ' — המדריך ישן';

  @override
  String extendToday(int n) {
    return 'הארכת היום ב־$n דק׳';
  }

  @override
  String get profilesTitle => 'פרופילים';

  @override
  String deleteProfileTitle(String name) {
    return 'למחוק את הפרופיל $name?';
  }

  @override
  String get deleteProfileBody =>
      'גם כל ההתקדמות, המדבקות והספר יימחקו. אי אפשר לבטל.';

  @override
  String get cancel => 'ביטול';

  @override
  String get delete => 'מחיקה';

  @override
  String get statMinutesToday => 'דקות היום';

  @override
  String get statMinutesWeek => 'דקות השבוע';

  @override
  String get letterMastered => 'נשלטות';

  @override
  String get letterPracticing => 'בתרגול';

  @override
  String get letterUnseen => 'עוד לא נפגשו';

  @override
  String get typeHunt => 'צליל';

  @override
  String get typeJoin => 'הברות';

  @override
  String get typeRhyme => 'חריזה';

  @override
  String get promptHunt => 'איזו אות שמעתם? הקישו עליה';

  @override
  String get promptJoin => 'חברו הברות — החליקו את המילה כולה';

  @override
  String get promptRhyme => 'מה מתחרז? הקישו על התמונה';

  @override
  String get expeditionTitle => 'משלחת חזרה';

  @override
  String get badgeExpedition => 'משלחתן';

  @override
  String get badgeExpeditionHow => 'משלחת החזרה השבועית הראשונה';

  @override
  String get seasonStickersTitle => 'מדבקות עונות';

  @override
  String get mapLoadFailed => 'לא ניתן היה לטעון את המפה';

  @override
  String get retry => 'נסו שוב';

  @override
  String get vocativeLabel => 'צורת פנייה בצ׳כית (פונה)';

  @override
  String get vocativeHint => 'למשל Lauro';

  @override
  String get guideTitle => 'המדריך שלך';

  @override
  String get petPlay => 'בואו נשחק';

  @override
  String get badgeHost => 'מארח';

  @override
  String get badgeHostHow => '10 מתנות לחיות';

  @override
  String get badgeCuddler => 'מלטף';

  @override
  String get badgeCuddlerHow => 'ליטף 5 חיות';

  @override
  String get badgeWishMaker => 'משאלה שהתגשמה';

  @override
  String get badgeWishMakerHow => '10 משאלות שהתגשמו';

  @override
  String get badgeFriendOfAll => 'חבר של כולם';

  @override
  String get badgeFriendOfAllHow => 'כל חיה קיבלה מתנה';

  @override
  String get settingPetRounds => 'מתנות לחיות: קודם לכתוב את המילה';

  @override
  String get petBowlFood => 'קערה';

  @override
  String get petBowlWater => 'מים';

  @override
  String get storeIslandA => 'אי האותיות';

  @override
  String get storeIslandB => 'אי המילים';

  @override
  String get storeIslandC => 'אי המשפטים';

  @override
  String storeProductIsland(String island, String language) {
    return '$island – $language';
  }

  @override
  String storeProductIslandDesc(String language) {
    return 'יחידות חדשות, מדבקות ותושבים בעולם החיות. שפה: $language.';
  }

  @override
  String storeProductLanguage(String language) {
    return 'שפה נוספת – $language';
  }

  @override
  String storeProductLanguageDesc(String island, String language) {
    return '$island בשפה נוספת: $language.';
  }

  @override
  String get storeProductBundle => 'הכול לתמיד';

  @override
  String get storeProductBundleDesc => 'כל האיים והשפות, גם אלה שעוד יתווספו.';

  @override
  String get storeProductParent => 'חבילת הורים';

  @override
  String get storeProductParentDesc =>
      'דפי עבודה, הדפסת הספר שלי, סקירה שבועית והעברת התקדמות.';

  @override
  String get storeStateFree => 'חינם';

  @override
  String get storeStateOwned => 'ברשותך';

  @override
  String storeBuy(String price) {
    return 'קנו ב־$price';
  }

  @override
  String get storeRestore => 'שחזור רכישות';

  @override
  String get storeDebugTitle => 'חנות (ניפוי)';

  @override
  String get storeDebugEnable => 'הדמיית חנות פעילה';

  @override
  String get storeDebugForget => 'שכחו רכישות';

  @override
  String get homeLanguageLabel => 'שפת המשפחה (תפריטים ורמזים)';

  @override
  String get homeLanguageSame => 'כמו שפת המשחק';

  @override
  String get parentPrivacy => 'מדיניות פרטיות';
}
