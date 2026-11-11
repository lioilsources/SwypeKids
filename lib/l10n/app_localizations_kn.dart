// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Kannada (`kn`).
class AppLocalizationsKn extends AppLocalizations {
  AppLocalizationsKn([String locale = 'kn']) : super(locale);

  @override
  String get appTitle => 'SwypeKids';

  @override
  String get menuSyllabary => 'ವರ್ಣಮಾಲೆ (ಸ್ವೈಪ್)';

  @override
  String get menuSentence => 'ವಾಕ್ಯ ರಚಿಸಿ';

  @override
  String get menuZoo => 'ಮೃಗಾಲಯ';

  @override
  String get menuBook => 'ನನ್ನ ಪುಸ್ತಕ';

  @override
  String get menuParents => 'ಪೋಷಕರಿಗಾಗಿ';

  @override
  String get practiceTitle => 'ಅಭ್ಯಾಸ';

  @override
  String bedtimeText(String guide) {
    return '$guide ಮಲಗಿದೆ. ನಾಳೆ ಸಿಗೋಣ!';
  }

  @override
  String get typeListen => 'ಕೇಳಿ';

  @override
  String get typePicture => 'ಚಿತ್ರ';

  @override
  String get typeGap => 'ಪೂರ್ಣಗೊಳಿಸಿ';

  @override
  String get typeReview => 'ಪುನರಾವರ್ತನೆ';

  @override
  String get typeWord => 'ಪದ';

  @override
  String get typeSyllable => 'ಅಕ್ಷರ-ಖಂಡ';

  @override
  String get promptListen => 'ಕೇಳಿ ಮತ್ತು ಕೇಳಿದ್ದನ್ನು ಸ್ವೈಪ್ ಮಾಡಿ';

  @override
  String get promptPicture => 'ಚಿತ್ರದಲ್ಲಿ ಏನಿದೆ? ಬರೆಯಿರಿ';

  @override
  String get promptGap => 'ಯಾವ ಅಕ್ಷರ ಕಾಣೆಯಾಗಿದೆ? ಪೂರ್ಣ ಪದವನ್ನು ಸ್ವೈಪ್ ಮಾಡಿ';

  @override
  String get promptSwipeTouch => 'ಚಿತ್ರಗಳ ಮೇಲೆ ಬೆರಳನ್ನು ಜಾರಿಸಿ';

  @override
  String get promptSwipeTrackpad => 'ಎರಡು ಬೆರಳುಗಳಿಂದ ಚಿತ್ರಗಳ ಮೇಲೆ ಜಾರಿಸಿ';

  @override
  String get successText => 'ಶಬ್ಬಾಸ್!';

  @override
  String get errorText => 'ಮತ್ತೆ ಪ್ರಯತ್ನಿಸಿ!';

  @override
  String get newSticker => 'ನಿಮಗೆ ಹೊಸ ಸ್ಟಿಕ್ಕರ್ ಸಿಕ್ಕಿದೆ!';

  @override
  String starsGained(int count) {
    return '+$count ನಕ್ಷತ್ರಗಳು';
  }

  @override
  String get backToMap => 'ನಕ್ಷೆಗೆ ಹಿಂತಿರುಗಿ';

  @override
  String get winTitle => 'ಮುಗಿಯಿತು!\nನೀವು ಚಾಂಪಿಯನ್!';

  @override
  String winStars(int count) {
    return 'ನೀವು $count ನಕ್ಷತ್ರಗಳನ್ನು ಗಳಿಸಿದ್ದೀರಿ!';
  }

  @override
  String get playAgain => 'ಮತ್ತೆ ಆಡಿ';

  @override
  String get builderBadge => 'ವಾಕ್ಯ';

  @override
  String get who => 'ಯಾರು';

  @override
  String get whatDoes => 'ಏನು ಮಾಡುತ್ತದೆ';

  @override
  String get whatWhere => 'ಏನು / ಎಲ್ಲಿ';

  @override
  String get newLabel => 'ಹೊಸದು';

