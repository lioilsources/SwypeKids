// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Urdu (`ur`).
class AppLocalizationsUr extends AppLocalizations {
  AppLocalizationsUr([String locale = 'ur']) : super(locale);

  @override
  String get appTitle => 'SwypeKids';

  @override
  String get menuSyllabary => 'حروفِ تہجی (سوائپ)';

  @override
  String get menuSentence => 'جملہ بنائیں';

  @override
  String get menuZoo => 'چڑیا گھر';

  @override
  String get menuBook => 'میری کتاب';

  @override
  String get menuParents => 'والدین کے لیے';

  @override
  String get practiceTitle => 'مشق';

  @override
  String bedtimeText(String guide) {
    return '$guide سو گیا ہے۔ کل ملیں گے!';
  }

  @override
  String get typeListen => 'سنیں';

  @override
  String get typePicture => 'تصویر';

  @override
  String get typeGap => 'مکمل کریں';

  @override
  String get typeReview => 'دہرائی';

  @override
  String get typeWord => 'لفظ';

  @override
  String get typeSyllable => 'رکن';

  @override
  String get promptListen => 'سنیں اور جو سنا اسے سوائپ کریں';

  @override
  String get promptPicture => 'تصویر میں کیا ہے؟ لکھیں';

  @override
  String get promptGap => 'کون سا حرف غائب ہے؟ پورا لفظ سوائپ کریں';

  @override
  String get promptSwipeTouch => 'تصویروں پر انگلی پھیریں';

  @override
  String get promptSwipeTrackpad => 'دو انگلیوں سے تصویروں پر پھیریں';

  @override
  String get successText => 'شاباش!';

  @override
  String get errorText => 'دوبارہ کوشش کریں!';

  @override
  String get newSticker => 'آپ کو نیا اسٹکر ملا!';

  @override
  String starsGained(int count) {
    return '+$count ستارے';
  }

  @override
  String get backToMap => 'نقشے پر واپس';

  @override
  String get winTitle => 'ہو گیا!\nآپ چیمپیئن ہیں!';

  @override
  String winStars(int count) {
    return 'آپ نے $count ستارے جیتے!';
  }

  @override
  String get playAgain => 'دوبارہ کھیلیں';

  @override
  String get builderBadge => 'جملہ';

  @override
  String get who => 'کون';

  @override
  String get whatDoes => 'کیا کرتا ہے';

  @override
  String get whatWhere => 'کیا / کہاں';

  @override
  String get newLabel => 'نیا';

  @override
  String get clear => 'مٹائیں';

  @override
  String get bookTitle => 'میری کتاب';

  @override
  String get bookEmptyHint => 'جملہ بنائیں اور کتاب میں محفوظ کریں';

  @override
  String get zooTitle => 'چڑیا گھر';

  @override
  String badgesTitle(int earned, int total) {
    return 'بیج $earned/$total';
  }

  @override
  String get badgeFirstSwype => 'پہلا سوائپ';

  @override
  String get badgeFirstSwypeHow => 'پہلا درست سوائپ';

  @override
  String get badgeNoMistake => 'بغیر غلطی';

  @override
  String get badgeNoMistakeHow => 'پوری اکائی تین ستاروں کے ساتھ';

  @override
  String get badgeExplorer => 'کھوجی';

  @override
  String get badgeExplorerHow => 'پہلا اسٹکر';

  @override
  String get badgeCollectorHalf => 'جمع کرنے والا';

  @override
  String get badgeCollectorHalfHow => 'آدھا چڑیا گھر';

  @override
  String get badgeCollectorAll => 'بڑا جمع کرنے والا';

  @override
  String get badgeCollectorAllHow => 'پورا چڑیا گھر';

  @override
  String get badgeNightOwl => 'رات کا الو';

  @override
  String get badgeNightOwlHow => 'رات کو کھیلا';

  @override
  String get badgeEarlyBird => 'صبح کا پرندہ';

  @override
  String get badgeEarlyBirdHow => 'صبح کھیلا';

  @override
  String get badgeFourSeasons => 'چار موسم';

  @override
  String get badgeFourSeasonsHow => 'ہر موسم میں کھیلا';

  @override
  String get badgeWordsmith10 => 'لفظ ساز';

  @override
  String get badgeWordsmith10How => 'تھیلے میں 10 الفاظ';

  @override
  String get badgeWordsmith25 => 'بڑا لفظ ساز';

  @override
  String get badgeWordsmith25How => 'تھیلے میں 25 الفاظ';

  @override
  String get badgeWordsmith50 => 'الفاظ کا استاد';

  @override
  String get badgeWordsmith50How => 'تھیلے میں 50 الفاظ';

  @override
  String get badgePoet => 'شاعر';

  @override
  String get badgePoetHow => 'میری کتاب میں 10 جملے';

  @override
  String get badgeListener => 'سامع';

