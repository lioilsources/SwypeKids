// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Panjabi Punjabi (`pa`).
class AppLocalizationsPa extends AppLocalizations {
  AppLocalizationsPa([String locale = 'pa']) : super(locale);

  @override
  String get appTitle => 'SwypeKids';

  @override
  String get menuSyllabary => 'ਵਰਣਮਾਲਾ (ਸਵਾਈਪ)';

  @override
  String get menuSentence => 'ਵਾਕ ਬਣਾਓ';

  @override
  String get menuZoo => 'ਚਿੜੀਆਘਰ';

  @override
  String get menuBook => 'ਮੇਰੀ ਕਿਤਾਬ';

  @override
  String get menuParents => 'ਮਾਪਿਆਂ ਲਈ';

  @override
  String get practiceTitle => 'ਅਭਿਆਸ';

  @override
  String bedtimeText(String guide) {
    return '$guide ਸੌਂ ਗਿਆ ਹੈ। ਕੱਲ੍ਹ ਮਿਲਾਂਗੇ!';
  }

  @override
  String get typeListen => 'ਸੁਣੋ';

  @override
  String get typePicture => 'ਤਸਵੀਰ';

  @override
  String get typeGap => 'ਪੂਰਾ ਕਰੋ';

  @override
  String get typeReview => 'ਦੁਹਰਾਈ';

  @override
  String get typeWord => 'ਸ਼ਬਦ';

  @override
  String get typeSyllable => 'ਅੱਖਰ-ਖੰਡ';

  @override
  String get promptListen => 'ਸੁਣੋ ਅਤੇ ਜੋ ਸੁਣਿਆ ਉਹ ਸਵਾਈਪ ਕਰੋ';

  @override
  String get promptPicture => 'ਤਸਵੀਰ ਵਿੱਚ ਕੀ ਹੈ? ਲਿਖੋ';

  @override
  String get promptGap => 'ਕਿਹੜਾ ਅੱਖਰ ਗਾਇਬ ਹੈ? ਪੂਰਾ ਸ਼ਬਦ ਸਵਾਈਪ ਕਰੋ';

  @override
  String get promptSwipeTouch => 'ਤਸਵੀਰਾਂ ’ਤੇ ਉਂਗਲ ਫੇਰੋ';

  @override
  String get promptSwipeTrackpad => 'ਦੋ ਉਂਗਲਾਂ ਨਾਲ ਤਸਵੀਰਾਂ ’ਤੇ ਫੇਰੋ';

  @override
  String get successText => 'ਸ਼ਾਬਾਸ਼!';

  @override
  String get errorText => 'ਫਿਰ ਕੋਸ਼ਿਸ਼ ਕਰੋ!';

  @override
  String get newSticker => 'ਤੁਹਾਨੂੰ ਨਵਾਂ ਸਟਿੱਕਰ ਮਿਲਿਆ!';

  @override
  String starsGained(int count) {
    return '+$count ਤਾਰੇ';
  }

  @override
  String get backToMap => 'ਨਕਸ਼ੇ ’ਤੇ ਵਾਪਸ';

  @override
  String get winTitle => 'ਹੋ ਗਿਆ!\nਤੁਸੀਂ ਚੈਂਪੀਅਨ ਹੋ!';

  @override
  String winStars(int count) {
    return 'ਤੁਸੀਂ $count ਤਾਰੇ ਜਿੱਤੇ!';
  }

  @override
  String get playAgain => 'ਫਿਰ ਖੇਡੋ';

  @override
  String get builderBadge => 'ਵਾਕ';

  @override
  String get who => 'ਕੌਣ';

  @override
  String get whatDoes => 'ਕੀ ਕਰਦਾ ਹੈ';

  @override
  String get whatWhere => 'ਕੀ / ਕਿੱਥੇ';

  @override
  String get newLabel => 'ਨਵਾਂ';

  @override
  String get clear => 'ਮਿਟਾਓ';

  @override
  String get bookTitle => 'ਮੇਰੀ ਕਿਤਾਬ';

  @override
  String get bookEmptyHint => 'ਵਾਕ ਬਣਾਓ ਅਤੇ ਕਿਤਾਬ ਵਿੱਚ ਸੰਭਾਲੋ';

