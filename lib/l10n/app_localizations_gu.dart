// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Gujarati (`gu`).
class AppLocalizationsGu extends AppLocalizations {
  AppLocalizationsGu([String locale = 'gu']) : super(locale);

  @override
  String get appTitle => 'SwypeKids';

  @override
  String get menuSyllabary => 'બારાખડી (સ્વાઇપ)';

  @override
  String get menuSentence => 'વાક્ય બનાવો';

  @override
  String get menuZoo => 'પ્રાણીસંગ્રહાલય';

  @override
  String get menuBook => 'મારું પુસ્તક';

  @override
  String get menuParents => 'માતાપિતા માટે';

  @override
  String get practiceTitle => 'પ્રેક્ટિસ';

  @override
  String bedtimeText(String guide) {
    return '$guide સૂઈ ગયું છે. કાલે મળીશું!';
  }

  @override
  String get typeListen => 'સાંભળો';

  @override
  String get typePicture => 'ચિત્ર';

  @override
  String get typeGap => 'પૂરું કરો';

  @override
  String get typeReview => 'પુનરાવર્તન';

  @override
  String get typeWord => 'શબ્દ';

  @override
  String get typeSyllable => 'અક્ષર-ખંડ';

  @override
  String get promptListen => 'સાંભળો અને જે સાંભળ્યું તે સ્વાઇપ કરો';

  @override
  String get promptPicture => 'ચિત્રમાં શું છે? લખો';

  @override
  String get promptGap => 'કયો અક્ષર ખૂટે છે? આખો શબ્દ સ્વાઇપ કરો';

  @override
  String get promptSwipeTouch => 'ચિત્રો પર આંગળી ફેરવો';

  @override
  String get promptSwipeTrackpad => 'બે આંગળીઓથી ચિત્રો પર ફેરવો';

  @override
  String get successText => 'શાબાશ!';

  @override
  String get errorText => 'ફરી પ્રયત્ન કરો!';

  @override
  String get newSticker => 'તમને નવું સ્ટિકર મળ્યું!';

  @override
  String starsGained(int count) {
    return '+$count તારા';
  }

  @override
  String get backToMap => 'નકશા પર પાછા';

  @override
  String get winTitle => 'પૂરું!\nતમે ચેમ્પિયન છો!';

  @override
  String winStars(int count) {
    return 'તમે $count તારા મેળવ્યા!';
  }

  @override
  String get playAgain => 'ફરી રમો';

  @override
  String get builderBadge => 'વાક્ય';

  @override
  String get who => 'કોણ';

  @override
  String get whatDoes => 'શું કરે છે';

  @override
  String get whatWhere => 'શું / ક્યાં';

  @override
  String get newLabel => 'નવું';

  @override
  String get clear => 'સાફ કરો';

  @override
  String get bookTitle => 'મારું પુસ્તક';

  @override
  String get bookEmptyHint => 'વાક્ય બનાવીને પુસ્તકમાં સાચવો';

  @override
  String get zooTitle => 'પ્રાણીસંગ્રહાલય';

  @override
  String badgesTitle(int earned, int total) {
    return 'બેજ $earned/$total';
  }

  @override
  String get badgeFirstSwype => 'પહેલી સ્વાઇપ';

  @override
  String get badgeFirstSwypeHow => 'પહેલી સાચી સ્વાઇપ';

  @override
  String get badgeNoMistake => 'એક પણ ભૂલ નહીં';

  @override
  String get badgeNoMistakeHow => 'આખું એકમ ત્રણ તારા સાથે';

  @override
  String get badgeExplorer => 'સંશોધક';

  @override
  String get badgeExplorerHow => 'પહેલું સ્ટિકર';

  @override
  String get badgeCollectorHalf => 'સંગ્રાહક';

  @override
  String get badgeCollectorHalfHow => 'અડધું પ્રાણીસંગ્રહાલય';

  @override
  String get badgeCollectorAll => 'મોટો સંગ્રાહક';

  @override
  String get badgeCollectorAllHow => 'આખું પ્રાણીસંગ્રહાલય';

