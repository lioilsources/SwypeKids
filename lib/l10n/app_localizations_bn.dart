// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Bengali Bangla (`bn`).
class AppLocalizationsBn extends AppLocalizations {
  AppLocalizationsBn([String locale = 'bn']) : super(locale);

  @override
  String get appTitle => 'SwypeKids';

  @override
  String get menuSyllabary => 'বর্ণমালা (সোয়াইপ)';

  @override
  String get menuSentence => 'বাক্য সাজাও';

  @override
  String get menuZoo => 'চিড়িয়াখানা';

  @override
  String get menuBook => 'আমার বই';

  @override
  String get menuParents => 'অভিভাবকদের জন্য';

  @override
  String get practiceTitle => 'অনুশীলন';

  @override
  String bedtimeText(String guide) {
    return '$guide ঘুমিয়ে পড়েছে। কাল আবার দেখা হবে!';
  }

  @override
  String get typeListen => 'শোনো';

  @override
  String get typePicture => 'ছবি';

  @override
  String get typeGap => 'পূরণ করো';

  @override
  String get typeReview => 'পুনরাবৃত্তি';

  @override
  String get typeWord => 'শব্দ';

  @override
  String get typeSyllable => 'অক্ষর-খণ্ড';

  @override
  String get promptListen => 'শুনে যা শুনলে তা সোয়াইপ করো';

  @override
  String get promptPicture => 'ছবিতে কী আছে? লেখো';

  @override
  String get promptGap => 'কোন অক্ষরটি নেই? পুরো শব্দটি সোয়াইপ করো';

  @override
  String get promptSwipeTouch => 'ছবিগুলোর ওপর আঙুল টানো';

  @override
  String get promptSwipeTrackpad => 'দুই আঙুলে ছবিগুলোর ওপর টানো';

  @override
  String get successText => 'চমৎকার!';

  @override
  String get errorText => 'আবার চেষ্টা করো!';

  @override
  String get newSticker => 'তুমি নতুন স্টিকার পেয়েছ!';

  @override
  String starsGained(int count) {
    return '+$countটি তারা';
  }

  @override
  String get backToMap => 'মানচিত্রে ফিরে যাও';

  @override
  String get winTitle => 'হয়ে গেছে!\nতুমি চ্যাম্পিয়ন!';

  @override
  String winStars(int count) {
    return 'তুমি $countটি তারা পেয়েছ!';
  }

  @override
  String get playAgain => 'আবার খেলো';

  @override
  String get builderBadge => 'বাক্য';

  @override
  String get who => 'কে';

  @override
  String get whatDoes => 'কী করে';

  @override
  String get whatWhere => 'কী / কোথায়';

  @override
  String get newLabel => 'নতুন';

  @override
  String get clear => 'মুছো';

  @override
  String get bookTitle => 'আমার বই';

  @override
  String get bookEmptyHint => 'একটি বাক্য সাজিয়ে বইয়ে রাখো';

  @override
  String get zooTitle => 'চিড়িয়াখানা';

  @override
  String badgesTitle(int earned, int total) {
    return 'ব্যাজ $earned/$total';
  }

  @override
  String get badgeFirstSwype => 'প্রথম টান';

  @override
  String get badgeFirstSwypeHow => 'প্রথম সঠিক সোয়াইপ';

  @override
  String get badgeNoMistake => 'কোনো ভুল নেই';

  @override
  String get badgeNoMistakeHow => 'পুরো ইউনিট তিন তারায়';

  @override
  String get badgeExplorer => 'অনুসন্ধানী';

  @override
  String get badgeExplorerHow => 'প্রথম স্টিকার';

  @override
  String get badgeCollectorHalf => 'সংগ্রাহক';

  @override
  String get badgeCollectorHalfHow => 'চিড়িয়াখানার অর্ধেক';

  @override
  String get badgeCollectorAll => 'বড় সংগ্রাহক';