  @override
  String get zooTitle => 'ਚਿੜੀਆਘਰ';

  @override
  String badgesTitle(int earned, int total) {
    return 'ਬੈਜ $earned/$total';
  }

  @override
  String get badgeFirstSwype => 'ਪਹਿਲੀ ਸਵਾਈਪ';

  @override
  String get badgeFirstSwypeHow => 'ਪਹਿਲੀ ਸਹੀ ਸਵਾਈਪ';

  @override
  String get badgeNoMistake => 'ਇੱਕ ਵੀ ਗਲਤੀ ਨਹੀਂ';

  @override
  String get badgeNoMistakeHow => 'ਪੂਰੀ ਇਕਾਈ ਤਿੰਨ ਤਾਰਿਆਂ ਨਾਲ';

  @override
  String get badgeExplorer => 'ਖੋਜੀ';

  @override
  String get badgeExplorerHow => 'ਪਹਿਲਾ ਸਟਿੱਕਰ';

  @override
  String get badgeCollectorHalf => 'ਇਕੱਠਾ ਕਰਨ ਵਾਲਾ';

  @override
  String get badgeCollectorHalfHow => 'ਅੱਧਾ ਚਿੜੀਆਘਰ';

  @override
  String get badgeCollectorAll => 'ਵੱਡਾ ਇਕੱਠਾ ਕਰਨ ਵਾਲਾ';

  @override
  String get badgeCollectorAllHow => 'ਪੂਰਾ ਚਿੜੀਆਘਰ';

  @override
  String get badgeNightOwl => 'ਰਾਤ ਦਾ ਉੱਲੂ';

  @override
  String get badgeNightOwlHow => 'ਰਾਤ ਨੂੰ ਖੇਡਿਆ';

  @override
  String get badgeEarlyBird => 'ਸਵੇਰ ਦਾ ਪੰਛੀ';

  @override
  String get badgeEarlyBirdHow => 'ਸਵੇਰੇ ਖੇਡਿਆ';

  @override
  String get badgeFourSeasons => 'ਚਾਰ ਰੁੱਤਾਂ';

  @override
  String get badgeFourSeasonsHow => 'ਹਰ ਰੁੱਤ ਵਿੱਚ ਖੇਡਿਆ';

  @override
  String get badgeWordsmith10 => 'ਸ਼ਬਦ-ਘਾੜਾ';

  @override
  String get badgeWordsmith10How => 'ਝੋਲੇ ਵਿੱਚ 10 ਸ਼ਬਦ';

  @override
  String get badgeWordsmith25 => 'ਵੱਡਾ ਸ਼ਬਦ-ਘਾੜਾ';

  @override
  String get badgeWordsmith25How => 'ਝੋਲੇ ਵਿੱਚ 25 ਸ਼ਬਦ';

  @override
  String get badgeWordsmith50 => 'ਸ਼ਬਦਾਂ ਦਾ ਉਸਤਾਦ';

  @override
  String get badgeWordsmith50How => 'ਝੋਲੇ ਵਿੱਚ 50 ਸ਼ਬਦ';

  @override
  String get badgePoet => 'ਕਵੀ';

  @override
  String get badgePoetHow => 'ਮੇਰੀ ਕਿਤਾਬ ਵਿੱਚ 10 ਵਾਕ';

  @override
  String get badgeListener => 'ਸਰੋਤਾ';

  @override
  String get badgeListenerHow => 'ਤਿੰਨ ਤਾਰਿਆਂ ਨਾਲ 10 ਸੁਣਨ ਦੇ ਗੇੜ';

  @override
  String get badgePersistent => 'ਡਟਿਆ ਰਹਿਣ ਵਾਲਾ';

  @override
  String get badgePersistentHow => 'ਖੇਡਣ ਦੇ 7 ਦਿਨ';

  @override
  String get parentTitle => 'ਮਾਪਿਆਂ ਲਈ';

  @override
  String gateQuestion(int a, int b) {
    return '$a × $b ਕਿੰਨੇ ਹੁੰਦੇ ਹਨ?';
  }

