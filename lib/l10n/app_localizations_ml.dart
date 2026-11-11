// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Malayalam (`ml`).
class AppLocalizationsMl extends AppLocalizations {
  AppLocalizationsMl([String locale = 'ml']) : super(locale);

  @override
  String get appTitle => 'SwypeKids';

  @override
  String get menuSyllabary => 'അക്ഷരമാല (സ്വൈപ്പ്)';

  @override
  String get menuSentence => 'വാക്യം ഉണ്ടാക്കൂ';

  @override
  String get menuZoo => 'മൃഗശാല';

  @override
  String get menuBook => 'എന്റെ പുസ്തകം';

  @override
  String get menuParents => 'മാതാപിതാക്കൾക്ക്';

  @override
  String get practiceTitle => 'പരിശീലനം';

  @override
  String bedtimeText(String guide) {
    return '$guide ഉറങ്ങുകയാണ്. നാളെ കാണാം!';
  }

  @override
  String get typeListen => 'കേൾക്കൂ';

  @override
  String get typePicture => 'ചിത്രം';

  @override
  String get typeGap => 'പൂരിപ്പിക്കൂ';

  @override
  String get typeReview => 'ആവർത്തനം';

  @override
  String get typeWord => 'വാക്ക്';

  @override
  String get typeSyllable => 'അക്ഷരഖണ്ഡം';

  @override
  String get promptListen => 'കേട്ടത് സ്വൈപ്പ് ചെയ്യൂ';

  @override
  String get promptPicture => 'ചിത്രത്തിൽ എന്താണ്? എഴുതൂ';

  @override
  String get promptGap =>
      'ഏത് അക്ഷരമാണ് വിട്ടുപോയത്? മുഴുവൻ വാക്കും സ്വൈപ്പ് ചെയ്യൂ';

  @override
  String get promptSwipeTouch => 'ചിത്രങ്ങൾക്ക് മേൽ വിരൽ നീക്കൂ';

  @override
  String get promptSwipeTrackpad =>
      'രണ്ട് വിരലുകൾ കൊണ്ട് ചിത്രങ്ങൾക്ക് മേൽ നീക്കൂ';

  @override
  String get successText => 'ശബാഷ്!';

  @override
  String get errorText => 'ഒന്നുകൂടി ശ്രമിക്കൂ!';

  @override
  String get newSticker => 'നിനക്ക് പുതിയ സ്റ്റിക്കർ കിട്ടി!';

  @override
  String starsGained(int count) {
    return '+$count നക്ഷത്രങ്ങൾ';
  }

  @override
  String get backToMap => 'ഭൂപടത്തിലേക്ക് മടങ്ങൂ';

  @override
  String get winTitle => 'കഴിഞ്ഞു!\nനീ ചാമ്പ്യനാണ്!';

  @override
  String winStars(int count) {
    return 'നിനക്ക് $count നക്ഷത്രങ്ങൾ കിട്ടി!';
  }

  @override
  String get playAgain => 'വീണ്ടും കളിക്കൂ';

  @override
  String get builderBadge => 'വാക്യം';

  @override
  String get who => 'ആര്';

  @override
  String get whatDoes => 'എന്ത് ചെയ്യുന്നു';

  @override
  String get whatWhere => 'എന്ത് / എവിടേക്ക്';

  @override
  String get newLabel => 'പുതിയത്';

  @override
  String get clear => 'മായ്ക്കൂ';

  @override
  String get bookTitle => 'എന്റെ പുസ്തകം';

  @override
  String get bookEmptyHint => 'ഒരു വാക്യം ഉണ്ടാക്കി പുസ്തകത്തിൽ സൂക്ഷിക്കൂ';

  @override
  String get zooTitle => 'മൃഗശാല';

  @override
  String badgesTitle(int earned, int total) {
    return 'ബാഡ്ജുകൾ $earned/$total';
  }

  @override
  String get badgeFirstSwype => 'ആദ്യ സ്വൈപ്പ്';