  @override
  String get clear => 'ಅಳಿಸಿ';

  @override
  String get bookTitle => 'ನನ್ನ ಪುಸ್ತಕ';

  @override
  String get bookEmptyHint => 'ವಾಕ್ಯ ರಚಿಸಿ ಪುಸ್ತಕದಲ್ಲಿ ಉಳಿಸಿ';

  @override
  String get zooTitle => 'ಮೃಗಾಲಯ';

  @override
  String badgesTitle(int earned, int total) {
    return 'ಬ್ಯಾಡ್ಜ್‌ಗಳು $earned/$total';
  }

  @override
  String get badgeFirstSwype => 'ಮೊದಲ ಸ್ವೈಪ್';

  @override
  String get badgeFirstSwypeHow => 'ಮೊದಲ ಸರಿಯಾದ ಸ್ವೈಪ್';

  @override
  String get badgeNoMistake => 'ತಪ್ಪಿಲ್ಲ';

  @override
  String get badgeNoMistakeHow => 'ಇಡೀ ಘಟಕ ಮೂರು ನಕ್ಷತ್ರಗಳೊಂದಿಗೆ';

  @override
  String get badgeExplorer => 'ಅನ್ವೇಷಕ';

  @override
  String get badgeExplorerHow => 'ಮೊದಲ ಸ್ಟಿಕ್ಕರ್';

  @override
  String get badgeCollectorHalf => 'ಸಂಗ್ರಾಹಕ';

  @override
  String get badgeCollectorHalfHow => 'ಅರ್ಧ ಮೃಗಾಲಯ';

  @override
  String get badgeCollectorAll => 'ದೊಡ್ಡ ಸಂಗ್ರಾಹಕ';

  @override
  String get badgeCollectorAllHow => 'ಇಡೀ ಮೃಗಾಲಯ';

  @override
  String get badgeNightOwl => 'ರಾತ್ರಿ ಗೂಬೆ';

  @override
  String get badgeNightOwlHow => 'ರಾತ್ರಿ ಆಡಿದೆ';

  @override
  String get badgeEarlyBird => 'ಬೆಳಗಿನ ಹಕ್ಕಿ';

  @override
  String get badgeEarlyBirdHow => 'ಬೆಳಿಗ್ಗೆ ಆಡಿದೆ';

  @override
  String get badgeFourSeasons => 'ನಾಲ್ಕು ಋತುಗಳು';

  @override
  String get badgeFourSeasonsHow => 'ಪ್ರತಿ ಋತುವಿನಲ್ಲೂ ಆಡಿದೆ';

  @override
  String get badgeWordsmith10 => 'ಪದ ಶಿಲ್ಪಿ';

  @override
  String get badgeWordsmith10How => 'ಚೀಲದಲ್ಲಿ 10 ಪದಗಳು';

  @override
  String get badgeWordsmith25 => 'ದೊಡ್ಡ ಪದ ಶಿಲ್ಪಿ';

  @override
  String get badgeWordsmith25How => 'ಚೀಲದಲ್ಲಿ 25 ಪದಗಳು';

  @override
  String get badgeWordsmith50 => 'ಪದ ಮಾಸ್ಟರ್';

  @override
  String get badgeWordsmith50How => 'ಚೀಲದಲ್ಲಿ 50 ಪದಗಳು';

  @override
  String get badgePoet => 'ಕವಿ';

  @override
  String get badgePoetHow => 'ನನ್ನ ಪುಸ್ತಕದಲ್ಲಿ 10 ವಾಕ್ಯಗಳು';

  @override
  String get badgeListener => 'ಕೇಳುಗ';

  @override
  String get badgeListenerHow => 'ಮೂರು ನಕ್ಷತ್ರಗಳೊಂದಿಗೆ 10 ಆಲಿಸುವ ಸುತ್ತುಗಳು';

  @override
  String get badgePersistent => 'ಛಲಗಾರ';

  @override
  String get badgePersistentHow => '7 ಆಟದ ದಿನಗಳು';

  @override
  String get parentTitle => 'ಪೋಷಕರಿಗಾಗಿ';

