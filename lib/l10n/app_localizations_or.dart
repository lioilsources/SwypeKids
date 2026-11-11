// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Oriya (`or`).
class AppLocalizationsOr extends AppLocalizations {
  AppLocalizationsOr([String locale = 'or']) : super(locale);

  @override
  String get appTitle => 'SwypeKids';

  @override
  String get menuSyllabary => 'ବର୍ଣ୍ଣମାଳା (ସ୍ୱାଇପ୍)';

  @override
  String get menuSentence => 'ବାକ୍ୟ ଗଢ଼ନ୍ତୁ';

  @override
  String get menuZoo => 'ଚିଡ଼ିଆଖାନା';

  @override
  String get menuBook => 'ମୋ ବହି';

  @override
  String get menuParents => 'ଅଭିଭାବକଙ୍କ ପାଇଁ';

  @override
  String get practiceTitle => 'ଅଭ୍ୟାସ';

  @override
  String bedtimeText(String guide) {
    return '$guide ଶୋଇପଡ଼ିଛି। କାଲି ଦେଖା ହେବ!';
  }

  @override
  String get typeListen => 'ଶୁଣ';

  @override
  String get typePicture => 'ଚିତ୍ର';

  @override
  String get typeGap => 'ପୂରଣ କର';

  @override
  String get typeReview => 'ପୁନରାବୃତ୍ତି';

  @override
  String get typeWord => 'ଶବ୍ଦ';

  @override
  String get typeSyllable => 'ଅକ୍ଷରଖଣ୍ଡ';

  @override
  String get promptListen => 'ଶୁଣ ଏବଂ ଯାହା ଶୁଣିଲ ତାହା ସ୍ୱାଇପ୍ କର';

  @override
  String get promptPicture => 'ଚିତ୍ରରେ କ\'ଣ ଅଛି? ଲେଖ';

  @override
  String get promptGap => 'କେଉଁ ଅକ୍ଷର ନାହିଁ? ପୂରା ଶବ୍ଦ ସ୍ୱାଇପ୍ କର';

  @override
  String get promptSwipeTouch => 'ଚିତ୍ର ଉପରେ ଆଙ୍ଗୁଠି ବୁଲାଅ';

  @override
  String get promptSwipeTrackpad => 'ଦୁଇ ଆଙ୍ଗୁଠିରେ ଚିତ୍ର ଉପରେ ବୁଲାଅ';

  @override
  String get successText => 'ବହୁତ ଭଲ!';

  @override
  String get errorText => 'ପୁଣି ଚେଷ୍ଟା କର!';

  @override
  String get newSticker => 'ତୁମେ ନୂଆ ଷ୍ଟିକର୍ ପାଇଲ!';

  @override
  String starsGained(int count) {
    return '+$countଟି ତାରା';
  }

  @override
  String get backToMap => 'ମାନଚିତ୍ରକୁ ଫେର';

  @override
  String get winTitle => 'ହୋଇଗଲା!\nତୁମେ ଚାମ୍ପିଅନ୍!';

  @override
  String winStars(int count) {
    return 'ତୁମେ $countଟି ତାରା ପାଇଲ!';
  }

  @override
  String get playAgain => 'ପୁଣି ଖେଳ';

  @override
  String get builderBadge => 'ବାକ୍ୟ';

  @override
  String get who => 'କିଏ';

  @override
  String get whatDoes => 'କ\'ଣ କରେ';

  @override
  String get whatWhere => 'କ\'ଣ / କେଉଁଠି';

  @override
  String get newLabel => 'ନୂଆ';

  @override
  String get clear => 'ସଫା କର';

  @override
  String get bookTitle => 'ମୋ ବହି';

  @override
  String get bookEmptyHint => 'ଗୋଟିଏ ବାକ୍ୟ ଗଢ଼ି ବହିରେ ସଞ୍ଚୟ କର';

  @override
  String get zooTitle => 'ଚିଡ଼ିଆଖାନା';

  @override
  String badgesTitle(int earned, int total) {
    return 'ବ୍ୟାଜ୍ $earned/$total';
  }

  @override
  String get badgeFirstSwype => 'ପ୍ରଥମ ସ୍ୱାଇପ୍';