  @override
  String get badgeFirstSwypeHow => 'ആദ്യത്തെ ശരിയായ സ്വൈപ്പ്';

  @override
  String get badgeNoMistake => 'തെറ്റില്ലാതെ';

  @override
  String get badgeNoMistakeHow => 'ഒരു മുഴുവൻ യൂണിറ്റ് മൂന്ന് നക്ഷത്രങ്ങളോടെ';

  @override
  String get badgeExplorer => 'പര്യവേക്ഷകൻ';

  @override
  String get badgeExplorerHow => 'ആദ്യ സ്റ്റിക്കർ';

  @override
  String get badgeCollectorHalf => 'ശേഖരിക്കുന്നവൻ';

  @override
  String get badgeCollectorHalfHow => 'മൃഗശാലയുടെ പകുതി';

  @override
  String get badgeCollectorAll => 'വലിയ ശേഖരിക്കുന്നവൻ';

  @override
  String get badgeCollectorAllHow => 'മുഴുവൻ മൃഗശാല';

  @override
  String get badgeNightOwl => 'രാത്രി മൂങ്ങ';

  @override
  String get badgeNightOwlHow => 'രാത്രി കളിച്ചു';

  @override
  String get badgeEarlyBird => 'പുലർകാല പക്ഷി';

  @override
  String get badgeEarlyBirdHow => 'രാവിലെ കളിച്ചു';

  @override
  String get badgeFourSeasons => 'നാല് ഋതുക്കൾ';

  @override
  String get badgeFourSeasonsHow => 'എല്ലാ ഋതുവിലും കളിച്ചു';

  @override
  String get badgeWordsmith10 => 'വാക്ക് ശിൽപി';

  @override
  String get badgeWordsmith10How => 'ബാഗിൽ 10 വാക്കുകൾ';

  @override
  String get badgeWordsmith25 => 'വലിയ വാക്ക് ശിൽപി';

  @override
  String get badgeWordsmith25How => 'ബാഗിൽ 25 വാക്കുകൾ';

  @override
  String get badgeWordsmith50 => 'വാക്കുകളുടെ ഗുരു';

  @override
  String get badgeWordsmith50How => 'ബാഗിൽ 50 വാക്കുകൾ';

  @override
  String get badgePoet => 'കവി';

  @override
  String get badgePoetHow => 'എന്റെ പുസ്തകത്തിൽ 10 വാക്യങ്ങൾ';

  @override
  String get badgeListener => 'കേൾവിക്കാരൻ';

  @override
  String get badgeListenerHow => 'മൂന്ന് നക്ഷത്രങ്ങളോടെ 10 കേൾക്കൽ റൗണ്ടുകൾ';

  @override
  String get badgePersistent => 'സ്ഥിരോത്സാഹി';

  @override
  String get badgePersistentHow => '7 കളി ദിവസങ്ങൾ';

  @override
  String get parentTitle => 'മാതാപിതാക്കൾക്ക്';

  @override
  String gateQuestion(int a, int b) {
    return '$a × $b എത്രയാണ്?';
  }

  @override
  String get backToGame => 'കളിയിലേക്ക് മടങ്ങൂ';

  @override
  String get sectionOverview => 'അവലോകനം';

  @override
  String get sectionLetters => 'അക്ഷരങ്ങൾ';

  @override
  String get sectionTips => 'വീടിനുള്ള നിർദ്ദേശങ്ങൾ';

  @override
  String get sectionMethod => 'ആപ്പ് എങ്ങനെ പഠിപ്പിക്കുന്നു';

  @override
  String get sectionSettings => 'ക്രമീകരണങ്ങൾ';

  @override
  String get statProfile => 'പ്രൊഫൈൽ';

  @override
  String get statPlayDays => 'കളി ദിവസങ്ങൾ';

  @override
  String get statLessons => 'പാഠങ്ങൾ';

  @override
  String get statStars => 'നക്ഷത്രങ്ങൾ';