  @override
  String get badgeNightOwl => 'રાતનું ઘુવડ';

  @override
  String get badgeNightOwlHow => 'રાત્રે રમ્યું';

  @override
  String get badgeEarlyBird => 'વહેલું પંખી';

  @override
  String get badgeEarlyBirdHow => 'સવારે રમ્યું';

  @override
  String get badgeFourSeasons => 'ચાર ઋતુઓ';

  @override
  String get badgeFourSeasonsHow => 'દરેક ઋતુમાં રમ્યું';

  @override
  String get badgeWordsmith10 => 'શબ્દશિલ્પી';

  @override
  String get badgeWordsmith10How => 'થેલીમાં 10 શબ્દો';

  @override
  String get badgeWordsmith25 => 'મોટો શબ્દશિલ્પી';

  @override
  String get badgeWordsmith25How => 'થેલીમાં 25 શબ્દો';

  @override
  String get badgeWordsmith50 => 'શબ્દોનો માસ્ટર';

  @override
  String get badgeWordsmith50How => 'થેલીમાં 50 શબ્દો';

  @override
  String get badgePoet => 'કવિ';

  @override
  String get badgePoetHow => 'મારા પુસ્તકમાં 10 વાક્યો';

  @override
  String get badgeListener => 'શ્રોતા';

  @override
  String get badgeListenerHow => 'ત્રણ તારા સાથે 10 સાંભળવાના રાઉન્ડ';

  @override
  String get badgePersistent => 'મક્કમ';

  @override
  String get badgePersistentHow => 'રમવાના 7 દિવસ';

  @override
  String get parentTitle => 'માતાપિતા માટે';

  @override
  String gateQuestion(int a, int b) {
    return '$a × $b કેટલા?';
  }

  @override
  String get backToGame => 'રમતમાં પાછા';

  @override
  String get sectionOverview => 'ઝાંખી';

  @override
  String get sectionLetters => 'અક્ષરો';

  @override
  String get sectionTips => 'ઘર માટે સૂચનો';

  @override
  String get sectionMethod => 'એપ કેવી રીતે શીખવે છે';

  @override
  String get sectionSettings => 'સેટિંગ્સ';

  @override
  String get statProfile => 'પ્રોફાઇલ';

  @override
  String get statPlayDays => 'રમવાના દિવસો';

  @override
  String get statLessons => 'પાઠ';

  @override
  String get statStars => 'તારા';

  @override
  String get statWords => 'થેલીમાં શબ્દો';

  @override
  String get statSentences => 'મારા પુસ્તકમાં વાક્યો';

  @override
  String get statBadges => 'બેજ';

  @override
  String get lettersLegend => '🟢 આવડે છે · 🟡 પ્રેક્ટિસમાં · ⚪ હજી મળ્યા નથી';

  @override
  String troubleWords(String letter, String words) {
    return '$letter વાળા શબ્દો જે ગૂંચવાય છે: $words';
  }

  @override
  String get tipNoData =>
      'પ્રેક્ટિસ માટે હજી કંઈ નથી — થોડા પાઠ પછી સૂચનો દેખાશે.';

  @override
  String tipWeakest(String words) {
    return 'સૌથી નબળા શબ્દો: $words. ઘરે તેમને અક્ષર-ખંડ પ્રમાણે તાળી પાડીને બોલો અને તેનાથી શરૂ થતી વસ્તુઓ શોધો.';
  }

  @override
  String tipLetter(String letter) {
    return 'અક્ષર $letter હજી બેસી રહ્યો છે: ઘરે સાથે મળીને $letter થી શરૂ થતી વસ્તુઓ શોધો.';
  }

  @override
  String get tipLongPress =>
      'નકશા પર પાઠને લાંબો દબાવો તો તેમાં શું અને કેમ પ્રેક્ટિસ થાય છે તે દેખાશે.';

  @override
  String methodLabel(String method) {
    return 'પદ્ધતિ: $method';
  }

