// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hindi (`hi`).
class AppLocalizationsHi extends AppLocalizations {
  AppLocalizationsHi([String locale = 'hi']) : super(locale);

  @override
  String get appTitle => 'SwypeKids';

  @override
  String get menuSyllabary => 'वर्णमाला (स्वाइप)';

  @override
  String get menuSentence => 'वाक्य बनाओ';

  @override
  String get menuZoo => 'चिड़ियाघर';

  @override
  String get menuBook => 'मेरी किताब';

  @override
  String get menuParents => 'माता-पिता के लिए';

  @override
  String get practiceTitle => 'अभ्यास';

  @override
  String bedtimeText(String guide) {
    return '$guide सो गया है। कल मिलते हैं!';
  }

  @override
  String get typeListen => 'सुनो';

  @override
  String get typePicture => 'चित्र';

  @override
  String get typeGap => 'भरो';

  @override
  String get typeReview => 'दोहराव';

  @override
  String get typeWord => 'शब्द';

  @override
  String get typeSyllable => 'अक्षर-खंड';

  @override
  String get promptListen => 'सुनो और जो सुना उसे स्वाइप करो';

  @override
  String get promptPicture => 'चित्र में क्या है? लिखो';

  @override
  String get promptGap => 'कौन-सा अक्षर छूट गया? पूरा शब्द स्वाइप करो';

  @override
  String get promptSwipeTouch => 'चित्रों पर उँगली फेरो';

  @override
  String get promptSwipeTrackpad => 'दो उँगलियों से चित्रों पर फेरो';

  @override
  String get successText => 'शाबाश!';

  @override
  String get errorText => 'फिर से कोशिश करो!';

  @override
  String get newSticker => 'तुम्हें नया स्टिकर मिला!';

  @override
  String starsGained(int count) {
    return '+$count सितारे';
  }

  @override
  String get backToMap => 'नक्शे पर वापस';

  @override
  String get winTitle => 'हो गया!\nतुम चैंपियन हो!';

  @override
  String winStars(int count) {
    return 'तुमने $count सितारे जीते!';
  }

  @override
  String get playAgain => 'फिर से खेलो';

  @override
  String get builderBadge => 'वाक्य';

  @override
  String get who => 'कौन';

  @override
  String get whatDoes => 'क्या करता है';

  @override
  String get whatWhere => 'क्या / कहाँ';

  @override
  String get newLabel => 'नया';

  @override
  String get clear => 'मिटाओ';

  @override
  String get bookTitle => 'मेरी किताब';

  @override
  String get bookEmptyHint => 'वाक्य बनाओ और किताब में सहेजो';

  @override
  String get zooTitle => 'चिड़ियाघर';

  @override
  String badgesTitle(int earned, int total) {
    return 'बैज $earned/$total';
  }

  @override
  String get badgeFirstSwype => 'पहला स्वाइप';

  @override
  String get badgeFirstSwypeHow => 'पहला सही स्वाइप';

  @override
  String get badgeNoMistake => 'एक भी गलती नहीं';

  @override
  String get badgeNoMistakeHow => 'पूरी इकाई तीन सितारों के साथ';

  @override
  String get badgeExplorer => 'खोजी';

  @override
  String get badgeExplorerHow => 'पहला स्टिकर';

  @override
  String get badgeCollectorHalf => 'संग्राहक';

  @override
  String get badgeCollectorHalfHow => 'आधा चिड़ियाघर';

  @override
  String get badgeCollectorAll => 'बड़ा संग्राहक';

  @override
  String get badgeCollectorAllHow => 'पूरा चिड़ियाघर';

  @override
  String get badgeNightOwl => 'रात का उल्लू';

  @override
  String get badgeNightOwlHow => 'रात में खेला';

  @override
  String get badgeEarlyBird => 'सुबह की चिड़िया';

  @override
  String get badgeEarlyBirdHow => 'सुबह खेला';

  @override
  String get badgeFourSeasons => 'चार मौसम';

  @override
  String get badgeFourSeasonsHow => 'हर मौसम में खेला';

  @override
  String get badgeWordsmith10 => 'शब्दकार';

  @override
  String get badgeWordsmith10How => 'थैले में 10 शब्द';

  @override
  String get badgeWordsmith25 => 'बड़ा शब्दकार';

  @override
  String get badgeWordsmith25How => 'थैले में 25 शब्द';

  @override
  String get badgeWordsmith50 => 'शब्दों का उस्ताद';

  @override
  String get badgeWordsmith50How => 'थैले में 50 शब्द';

  @override
  String get badgePoet => 'कवि';

  @override
  String get badgePoetHow => 'मेरी किताब में 10 वाक्य';

  @override
  String get badgeListener => 'श्रोता';