  @override
  String get backToGame => 'ਖੇਡ ’ਤੇ ਵਾਪਸ';

  @override
  String get sectionOverview => 'ਸੰਖੇਪ ਜਾਣਕਾਰੀ';

  @override
  String get sectionLetters => 'ਅੱਖਰ';

  @override
  String get sectionTips => 'ਘਰ ਲਈ ਸੁਝਾਅ';

  @override
  String get sectionMethod => 'ਐਪ ਕਿਵੇਂ ਸਿਖਾਉਂਦੀ ਹੈ';

  @override
  String get sectionSettings => 'ਸੈਟਿੰਗਾਂ';

  @override
  String get statProfile => 'ਪ੍ਰੋਫਾਈਲ';

  @override
  String get statPlayDays => 'ਖੇਡਣ ਦੇ ਦਿਨ';

  @override
  String get statLessons => 'ਪਾਠ';

  @override
  String get statStars => 'ਤਾਰੇ';

  @override
  String get statWords => 'ਝੋਲੇ ਵਿੱਚ ਸ਼ਬਦ';

  @override
  String get statSentences => 'ਮੇਰੀ ਕਿਤਾਬ ਵਿੱਚ ਵਾਕ';

  @override
  String get statBadges => 'ਬੈਜ';

  @override
  String get lettersLegend => '🟢 ਆ ਗਏ · 🟡 ਅਭਿਆਸ ਵਿੱਚ · ⚪ ਹਾਲੇ ਨਹੀਂ ਮਿਲੇ';

  @override
  String troubleWords(String letter, String words) {
    return '$letter ਵਾਲੇ ਸ਼ਬਦ ਜੋ ਰਲ-ਗੱਡ ਹੋ ਜਾਂਦੇ ਹਨ: $words';
  }

  @override
  String get tipNoData =>
      'ਅਭਿਆਸ ਲਈ ਹਾਲੇ ਕੁਝ ਨਹੀਂ — ਕੁਝ ਪਾਠਾਂ ਤੋਂ ਬਾਅਦ ਸੁਝਾਅ ਦਿਖਣਗੇ।';

  @override
  String tipWeakest(String words) {
    return 'ਸਭ ਤੋਂ ਕਮਜ਼ੋਰ ਸ਼ਬਦ: $words। ਘਰ ਵਿੱਚ ਉਨ੍ਹਾਂ ਨੂੰ ਅੱਖਰ-ਖੰਡਾਂ ਮੁਤਾਬਕ ਤਾੜੀ ਮਾਰ ਕੇ ਬੋਲੋ ਅਤੇ ਉਨ੍ਹਾਂ ਨਾਲ ਸ਼ੁਰੂ ਹੋਣ ਵਾਲੀਆਂ ਚੀਜ਼ਾਂ ਲੱਭੋ।';
  }

  @override
  String tipLetter(String letter) {
    return 'ਅੱਖਰ $letter ਹਾਲੇ ਟਿਕ ਰਿਹਾ ਹੈ: ਘਰ ਵਿੱਚ ਮਿਲ ਕੇ $letter ਨਾਲ ਸ਼ੁਰੂ ਹੋਣ ਵਾਲੀਆਂ ਚੀਜ਼ਾਂ ਲੱਭੋ।';
  }

  @override
  String get tipLongPress =>
      'ਨਕਸ਼ੇ ’ਤੇ ਪਾਠ ਨੂੰ ਦੇਰ ਤੱਕ ਦਬਾਉਣ ਨਾਲ ਦਿਖੇਗਾ ਕਿ ਉਸ ਵਿੱਚ ਕੀ ਅਤੇ ਕਿਉਂ ਅਭਿਆਸ ਹੁੰਦਾ ਹੈ।';

  @override
  String methodLabel(String method) {
    return 'ਤਰੀਕਾ: $method';
  }