  @override
  String get statWords => 'ബാഗിലെ വാക്കുകൾ';

  @override
  String get statSentences => 'എന്റെ പുസ്തകത്തിലെ വാക്യങ്ങൾ';

  @override
  String get statBadges => 'ബാഡ്ജുകൾ';

  @override
  String get lettersLegend =>
      '🟢 വഴങ്ങി · 🟡 പരിശീലനത്തിൽ · ⚪ ഇതുവരെ കണ്ടിട്ടില്ല';

  @override
  String troubleWords(String letter, String words) {
    return '$letter ഉള്ള, കൂടിക്കുഴയുന്ന വാക്കുകൾ: $words';
  }

  @override
  String get tipNoData =>
      'പരിശീലിക്കാൻ ഇതുവരെ ഒന്നുമില്ല — കുറച്ച് പാഠങ്ങൾക്ക് ശേഷം നിർദ്ദേശങ്ങൾ വരും.';

  @override
  String tipWeakest(String words) {
    return 'ഏറ്റവും ദുർബലമായ വാക്കുകൾ: $words. വീട്ടിൽ അവ അക്ഷരഖണ്ഡങ്ങളായി കൈകൊട്ടി പറയൂ, അതിൽ തുടങ്ങുന്ന വസ്തുക്കൾ കണ്ടെത്തൂ.';
  }

  @override
  String tipLetter(String letter) {
    return '$letter എന്ന അക്ഷരം ഇപ്പോഴും ഉറയ്ക്കുന്നു: വീട്ടിൽ $letter കൊണ്ട് തുടങ്ങുന്ന വസ്തുക്കൾ ഒന്നിച്ച് തിരയൂ.';
  }

  @override
  String get tipLongPress =>
      'ഭൂപടത്തിൽ ഒരു പാഠം ദീർഘനേരം അമർത്തിയാൽ അതിൽ എന്ത്, എന്തിന് പരിശീലിക്കുന്നു എന്ന് കാണാം.';

  @override
  String methodLabel(String method) {
    return 'രീതി: $method';
  }

  @override
  String get methodText =>
      'കുട്ടി അക്ഷരഖണ്ഡമോ വാക്കോ കേൾക്കുന്ന ക്രമത്തിൽ അക്ഷരങ്ങൾക്ക് മേൽ വിരൽ നീക്കുന്നു. ആദ്യം തുറന്ന അക്ഷരഖണ്ഡങ്ങൾ (MA, TA), പിന്നെ മുഴുവൻ വാക്കുകൾ, എഴുത്തില്ലാത്ത കേൾക്കൽ റൗണ്ടുകൾ, വിട്ടുപോയത് പൂരിപ്പിക്കൽ റൗണ്ടുകൾ, ഏറ്റവും ദുർബലമായ വാക്കുകളുടെ ആവർത്തനം. തെറ്റ് ഒരിക്കലും പുരോഗതി തടയില്ല — കാർഡ് ഒന്ന് കുലുങ്ങി സൂചന നൽകും. പഠിച്ച വാക്കുകൾ ഉടൻ വാക്യത്തിൽ (വാക്യ നിർമ്മാതാവ്) ഉപയോഗിക്കുകയും എന്റെ പുസ്തകത്തിൽ സൂക്ഷിക്കുകയും ചെയ്യാം.';

  @override
  String get settingSounds => 'ശബ്ദങ്ങൾ';

  @override
  String get settingAmbient => 'ലോകത്തിന്റെ ശബ്ദങ്ങൾ';

  @override
  String get settingMusic => 'സംഗീതം';

  @override
  String get settingLeftHanded => 'ഇടംകൈയൻ (പ്രതിബിംബ കീബോർഡ്)';

  @override
  String get settingDyslexiaFont => 'ഡിസ്ലെക്സിയ സൗഹൃദ ഫോണ്ട് (OpenDyslexic)';

  @override
  String get settingSeason => 'ഭൂപടത്തിലെ ഋതു';