  @override
  String gateQuestion(int a, int b) {
    return '$a × $b ಎಷ್ಟು?';
  }

  @override
  String get backToGame => 'ಆಟಕ್ಕೆ ಹಿಂತಿರುಗಿ';

  @override
  String get sectionOverview => 'ಅವಲೋಕನ';

  @override
  String get sectionLetters => 'ಅಕ್ಷರಗಳು';

  @override
  String get sectionTips => 'ಮನೆಗಾಗಿ ಸಲಹೆಗಳು';

  @override
  String get sectionMethod => 'ಆ್ಯಪ್ ಹೇಗೆ ಕಲಿಸುತ್ತದೆ';

  @override
  String get sectionSettings => 'ಸೆಟ್ಟಿಂಗ್‌ಗಳು';

  @override
  String get statProfile => 'ಪ್ರೊಫೈಲ್';

  @override
  String get statPlayDays => 'ಆಟದ ದಿನಗಳು';

  @override
  String get statLessons => 'ಪಾಠಗಳು';

  @override
  String get statStars => 'ನಕ್ಷತ್ರಗಳು';

  @override
  String get statWords => 'ಚೀಲದಲ್ಲಿ ಪದಗಳು';

  @override
  String get statSentences => 'ನನ್ನ ಪುಸ್ತಕದಲ್ಲಿ ವಾಕ್ಯಗಳು';

  @override
  String get statBadges => 'ಬ್ಯಾಡ್ಜ್‌ಗಳು';

  @override
  String get lettersLegend => '🟢 ಕರಗತ · 🟡 ಅಭ್ಯಾಸದಲ್ಲಿ · ⚪ ಇನ್ನೂ ಸಿಕ್ಕಿಲ್ಲ';

  @override
  String troubleWords(String letter, String words) {
    return '$letter ಇರುವ ಗೊಂದಲದ ಪದಗಳು: $words';
  }

  @override
  String get tipNoData =>
      'ಅಭ್ಯಾಸಕ್ಕೆ ಇನ್ನೂ ಏನೂ ಇಲ್ಲ — ಕೆಲವು ಪಾಠಗಳ ನಂತರ ಸಲಹೆಗಳು ಕಾಣಿಸುತ್ತವೆ.';

  @override
  String tipWeakest(String words) {
    return 'ಅತಿ ದುರ್ಬಲ ಪದಗಳು: $words. ಮನೆಯಲ್ಲಿ ಅವನ್ನು ಅಕ್ಷರ-ಖಂಡಗಳಲ್ಲಿ ಚಪ್ಪಾಳೆ ತಟ್ಟಿ ಹೇಳಿ, ಅವುಗಳಿಂದ ಶುರುವಾಗುವ ವಸ್ತುಗಳನ್ನು ಹುಡುಕಿ.';
  }

  @override
  String tipLetter(String letter) {
    return '$letter ಅಕ್ಷರ ಇನ್ನೂ ಕುಳಿತುಕೊಳ್ಳುತ್ತಿದೆ: ಮನೆಯಲ್ಲಿ ಒಟ್ಟಿಗೆ $letter ದಿಂದ ಶುರುವಾಗುವ ವಸ್ತುಗಳನ್ನು ಹುಡುಕಿ.';
  }

  @override
  String get tipLongPress =>
      'ನಕ್ಷೆಯಲ್ಲಿ ಪಾಠವನ್ನು ಹೆಚ್ಚು ಹೊತ್ತು ಒತ್ತಿದರೆ ಅದರಲ್ಲಿ ಏನು ಮತ್ತು ಏಕೆ ಅಭ್ಯಾಸವಾಗುತ್ತದೆ ಎಂದು ತೋರಿಸುತ್ತದೆ.';

  @override
  String methodLabel(String method) {
    return 'ವಿಧಾನ: $method';
  }