  @override
  String get methodText =>
      'ਬੱਚਾ ਅੱਖਰ-ਖੰਡ ਜਾਂ ਸ਼ਬਦ ਜਿਸ ਕ੍ਰਮ ਵਿੱਚ ਸੁਣਦਾ ਹੈ ਉਸੇ ਕ੍ਰਮ ਵਿੱਚ ਅੱਖਰਾਂ ’ਤੇ ਉਂਗਲ ਫੇਰਦਾ ਹੈ। ਪਹਿਲਾਂ ਖੁੱਲ੍ਹੇ ਅੱਖਰ-ਖੰਡ (MA, TA), ਫਿਰ ਪੂਰੇ ਸ਼ਬਦ, ਲਿਖਤ ਤੋਂ ਬਿਨਾਂ ਸੁਣਨ ਦੇ ਗੇੜ, ਖਾਲੀ ਥਾਂ ਭਰਨ ਦੇ ਗੇੜ ਅਤੇ ਸਭ ਤੋਂ ਕਮਜ਼ੋਰ ਸ਼ਬਦਾਂ ਦੀ ਦੁਹਰਾਈ। ਗਲਤੀ ਕਦੇ ਅੱਗੇ ਵਧਣ ਤੋਂ ਨਹੀਂ ਰੋਕਦੀ — ਕਾਰਡ ਸਿਰਫ਼ ਹਿੱਲਦਾ ਹੈ ਅਤੇ ਇਸ਼ਾਰਾ ਦਿੰਦਾ ਹੈ। ਸਿੱਖੇ ਸ਼ਬਦ ਤੁਰੰਤ ਵਾਕ ਵਿੱਚ (ਵਾਕ-ਬਿਲਡਰ) ਵਰਤੇ ਜਾਂਦੇ ਹਨ ਅਤੇ ਮੇਰੀ ਕਿਤਾਬ ਵਿੱਚ ਸੰਭਾਲੇ ਜਾ ਸਕਦੇ ਹਨ।';

  @override
  String get settingSounds => 'ਆਵਾਜ਼ਾਂ';

  @override
  String get settingAmbient => 'ਦੁਨੀਆ ਦੀਆਂ ਆਵਾਜ਼ਾਂ';

  @override
  String get settingMusic => 'ਸੰਗੀਤ';

  @override
  String get settingLeftHanded => 'ਖੱਬੂ (ਉਲਟਾ ਕੀਬੋਰਡ)';

  @override
  String get settingDyslexiaFont => 'ਡਿਸਲੈਕਸੀਆ-ਅਨੁਕੂਲ ਫੌਂਟ (OpenDyslexic)';

  @override
  String get settingSeason => 'ਨਕਸ਼ੇ ’ਤੇ ਰੁੱਤ';

  @override
  String get seasonAuto => 'ਕੈਲੰਡਰ ਮੁਤਾਬਕ';

  @override
  String get seasonSpring => 'ਬਸੰਤ';

  @override
  String get seasonSummer => 'ਗਰਮੀ';

  @override
  String get seasonAutumn => 'ਪਤਝੜ';

  @override
  String get seasonWinter => 'ਸਰਦੀ';

  @override
  String get settingTimeLimit => 'ਰੋਜ਼ ਖੇਡਣ ਦੀ ਸਮਾਂ ਹੱਦ';

  @override
  String get noLimit => 'ਕੋਈ ਹੱਦ ਨਹੀਂ';

  @override
  String minutes(int n) {
    return '$n ਮਿੰਟ';
  }

  @override
  String playedToday(int played) {
    return 'ਅੱਜ ਖੇਡਿਆ: $played ਮਿੰਟ';
  }

  @override
  String playedTodayOf(int played, int limit) {
    return 'ਅੱਜ ਖੇਡਿਆ: $limit ਵਿੱਚੋਂ $played ਮਿੰਟ';
  }

  @override
  String get guideAsleep => ' — ਗਾਈਡ ਸੌਂ ਰਿਹਾ ਹੈ';

  @override
  String extendToday(int n) {
    return 'ਅੱਜ ਨੂੰ $n ਮਿੰਟ ਵਧਾਓ';
  }

  @override
  String get profilesTitle => 'ਪ੍ਰੋਫਾਈਲ';

  @override
  String deleteProfileTitle(String name) {
    return 'ਪ੍ਰੋਫਾਈਲ $name ਮਿਟਾਉਣੀ ਹੈ?';
  }

