// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Tamil (`ta`).
class AppLocalizationsTa extends AppLocalizations {
  AppLocalizationsTa([String locale = 'ta']) : super(locale);

  @override
  String get appTitle => 'SwypeKids';

  @override
  String get menuSyllabary => 'எழுத்து வரிசை (ஸ்வைப்)';

  @override
  String get menuSentence => 'வாக்கியம் அமை';

  @override
  String get menuZoo => 'மிருகக்காட்சிசாலை';

  @override
  String get menuBook => 'என் புத்தகம்';

  @override
  String get menuParents => 'பெற்றோருக்கு';

  @override
  String get practiceTitle => 'பயிற்சி';

  @override
  String bedtimeText(String guide) {
    return '$guide தூங்குகிறது. நாளை சந்திப்போம்!';
  }

  @override
  String get typeListen => 'கேள்';

  @override
  String get typePicture => 'படம்';

  @override
  String get typeGap => 'நிரப்பு';

  @override
  String get typeReview => 'மீள்பார்வை';

  @override
  String get typeWord => 'சொல்';

  @override
  String get typeSyllable => 'அசை';

  @override
  String get promptListen => 'கேட்டு, கேட்டதை ஸ்வைப் செய்';

  @override
  String get promptPicture => 'படத்தில் என்ன இருக்கிறது? எழுது';

  @override
  String get promptGap =>
      'எந்த எழுத்து விடுபட்டது? முழுச் சொல்லையும் ஸ்வைப் செய்';

  @override
  String get promptSwipeTouch => 'படங்கள் மேல் விரலை நகர்த்து';

  @override
  String get promptSwipeTrackpad => 'இரண்டு விரல்களால் படங்கள் மேல் நகர்த்து';

  @override
  String get successText => 'அருமை!';

  @override
  String get errorText => 'மீண்டும் முயற்சி செய்!';

  @override
  String get newSticker => 'உனக்குப் புதிய ஸ்டிக்கர் கிடைத்தது!';

  @override
  String starsGained(int count) {
    return '+$count நட்சத்திரங்கள்';
  }

  @override
  String get backToMap => 'வரைபடத்துக்குத் திரும்பு';

  @override
  String get winTitle => 'முடிந்தது!\nநீ சாம்பியன்!';

  @override
  String winStars(int count) {
    return 'நீ $count நட்சத்திரங்கள் பெற்றாய்!';
  }

  @override
  String get playAgain => 'மீண்டும் விளையாடு';

  @override
  String get builderBadge => 'வாக்கியம்';

  @override
  String get who => 'யார்';

  @override
  String get whatDoes => 'என்ன செய்கிறது';

  @override
  String get whatWhere => 'என்ன / எங்கே';

  @override
  String get newLabel => 'புதியது';

  @override
  String get clear => 'அழி';

  @override
  String get bookTitle => 'என் புத்தகம்';

  @override
  String get bookEmptyHint => 'ஒரு வாக்கியத்தை அமைத்துப் புத்தகத்தில் சேமி';

  @override
  String get zooTitle => 'மிருகக்காட்சிசாலை';

  @override
  String badgesTitle(int earned, int total) {
    return 'பேட்ஜ்கள் $earned/$total';
  }

  @override
  String get badgeFirstSwype => 'முதல் ஸ்வைப்';

  @override
  String get badgeFirstSwypeHow => 'முதல் சரியான ஸ்வைப்';

  @override
  String get badgeNoMistake => 'தவறே இல்லை';

  @override
  String get badgeNoMistakeHow => 'முழு அலகும் மூன்று நட்சத்திரங்களுடன்';

  @override
  String get badgeExplorer => 'ஆய்வாளர்';

  @override
  String get badgeExplorerHow => 'முதல் ஸ்டிக்கர்';

  @override
  String get badgeCollectorHalf => 'சேகரிப்பாளர்';

  @override
  String get badgeCollectorHalfHow => 'பாதி மிருகக்காட்சிசாலை';

  @override
  String get badgeCollectorAll => 'பெரிய சேகரிப்பாளர்';

  @override
  String get badgeCollectorAllHow => 'முழு மிருகக்காட்சிசாலை';