  @override
  String get badgeFirstSwypeHow => 'ପ୍ରଥମ ଠିକ୍ ସ୍ୱାଇପ୍';

  @override
  String get badgeNoMistake => 'ଭୁଲ ନାହିଁ';

  @override
  String get badgeNoMistakeHow => 'ପୂରା ଏକକ ତିନି ତାରାରେ';

  @override
  String get badgeExplorer => 'ଅନୁସନ୍ଧାନକାରୀ';

  @override
  String get badgeExplorerHow => 'ପ୍ରଥମ ଷ୍ଟିକର୍';

  @override
  String get badgeCollectorHalf => 'ସଂଗ୍ରାହକ';

  @override
  String get badgeCollectorHalfHow => 'ଅଧା ଚିଡ଼ିଆଖାନା';

  @override
  String get badgeCollectorAll => 'ବଡ଼ ସଂଗ୍ରାହକ';

  @override
  String get badgeCollectorAllHow => 'ପୂରା ଚିଡ଼ିଆଖାନା';

  @override
  String get badgeNightOwl => 'ରାତିର ପେଚା';

  @override
  String get badgeNightOwlHow => 'ରାତିରେ ଖେଳିଛି';

  @override
  String get badgeEarlyBird => 'ସକାଳର ଚଢ଼େଇ';

  @override
  String get badgeEarlyBirdHow => 'ସକାଳେ ଖେଳିଛି';

  @override
  String get badgeFourSeasons => 'ଚାରି ଋତୁ';

  @override
  String get badgeFourSeasonsHow => 'ପ୍ରତ୍ୟେକ ଋତୁରେ ଖେଳିଛି';

  @override
  String get badgeWordsmith10 => 'ଶବ୍ଦଶିଳ୍ପୀ';

  @override
  String get badgeWordsmith10How => 'ଝୋଲାରେ 10ଟି ଶବ୍ଦ';

  @override
  String get badgeWordsmith25 => 'ବଡ଼ ଶବ୍ଦଶିଳ୍ପୀ';

  @override
  String get badgeWordsmith25How => 'ଝୋଲାରେ 25ଟି ଶବ୍ଦ';

  @override
  String get badgeWordsmith50 => 'ଶବ୍ଦ ଗୁରୁ';

  @override
  String get badgeWordsmith50How => 'ଝୋଲାରେ 50ଟି ଶବ୍ଦ';

  @override
  String get badgePoet => 'କବି';

  @override
  String get badgePoetHow => 'ମୋ ବହିରେ 10ଟି ବାକ୍ୟ';

  @override
  String get badgeListener => 'ଶ୍ରୋତା';

  @override
  String get badgeListenerHow => 'ତିନି ତାରାରେ 10ଟି ଶୁଣିବା ରାଉଣ୍ଡ';

  @override
  String get badgePersistent => 'ଅଧ୍ୟବସାୟୀ';

  @override
  String get badgePersistentHow => '7ଟି ଖେଳ ଦିନ';

  @override
  String get parentTitle => 'ଅଭିଭାବକଙ୍କ ପାଇଁ';

  @override
  String gateQuestion(int a, int b) {
    return '$a × $b କେତେ?';
  }

  @override
  String get backToGame => 'ଖେଳକୁ ଫେର';

  @override
  String get sectionOverview => 'ସାରାଂଶ';

  @override
  String get sectionLetters => 'ଅକ୍ଷର';

  @override
  String get sectionTips => 'ଘର ପାଇଁ ପରାମର୍ଶ';

  @override
  String get sectionMethod => 'ଆପ୍ କିପରି ଶିଖାଏ';

  @override
  String get sectionSettings => 'ସେଟିଂସ୍';

  @override
  String get statProfile => 'ପ୍ରୋଫାଇଲ୍';

  @override
  String get statPlayDays => 'ଖେଳ ଦିନ';

  @override
  String get statLessons => 'ପାଠ';

  @override
  String get statStars => 'ତାରା';

  @override
  String get statWords => 'ଝୋଲାରେ ଶବ୍ଦ';

  @override
  String get statSentences => 'ମୋ ବହିରେ ବାକ୍ୟ';

  @override
  String get statBadges => 'ବ୍ୟାଜ୍';