  @override
  String get badgeCollectorAllHow => 'পুরো চিড়িয়াখানা';

  @override
  String get badgeNightOwl => 'রাতের পেঁচা';

  @override
  String get badgeNightOwlHow => 'রাতে খেলেছে';

  @override
  String get badgeEarlyBird => 'সকালের পাখি';

  @override
  String get badgeEarlyBirdHow => 'সকালে খেলেছে';

  @override
  String get badgeFourSeasons => 'চার ঋতু';

  @override
  String get badgeFourSeasonsHow => 'প্রতিটি ঋতুতে খেলেছে';

  @override
  String get badgeWordsmith10 => 'শব্দশিল্পী';

  @override
  String get badgeWordsmith10How => 'ব্যাগে ১০টি শব্দ';

  @override
  String get badgeWordsmith25 => 'বড় শব্দশিল্পী';

  @override
  String get badgeWordsmith25How => 'ব্যাগে ২৫টি শব্দ';

  @override
  String get badgeWordsmith50 => 'শব্দ-ওস্তাদ';

  @override
  String get badgeWordsmith50How => 'ব্যাগে ৫০টি শব্দ';

  @override
  String get badgePoet => 'কবি';

  @override
  String get badgePoetHow => 'আমার বইয়ে ১০টি বাক্য';

  @override
  String get badgeListener => 'শ্রোতা';

  @override
  String get badgeListenerHow => 'তিন তারায় ১০টি শোনার রাউন্ড';

  @override
  String get badgePersistent => 'অধ্যবসায়ী';

  @override
  String get badgePersistentHow => '৭টি খেলার দিন';

  @override
  String get parentTitle => 'অভিভাবকদের জন্য';

  @override
  String gateQuestion(int a, int b) {
    return '$a × $b কত?';
  }

  @override
  String get backToGame => 'খেলায় ফিরে যাও';

  @override
  String get sectionOverview => 'সারসংক্ষেপ';

  @override
  String get sectionLetters => 'অক্ষর';

  @override
  String get sectionTips => 'বাড়ির জন্য পরামর্শ';

  @override
  String get sectionMethod => 'অ্যাপ কীভাবে শেখায়';

  @override
  String get sectionSettings => 'সেটিংস';

  @override
  String get statProfile => 'প্রোফাইল';

  @override
  String get statPlayDays => 'খেলার দিন';

  @override
  String get statLessons => 'পাঠ';

  @override
  String get statStars => 'তারা';

  @override
  String get statWords => 'ব্যাগে শব্দ';

  @override
  String get statSentences => 'আমার বইয়ে বাক্য';

  @override
  String get statBadges => 'ব্যাজ';

  @override
  String get lettersLegend => '🟢 আয়ত্ত · 🟡 অনুশীলনে · ⚪ এখনো দেখা হয়নি';

  @override
  String troubleWords(String letter, String words) {
    return '$letter যুক্ত যে শব্দগুলো গুলিয়ে যায়: $words';
  }

  @override
  String get tipNoData =>
      'অনুশীলনের মতো কিছু এখনো নেই। কয়েকটি পাঠের পর পরামর্শ আসবে।';

  @override
  String tipWeakest(String words) {
    return 'সবচেয়ে দুর্বল শব্দ: $words। বাড়িতে অক্ষর-খণ্ড ধরে হাততালি দিয়ে বলুন এবং ওই দিয়ে শুরু হওয়া জিনিস খুঁজুন।';
  }

  @override
  String tipLetter(String letter) {
    return '$letter অক্ষরটি এখনো বসছে: বাড়িতে একসঙ্গে $letter দিয়ে শুরু হওয়া জিনিস খুঁজুন।';
  }

  @override
  String get tipLongPress =>
      'মানচিত্রে কোনো পাঠে চেপে ধরলে দেখা যাবে তাতে কী অনুশীলন হয় এবং কেন।';