  @override
  String get methodText =>
      'ಮಗು ಅಕ್ಷರ-ಖಂಡ ಅಥವಾ ಪದವನ್ನು ಕೇಳುವ ಕ್ರಮದಲ್ಲಿ ಅಕ್ಷರಗಳ ಮೇಲೆ ಬೆರಳು ಜಾರಿಸುತ್ತದೆ. ಮೊದಲು ತೆರೆದ ಅಕ್ಷರ-ಖಂಡಗಳು (MA, TA), ನಂತರ ಪೂರ್ಣ ಪದಗಳು, ಪಠ್ಯವಿಲ್ಲದ ಆಲಿಸುವ ಸುತ್ತುಗಳು, ಖಾಲಿ ತುಂಬುವ ಸುತ್ತುಗಳು ಮತ್ತು ಅತಿ ದುರ್ಬಲ ಪದಗಳ ಪುನರಾವರ್ತನೆ. ತಪ್ಪು ಯಾವಾಗಲೂ ಮುನ್ನಡೆಯನ್ನು ತಡೆಯುವುದಿಲ್ಲ — ಕಾರ್ಡ್ ಕೇವಲ ಅಲುಗಾಡಿ ಸುಳಿವು ಕೊಡುತ್ತದೆ. ಕಲಿತ ಪದಗಳು ತಕ್ಷಣ ವಾಕ್ಯದಲ್ಲಿ (ವಾಕ್ಯ ರಚಕ) ಬಳಕೆಯಾಗುತ್ತವೆ ಮತ್ತು ನನ್ನ ಪುಸ್ತಕದಲ್ಲಿ ಉಳಿಸಬಹುದು.';

  @override
  String get settingSounds => 'ಶಬ್ದಗಳು';

  @override
  String get settingAmbient => 'ಜಗತ್ತಿನ ಶಬ್ದಗಳು';

  @override
  String get settingMusic => 'ಸಂಗೀತ';

  @override
  String get settingLeftHanded => 'ಎಡಗೈ (ಪ್ರತಿಬಿಂಬಿತ ಕೀಬೋರ್ಡ್)';

  @override
  String get settingDyslexiaFont => 'ಡಿಸ್ಲೆಕ್ಸಿಯಾ ಸ್ನೇಹಿ ಫಾಂಟ್ (OpenDyslexic)';

  @override
  String get settingSeason => 'ನಕ್ಷೆಯಲ್ಲಿ ಋತು';

  @override
  String get seasonAuto => 'ಕ್ಯಾಲೆಂಡರ್ ಪ್ರಕಾರ';

  @override
  String get seasonSpring => 'ವಸಂತ';

  @override
  String get seasonSummer => 'ಬೇಸಿಗೆ';

  @override
  String get seasonAutumn => 'ಶರತ್ಕಾಲ';

  @override
  String get seasonWinter => 'ಚಳಿಗಾಲ';

  @override
  String get settingTimeLimit => 'ದಿನದ ಆಟದ ಸಮಯ ಮಿತಿ';

  @override
  String get noLimit => 'ಮಿತಿ ಇಲ್ಲ';

  @override
  String minutes(int n) {
    return '$n ನಿಮಿ';
  }

  @override
  String playedToday(int played) {
    return 'ಇಂದು ಆಡಿದ್ದು: $played ನಿಮಿ';
  }

  @override
  String playedTodayOf(int played, int limit) {
    return 'ಇಂದು ಆಡಿದ್ದು: $limit ರಲ್ಲಿ $played ನಿಮಿ';
  }

  @override
  String get guideAsleep => ' — ಮಾರ್ಗದರ್ಶಿ ಮಲಗಿದ್ದಾನೆ';

  @override
  String extendToday(int n) {
    return 'ಇಂದನ್ನು $n ನಿಮಿ ವಿಸ್ತರಿಸಿ';
  }

  @override
  String get profilesTitle => 'ಪ್ರೊಫೈಲ್‌ಗಳು';

  @override
  String deleteProfileTitle(String name) {
    return '$name ಪ್ರೊಫೈಲ್ ಅಳಿಸಬೇಕೇ?';
  }