  @override
  String get badgeNightOwl => 'இரவு ஆந்தை';

  @override
  String get badgeNightOwlHow => 'இரவில் விளையாடியது';

  @override
  String get badgeEarlyBird => 'அதிகாலைப் பறவை';

  @override
  String get badgeEarlyBirdHow => 'காலையில் விளையாடியது';

  @override
  String get badgeFourSeasons => 'நான்கு பருவங்கள்';

  @override
  String get badgeFourSeasonsHow => 'ஒவ்வொரு பருவத்திலும் விளையாடியது';

  @override
  String get badgeWordsmith10 => 'சொல் கலைஞர்';

  @override
  String get badgeWordsmith10How => 'பையில் 10 சொற்கள்';

  @override
  String get badgeWordsmith25 => 'பெரிய சொல் கலைஞர்';

  @override
  String get badgeWordsmith25How => 'பையில் 25 சொற்கள்';

  @override
  String get badgeWordsmith50 => 'சொல் வித்தகர்';

  @override
  String get badgeWordsmith50How => 'பையில் 50 சொற்கள்';

  @override
  String get badgePoet => 'கவிஞர்';

  @override
  String get badgePoetHow => 'என் புத்தகத்தில் 10 வாக்கியங்கள்';

  @override
  String get badgeListener => 'கேட்பவர்';

  @override
  String get badgeListenerHow =>
      'மூன்று நட்சத்திரங்களுடன் 10 கேட்கும் சுற்றுகள்';

  @override
  String get badgePersistent => 'விடாமுயற்சியாளர்';

  @override
  String get badgePersistentHow => '7 விளையாட்டு நாட்கள்';

  @override
  String get parentTitle => 'பெற்றோருக்கு';

  @override
  String gateQuestion(int a, int b) {
    return '$a × $b எவ்வளவு?';
  }

  @override
  String get backToGame => 'விளையாட்டுக்குத் திரும்பு';

  @override
  String get sectionOverview => 'மேலோட்டம்';

  @override
  String get sectionLetters => 'எழுத்துகள்';

  @override
  String get sectionTips => 'வீட்டுக்கான ஆலோசனைகள்';

  @override
  String get sectionMethod => 'செயலி எப்படிக் கற்பிக்கிறது';

  @override
  String get sectionSettings => 'அமைப்புகள்';

  @override
  String get statProfile => 'சுயவிவரம்';

  @override
  String get statPlayDays => 'விளையாட்டு நாட்கள்';

  @override
  String get statLessons => 'பாடங்கள்';

  @override
  String get statStars => 'நட்சத்திரங்கள்';

  @override
  String get statWords => 'பையில் சொற்கள்';

  @override
  String get statSentences => 'என் புத்தகத்தில் வாக்கியங்கள்';

  @override
  String get statBadges => 'பேட்ஜ்கள்';

  @override
  String get lettersLegend =>
      '🟢 கற்றுக்கொண்டது · 🟡 பயிற்சியில் · ⚪ இன்னும் சந்திக்கவில்லை';

  @override
  String troubleWords(String letter, String words) {
    return '$letter உள்ள குழப்பமான சொற்கள்: $words';
  }

  @override
  String get tipNoData =>
      'பயிற்சிக்கு இன்னும் ஒன்றும் இல்லை — சில பாடங்களுக்குப் பிறகு ஆலோசனைகள் தோன்றும்.';

  @override
  String tipWeakest(String words) {
    return 'மிகப் பலவீனமான சொற்கள்: $words. வீட்டில் அவற்றை அசைகளாகக் கைதட்டிச் சொல்லி, அவற்றில் தொடங்கும் பொருட்களைத் தேடுங்கள்.';
  }

  @override
  String tipLetter(String letter) {
    return '$letter என்ற எழுத்து இன்னும் பதியவில்லை: வீட்டில் சேர்ந்து $letter இல் தொடங்கும் பொருட்களைத் தேடுங்கள்.';
  }

  @override
  String get tipLongPress =>
      'வரைபடத்தில் ஒரு பாடத்தை நீண்ட நேரம் அழுத்தினால் அதில் என்ன, ஏன் பயிற்சி செய்கிறது என்று காட்டும்.';