  @override
  String get methodText =>
      'બાળક અક્ષર-ખંડ કે શબ્દ જે ક્રમમાં સાંભળે છે તે ક્રમમાં અક્ષરો પર આંગળી ફેરવે છે. પહેલાં ખુલ્લા અક્ષર-ખંડ (MA, TA), પછી આખા શબ્દો, લખાણ વિનાના સાંભળવાના રાઉન્ડ, ખાલી જગ્યા પૂરવાના રાઉન્ડ અને સૌથી નબળા શબ્દોનું પુનરાવર્તન. ભૂલ ક્યારેય આગળ વધતાં અટકાવતી નથી — કાર્ડ ફક્ત હલે છે અને ઇશારો આપે છે. શીખેલા શબ્દો તરત વાક્યમાં (વાક્ય-બિલ્ડર) વપરાય છે અને મારા પુસ્તકમાં સાચવી શકાય છે.';

  @override
  String get settingSounds => 'અવાજો';

  @override
  String get settingAmbient => 'દુનિયાના અવાજો';

  @override
  String get settingMusic => 'સંગીત';

  @override
  String get settingLeftHanded => 'ડાબોડી (ઊલટું કીબોર્ડ)';

  @override
  String get settingDyslexiaFont => 'ડિસ્લેક્સિયા-અનુકૂળ ફૉન્ટ (OpenDyslexic)';

  @override
  String get settingSeason => 'નકશા પર ઋતુ';

  @override
  String get seasonAuto => 'કેલેન્ડર પ્રમાણે';

  @override
  String get seasonSpring => 'વસંત';

  @override
  String get seasonSummer => 'ઉનાળો';

  @override
  String get seasonAutumn => 'પાનખર';

  @override
  String get seasonWinter => 'શિયાળો';

  @override
  String get settingTimeLimit => 'રમવાની દૈનિક સમય મર્યાદા';

  @override
  String get noLimit => 'મર્યાદા નહીં';

  @override
  String minutes(int n) {
    return '$n મિનિટ';
  }

  @override
  String playedToday(int played) {
    return 'આજે રમ્યા: $played મિનિટ';
  }

  @override
  String playedTodayOf(int played, int limit) {
    return 'આજે રમ્યા: $limit માંથી $played મિનિટ';
  }

  @override
  String get guideAsleep => ' — માર્ગદર્શક સૂઈ ગયો છે';

  @override
  String extendToday(int n) {
    return 'આજે $n મિનિટ વધારો';
  }

  @override
  String get profilesTitle => 'પ્રોફાઇલ';

  @override
  String deleteProfileTitle(String name) {
    return 'પ્રોફાઇલ $name કાઢી નાખવી?';
  }

  @override
  String get deleteProfileBody =>
      'બધી પ્રગતિ, સ્ટિકર અને પુસ્તક પણ ભૂંસાઈ જશે. આ પાછું લાવી શકાશે નહીં.';

  @override
  String get cancel => 'રદ કરો';

  @override
  String get delete => 'કાઢી નાખો';

  @override
  String get statMinutesToday => 'આજની મિનિટ';

  @override
  String get statMinutesWeek => 'આ અઠવાડિયાની મિનિટ';

  @override
  String get letterMastered => 'આવડે છે';

  @override
  String get letterPracticing => 'પ્રેક્ટિસમાં';

  @override
  String get letterUnseen => 'હજી મળ્યા નથી';

  @override
  String get typeHunt => 'ધ્વનિ';

  @override
  String get typeJoin => 'અક્ષર-ખંડ';

  @override
  String get typeRhyme => 'પ્રાસ';

  @override
  String get promptHunt => 'કયો અક્ષર સાંભળ્યો? તેને દબાવો';

  @override
  String get promptJoin => 'અક્ષર-ખંડ જોડો — આખો શબ્દ સ્વાઇપ કરો';

  @override
  String get promptRhyme => 'કોનો પ્રાસ મળે છે? ચિત્રને દબાવો';

  @override
  String get expeditionTitle => 'પુનરાવર્તન અભિયાન';