  @override
  String get badgeListenerHow => 'تین ستاروں کے ساتھ 10 سننے کے دور';

  @override
  String get badgePersistent => 'ثابت قدم';

  @override
  String get badgePersistentHow => 'کھیلنے کے 7 دن';

  @override
  String get parentTitle => 'والدین کے لیے';

  @override
  String gateQuestion(int a, int b) {
    return '$a × $b کتنے ہوتے ہیں؟';
  }

  @override
  String get backToGame => 'کھیل پر واپس';

  @override
  String get sectionOverview => 'جائزہ';

  @override
  String get sectionLetters => 'حروف';

  @override
  String get sectionTips => 'گھر کے لیے مشورے';

  @override
  String get sectionMethod => 'ایپ کیسے سکھاتی ہے';

  @override
  String get sectionSettings => 'ترتیبات';

  @override
  String get statProfile => 'پروفائل';

  @override
  String get statPlayDays => 'کھیلنے کے دن';

  @override
  String get statLessons => 'اسباق';

  @override
  String get statStars => 'ستارے';

  @override
  String get statWords => 'تھیلے میں الفاظ';

  @override
  String get statSentences => 'میری کتاب میں جملے';

  @override
  String get statBadges => 'بیج';

  @override
  String get lettersLegend => '🟢 سیکھ لیے · 🟡 مشق میں · ⚪ ابھی نہیں ملے';

  @override
  String troubleWords(String letter, String words) {
    return '$letter والے الفاظ جو گڈمڈ ہو جاتے ہیں: $words';
  }

  @override
  String get tipNoData =>
      'مشق کے لیے ابھی کچھ نہیں — چند اسباق کے بعد مشورے ظاہر ہوں گے۔';

  @override
  String tipWeakest(String words) {
    return 'سب سے کمزور الفاظ: $words۔ گھر پر انہیں رکنوں کے حساب سے تالی بجا کر بولیں اور ان سے شروع ہونے والی چیزیں تلاش کریں۔';
  }

  @override
  String tipLetter(String letter) {
    return 'حرف $letter ابھی جم رہا ہے: گھر میں مل کر $letter سے شروع ہونے والی چیزیں ڈھونڈیں۔';
  }

  @override
  String get tipLongPress =>
      'نقشے پر کسی سبق کو دیر تک دبانے سے پتا چلتا ہے کہ اس میں کیا اور کیوں مشق ہوتی ہے۔';

  @override
  String methodLabel(String method) {
    return 'طریقہ: $method';
  }

  @override
  String get methodText =>
      'بچہ رکن یا لفظ کو جس ترتیب سے سنتا ہے اسی ترتیب سے حروف پر انگلی پھیرتا ہے۔ پہلے کھلے رکن (MA, TA)، پھر پورے الفاظ، بغیر متن کے سننے کے دور، خالی جگہ بھرنے کے دور اور سب سے کمزور الفاظ کی دہرائی۔ غلطی کبھی آگے بڑھنے سے نہیں روکتی — کارڈ بس ہلتا ہے اور اشارہ دیتا ہے۔ سیکھے ہوئے الفاظ فوراً جملے میں (جملہ ساز) استعمال ہوتے ہیں اور میری کتاب میں محفوظ کیے جا سکتے ہیں۔';

  @override
  String get settingSounds => 'آوازیں';

  @override
  String get settingAmbient => 'دنیا کی آوازیں';

  @override
  String get settingMusic => 'موسیقی';

  @override
  String get settingLeftHanded => 'بایاں ہاتھ (الٹا کی بورڈ)';

  @override
  String get settingDyslexiaFont => 'ڈسلیکسیا دوست فونٹ (OpenDyslexic)';

  @override
  String get settingSeason => 'نقشے پر موسم';

  @override
  String get seasonAuto => 'کیلنڈر کے مطابق';

  @override
  String get seasonSpring => 'بہار';

  @override
  String get seasonSummer => 'گرمی';

  @override
  String get seasonAutumn => 'خزاں';

  @override
  String get seasonWinter => 'سردی';

  @override
  String get settingTimeLimit => 'روزانہ کھیلنے کی وقت کی حد';

  @override
  String get noLimit => 'کوئی حد نہیں';

  @override
  String minutes(int n) {
    return '$n منٹ';
  }

  @override
  String playedToday(int played) {
    return 'آج کھیلا: $played منٹ';
  }

  @override
  String playedTodayOf(int played, int limit) {
    return 'آج کھیلا: $limit میں سے $played منٹ';
  }

  @override
  String get guideAsleep => ' — رہنما سو رہا ہے';

  @override
  String extendToday(int n) {
    return 'آج کو $n منٹ بڑھائیں';
  }

  @override
  String get profilesTitle => 'پروفائلز';

  @override
  String deleteProfileTitle(String name) {
    return 'پروفائل $name حذف کریں؟';
  }