  @override
  String get deleteProfileBody =>
      'ಎಲ್ಲಾ ಪ್ರಗತಿ, ಸ್ಟಿಕ್ಕರ್‌ಗಳು ಮತ್ತು ಪುಸ್ತಕವೂ ಅಳಿಸಲ್ಪಡುತ್ತವೆ. ಇದನ್ನು ಹಿಂತಿರುಗಿಸಲಾಗದು.';

  @override
  String get cancel => 'ರದ್ದುಮಾಡಿ';

  @override
  String get delete => 'ಅಳಿಸಿ';

  @override
  String get statMinutesToday => 'ಇಂದಿನ ನಿಮಿಷಗಳು';

  @override
  String get statMinutesWeek => 'ಈ ವಾರದ ನಿಮಿಷಗಳು';

  @override
  String get letterMastered => 'ಕರಗತ';

  @override
  String get letterPracticing => 'ಅಭ್ಯಾಸದಲ್ಲಿ';

  @override
  String get letterUnseen => 'ಇನ್ನೂ ಸಿಕ್ಕಿಲ್ಲ';

  @override
  String get typeHunt => 'ಧ್ವನಿ';

  @override
  String get typeJoin => 'ಅಕ್ಷರ-ಖಂಡ';

  @override
  String get typeRhyme => 'ಪ್ರಾಸ';

  @override
  String get promptHunt => 'ಯಾವ ಅಕ್ಷರ ಕೇಳಿಸಿತು? ಅದನ್ನು ಒತ್ತಿ';

  @override
  String get promptJoin => 'ಅಕ್ಷರ-ಖಂಡಗಳನ್ನು ಜೋಡಿಸಿ — ಪೂರ್ಣ ಪದವನ್ನು ಸ್ವೈಪ್ ಮಾಡಿ';

  @override
  String get promptRhyme => 'ಯಾವುದು ಪ್ರಾಸ ಹೊಂದುತ್ತದೆ? ಚಿತ್ರವನ್ನು ಒತ್ತಿ';

  @override
  String get expeditionTitle => 'ಪುನರಾವರ್ತನೆ ಅಭಿಯಾನ';

  @override
  String get badgeExpedition => 'ಅಭಿಯಾನಿ';

  @override
  String get badgeExpeditionHow => 'ಮೊದಲ ಸಾಪ್ತಾಹಿಕ ಪುನರಾವರ್ತನೆ ಅಭಿಯಾನ';

  @override
  String get seasonStickersTitle => 'ಋತುಗಳ ಸ್ಟಿಕ್ಕರ್‌ಗಳು';

  @override
  String get mapLoadFailed => 'ನಕ್ಷೆಯನ್ನು ಲೋಡ್ ಮಾಡಲಾಗಲಿಲ್ಲ';

  @override
  String get retry => 'ಮತ್ತೆ ಪ್ರಯತ್ನಿಸಿ';

  @override
  String get vocativeLabel => 'ಚೆಕ್ ಭಾಷೆಯಲ್ಲಿ ಸಂಬೋಧನೆ ರೂಪ (ಸಂಬೋಧನ ವಿಭಕ್ತಿ)';

  @override
  String get vocativeHint => 'ಉದಾ. Lauro';

  @override
  String get guideTitle => 'ನಿಮ್ಮ ಮಾರ್ಗದರ್ಶಿ';

  @override
  String get petPlay => 'ಬನ್ನಿ ಆಡೋಣ';

  @override
  String get badgeHost => 'ಆತಿಥೇಯ';

  @override
  String get badgeHostHow => 'ಪ್ರಾಣಿಗಳಿಗೆ 10 ಉಡುಗೊರೆಗಳು';

  @override
  String get badgeCuddler => 'ಮುದ್ದಿಸುವವ';

  @override
  String get badgeCuddlerHow => '5 ಪ್ರಾಣಿಗಳನ್ನು ಮುದ್ದಿಸಿದೆ';

  @override
  String get badgeWishMaker => 'ಈಡೇರಿದ ಆಸೆ';

  @override
  String get badgeWishMakerHow => '10 ಆಸೆಗಳು ಈಡೇರಿದವು';