  @override
  String get badgeExpedition => 'અભિયાની';

  @override
  String get badgeExpeditionHow => 'પહેલું સાપ્તાહિક પુનરાવર્તન અભિયાન';

  @override
  String get seasonStickersTitle => 'ઋતુઓના સ્ટિકર';

  @override
  String get mapLoadFailed => 'નકશો લોડ થઈ શક્યો નહીં';

  @override
  String get retry => 'ફરી પ્રયત્ન કરો';

  @override
  String get vocativeLabel => 'ચેક ભાષામાં સંબોધનનું રૂપ (સંબોધન કારક)';

  @override
  String get vocativeHint => 'જેમ કે Lauro';

  @override
  String get guideTitle => 'તમારો માર્ગદર્શક';

  @override
  String get petPlay => 'ચાલો રમીએ';

  @override
  String get badgeHost => 'યજમાન';

  @override
  String get badgeHostHow => 'પ્રાણીઓને 10 ભેટ';

  @override
  String get badgeCuddler => 'વહાલ કરનાર';

  @override
  String get badgeCuddlerHow => '5 પ્રાણીઓને પંપાળ્યા';

  @override
  String get badgeWishMaker => 'પૂરી થયેલી ઇચ્છા';

  @override
  String get badgeWishMakerHow => '10 ઇચ્છાઓ પૂરી થઈ';

  @override
  String get badgeFriendOfAll => 'બધાનો મિત્ર';

  @override
  String get badgeFriendOfAllHow => 'દરેક પ્રાણીને ભેટ મળી';

  @override
  String get settingPetRounds => 'પ્રાણીઓને ભેટ: પહેલાં શબ્દ લખો';

  @override
  String get petBowlFood => 'વાટકી';

  @override
  String get petBowlWater => 'પાણી';

  @override
  String get storeIslandA => 'અક્ષરોનો ટાપુ';

  @override
  String get storeIslandB => 'શબ્દોનો ટાપુ';

  @override
  String get storeIslandC => 'વાક્યોનો ટાપુ';

  @override
  String storeProductIsland(String island, String language) {
    return '$island – $language';
  }

  @override
  String storeProductIslandDesc(String language) {
    return 'નવા એકમો, સ્ટિકર અને પ્રાણી-દુનિયાના રહેવાસીઓ. ભાષા: $language.';
  }

  @override
  String storeProductLanguage(String language) {
    return 'બીજી ભાષા – $language';
  }

  @override
  String storeProductLanguageDesc(String island, String language) {
    return '$island બીજી ભાષામાં: $language.';
  }

  @override
  String get storeProductBundle => 'બધું કાયમ માટે';

  @override
  String get storeProductBundleDesc =>
      'બધા ટાપુઓ અને ભાષાઓ, જે હજી ઉમેરાવાના છે તે પણ.';

  @override
  String get storeProductParent => 'માતાપિતા પેક';

  @override
  String get storeProductParentDesc =>
      'વર્કશીટ, મારા પુસ્તકની પ્રિન્ટ, સાપ્તાહિક ઝાંખી અને પ્રગતિનું સ્થાનાંતર.';

  @override
  String get storeStateFree => 'મફત';

  @override
  String get storeStateOwned => 'તમારી પાસે છે';

  @override
  String storeBuy(String price) {
    return '$price માં ખરીદો';
  }

  @override
  String get storeRestore => 'ખરીદી પુનઃસ્થાપિત કરો';

  @override
  String get storeDebugTitle => 'સ્ટોર (ડિબગ)';

  @override
  String get storeDebugEnable => 'ચાલુ સ્ટોરનું અનુકરણ';

  @override
  String get storeDebugForget => 'ખરીદી ભૂલી જાઓ';

  @override
  String get homeLanguageLabel => 'પરિવારની ભાષા (મેનુ અને સૂચનો)';

  @override
  String get homeLanguageSame => 'રમતની ભાષા જેવી જ';

  @override
  String get parentPrivacy => 'ગોપનીયતા નીતિ';
}
