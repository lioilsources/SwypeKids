// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String get appTitle => 'Swype Kids';

  @override
  String get menuSyllabary => 'もじのほん（スワイプ）';

  @override
  String get menuSentence => 'ぶんをつくる';

  @override
  String get menuZoo => 'どうぶつえん';

  @override
  String get menuBook => 'わたしのほん';

  @override
  String get menuParents => '保護者の方へ';

  @override
  String get practiceTitle => 'れんしゅう';

  @override
  String get bedtimeText => 'ピピはもうねています。またあした！';

  @override
  String get typeListen => 'きく';

  @override
  String get typePicture => 'え';

  @override
  String get typeGap => 'うめる';

  @override
  String get typeReview => 'ふくしゅう';

  @override
  String get typeWord => 'ことば';

  @override
  String get typeSyllable => 'おと';

  @override
  String get promptListen => 'きいて、きこえたとおりになぞろう';

  @override
  String get promptPicture => 'えはなに？かいてみよう';

  @override
  String get promptGap => 'どのもじがない？ことばぜんぶをなぞろう';

  @override
  String get promptSwipeTouch => 'ゆびでえをなぞろう';

  @override
  String get promptSwipeTrackpad => 'ゆび2ほんでえをなぞろう';

  @override
  String get successText => 'すごい！';

  @override
  String get errorText => 'もういちど！';

  @override
  String get newSticker => 'あたらしいシールをもらったよ！';

  @override
  String starsGained(int count) {
    return '+$count ほし';
  }

  @override
  String get backToMap => 'ちずにもどる';

  @override
  String get winTitle => 'できた！\nチャンピオンだ！';

  @override
  String winStars(int count) {
    return 'ほしを $count こあつめたよ！';
  }

  @override
  String get playAgain => 'もういちどあそぶ';

  @override
  String get builderBadge => 'ぶん';

  @override
  String get who => 'だれが';

  @override
  String get whatDoes => 'なにをする';

  @override
  String get whatWhere => 'なにを / どこへ';

  @override
  String get newLabel => 'あたらしい';

  @override
  String get clear => 'けす';

  @override
  String get bookTitle => 'わたしのほん';

  @override
  String get bookEmptyHint => 'ぶんをつくって、ほんにしまおう';

  @override
  String get zooTitle => 'どうぶつえん';

  @override
  String badgesTitle(int earned, int total) {
    return 'バッジ $earned/$total';
  }

  @override
  String get badgeFirstSwype => 'はじめてのスワイプ';

  @override
  String get badgeFirstSwypeHow => 'はじめてせいかいしたスワイプ';

  @override
  String get badgeNoMistake => 'ノーミス';

  @override
  String get badgeNoMistakeHow => 'ユニットぜんぶほし3つ';

  @override
  String get badgeExplorer => 'たんけんか';

  @override
  String get badgeExplorerHow => 'はじめてのシール';

  @override
  String get badgeCollectorHalf => 'コレクター';

  @override
  String get badgeCollectorHalfHow => 'どうぶつえんのはんぶん';

  @override
  String get badgeCollectorAll => 'だいコレクター';

  @override
  String get badgeCollectorAllHow => 'どうぶつえんぜんぶ';

  @override
  String get badgeNightOwl => 'よるのふくろう';

  @override
  String get badgeNightOwlHow => 'よるにあそんだ';

  @override
  String get badgeEarlyBird => 'はやおきさん';

  @override
  String get badgeEarlyBirdHow => 'あさにあそんだ';

  @override
  String get badgeFourSeasons => 'しき';

  @override
  String get badgeFourSeasonsHow => 'どのきせつにもあそんだ';

  @override
  String get badgeWordsmith10 => 'ことばあつめ';

  @override
  String get badgeWordsmith10How => 'かばんにことば10こ';

  @override
  String get badgeWordsmith25 => 'ことばあつめの名人';

  @override
  String get badgeWordsmith25How => 'かばんにことば25こ';

  @override
  String get badgeWordsmith50 => 'ことばマスター';

  @override
  String get badgeWordsmith50How => 'かばんにことば50こ';

  @override
  String get badgePoet => 'しじん';

  @override
  String get badgePoetHow => 'ほんにぶんが10こ';

  @override
  String get badgeListener => 'きくのめいじん';

  @override
  String get badgeListenerHow => 'きくラウンドでほし3つを10かい';

  @override
  String get badgePersistent => 'つづけるひと';

  @override
  String get badgePersistentHow => '7日あそんだ';

  @override
  String get parentTitle => '保護者の方へ';

  @override
  String gateQuestion(int a, int b) {
    return '$a × $b はいくつ？';
  }

  @override
  String get backToGame => 'ゲームにもどる';

  @override
  String get sectionOverview => '概要';

  @override
  String get sectionLetters => '文字';

  @override
  String get sectionTips => 'おうちでのヒント';

  @override
  String get sectionMethod => 'アプリの教え方';

  @override
  String get sectionSettings => '設定';

  @override
  String get statProfile => 'プロフィール';

  @override
  String get statPlayDays => '遊んだ日';

  @override
  String get statLessons => 'レッスン';

  @override
  String get statStars => '星';

  @override
  String get statWords => 'かばんの言葉';

  @override
  String get statSentences => '本の文';

  @override
  String get statBadges => 'バッジ';

  @override
  String get lettersLegend => '🟢 できた · 🟡 練習中 · ⚪ まだ出ていない';

  @override
  String troubleWords(String letter, String words) {
    return '$letter を含む、まちがえやすい言葉：$words';
  }

  @override
  String get tipNoData => 'まだ練習するものがありません。数レッスン後にヒントが出ます。';

  @override
  String tipWeakest(String words) {
    return 'いちばん苦手な言葉：$words。おうちで音ごとに手をたたいて読み、同じ音で始まるものを探してみましょう。';
  }

  @override
  String tipLetter(String letter) {
    return '文字 $letter はまだ定着していません。おうちで $letter で始まるものを一緒に探しましょう。';
  }

  @override
  String get tipLongPress => '地図のレッスンを長押しすると、何をなぜ練習するかが見られます。';

  @override
  String methodLabel(String method) {
    return '方法：$method';
  }

  @override
  String get methodText =>
      '子どもは聞こえた音の順に文字をなぞって、音節や言葉を作ります。まず開音節（MA、TA）、次に言葉全体、文字のない聞き取り、穴うめ、苦手な言葉の復習へ進みます。まちがえても進行は止まりません。カードが揺れてヒントを出すだけです。覚えた言葉はすぐ文に使え（文づくり）、わたしの本に保存できます。';

  @override
  String get settingSounds => '効果音';

  @override
  String get settingAmbient => '世界の音';

  @override
  String get settingMusic => '音楽';

  @override
  String get settingLeftHanded => '左利き（鏡のキーボード）';

  @override
  String get settingDyslexiaFont => 'ディスレクシア向けフォント（OpenDyslexic）';

  @override
  String get settingSeason => '地図の季節';

  @override
  String get seasonAuto => 'カレンダー通り';

  @override
  String get seasonSpring => '春';

  @override
  String get seasonSummer => '夏';

  @override
  String get seasonAutumn => '秋';

  @override
  String get seasonWinter => '冬';

  @override
  String get settingTimeLimit => '1日の遊び時間の上限';

  @override
  String get noLimit => '上限なし';

  @override
  String minutes(int n) {
    return '$n 分';
  }

  @override
  String playedToday(int played) {
    return '今日は $played 分遊びました';
  }

  @override
  String playedTodayOf(int played, int limit) {
    return '今日は $played 分遊びました（上限 $limit 分）';
  }

  @override
  String get guideAsleep => '——案内役はもう寝ています';

  @override
  String extendToday(int n) {
    return '今日は $n 分延長';
  }

  @override
  String get profilesTitle => 'プロフィール';

  @override
  String deleteProfileTitle(String name) {
    return 'プロフィール $name を削除しますか？';
  }

  @override
  String get deleteProfileBody => '進み具合、シール、本もすべて削除されます。元に戻せません。';

  @override
  String get cancel => 'キャンセル';

  @override
  String get delete => '削除';

  @override
  String get statMinutesToday => '今日の分数';

  @override
  String get statMinutesWeek => '今週の分数';

  @override
  String get letterMastered => 'できた';

  @override
  String get letterPracticing => '練習中';

  @override
  String get letterUnseen => 'まだ出ていない';

  @override
  String get typeHunt => 'おと';

  @override
  String get typeJoin => 'おとつなぎ';

  @override
  String get typeRhyme => 'いん';

  @override
  String get promptHunt => 'どのもじがきこえた？タップしてね';

  @override
  String get promptJoin => 'おとをつなげて、ことばぜんぶをなぞろう';

  @override
  String get promptRhyme => 'おなじひびきはどれ？えをタップしてね';

  @override
  String get expeditionTitle => 'ふくしゅうたんけん';

  @override
  String get badgeExpedition => 'たんけんたい';

  @override
  String get badgeExpeditionHow => 'はじめてのしゅうかんふくしゅうたんけん';

  @override
  String get seasonStickersTitle => 'きせつのシール';

  @override
  String get mapLoadFailed => 'ちずをよみこめませんでした';

  @override
  String get retry => 'もういちど';
}