  @override
  String get badgeFriendOfAll => 'ಎಲ್ಲರ ಗೆಳೆಯ';

  @override
  String get badgeFriendOfAllHow => 'ಪ್ರತಿ ಪ್ರಾಣಿಗೂ ಉಡುಗೊರೆ ಸಿಕ್ಕಿದೆ';

  @override
  String get settingPetRounds => 'ಪ್ರಾಣಿಗಳಿಗೆ ಉಡುಗೊರೆ: ಮೊದಲು ಪದ ಬರೆಯಿರಿ';

  @override
  String get petBowlFood => 'ಬಟ್ಟಲು';

  @override
  String get petBowlWater => 'ನೀರು';

  @override
  String get storeIslandA => 'ಅಕ್ಷರಗಳ ದ್ವೀಪ';

  @override
  String get storeIslandB => 'ಪದಗಳ ದ್ವೀಪ';

  @override
  String get storeIslandC => 'ವಾಕ್ಯಗಳ ದ್ವೀಪ';

  @override
  String storeProductIsland(String island, String language) {
    return '$island – $language';
  }

  @override
  String storeProductIslandDesc(String language) {
    return 'ಹೊಸ ಘಟಕಗಳು, ಸ್ಟಿಕ್ಕರ್‌ಗಳು ಮತ್ತು ಪ್ರಾಣಿ ಲೋಕದ ನಿವಾಸಿಗಳು. ಭಾಷೆ: $language.';
  }

  @override
  String storeProductLanguage(String language) {
    return 'ಇನ್ನೊಂದು ಭಾಷೆ – $language';
  }

  @override
  String storeProductLanguageDesc(String island, String language) {
    return '$island ಇನ್ನೊಂದು ಭಾಷೆಯಲ್ಲಿ: $language.';
  }

  @override
  String get storeProductBundle => 'ಎಲ್ಲವೂ ಶಾಶ್ವತವಾಗಿ';

  @override
  String get storeProductBundleDesc =>
      'ಎಲ್ಲಾ ದ್ವೀಪಗಳು ಮತ್ತು ಭಾಷೆಗಳು, ಮುಂದೆ ಬರುವವೂ ಸೇರಿ.';

  @override
  String get storeProductParent => 'ಪೋಷಕರ ಪ್ಯಾಕ್';

  @override
  String get storeProductParentDesc =>
      'ವರ್ಕ್‌ಶೀಟ್‌ಗಳು, ನನ್ನ ಪುಸ್ತಕದ ಮುದ್ರಣ, ಸಾಪ್ತಾಹಿಕ ಅವಲೋಕನ ಮತ್ತು ಪ್ರಗತಿ ವರ್ಗಾವಣೆ.';

  @override
  String get storeStateFree => 'ಉಚಿತ';

  @override
  String get storeStateOwned => 'ನಿಮ್ಮಲ್ಲಿದೆ';

  @override
  String storeBuy(String price) {
    return '$price ಗೆ ಖರೀದಿಸಿ';
  }

  @override
  String get storeRestore => 'ಖರೀದಿಗಳನ್ನು ಮರುಪಡೆಯಿರಿ';

  @override
  String get storeDebugTitle => 'ಸ್ಟೋರ್ (ಡೀಬಗ್)';

  @override
  String get storeDebugEnable => 'ಸಕ್ರಿಯ ಸ್ಟೋರ್‌ನ ಅನುಕರಣೆ';

  @override
  String get storeDebugForget => 'ಖರೀದಿಗಳನ್ನು ಮರೆಯಿರಿ';

  @override
  String get homeLanguageLabel => 'ಕುಟುಂಬದ ಭಾಷೆ (ಮೆನು ಮತ್ತು ಸುಳಿವುಗಳು)';

  @override
  String get homeLanguageSame => 'ಆಟದ ಭಾಷೆಯಂತೆಯೇ';

  @override
  String get parentPrivacy => 'ಗೌಪ್ಯತಾ ನೀತಿ';
}