  @override
  String get lettersLegend =>
      '🟢 ଆୟତ୍ତ · 🟡 ଅଭ୍ୟାସରେ · ⚪ ଏପର୍ଯ୍ୟନ୍ତ ଦେଖା ହୋଇନାହିଁ';

  @override
  String troubleWords(String letter, String words) {
    return '$letter ଥିବା ଯେଉଁ ଶବ୍ଦ ଗୋଳମାଳ ହୁଏ: $words';
  }

  @override
  String get tipNoData =>
      'ଅଭ୍ୟାସ କରିବାକୁ ଏପର୍ଯ୍ୟନ୍ତ କିଛି ନାହିଁ — କିଛି ପାଠ ପରେ ପରାମର୍ଶ ଦେଖାଯିବ।';

  @override
  String tipWeakest(String words) {
    return 'ସବୁଠାରୁ ଦୁର୍ବଳ ଶବ୍ଦ: $words। ଘରେ ସେଗୁଡ଼ିକୁ ଅକ୍ଷରଖଣ୍ଡ ଅନୁସାରେ ତାଳି ମାରି କୁହନ୍ତୁ ଏବଂ ସେଥିରୁ ଆରମ୍ଭ ହେଉଥିବା ଜିନିଷ ଖୋଜନ୍ତୁ।';
  }

  @override
  String tipLetter(String letter) {
    return '$letter ଅକ୍ଷର ଏପର୍ଯ୍ୟନ୍ତ ବସୁଛି: ଘରେ ଏକାଠି $letter ରୁ ଆରମ୍ଭ ହେଉଥିବା ଜିନିଷ ଖୋଜନ୍ତୁ।';
  }

  @override
  String get tipLongPress =>
      'ମାନଚିତ୍ରରେ ପାଠକୁ ଅଧିକ ସମୟ ଦବାଇଲେ ସେଥିରେ କ\'ଣ ଓ କାହିଁକି ଅଭ୍ୟାସ ହୁଏ ତାହା ଦେଖାଯାଏ।';

  @override
  String methodLabel(String method) {
    return 'ପଦ୍ଧତି: $method';
  }

  @override
  String get methodText =>
      'ଶିଶୁ ଅକ୍ଷରଖଣ୍ଡ ବା ଶବ୍ଦ ଯେଉଁ କ୍ରମରେ ଶୁଣେ ସେହି କ୍ରମରେ ଅକ୍ଷର ଉପରେ ଆଙ୍ଗୁଠି ବୁଲାଏ। ପ୍ରଥମେ ଖୋଲା ଅକ୍ଷରଖଣ୍ଡ (MA, TA), ତା\'ପରେ ପୂରା ଶବ୍ଦ, ଲେଖା ବିନା ଶୁଣିବା ରାଉଣ୍ଡ, ଖାଲି ଜାଗା ପୂରଣ ରାଉଣ୍ଡ ଏବଂ ସବୁଠାରୁ ଦୁର୍ବଳ ଶବ୍ଦର ପୁନରାବୃତ୍ତି। ଭୁଲ କେବେ ଆଗକୁ ବଢ଼ିବାରେ ବାଧା ଦିଏ ନାହିଁ — କାର୍ଡ କେବଳ ଥରେ ଓ ସୂଚନା ଦିଏ। ଶିଖିଥିବା ଶବ୍ଦ ତୁରନ୍ତ ବାକ୍ୟରେ (ବାକ୍ୟ ନିର୍ମାତା) ବ୍ୟବହୃତ ହୁଏ ଏବଂ ମୋ ବହିରେ ସଞ୍ଚୟ କରାଯାଇପାରେ।';

  @override
  String get settingSounds => 'ଧ୍ୱନି';

  @override
  String get settingAmbient => 'ଦୁନିଆର ଧ୍ୱନି';

  @override
  String get settingMusic => 'ସଙ୍ଗୀତ';

  @override
  String get settingLeftHanded => 'ବାଁହାତୀ (ଓଲଟା କୀବୋର୍ଡ)';

  @override
  String get settingDyslexiaFont => 'ଡିସଲେକ୍ସିଆ-ଅନୁକୂଳ ଫଣ୍ଟ (OpenDyslexic)';

  @override
  String get settingSeason => 'ମାନଚିତ୍ରରେ ଋତୁ';