  @override
  String get deleteProfileBody =>
      'ਸਾਰੀ ਤਰੱਕੀ, ਸਟਿੱਕਰ ਅਤੇ ਕਿਤਾਬ ਵੀ ਮਿਟ ਜਾਣਗੇ। ਇਹ ਵਾਪਸ ਨਹੀਂ ਹੋ ਸਕਦਾ।';

  @override
  String get cancel => 'ਰੱਦ ਕਰੋ';

  @override
  String get delete => 'ਮਿਟਾਓ';

  @override
  String get statMinutesToday => 'ਅੱਜ ਦੇ ਮਿੰਟ';

  @override
  String get statMinutesWeek => 'ਇਸ ਹਫ਼ਤੇ ਦੇ ਮਿੰਟ';

  @override
  String get letterMastered => 'ਆ ਗਏ';

  @override
  String get letterPracticing => 'ਅਭਿਆਸ ਵਿੱਚ';

  @override
  String get letterUnseen => 'ਹਾਲੇ ਨਹੀਂ ਮਿਲੇ';

  @override
  String get typeHunt => 'ਧੁਨੀ';

  @override
  String get typeJoin => 'ਅੱਖਰ-ਖੰਡ';

  @override
  String get typeRhyme => 'ਤੁਕਬੰਦੀ';

  @override
  String get promptHunt => 'ਕਿਹੜਾ ਅੱਖਰ ਸੁਣਿਆ? ਉਸ ਨੂੰ ਛੂਹੋ';

  @override
  String get promptJoin => 'ਅੱਖਰ-ਖੰਡ ਜੋੜੋ — ਪੂਰਾ ਸ਼ਬਦ ਸਵਾਈਪ ਕਰੋ';

  @override
  String get promptRhyme => 'ਕਿਸ ਦੀ ਤੁਕ ਮਿਲਦੀ ਹੈ? ਤਸਵੀਰ ਨੂੰ ਛੂਹੋ';

  @override
  String get expeditionTitle => 'ਦੁਹਰਾਈ ਮੁਹਿੰਮ';

  @override
  String get badgeExpedition => 'ਮੁਹਿੰਮਬਾਜ਼';

  @override
  String get badgeExpeditionHow => 'ਪਹਿਲੀ ਹਫ਼ਤਾਵਾਰੀ ਦੁਹਰਾਈ ਮੁਹਿੰਮ';

  @override
  String get seasonStickersTitle => 'ਰੁੱਤਾਂ ਦੇ ਸਟਿੱਕਰ';

  @override
  String get mapLoadFailed => 'ਨਕਸ਼ਾ ਲੋਡ ਨਹੀਂ ਹੋ ਸਕਿਆ';

  @override
  String get retry => 'ਫਿਰ ਕੋਸ਼ਿਸ਼ ਕਰੋ';

  @override
  String get vocativeLabel => 'ਚੈੱਕ ਭਾਸ਼ਾ ਵਿੱਚ ਸੰਬੋਧਨ ਦਾ ਰੂਪ (ਸੰਬੋਧਨ ਕਾਰਕ)';

  @override
  String get vocativeHint => 'ਜਿਵੇਂ Lauro';

  @override
  String get guideTitle => 'ਤੁਹਾਡਾ ਗਾਈਡ';

  @override
  String get petPlay => 'ਆਓ ਖੇਡੀਏ';

  @override
  String get badgeHost => 'ਮੇਜ਼ਬਾਨ';

  @override
  String get badgeHostHow => 'ਜਾਨਵਰਾਂ ਨੂੰ 10 ਤੋਹਫ਼ੇ';

  @override
  String get badgeCuddler => 'ਪਿਆਰ ਕਰਨ ਵਾਲਾ';

  @override
  String get badgeCuddlerHow => '5 ਜਾਨਵਰਾਂ ਨੂੰ ਪਲੋਸਿਆ';

  @override
  String get badgeWishMaker => 'ਪੂਰੀ ਹੋਈ ਇੱਛਾ';

  @override
  String get badgeWishMakerHow => '10 ਇੱਛਾਵਾਂ ਪੂਰੀਆਂ ਹੋਈਆਂ';