  @override
  String get badgeListenerHow => 'तीन सितारों के साथ 10 सुनने के राउंड';

  @override
  String get badgePersistent => 'डटा रहने वाला';

  @override
  String get badgePersistentHow => 'खेलने के 7 दिन';

  @override
  String get parentTitle => 'माता-पिता के लिए';

  @override
  String gateQuestion(int a, int b) {
    return '$a × $b कितना होता है?';
  }

  @override
  String get backToGame => 'खेल पर वापस';

  @override
  String get sectionOverview => 'सार';

  @override
  String get sectionLetters => 'अक्षर';

  @override
  String get sectionTips => 'घर के लिए सुझाव';

  @override
  String get sectionMethod => 'ऐप कैसे सिखाता है';

  @override
  String get sectionSettings => 'सेटिंग्स';

  @override
  String get statProfile => 'प्रोफ़ाइल';

  @override
  String get statPlayDays => 'खेलने के दिन';

  @override
  String get statLessons => 'पाठ';

  @override
  String get statStars => 'सितारे';

  @override
  String get statWords => 'थैले में शब्द';

  @override
  String get statSentences => 'मेरी किताब में वाक्य';

  @override
  String get statBadges => 'बैज';

  @override
  String get lettersLegend => '🟢 सीख लिए · 🟡 अभ्यास में · ⚪ अभी नहीं मिले';

  @override
  String troubleWords(String letter, String words) {
    return '$letter वाले शब्द जो गड़बड़ाते हैं: $words';
  }

  @override
  String get tipNoData =>
      'अभी अभ्यास के लिए कुछ नहीं है — कुछ पाठों के बाद सुझाव दिखेंगे।';

  @override
  String tipWeakest(String words) {
    return 'सबसे कमज़ोर शब्द: $words। घर पर उन्हें अक्षर-खंडों में ताली बजाकर बोलें और उनसे शुरू होने वाली चीज़ें खोजें।';
  }

  @override
  String tipLetter(String letter) {
    return 'अक्षर $letter अभी जम रहा है: घर पर साथ मिलकर $letter से शुरू होने वाली चीज़ें खोजें।';
  }

  @override
  String get tipLongPress =>
      'नक्शे पर किसी पाठ को देर तक दबाने से दिखेगा कि उसमें क्या और क्यों अभ्यास होता है।';

  @override
  String methodLabel(String method) {
    return 'तरीका: $method';
  }

  @override
  String get methodText =>
      'बच्चा अक्षर-खंड या शब्द जिस क्रम में सुनता है, उसी क्रम में अक्षरों पर उँगली फेरता है। पहले खुले अक्षर-खंड (MA, TA), फिर पूरे शब्द, बिना पाठ के सुनने के राउंड, खाली जगह भरने के राउंड और सबसे कमज़ोर शब्दों की दोहराई। गलती कभी आगे बढ़ना नहीं रोकती — कार्ड बस हिलता है और संकेत देता है। सीखे हुए शब्द तुरंत वाक्य में (वाक्य-बिल्डर) आते हैं और मेरी किताब में सहेजे जा सकते हैं।';

  @override
  String get settingSounds => 'ध्वनियाँ';

  @override
  String get settingAmbient => 'दुनिया की आवाज़ें';

  @override
  String get settingMusic => 'संगीत';

  @override
  String get settingLeftHanded => 'बायाँ हाथ (उलटा कीबोर्ड)';

  @override
  String get settingDyslexiaFont =>
      'डिस्लेक्सिया के लिए अनुकूल फ़ॉन्ट (OpenDyslexic)';

  @override
  String get settingSeason => 'नक्शे पर मौसम';

  @override
  String get seasonAuto => 'कैलेंडर के अनुसार';

  @override
  String get seasonSpring => 'वसंत';

  @override
  String get seasonSummer => 'गर्मी';

  @override
  String get seasonAutumn => 'पतझड़';

  @override
  String get seasonWinter => 'सर्दी';

  @override
  String get settingTimeLimit => 'रोज़ाना खेलने की समय सीमा';

  @override
  String get noLimit => 'कोई सीमा नहीं';

  @override
  String minutes(int n) {
    return '$n मिनट';
  }

  @override
  String playedToday(int played) {
    return 'आज खेला: $played मिनट';
  }

  @override
  String playedTodayOf(int played, int limit) {
    return 'आज खेला: $limit में से $played मिनट';
  }

  @override
  String get guideAsleep => ' — गाइड सो रहा है';

  @override
  String extendToday(int n) {
    return 'आज $n मिनट बढ़ाएँ';
  }

  @override
  String get profilesTitle => 'प्रोफ़ाइल';

  @override
  String deleteProfileTitle(String name) {
    return 'प्रोफ़ाइल $name हटाएँ?';
  }