  @override
  String methodLabel(String method) {
    return 'முறை: $method';
  }

  @override
  String get methodText =>
      'குழந்தை அசையையோ சொல்லையோ கேட்கும் வரிசையிலேயே எழுத்துகளின் மேல் விரலை நகர்த்துகிறது. முதலில் திறந்த அசைகள் (MA, TA), பிறகு முழுச் சொற்கள், எழுத்தில்லாமல் கேட்கும் சுற்றுகள், இடைவெளி நிரப்பும் சுற்றுகள், மிகப் பலவீனமான சொற்களின் மீள்பார்வை. தவறு ஒருபோதும் முன்னேற்றத்தைத் தடுக்காது — அட்டை சற்று அதிர்ந்து குறிப்பு தரும். கற்ற சொற்கள் உடனே வாக்கியத்தில் (வாக்கிய அமைப்பாளர்) பயன்படுத்தப்பட்டு என் புத்தகத்தில் சேமிக்கப்படலாம்.';

  @override
  String get settingSounds => 'ஒலிகள்';

  @override
  String get settingAmbient => 'உலகின் ஒலிகள்';

  @override
  String get settingMusic => 'இசை';

  @override
  String get settingLeftHanded => 'இடதுகைப் பழக்கம் (பிரதிபலித்த விசைப்பலகை)';

  @override
  String get settingDyslexiaFont =>
      'டிஸ்லெக்சியா நட்பு எழுத்துரு (OpenDyslexic)';

  @override
  String get settingSeason => 'வரைபடத்தில் பருவம்';

  @override
  String get seasonAuto => 'நாட்காட்டிப்படி';

  @override
  String get seasonSpring => 'வசந்தம்';

  @override
  String get seasonSummer => 'கோடை';

  @override
  String get seasonAutumn => 'இலையுதிர்காலம்';

  @override
  String get seasonWinter => 'குளிர்காலம்';

  @override
  String get settingTimeLimit => 'தினசரி விளையாட்டு நேர வரம்பு';

  @override
  String get noLimit => 'வரம்பு இல்லை';

  @override
  String minutes(int n) {
    return '$n நிமி';
  }

  @override
  String playedToday(int played) {
    return 'இன்று விளையாடியது: $played நிமி';
  }

  @override
  String playedTodayOf(int played, int limit) {
    return 'இன்று விளையாடியது: $limit இல் $played நிமி';
  }

  @override
  String get guideAsleep => ' — வழிகாட்டி தூங்குகிறது';

  @override
  String extendToday(int n) {
    return 'இன்றைக்கு $n நிமி நீட்டு';
  }

  @override
  String get profilesTitle => 'சுயவிவரங்கள்';

  @override
  String deleteProfileTitle(String name) {
    return '$name சுயவிவரத்தை நீக்கவா?';
  }

  @override
  String get deleteProfileBody =>
      'அனைத்து முன்னேற்றம், ஸ்டிக்கர்கள், புத்தகம் ஆகியவையும் நீக்கப்படும். இதைத் திரும்பப் பெற முடியாது.';

  @override
  String get cancel => 'ரத்துசெய்';

  @override
  String get delete => 'நீக்கு';

  @override
  String get statMinutesToday => 'இன்றைய நிமிடங்கள்';

  @override
  String get statMinutesWeek => 'இந்த வார நிமிடங்கள்';

  @override
  String get letterMastered => 'கற்றுக்கொண்டது';

  @override
  String get letterPracticing => 'பயிற்சியில்';

  @override
  String get letterUnseen => 'இன்னும் சந்திக்கவில்லை';

  @override
  String get typeHunt => 'ஒலி';

  @override
  String get typeJoin => 'அசைகள்';

  @override
  String get typeRhyme => 'எதுகை';

  @override
  String get promptHunt => 'எந்த எழுத்தைக் கேட்டாய்? அதைத் தொடு';

  @override
  String get promptJoin => 'அசைகளை இணை — முழுச் சொல்லையும் ஸ்வைப் செய்';

  @override
  String get promptRhyme => 'எது எதுகை ஆகிறது? படத்தைத் தொடு';

  @override
  String get expeditionTitle => 'மீள்பார்வைப் பயணம்';