  @override
  String methodLabel(String method) {
    return 'পদ্ধতি: $method';
  }

  @override
  String get methodText =>
      'শিশু অক্ষর-খণ্ড বা শব্দ যে ক্রমে শোনে সেই ক্রমে অক্ষরের ওপর আঙুল টানে। প্রথমে খোলা অক্ষর-খণ্ড (MA, TA), তারপর পুরো শব্দ, লেখা ছাড়া শোনার রাউন্ড, ফাঁক পূরণ এবং সবচেয়ে দুর্বল শব্দের পুনরাবৃত্তি। ভুল কখনো এগোনো আটকায় না, কার্ডটি শুধু কাঁপে ও ইঙ্গিত দেয়। শেখা শব্দ সঙ্গে সঙ্গে বাক্যে (বাক্য-নির্মাতা) বসে এবং আমার বইয়ে রাখা যায়।';

  @override
  String get settingSounds => 'শব্দ';

  @override
  String get settingAmbient => 'পরিবেশের শব্দ';

  @override
  String get settingMusic => 'সংগীত';

  @override
  String get settingLeftHanded => 'বাঁহাতি (উল্টানো কিবোর্ড)';

  @override
  String get settingDyslexiaFont => 'ডিসলেক্সিয়া-বান্ধব ফন্ট (OpenDyslexic)';

  @override
  String get settingSeason => 'মানচিত্রে ঋতু';

  @override
  String get seasonAuto => 'ক্যালেন্ডার অনুযায়ী';

  @override
  String get seasonSpring => 'বসন্ত';

  @override
  String get seasonSummer => 'গ্রীষ্ম';

  @override
  String get seasonAutumn => 'শরৎ';

  @override
  String get seasonWinter => 'শীত';

  @override
  String get settingTimeLimit => 'দৈনিক খেলার সময়সীমা';

  @override
  String get noLimit => 'সীমা নেই';

  @override
  String minutes(int n) {
    return '$n মিনিট';
  }

  @override
  String playedToday(int played) {
    return 'আজ খেলা হয়েছে: $played মিনিট';
  }

  @override
  String playedTodayOf(int played, int limit) {
    return 'আজ খেলা হয়েছে: $limit মিনিটের মধ্যে $played মিনিট';
  }

  @override
  String get guideAsleep => ' — গাইড ঘুমিয়ে আছে';

  @override
  String extendToday(int n) {
    return 'আজ $n মিনিট বাড়াও';
  }

  @override
  String get profilesTitle => 'প্রোফাইল';

  @override
  String deleteProfileTitle(String name) {
    return '$name প্রোফাইল মুছবেন?';
  }

  @override
  String get deleteProfileBody =>
      'সব অগ্রগতি, স্টিকার ও বইও মুছে যাবে। এটি ফেরানো যাবে না।';

  @override
  String get cancel => 'বাতিল';

  @override
  String get delete => 'মুছো';

  @override
  String get statMinutesToday => 'আজকের মিনিট';

  @override
  String get statMinutesWeek => 'এই সপ্তাহের মিনিট';

  @override
  String get letterMastered => 'আয়ত্ত';

  @override
  String get letterPracticing => 'অনুশীলনে';

  @override
  String get letterUnseen => 'এখনো দেখা হয়নি';

  @override
  String get typeHunt => 'ধ্বনি';

  @override
  String get typeJoin => 'অক্ষর-খণ্ড';

  @override
  String get typeRhyme => 'ছড়া';

  @override
  String get promptHunt => 'কোন অক্ষর শুনলে? সেটিতে ছোঁও';

  @override
  String get promptJoin => 'অক্ষর-খণ্ড জোড়ো — পুরো শব্দ সোয়াইপ করো';

  @override
  String get promptRhyme => 'কোনটি মেলে? ছবিতে ছোঁও';

  @override
  String get expeditionTitle => 'পুনরাবৃত্তির অভিযান';