  @override
  String get deleteProfileBody =>
      'تمام پیش رفت، اسٹکر اور کتاب بھی حذف ہو جائیں گے۔ اسے واپس نہیں کیا جا سکتا۔';

  @override
  String get cancel => 'منسوخ کریں';

  @override
  String get delete => 'حذف کریں';

  @override
  String get statMinutesToday => 'آج کے منٹ';

  @override
  String get statMinutesWeek => 'اس ہفتے کے منٹ';

  @override
  String get letterMastered => 'سیکھ لیے';

  @override
  String get letterPracticing => 'مشق میں';

  @override
  String get letterUnseen => 'ابھی نہیں ملے';

  @override
  String get typeHunt => 'آواز';

  @override
  String get typeJoin => 'رکن';

  @override
  String get typeRhyme => 'قافیہ';

  @override
  String get promptHunt => 'کون سا حرف سنا؟ اسے چھوئیں';

  @override
  String get promptJoin => 'رکن جوڑیں — پورا لفظ سوائپ کریں';

  @override
  String get promptRhyme => 'کس کا قافیہ ملتا ہے؟ تصویر کو چھوئیں';

  @override
  String get expeditionTitle => 'دہرائی کی مہم';

  @override
  String get badgeExpedition => 'مہم جو';

  @override
  String get badgeExpeditionHow => 'پہلی ہفتہ وار دہرائی مہم';

  @override
  String get seasonStickersTitle => 'موسموں کے اسٹکر';

  @override
  String get mapLoadFailed => 'نقشہ لوڈ نہیں ہو سکا';

  @override
  String get retry => 'دوبارہ کوشش کریں';

  @override
  String get vocativeLabel => 'چیک زبان میں مخاطب کی شکل (ندائیہ)';

  @override
  String get vocativeHint => 'مثلاً Lauro';

  @override
  String get guideTitle => 'آپ کا رہنما';

  @override
  String get petPlay => 'آؤ کھیلیں';

  @override
  String get badgeHost => 'میزبان';

  @override
  String get badgeHostHow => 'جانوروں کو 10 تحفے';

  @override
  String get badgeCuddler => 'پیار کرنے والا';

  @override
  String get badgeCuddlerHow => '5 جانوروں کو سہلایا';

  @override
  String get badgeWishMaker => 'پوری ہوئی خواہش';

  @override
  String get badgeWishMakerHow => '10 خواہشیں پوری ہوئیں';

  @override
  String get badgeFriendOfAll => 'سب کا دوست';

  @override
  String get badgeFriendOfAllHow => 'ہر جانور کو تحفہ ملا';

  @override
  String get settingPetRounds => 'جانوروں کو تحفے: پہلے لفظ لکھیں';

  @override
  String get petBowlFood => 'پیالہ';

  @override
  String get petBowlWater => 'پانی';

  @override
  String get storeIslandA => 'حروف کا جزیرہ';

  @override
  String get storeIslandB => 'الفاظ کا جزیرہ';

  @override
  String get storeIslandC => 'جملوں کا جزیرہ';

  @override
  String storeProductIsland(String island, String language) {
    return '$island – $language';
  }

  @override
  String storeProductIslandDesc(String language) {
    return 'نئی اکائیاں، اسٹکر اور جانوروں کی دنیا کے باسی۔ زبان: $language۔';
  }

  @override
  String storeProductLanguage(String language) {
    return 'ایک اور زبان – $language';
  }

  @override
  String storeProductLanguageDesc(String island, String language) {
    return '$island دوسری زبان میں: $language۔';
  }

  @override
  String get storeProductBundle => 'سب کچھ ہمیشہ کے لیے';

  @override
  String get storeProductBundleDesc => 'تمام جزیرے اور زبانیں، آنے والی بھی۔';

  @override
  String get storeProductParent => 'والدین پیک';

  @override
  String get storeProductParentDesc =>
      'ورک شیٹس، میری کتاب کی پرنٹنگ، ہفتہ وار جائزہ اور پیش رفت کی منتقلی۔';

  @override
  String get storeStateFree => 'مفت';

  @override
  String get storeStateOwned => 'آپ کے پاس ہے';

  @override
  String storeBuy(String price) {
    return '$price میں خریدیں';
  }

  @override
  String get storeRestore => 'خریداریاں بحال کریں';

  @override
  String get storeDebugTitle => 'اسٹور (ڈی بگ)';

  @override
  String get storeDebugEnable => 'فعال اسٹور کی نقل';

  @override
  String get storeDebugForget => 'خریداریاں بھلا دیں';

  @override
  String get homeLanguageLabel => 'خاندان کی زبان (مینو اور اشارے)';

  @override
  String get homeLanguageSame => 'کھیل کی زبان جیسی ہی';

  @override
  String get parentPrivacy => 'رازداری کی پالیسی';
}