  @override
  String get seasonAuto => 'କ୍ୟାଲେଣ୍ଡର ଅନୁସାରେ';

  @override
  String get seasonSpring => 'ବସନ୍ତ';

  @override
  String get seasonSummer => 'ଗ୍ରୀଷ୍ମ';

  @override
  String get seasonAutumn => 'ଶରତ';

  @override
  String get seasonWinter => 'ଶୀତ';

  @override
  String get settingTimeLimit => 'ଦୈନିକ ଖେଳ ସମୟ ସୀମା';

  @override
  String get noLimit => 'ସୀମା ନାହିଁ';

  @override
  String minutes(int n) {
    return '$n ମିନିଟ୍';
  }

  @override
  String playedToday(int played) {
    return 'ଆଜି ଖେଳିଛି: $played ମିନିଟ୍';
  }

  @override
  String playedTodayOf(int played, int limit) {
    return 'ଆଜି ଖେଳିଛି: $limit ମଧ୍ୟରୁ $played ମିନିଟ୍';
  }

  @override
  String get guideAsleep => ' — ଗାଇଡ୍ ଶୋଇଛି';

  @override
  String extendToday(int n) {
    return 'ଆଜି $n ମିନିଟ୍ ବଢ଼ାଅ';
  }

  @override
  String get profilesTitle => 'ପ୍ରୋଫାଇଲ୍';

  @override
  String deleteProfileTitle(String name) {
    return '$name ପ୍ରୋଫାଇଲ୍ ଲିଭାଇବେ?';
  }

  @override
  String get deleteProfileBody =>
      'ସମସ୍ତ ପ୍ରଗତି, ଷ୍ଟିକର୍ ଓ ବହି ମଧ୍ୟ ଲିଭିଯିବ। ଏହାକୁ ଫେରାଇ ହେବ ନାହିଁ।';

  @override
  String get cancel => 'ବାତିଲ୍';

  @override
  String get delete => 'ଲିଭାଅ';

  @override
  String get statMinutesToday => 'ଆଜିର ମିନିଟ୍';

  @override
  String get statMinutesWeek => 'ଏହି ସପ୍ତାହର ମିନିଟ୍';

  @override
  String get letterMastered => 'ଆୟତ୍ତ';

  @override
  String get letterPracticing => 'ଅଭ୍ୟାସରେ';

  @override
  String get letterUnseen => 'ଏପର୍ଯ୍ୟନ୍ତ ଦେଖା ହୋଇନାହିଁ';

  @override
  String get typeHunt => 'ଧ୍ୱନି';

  @override
  String get typeJoin => 'ଅକ୍ଷରଖଣ୍ଡ';

  @override
  String get typeRhyme => 'ମିଳ';

  @override
  String get promptHunt => 'କେଉଁ ଅକ୍ଷର ଶୁଣିଲ? ତାକୁ ଛୁଅ';

  @override
  String get promptJoin => 'ଅକ୍ଷରଖଣ୍ଡ ଯୋଡ଼ — ପୂରା ଶବ୍ଦ ସ୍ୱାଇପ୍ କର';

  @override
  String get promptRhyme => 'କ\'ଣ ମିଳେ? ଚିତ୍ରକୁ ଛୁଅ';

  @override
  String get expeditionTitle => 'ପୁନରାବୃତ୍ତି ଅଭିଯାନ';

  @override
  String get badgeExpedition => 'ଅଭିଯାତ୍ରୀ';

  @override
  String get badgeExpeditionHow => 'ପ୍ରଥମ ସାପ୍ତାହିକ ପୁନରାବୃତ୍ତି ଅଭିଯାନ';

  @override
  String get seasonStickersTitle => 'ଋତୁ ଷ୍ଟିକର୍';

  @override
  String get mapLoadFailed => 'ମାନଚିତ୍ର ଲୋଡ୍ ହୋଇପାରିଲା ନାହିଁ';

  @override
  String get retry => 'ପୁଣି ଚେଷ୍ଟା କର';

  @override
  String get vocativeLabel => 'ଚେକ୍ ଭାଷାରେ ସମ୍ବୋଧନ ରୂପ (ସମ୍ବୋଧନ)';