  @override
  String get badgeExpedition => 'অভিযাত্রী';

  @override
  String get badgeExpeditionHow => 'প্রথম সাপ্তাহিক পুনরাবৃত্তি অভিযান';

  @override
  String get seasonStickersTitle => 'ঋতুর স্টিকার';

  @override
  String get mapLoadFailed => 'মানচিত্র লোড করা যায়নি';

  @override
  String get retry => 'আবার চেষ্টা করো';

  @override
  String get vocativeLabel => 'চেক ভাষায় সম্বোধনের রূপ (সম্বোধন কারক)';

  @override
  String get vocativeHint => 'যেমন Lauro';

  @override
  String get guideTitle => 'তোমার গাইড';

  @override
  String get petPlay => 'এসো খেলি';

  @override
  String get badgeHost => 'আপ্যায়ক';

  @override
  String get badgeHostHow => 'প্রাণীদের ১০টি উপহার';

  @override
  String get badgeCuddler => 'আদরকারী';

  @override
  String get badgeCuddlerHow => '৫টি প্রাণীকে আদর করেছে';

  @override
  String get badgeWishMaker => 'পূর্ণ হওয়া ইচ্ছা';

  @override
  String get badgeWishMakerHow => '১০টি ইচ্ছা পূরণ';

  @override
  String get badgeFriendOfAll => 'সবার বন্ধু';

  @override
  String get badgeFriendOfAllHow => 'প্রতিটি প্রাণী উপহার পেয়েছে';

  @override
  String get settingPetRounds => 'প্রাণীদের উপহার: আগে শব্দটি লেখো';

  @override
  String get petBowlFood => 'বাটি';

  @override
  String get petBowlWater => 'জল';

  @override
  String get storeIslandA => 'অক্ষরের দ্বীপ';

  @override
  String get storeIslandB => 'শব্দের দ্বীপ';

  @override
  String get storeIslandC => 'বাক্যের দ্বীপ';

  @override
  String storeProductIsland(String island, String language) {
    return '$island – $language';
  }

  @override
  String storeProductIslandDesc(String language) {
    return 'নতুন ইউনিট, স্টিকার ও প্রাণীজগতের বাসিন্দা। ভাষা: $language।';
  }

  @override
  String storeProductLanguage(String language) {
    return 'আরও একটি ভাষা – $language';
  }

  @override
  String storeProductLanguageDesc(String island, String language) {
    return '$island আরেকটি ভাষায়: $language।';
  }

  @override
  String get storeProductBundle => 'সব চিরকালের জন্য';

  @override
  String get storeProductBundleDesc =>
      'সব দ্বীপ ও ভাষা, যেগুলো পরে আসবে সেগুলোও।';

  @override
  String get storeProductParent => 'অভিভাবক প্যাক';

  @override
  String get storeProductParentDesc =>
      'ওয়ার্কশিট, আমার বই ছাপা, সাপ্তাহিক সারসংক্ষেপ ও অগ্রগতি স্থানান্তর।';

  @override
  String get storeStateFree => 'বিনামূল্যে';

  @override
  String get storeStateOwned => 'আছে';

  @override
  String storeBuy(String price) {
    return '$price দিয়ে কিনুন';
  }

  @override
  String get storeRestore => 'কেনা ফিরিয়ে আনুন';

  @override
  String get storeDebugTitle => 'স্টোর (ডিবাগ)';

  @override
  String get storeDebugEnable => 'চালু স্টোরের অনুকরণ';

  @override
  String get storeDebugForget => 'কেনা ভুলে যান';

  @override
  String get homeLanguageLabel => 'পরিবারের ভাষা (মেনু ও ইঙ্গিত)';

  @override
  String get homeLanguageSame => 'খেলার ভাষার মতোই';

  @override
  String get parentPrivacy => 'গোপনীয়তা নীতি';
}
