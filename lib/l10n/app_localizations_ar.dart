// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appTitle => 'SwypeKids';

  @override
  String get menuSyllabary => 'الأبجدية (سوايب)';

  @override
  String get menuSentence => 'ركّب جملة';

  @override
  String get menuZoo => 'حديقة الحيوان';

  @override
  String get menuBook => 'كتابي';

  @override
  String get menuParents => 'للأهل';

  @override
  String get practiceTitle => 'تدريب';

  @override
  String bedtimeText(String guide) {
    return '$guide نائم الآن. إلى اللقاء غدًا!';
  }

  @override
  String get typeListen => 'استماع';

  @override
  String get typePicture => 'صورة';

  @override
  String get typeGap => 'أكمل';

  @override
  String get typeReview => 'مراجعة';

  @override
  String get typeWord => 'كلمة';

  @override
  String get typeSyllable => 'مقطع';

  @override
  String get promptListen => 'استمع وامسح بإصبعك ما تسمعه';

  @override
  String get promptPicture => 'ما الذي في الصورة؟ اكتبه';

  @override
  String get promptGap => 'أي حرف ناقص؟ امسح الكلمة كاملة';

  @override
  String get promptSwipeTouch => 'مرّر إصبعك على الصور';

  @override
  String get promptSwipeTrackpad => 'مرّر إصبعين على الصور';

  @override
  String get successText => 'أحسنت!';

  @override
  String get errorText => 'حاول مرة أخرى!';

  @override
  String get newSticker => 'حصلت على ملصق جديد!';

  @override
  String starsGained(int count) {
    return '+$count نجوم';
  }

  @override
  String get backToMap => 'العودة إلى الخريطة';

  @override
  String get winTitle => 'تمّ!\nأنت بطل!';

  @override
  String winStars(int count) {
    return 'ربحت $count نجوم!';
  }

  @override
  String get playAgain => 'العب من جديد';

  @override
  String get builderBadge => 'جملة';

  @override
  String get who => 'مَن';

  @override
  String get whatDoes => 'ماذا يفعل';

  @override
  String get whatWhere => 'ماذا / أين';

  @override
  String get newLabel => 'جديد';

  @override
  String get clear => 'مسح';

  @override
  String get bookTitle => 'كتابي';

  @override
  String get bookEmptyHint => 'ركّب جملة واحفظها في الكتاب';

  @override
  String get zooTitle => 'حديقة الحيوان';

  @override
  String badgesTitle(int earned, int total) {
    return 'الأوسمة $earned/$total';
  }

  @override
  String get badgeFirstSwype => 'أول مسحة';

  @override
  String get badgeFirstSwypeHow => 'أول مسحة صحيحة';

  @override
  String get badgeNoMistake => 'بلا أخطاء';

  @override
  String get badgeNoMistakeHow => 'وحدة كاملة بثلاث نجوم';

  @override
  String get badgeExplorer => 'مستكشف';

  @override
  String get badgeExplorerHow => 'أول ملصق';

  @override
  String get badgeCollectorHalf => 'جامع';

  @override
  String get badgeCollectorHalfHow => 'نصف حديقة الحيوان';

  @override
  String get badgeCollectorAll => 'جامع كبير';

  @override
  String get badgeCollectorAllHow => 'حديقة الحيوان كاملة';

  @override
  String get badgeNightOwl => 'بومة الليل';

  @override
  String get badgeNightOwlHow => 'لعبت ليلًا';

  @override
  String get badgeEarlyBird => 'طائر الصباح';

  @override
  String get badgeEarlyBirdHow => 'لعبت صباحًا';

  @override
  String get badgeFourSeasons => 'الفصول الأربعة';

  @override
  String get badgeFourSeasonsHow => 'لعبت في كل فصل';

  @override
  String get badgeWordsmith10 => 'صانع كلمات';

  @override
  String get badgeWordsmith10How => '10 كلمات في الحقيبة';

  @override
  String get badgeWordsmith25 => 'صانع كلمات كبير';

  @override
  String get badgeWordsmith25How => '25 كلمة في الحقيبة';

  @override
  String get badgeWordsmith50 => 'سيد الكلمات';

  @override
  String get badgeWordsmith50How => '50 كلمة في الحقيبة';

  @override
  String get badgePoet => 'شاعر';

  @override
  String get badgePoetHow => '10 جمل في كتابي';

  @override
  String get badgeListener => 'مستمع';

  @override
  String get badgeListenerHow => '10 جولات استماع بثلاث نجوم';

  @override
  String get badgePersistent => 'مثابر';

  @override
  String get badgePersistentHow => '7 أيام لعب';

  @override
  String get parentTitle => 'للأهل';

  @override
  String gateQuestion(int a, int b) {
    return 'كم يساوي $a × $b؟';
  }

  @override
  String get backToGame => 'العودة إلى اللعبة';

  @override
  String get sectionOverview => 'نظرة عامة';

  @override
  String get sectionLetters => 'الحروف';

  @override
  String get sectionTips => 'نصائح للبيت';

  @override
  String get sectionMethod => 'كيف يعلّم التطبيق';

  @override
  String get sectionSettings => 'الإعدادات';

  @override
  String get statProfile => 'الملف';

  @override
  String get statPlayDays => 'أيام لعب';

  @override
  String get statLessons => 'دروس';

  @override
  String get statStars => 'نجوم';

  @override
  String get statWords => 'كلمات في الحقيبة';

  @override
  String get statSentences => 'جمل في كتابي';

  @override
  String get statBadges => 'أوسمة';

  @override
  String get lettersLegend => '🟢 متقنة · 🟡 قيد التدريب · ⚪ لم تُصادَف بعد';

  @override
  String troubleWords(String letter, String words) {
    return 'كلمات فيها $letter يختلط أمرها: $words';
  }

  @override
  String get tipNoData => 'لا شيء للتدريب بعد، ستظهر النصائح بعد بضعة دروس.';

  @override
  String tipWeakest(String words) {
    return 'أضعف الكلمات: $words. جرّبوا في البيت أن تصفقوا لمقاطعها وأن تبحثوا عن أشياء تبدأ بها.';
  }

  @override
  String tipLetter(String letter) {
    return 'الحرف $letter ما زال يثبت: ابحثوا معًا في البيت عن أشياء تبدأ بالحرف $letter.';
  }

  @override
  String get tipLongPress =>
      'الضغط المطوّل على درس في الخريطة يُظهر ما يتدرّب عليه ولماذا.';

  @override
  String methodLabel(String method) {
    return 'الطريقة: $method';
  }

  @override
  String get methodText =>
      'يمرّر الطفل إصبعه على الحروف بالترتيب الذي يسمع به المقطع أو الكلمة. أولًا المقاطع المفتوحة (MA, TA)، ثم الكلمات الكاملة، وجولات الاستماع بلا نص، وجولات إكمال الفراغ، ومراجعة أضعف الكلمات. الخطأ لا يوقف التقدّم أبدًا، فالبطاقة تهتز وتلمّح فقط. الكلمات التي تعلّمها تدخل فورًا في جملة (مركّب الجمل) ويمكن حفظها في كتابي.';

  @override
  String get settingSounds => 'الأصوات';

  @override
  String get settingAmbient => 'أصوات العالم';

  @override
  String get settingMusic => 'الموسيقى';

  @override
  String get settingLeftHanded => 'أعسر (لوحة مفاتيح معكوسة)';

  @override
  String get settingDyslexiaFont => 'خط مناسب لعسر القراءة (OpenDyslexic)';

  @override
  String get settingSeason => 'الفصل على الخريطة';

  @override
  String get seasonAuto => 'حسب التقويم';

  @override
  String get seasonSpring => 'الربيع';

  @override
  String get seasonSummer => 'الصيف';

  @override
  String get seasonAutumn => 'الخريف';

  @override
  String get seasonWinter => 'الشتاء';

  @override
  String get settingTimeLimit => 'حدّ وقت اللعب اليومي';

  @override
  String get noLimit => 'بلا حدّ';

  @override
  String minutes(int n) {
    return '$n د';
  }

  @override
  String playedToday(int played) {
    return 'لُعب اليوم: $played د';
  }

  @override
  String playedTodayOf(int played, int limit) {
    return 'لُعب اليوم: $played من $limit د';
  }

  @override
  String get guideAsleep => ' — المرشد نائم';

  @override
  String extendToday(int n) {
    return 'مدّد اليوم $n د';
  }

  @override
  String get profilesTitle => 'الملفات';

  @override
  String deleteProfileTitle(String name) {
    return 'حذف الملف $name؟';
  }

  @override
  String get deleteProfileBody =>
      'سيُحذف كل التقدّم والملصقات والكتاب أيضًا. لا يمكن التراجع.';

  @override
  String get cancel => 'إلغاء';

  @override
  String get delete => 'حذف';

  @override
  String get statMinutesToday => 'دقائق اليوم';

  @override
  String get statMinutesWeek => 'دقائق هذا الأسبوع';

  @override
  String get letterMastered => 'متقنة';

  @override
  String get letterPracticing => 'قيد التدريب';

  @override
  String get letterUnseen => 'لم تُصادَف بعد';

  @override
  String get typeHunt => 'صوت';

  @override
  String get typeJoin => 'مقاطع';

  @override
  String get typeRhyme => 'قافية';

  @override
  String get promptHunt => 'أي حرف سمعت؟ المسه';

  @override
  String get promptJoin => 'اجمع المقاطع وامسح الكلمة كاملة';

  @override
  String get promptRhyme => 'ما الذي يقفّي؟ المس الصورة';

  @override
  String get expeditionTitle => 'رحلة المراجعة';

  @override
  String get badgeExpedition => 'رحّالة';

  @override
  String get badgeExpeditionHow => 'أول رحلة مراجعة أسبوعية';

  @override
  String get seasonStickersTitle => 'ملصقات الفصول';

  @override
  String get mapLoadFailed => 'تعذّر تحميل الخريطة';

  @override
  String get retry => 'حاول مجددًا';

  @override
  String get vocativeLabel => 'صيغة المناداة بالتشيكية (النداء)';

  @override
  String get vocativeHint => 'مثل: Lauro';

  @override
  String get guideTitle => 'مرشدك';

  @override
  String get petPlay => 'هيا نلعب';

  @override
  String get badgeHost => 'مضيف';

  @override
  String get badgeHostHow => '10 هدايا للحيوانات';

  @override
  String get badgeCuddler => 'محبّ للمداعبة';

  @override
  String get badgeCuddlerHow => 'داعب 5 حيوانات';

  @override
  String get badgeWishMaker => 'أمنية تحققت';

  @override
  String get badgeWishMakerHow => '10 أمنيات تحققت';

  @override
  String get badgeFriendOfAll => 'صديق الجميع';

  @override
  String get badgeFriendOfAllHow => 'كل حيوان تلقّى هدية';

  @override
  String get settingPetRounds => 'هدايا الحيوانات: اكتب الكلمة أولًا';

  @override
  String get petBowlFood => 'وعاء';

  @override
  String get petBowlWater => 'ماء';

  @override
  String get storeIslandA => 'جزيرة الحروف';

  @override
  String get storeIslandB => 'جزيرة الكلمات';

  @override
  String get storeIslandC => 'جزيرة الجمل';

  @override
  String storeProductIsland(String island, String language) {
    return '$island – $language';
  }

  @override
  String storeProductIslandDesc(String language) {
    return 'وحدات وملصقات وسكان جدد لعالم الحيوانات. اللغة: $language.';
  }

  @override
  String storeProductLanguage(String language) {
    return 'لغة أخرى – $language';
  }

  @override
  String storeProductLanguageDesc(String island, String language) {
    return '$island بلغة أخرى: $language.';
  }

  @override
  String get storeProductBundle => 'كل شيء إلى الأبد';

  @override
  String get storeProductBundleDesc =>
      'كل الجزر واللغات، حتى التي ستُضاف لاحقًا.';

  @override
  String get storeProductParent => 'حزمة الأهل';

  @override
  String get storeProductParentDesc =>
      'أوراق عمل وطباعة كتابي وملخص أسبوعي ونقل التقدّم.';

  @override
  String get storeStateFree => 'مجانًا';

  @override
  String get storeStateOwned => 'مملوك';

  @override
  String storeBuy(String price) {
    return 'اشترِ بـ $price';
  }

  @override
  String get storeRestore => 'استعادة المشتريات';

  @override
  String get storeDebugTitle => 'المتجر (تصحيح)';

  @override
  String get storeDebugEnable => 'محاكاة متجر مفعّل';

  @override
  String get storeDebugForget => 'نسيان المشتريات';

  @override
  String get homeLanguageLabel => 'لغة العائلة (القوائم والتلميحات)';

  @override
  String get homeLanguageSame => 'نفس لغة اللعبة';

  @override
  String get parentPrivacy => 'سياسة الخصوصية';
}