  @override
  String get badgeFriendOfAll => 'ਸਭ ਦਾ ਦੋਸਤ';

  @override
  String get badgeFriendOfAllHow => 'ਹਰ ਜਾਨਵਰ ਨੂੰ ਤੋਹਫ਼ਾ ਮਿਲਿਆ';

  @override
  String get settingPetRounds => 'ਜਾਨਵਰਾਂ ਨੂੰ ਤੋਹਫ਼ੇ: ਪਹਿਲਾਂ ਸ਼ਬਦ ਲਿਖੋ';

  @override
  String get petBowlFood => 'ਕੌਲੀ';

  @override
  String get petBowlWater => 'ਪਾਣੀ';

  @override
  String get storeIslandA => 'ਅੱਖਰਾਂ ਦਾ ਟਾਪੂ';

  @override
  String get storeIslandB => 'ਸ਼ਬਦਾਂ ਦਾ ਟਾਪੂ';

  @override
  String get storeIslandC => 'ਵਾਕਾਂ ਦਾ ਟਾਪੂ';

  @override
  String storeProductIsland(String island, String language) {
    return '$island – $language';
  }

  @override
  String storeProductIslandDesc(String language) {
    return 'ਨਵੀਆਂ ਇਕਾਈਆਂ, ਸਟਿੱਕਰ ਅਤੇ ਜਾਨਵਰਾਂ ਦੀ ਦੁਨੀਆ ਦੇ ਵਾਸੀ। ਭਾਸ਼ਾ: $language।';
  }

  @override
  String storeProductLanguage(String language) {
    return 'ਇੱਕ ਹੋਰ ਭਾਸ਼ਾ – $language';
  }

  @override
  String storeProductLanguageDesc(String island, String language) {
    return '$island ਦੂਜੀ ਭਾਸ਼ਾ ਵਿੱਚ: $language।';
  }

  @override
  String get storeProductBundle => 'ਸਭ ਕੁਝ ਸਦਾ ਲਈ';

  @override
  String get storeProductBundleDesc =>
      'ਸਾਰੇ ਟਾਪੂ ਅਤੇ ਭਾਸ਼ਾਵਾਂ, ਅੱਗੇ ਆਉਣ ਵਾਲੀਆਂ ਵੀ।';

  @override
  String get storeProductParent => 'ਮਾਪੇ ਪੈਕ';

  @override
  String get storeProductParentDesc =>
      'ਵਰਕਸ਼ੀਟਾਂ, ਮੇਰੀ ਕਿਤਾਬ ਦੀ ਛਪਾਈ, ਹਫ਼ਤਾਵਾਰੀ ਸੰਖੇਪ ਅਤੇ ਤਰੱਕੀ ਦਾ ਤਬਾਦਲਾ।';

  @override
  String get storeStateFree => 'ਮੁਫ਼ਤ';

  @override
  String get storeStateOwned => 'ਤੁਹਾਡੇ ਕੋਲ ਹੈ';

  @override
  String storeBuy(String price) {
    return '$price ਵਿੱਚ ਖਰੀਦੋ';
  }

  @override
  String get storeRestore => 'ਖਰੀਦਾਂ ਬਹਾਲ ਕਰੋ';

  @override
  String get storeDebugTitle => 'ਸਟੋਰ (ਡੀਬੱਗ)';

  @override
  String get storeDebugEnable => 'ਚਾਲੂ ਸਟੋਰ ਦੀ ਨਕਲ';

  @override
  String get storeDebugForget => 'ਖਰੀਦਾਂ ਭੁਲਾ ਦਿਓ';

  @override
  String get homeLanguageLabel => 'ਪਰਿਵਾਰ ਦੀ ਭਾਸ਼ਾ (ਮੀਨੂ ਅਤੇ ਸੰਕੇਤ)';

  @override
  String get homeLanguageSame => 'ਖੇਡ ਦੀ ਭਾਸ਼ਾ ਵਾਲੀ ਹੀ';

  @override
  String get parentPrivacy => 'ਪਰਦੇਦਾਰੀ ਨੀਤੀ';
}