  @override
  String get seasonAuto => 'കലണ്ടർ അനുസരിച്ച്';

  @override
  String get seasonSpring => 'വസന്തം';

  @override
  String get seasonSummer => 'വേനൽ';

  @override
  String get seasonAutumn => 'ശരത്';

  @override
  String get seasonWinter => 'ശിശിരം';

  @override
  String get settingTimeLimit => 'ദിവസേനയുള്ള കളി സമയ പരിധി';

  @override
  String get noLimit => 'പരിധിയില്ല';

  @override
  String minutes(int n) {
    return '$n മിനിറ്റ്';
  }

  @override
  String playedToday(int played) {
    return 'ഇന്ന് കളിച്ചത്: $played മിനിറ്റ്';
  }

  @override
  String playedTodayOf(int played, int limit) {
    return 'ഇന്ന് കളിച്ചത്: $limit ൽ $played മിനിറ്റ്';
  }

  @override
  String get guideAsleep => ' — വഴികാട്ടി ഉറങ്ങുന്നു';

  @override
  String extendToday(int n) {
    return 'ഇന്ന് $n മിനിറ്റ് നീട്ടൂ';
  }

  @override
  String get profilesTitle => 'പ്രൊഫൈലുകൾ';

  @override
  String deleteProfileTitle(String name) {
    return '$name പ്രൊഫൈൽ ഇല്ലാതാക്കണോ?';
  }

  @override
  String get deleteProfileBody =>
      'എല്ലാ പുരോഗതിയും സ്റ്റിക്കറുകളും പുസ്തകവും ഇല്ലാതാകും. ഇത് തിരികെ കിട്ടില്ല.';

  @override
  String get cancel => 'റദ്ദാക്കൂ';

  @override
  String get delete => 'ഇല്ലാതാക്കൂ';

  @override
  String get statMinutesToday => 'ഇന്നത്തെ മിനിറ്റുകൾ';

  @override
  String get statMinutesWeek => 'ഈ ആഴ്ചയിലെ മിനിറ്റുകൾ';

  @override
  String get letterMastered => 'വഴങ്ങി';

  @override
  String get letterPracticing => 'പരിശീലനത്തിൽ';

  @override
  String get letterUnseen => 'ഇതുവരെ കണ്ടിട്ടില്ല';

  @override
  String get typeHunt => 'ശബ്ദം';

  @override
  String get typeJoin => 'അക്ഷരഖണ്ഡങ്ങൾ';

  @override
  String get typeRhyme => 'പ്രാസം';

  @override
  String get promptHunt => 'ഏത് അക്ഷരമാണ് കേട്ടത്? അതിൽ തൊടൂ';

  @override
  String get promptJoin =>
      'അക്ഷരഖണ്ഡങ്ങൾ ചേർക്കൂ — മുഴുവൻ വാക്കും സ്വൈപ്പ് ചെയ്യൂ';

  @override
  String get promptRhyme => 'ഏതിനാണ് പ്രാസം? ചിത്രത്തിൽ തൊടൂ';

  @override
  String get expeditionTitle => 'ആവർത്തന യാത്ര';

  @override
  String get badgeExpedition => 'യാത്രികൻ';

  @override
  String get badgeExpeditionHow => 'ആദ്യ ആഴ്ചതോറുമുള്ള ആവർത്തന യാത്ര';

  @override
  String get seasonStickersTitle => 'ഋതു സ്റ്റിക്കറുകൾ';

  @override
  String get mapLoadFailed => 'ഭൂപടം ലോഡ് ചെയ്യാനായില്ല';

  @override
  String get retry => 'വീണ്ടും ശ്രമിക്കൂ';

  @override
  String get vocativeLabel => 'ചെക്ക് ഭാഷയിലെ സംബോധനാ രൂപം (സംബോധന)';

  @override
  String get vocativeHint => 'ഉദാ. Lauro';