  @override
  String get deleteProfileBody =>
      'पूरी प्रगति, स्टिकर और किताब भी मिट जाएँगे। यह वापस नहीं हो सकता।';

  @override
  String get cancel => 'रद्द करें';

  @override
  String get delete => 'हटाएँ';

  @override
  String get statMinutesToday => 'आज के मिनट';

  @override
  String get statMinutesWeek => 'इस हफ़्ते के मिनट';

  @override
  String get letterMastered => 'सीख लिए';

  @override
  String get letterPracticing => 'अभ्यास में';

  @override
  String get letterUnseen => 'अभी नहीं मिले';

  @override
  String get typeHunt => 'ध्वनि';

  @override
  String get typeJoin => 'अक्षर-खंड';

  @override
  String get typeRhyme => 'तुकबंदी';

  @override
  String get promptHunt => 'कौन-सा अक्षर सुना? उसे दबाओ';

  @override
  String get promptJoin => 'अक्षर-खंड जोड़ो — पूरा शब्द स्वाइप करो';

  @override
  String get promptRhyme => 'किसकी तुक मिलती है? चित्र दबाओ';

  @override
  String get expeditionTitle => 'दोहराव अभियान';

  @override
  String get badgeExpedition => 'अभियानी';

  @override
  String get badgeExpeditionHow => 'पहला साप्ताहिक दोहराव अभियान';

  @override
  String get seasonStickersTitle => 'मौसमों के स्टिकर';

  @override
  String get mapLoadFailed => 'नक्शा लोड नहीं हो सका';

  @override
  String get retry => 'फिर कोशिश करो';

  @override
  String get vocativeLabel => 'चेक भाषा में संबोधन का रूप (संबोधन कारक)';

  @override
  String get vocativeHint => 'जैसे Lauro';

  @override
  String get guideTitle => 'तुम्हारा गाइड';

  @override
  String get petPlay => 'आओ खेलें';

  @override
  String get badgeHost => 'मेज़बान';

  @override
  String get badgeHostHow => 'जानवरों को 10 तोहफ़े';

  @override
  String get badgeCuddler => 'दुलारने वाला';

  @override
  String get badgeCuddlerHow => '5 जानवरों को सहलाया';

  @override
  String get badgeWishMaker => 'पूरी हुई मुराद';

  @override
  String get badgeWishMakerHow => '10 मुरादें पूरी कीं';

  @override
  String get badgeFriendOfAll => 'सबका दोस्त';

  @override
  String get badgeFriendOfAllHow => 'हर जानवर को तोहफ़ा मिला';

  @override
  String get settingPetRounds => 'जानवरों को तोहफ़े: पहले शब्द लिखो';

  @override
  String get petBowlFood => 'कटोरा';

  @override
  String get petBowlWater => 'पानी';

  @override
  String get storeIslandA => 'अक्षरों का द्वीप';

  @override
  String get storeIslandB => 'शब्दों का द्वीप';

  @override
  String get storeIslandC => 'वाक्यों का द्वीप';

  @override
  String storeProductIsland(String island, String language) {
    return '$island – $language';
  }

  @override
  String storeProductIslandDesc(String language) {
    return 'नई इकाइयाँ, स्टिकर और जानवरों की दुनिया के निवासी। भाषा: $language।';
  }

  @override
  String storeProductLanguage(String language) {
    return 'एक और भाषा – $language';
  }

  @override
  String storeProductLanguageDesc(String island, String language) {
    return '$island दूसरी भाषा में: $language।';
  }

  @override
  String get storeProductBundle => 'सब कुछ हमेशा के लिए';

  @override
  String get storeProductBundleDesc =>
      'सभी द्वीप और भाषाएँ, वे भी जो आगे जुड़ेंगी।';

  @override
  String get storeProductParent => 'माता-पिता पैक';

  @override
  String get storeProductParentDesc =>
      'वर्कशीट, मेरी किताब की प्रिंटिंग, साप्ताहिक सार और प्रगति का स्थानांतरण।';

  @override
  String get storeStateFree => 'मुफ़्त';

  @override
  String get storeStateOwned => 'आपके पास है';

  @override
  String storeBuy(String price) {
    return '$price में खरीदें';
  }

  @override
  String get storeRestore => 'खरीदारी बहाल करें';

  @override
  String get storeDebugTitle => 'स्टोर (डीबग)';

  @override
  String get storeDebugEnable => 'चालू स्टोर का अनुकरण';

  @override
  String get storeDebugForget => 'खरीदारी भूल जाएँ';

  @override
  String get homeLanguageLabel => 'परिवार की भाषा (मेनू और संकेत)';

  @override
  String get homeLanguageSame => 'खेल की भाषा जैसी ही';

  @override
  String get parentPrivacy => 'गोपनीयता नीति';
}