  @override
  String get vocativeHint => 'ଯେପରି Lauro';

  @override
  String get guideTitle => 'ତୁମର ଗାଇଡ୍';

  @override
  String get petPlay => 'ଆସ ଖେଳିବା';

  @override
  String get badgeHost => 'ଆତିଥେୟ';

  @override
  String get badgeHostHow => 'ପଶୁମାନଙ୍କୁ 10ଟି ଉପହାର';

  @override
  String get badgeCuddler => 'ଆଦର କରୁଥିବା';

  @override
  String get badgeCuddlerHow => '5ଟି ପଶୁକୁ ଆଦର କଲା';

  @override
  String get badgeWishMaker => 'ପୂରଣ ହୋଇଥିବା ଇଚ୍ଛା';

  @override
  String get badgeWishMakerHow => '10ଟି ଇଚ୍ଛା ପୂରଣ';

  @override
  String get badgeFriendOfAll => 'ସମସ୍ତଙ୍କ ବନ୍ଧୁ';

  @override
  String get badgeFriendOfAllHow => 'ପ୍ରତ୍ୟେକ ପଶୁ ଉପହାର ପାଇଲା';

  @override
  String get settingPetRounds => 'ପଶୁମାନଙ୍କୁ ଉପହାର: ପ୍ରଥମେ ଶବ୍ଦ ଲେଖ';

  @override
  String get petBowlFood => 'ବାଟି';

  @override
  String get petBowlWater => 'ପାଣି';

  @override
  String get storeIslandA => 'ଅକ୍ଷର ଦ୍ୱୀପ';

  @override
  String get storeIslandB => 'ଶବ୍ଦ ଦ୍ୱୀପ';

  @override
  String get storeIslandC => 'ବାକ୍ୟ ଦ୍ୱୀପ';

  @override
  String storeProductIsland(String island, String language) {
    return '$island – $language';
  }

  @override
  String storeProductIslandDesc(String language) {
    return 'ନୂଆ ଏକକ, ଷ୍ଟିକର୍ ଓ ପଶୁ ଜଗତର ବାସିନ୍ଦା। ଭାଷା: $language।';
  }

  @override
  String storeProductLanguage(String language) {
    return 'ଆଉ ଗୋଟିଏ ଭାଷା – $language';
  }

  @override
  String storeProductLanguageDesc(String island, String language) {
    return '$island ଅନ୍ୟ ଭାଷାରେ: $language।';
  }

  @override
  String get storeProductBundle => 'ସବୁ ସବୁଦିନ ପାଇଁ';

  @override
  String get storeProductBundleDesc =>
      'ସମସ୍ତ ଦ୍ୱୀପ ଓ ଭାଷା, ଆଗକୁ ଆସିବା ଗୁଡ଼ିକ ମଧ୍ୟ।';

  @override
  String get storeProductParent => 'ଅଭିଭାବକ ପ୍ୟାକ୍';

  @override
  String get storeProductParentDesc =>
      'ୱାର୍କସିଟ୍, ମୋ ବହି ପ୍ରିଣ୍ଟ, ସାପ୍ତାହିକ ସାରାଂଶ ଓ ପ୍ରଗତି ସ୍ଥାନାନ୍ତର।';

  @override
  String get storeStateFree => 'ମାଗଣା';

  @override
  String get storeStateOwned => 'ଅଛି';

  @override
  String storeBuy(String price) {
    return '$price ରେ କିଣ';
  }

  @override
  String get storeRestore => 'କ୍ରୟ ଫେରାଅ';

  @override
  String get storeDebugTitle => 'ଷ୍ଟୋର୍ (ଡିବଗ୍)';

  @override
  String get storeDebugEnable => 'ଚାଲୁ ଷ୍ଟୋରର ଅନୁକରଣ';

  @override
  String get storeDebugForget => 'କ୍ରୟ ଭୁଲିଯାଅ';

  @override
  String get homeLanguageLabel => 'ପରିବାରର ଭାଷା (ମେନୁ ଓ ସୂଚନା)';

  @override
  String get homeLanguageSame => 'ଖେଳ ଭାଷା ଭଳି ହିଁ';

  @override
  String get parentPrivacy => 'ଗୋପନୀୟତା ନୀତି';
}