  @override
  String get badgeExpedition => 'பயணி';

  @override
  String get badgeExpeditionHow => 'முதல் வாராந்திர மீள்பார்வைப் பயணம்';

  @override
  String get seasonStickersTitle => 'பருவ ஸ்டிக்கர்கள்';

  @override
  String get mapLoadFailed => 'வரைபடத்தை ஏற்ற முடியவில்லை';

  @override
  String get retry => 'மீண்டும் முயற்சி செய்';

  @override
  String get vocativeLabel => 'செக் மொழியில் விளிக்கும் வடிவம் (விளி வேற்றுமை)';

  @override
  String get vocativeHint => 'எ.கா. Lauro';

  @override
  String get guideTitle => 'உன் வழிகாட்டி';

  @override
  String get petPlay => 'வா விளையாடலாம்';

  @override
  String get badgeHost => 'விருந்தோம்புபவர்';

  @override
  String get badgeHostHow => 'விலங்குகளுக்கு 10 பரிசுகள்';

  @override
  String get badgeCuddler => 'அரவணைப்பவர்';

  @override
  String get badgeCuddlerHow => '5 விலங்குகளைத் தடவிக்கொடுத்தது';

  @override
  String get badgeWishMaker => 'நிறைவேறிய ஆசை';

  @override
  String get badgeWishMakerHow => '10 ஆசைகள் நிறைவேறின';

  @override
  String get badgeFriendOfAll => 'எல்லோருக்கும் நண்பன்';

  @override
  String get badgeFriendOfAllHow => 'ஒவ்வொரு விலங்குக்கும் பரிசு கிடைத்தது';

  @override
  String get settingPetRounds => 'விலங்குகளுக்குப் பரிசு: முதலில் சொல்லை எழுது';

  @override
  String get petBowlFood => 'கிண்ணம்';

  @override
  String get petBowlWater => 'தண்ணீர்';

  @override
  String get storeIslandA => 'எழுத்துத் தீவு';

  @override
  String get storeIslandB => 'சொல் தீவு';

  @override
  String get storeIslandC => 'வாக்கியத் தீவு';

  @override
  String storeProductIsland(String island, String language) {
    return '$island – $language';
  }

  @override
  String storeProductIslandDesc(String language) {
    return 'புதிய அலகுகள், ஸ்டிக்கர்கள், விலங்கு உலகின் குடிமக்கள். மொழி: $language.';
  }

  @override
  String storeProductLanguage(String language) {
    return 'இன்னொரு மொழி – $language';
  }

  @override
  String storeProductLanguageDesc(String island, String language) {
    return '$island வேறொரு மொழியில்: $language.';
  }

  @override
  String get storeProductBundle => 'எல்லாம் என்றென்றும்';

  @override
  String get storeProductBundleDesc =>
      'எல்லாத் தீவுகளும் மொழிகளும், இனி வரப்போகிறவையும்.';

  @override
  String get storeProductParent => 'பெற்றோர் தொகுப்பு';

  @override
  String get storeProductParentDesc =>
      'பணித்தாள்கள், என் புத்தக அச்சு, வாராந்திர மேலோட்டம், முன்னேற்றப் பரிமாற்றம்.';

  @override
  String get storeStateFree => 'இலவசம்';

  @override
  String get storeStateOwned => 'உங்களிடம் உள்ளது';

  @override
  String storeBuy(String price) {
    return '$price க்கு வாங்கு';
  }

  @override
  String get storeRestore => 'வாங்குதல்களை மீட்டெடு';

  @override
  String get storeDebugTitle => 'ஸ்டோர் (பிழைதிருத்தம்)';

  @override
  String get storeDebugEnable => 'இயக்கப்பட்ட ஸ்டோரை உருவகப்படுத்து';

  @override
  String get storeDebugForget => 'வாங்குதல்களை மற';

  @override
  String get homeLanguageLabel => 'குடும்ப மொழி (மெனுக்கள், குறிப்புகள்)';

  @override
  String get homeLanguageSame => 'விளையாட்டு மொழியே';

  @override
  String get parentPrivacy => 'தனியுரிமைக் கொள்கை';
}
