// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Swype Kids';

  @override
  String get menuSyllabary => 'Syllabary (Swype)';

  @override
  String get menuSentence => 'Build a sentence';

  @override
  String get menuZoo => 'Zoo';

  @override
  String get menuBook => 'My Book';

  @override
  String get menuParents => 'For parents';

  @override
  String get practiceTitle => 'Practice';

  @override
  String get bedtimeText => 'Pipi is asleep. See you tomorrow!';

  @override
  String get typeListen => 'LISTEN';

  @override
  String get typePicture => 'PICTURE';

  @override
  String get typeGap => 'FILL IN';

  @override
  String get typeReview => 'REVIEW';

  @override
  String get typeWord => 'WORD';

  @override
  String get typeSyllable => 'SYLLABLE';

  @override
  String get promptListen => 'Listen and swipe what you hear';

  @override
  String get promptPicture => 'What\'s in the picture? Write it';

  @override
  String get promptGap => 'Which letter is missing? Swipe the whole word';

  @override
  String get promptSwipeTouch => 'Swipe your finger across the pictures';

  @override
  String get promptSwipeTrackpad =>
      'Swipe with two fingers across the pictures';

  @override
  String get successText => 'Well done!';

  @override
  String get errorText => 'Try again!';

  @override
  String get newSticker => 'You got a new sticker!';

  @override
  String starsGained(int count) {
    return '+$count stars';
  }

  @override
  String get backToMap => 'Back to the map';

  @override
  String get winTitle => 'Done!\nYou\'re a champion!';

  @override
  String winStars(int count) {
    return 'You earned $count stars!';
  }

  @override
  String get playAgain => 'Play again';

  @override
  String get builderBadge => 'SENTENCE';

  @override
  String get who => 'WHO';

  @override
  String get whatDoes => 'DOES WHAT';

  @override
  String get whatWhere => 'WHAT / WHERE';

  @override
  String get newLabel => 'NEW';

  @override
  String get clear => 'Clear';

  @override
  String get bookTitle => 'My Book';

  @override
  String get bookEmptyHint => 'Build a sentence and save it to your book';

  @override
  String get zooTitle => 'Zoo';

  @override
  String badgesTitle(int earned, int total) {
    return 'Badges $earned/$total';
  }

  @override
  String get badgeFirstSwype => 'First swipe';

  @override
  String get badgeFirstSwypeHow => 'First correct swipe';

  @override
  String get badgeNoMistake => 'No mistakes';

  @override
  String get badgeNoMistakeHow => 'A whole unit on three stars';

  @override
  String get badgeExplorer => 'Explorer';

  @override
  String get badgeExplorerHow => 'First sticker';

  @override
  String get badgeCollectorHalf => 'Collector';

  @override
  String get badgeCollectorHalfHow => 'Half of the zoo';

  @override
  String get badgeCollectorAll => 'Great collector';

  @override
  String get badgeCollectorAllHow => 'The whole zoo';

  @override
  String get badgeNightOwl => 'Night owl';

  @override
  String get badgeNightOwlHow => 'Played at night';

  @override
  String get badgeEarlyBird => 'Early bird';

  @override
  String get badgeEarlyBirdHow => 'Played in the morning';

  @override
  String get badgeFourSeasons => 'Four seasons';

  @override
  String get badgeFourSeasonsHow => 'Played in every season';

  @override
  String get badgeWordsmith10 => 'Wordsmith';

  @override
  String get badgeWordsmith10How => '10 words in the bag';

  @override
  String get badgeWordsmith25 => 'Big wordsmith';

  @override
  String get badgeWordsmith25How => '25 words in the bag';

  @override
  String get badgeWordsmith50 => 'Word master';

  @override
  String get badgeWordsmith50How => '50 words in the bag';

  @override
  String get badgePoet => 'Poet';

  @override
  String get badgePoetHow => '10 sentences in My Book';

  @override
  String get badgeListener => 'Listener';

  @override
  String get badgeListenerHow => '10 listening rounds on three stars';

  @override
  String get badgePersistent => 'Keeps going';

  @override
  String get badgePersistentHow => '7 play days';

  @override
  String get parentTitle => 'For parents';

  @override
  String gateQuestion(int a, int b) {
    return 'What is $a × $b?';
  }

  @override
  String get backToGame => 'Back to the game';

  @override
  String get sectionOverview => 'Overview';

  @override
  String get sectionLetters => 'Letters';

  @override
  String get sectionTips => 'Tips for home';

  @override
  String get sectionMethod => 'How the app teaches';

  @override
  String get sectionSettings => 'Settings';

  @override
  String get statProfile => 'profile';

  @override
  String get statPlayDays => 'play days';

  @override
  String get statLessons => 'lessons';

  @override
  String get statStars => 'stars';

  @override
  String get statWords => 'words in the bag';

  @override
  String get statSentences => 'sentences in My Book';

  @override
  String get statBadges => 'badges';

  @override
  String get lettersLegend => '🟢 mastered · 🟡 practising · ⚪ not met yet';

  @override
  String troubleWords(String letter, String words) {
    return 'Words with $letter that get mixed up: $words';
  }

  @override
  String get tipNoData =>
      'Nothing to practise yet — tips appear after a few lessons.';

  @override
  String tipWeakest(String words) {
    return 'Weakest words: $words. Try clapping them out by syllable at home and spotting things that start with them.';
  }

  @override
  String tipLetter(String letter) {
    return 'The letter $letter is still settling: look for things at home that start with $letter.';
  }

  @override
  String get tipLongPress =>
      'Long-press a lesson on the map to see what it practises and why.';

  @override
  String methodLabel(String method) {
    return 'Method: $method';
  }

  @override
  String get methodText =>
      'Your child swipes across the letters in the order they hear the syllable or word. Open syllables first (MA, TA), then whole words, listening rounds without text, fill-in-the-gap rounds and review of the weakest words. A mistake never blocks progress — the card just shakes and hints. Learned words go straight into a sentence (the sentence builder) and can be saved to My Book.';

  @override
  String get settingSounds => 'Sounds';

  @override
  String get settingAmbient => 'World sounds';

  @override
  String get settingMusic => 'Music';

  @override
  String get settingLeftHanded => 'Left-handed (mirrored keyboard)';

  @override
  String get settingDyslexiaFont => 'Dyslexia-friendly font (OpenDyslexic)';

  @override
  String get settingSeason => 'Season on the map';

  @override
  String get seasonAuto => 'by the calendar';

  @override
  String get seasonSpring => 'spring';

  @override
  String get seasonSummer => 'summer';

  @override
  String get seasonAutumn => 'autumn';

  @override
  String get seasonWinter => 'winter';

  @override
  String get settingTimeLimit => 'Daily play time limit';

  @override
  String get noLimit => 'no limit';

  @override
  String minutes(int n) {
    return '$n min';
  }

  @override
  String playedToday(int played) {
    return 'Played today: $played min';
  }

  @override
  String playedTodayOf(int played, int limit) {
    return 'Played today: $played of $limit min';
  }

  @override
  String get guideAsleep => ' — the guide is asleep';

  @override
  String extendToday(int n) {
    return 'Extend today by $n min';
  }

  @override
  String get profilesTitle => 'Profiles';

  @override
  String deleteProfileTitle(String name) {
    return 'Delete profile $name?';
  }

  @override
  String get deleteProfileBody =>
      'All progress, stickers and the book will be deleted too. This cannot be undone.';

  @override
  String get cancel => 'Cancel';

  @override
  String get delete => 'Delete';

  @override
  String get statMinutesToday => 'minutes today';

  @override
  String get statMinutesWeek => 'minutes this week';

  @override
  String get letterMastered => 'mastered';

  @override
  String get letterPracticing => 'practising';

  @override
  String get letterUnseen => 'not met yet';

  @override
  String get typeHunt => 'SOUND';

  @override
  String get typeJoin => 'SYLLABLES';

  @override
  String get typeRhyme => 'RHYME';

  @override
  String get promptHunt => 'Which letter did you hear? Tap it';

  @override
  String get promptJoin => 'Join the syllables — swipe the whole word';

  @override
  String get promptRhyme => 'What rhymes? Tap the picture';

  @override
  String get expeditionTitle => 'Review expedition';

  @override
  String get badgeExpedition => 'Expeditioner';

  @override
  String get badgeExpeditionHow => 'First weekly review expedition';

  @override
  String get seasonStickersTitle => 'Season stickers';
}