  @override
  String get guideTitle => 'നിന്റെ വഴികാട്ടി';

  @override
  String get petPlay => 'വരൂ കളിക്കാം';

  @override
  String get badgeHost => 'ആതിഥേയൻ';

  @override
  String get badgeHostHow => 'മൃഗങ്ങൾക്ക് 10 സമ്മാനങ്ങൾ';

  @override
  String get badgeCuddler => 'ലാളിക്കുന്നവൻ';

  @override
  String get badgeCuddlerHow => '5 മൃഗങ്ങളെ തലോടി';

  @override
  String get badgeWishMaker => 'സഫലമായ ആഗ്രഹം';

  @override
  String get badgeWishMakerHow => '10 ആഗ്രഹങ്ങൾ സഫലമായി';

  @override
  String get badgeFriendOfAll => 'എല്ലാവരുടെയും കൂട്ടുകാരൻ';

  @override
  String get badgeFriendOfAllHow => 'ഓരോ മൃഗത്തിനും സമ്മാനം കിട്ടി';

  @override
  String get settingPetRounds => 'മൃഗങ്ങൾക്ക് സമ്മാനം: ആദ്യം വാക്ക് എഴുതൂ';

  @override
  String get petBowlFood => 'പാത്രം';

  @override
  String get petBowlWater => 'വെള്ളം';

  @override
  String get storeIslandA => 'അക്ഷര ദ്വീപ്';

  @override
  String get storeIslandB => 'വാക്ക് ദ്വീപ്';

  @override
  String get storeIslandC => 'വാക്യ ദ്വീപ്';

  @override
  String storeProductIsland(String island, String language) {
    return '$island – $language';
  }

  @override
  String storeProductIslandDesc(String language) {
    return 'പുതിയ യൂണിറ്റുകൾ, സ്റ്റിക്കറുകൾ, മൃഗലോകത്തെ താമസക്കാർ. ഭാഷ: $language.';
  }

  @override
  String storeProductLanguage(String language) {
    return 'മറ്റൊരു ഭാഷ – $language';
  }

  @override
  String storeProductLanguageDesc(String island, String language) {
    return '$island മറ്റൊരു ഭാഷയിൽ: $language.';
  }

  @override
  String get storeProductBundle => 'എല്ലാം എന്നെന്നേക്കുമായി';

  @override
  String get storeProductBundleDesc =>
      'എല്ലാ ദ്വീപുകളും ഭാഷകളും, വരാനിരിക്കുന്നവയും.';

  @override
  String get storeProductParent => 'മാതാപിതാക്കളുടെ പാക്ക്';

  @override
  String get storeProductParentDesc =>
      'വർക്ക്ഷീറ്റുകൾ, എന്റെ പുസ്തകത്തിന്റെ പ്രിന്റ്, ആഴ്ചതോറുമുള്ള അവലോകനം, പുരോഗതി കൈമാറ്റം.';

  @override
  String get storeStateFree => 'സൗജന്യം';

  @override
  String get storeStateOwned => 'നിങ്ങളുടെ പക്കലുണ്ട്';

  @override
  String storeBuy(String price) {
    return '$price ന് വാങ്ങൂ';
  }

  @override
  String get storeRestore => 'വാങ്ങലുകൾ പുനഃസ്ഥാപിക്കൂ';

  @override
  String get storeDebugTitle => 'സ്റ്റോർ (ഡീബഗ്)';

  @override
  String get storeDebugEnable => 'സജീവമായ സ്റ്റോറിന്റെ അനുകരണം';

  @override
  String get storeDebugForget => 'വാങ്ങലുകൾ മറക്കൂ';

  @override
  String get homeLanguageLabel => 'കുടുംബത്തിന്റെ ഭാഷ (മെനുവും സൂചനകളും)';

  @override
  String get homeLanguageSame => 'കളിയുടെ ഭാഷ തന്നെ';

  @override
  String get parentPrivacy => 'സ്വകാര്യതാ നയം';
}
