// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get appTitle => 'Swype Kids';

  @override
  String get menuSyllabary => '拼音课本（滑动）';

  @override
  String get menuSentence => '造句';

  @override
  String get menuZoo => '动物园';

  @override
  String get menuBook => '我的小书';

  @override
  String get menuParents => '家长专区';

  @override
  String get practiceTitle => '练习';

  @override
  String get bedtimeText => '皮皮睡着了，明天见！';

  @override
  String get typeListen => '听力';

  @override
  String get typePicture => '看图';

  @override
  String get typeGap => '填空';

  @override
  String get typeReview => '复习';

  @override
  String get typeWord => '词语';

  @override
  String get typeSyllable => '音节';

  @override
  String get promptListen => '听一听，滑出你听到的';

  @override
  String get promptPicture => '图上是什么？写出来';

  @override
  String get promptGap => '少了哪个字母？滑出整个词';

  @override
  String get promptSwipeTouch => '用手指划过图片';

  @override
  String get promptSwipeTrackpad => '用两根手指划过图片';

  @override
  String get successText => '太棒了！';

  @override
  String get errorText => '再试一次！';

  @override
  String get newSticker => '你得到了一张新贴纸！';

  @override
  String starsGained(int count) {
    return '+$count 颗星';
  }

  @override
  String get backToMap => '回到地图';

  @override
  String get winTitle => '完成了！\n你是冠军！';

  @override
  String winStars(int count) {
    return '你得到了 $count 颗星！';
  }

  @override
  String get playAgain => '再玩一次';

  @override
  String get builderBadge => '句子';

  @override
  String get who => '谁';

  @override
  String get whatDoes => '做什么';

  @override
  String get whatWhere => '什么 / 哪里';

  @override
  String get newLabel => '新';

  @override
  String get clear => '清除';

  @override
  String get bookTitle => '我的小书';

  @override
  String get bookEmptyHint => '造一个句子，存进小书里';

  @override
  String get zooTitle => '动物园';

  @override
  String badgesTitle(int earned, int total) {
    return '徽章 $earned/$total';
  }

  @override
  String get badgeFirstSwype => '第一划';

  @override
  String get badgeFirstSwypeHow => '第一次滑对';

  @override
  String get badgeNoMistake => '零失误';

  @override
  String get badgeNoMistakeHow => '整个单元都是三颗星';

  @override
  String get badgeExplorer => '探险家';

  @override
  String get badgeExplorerHow => '第一张贴纸';

  @override
  String get badgeCollectorHalf => '收藏家';

  @override
  String get badgeCollectorHalfHow => '动物园的一半';

  @override
  String get badgeCollectorAll => '大收藏家';

  @override
  String get badgeCollectorAllHow => '整个动物园';

  @override
  String get badgeNightOwl => '夜猫子';

  @override
  String get badgeNightOwlHow => '晚上玩过';

  @override
  String get badgeEarlyBird => '早起鸟';

  @override
  String get badgeEarlyBirdHow => '早上玩过';

  @override
  String get badgeFourSeasons => '四季';

  @override
  String get badgeFourSeasonsHow => '每个季节都玩过';

  @override
  String get badgeWordsmith10 => '词语小能手';

  @override
  String get badgeWordsmith10How => '背包里有 10 个词';

  @override
  String get badgeWordsmith25 => '词语大能手';

  @override
  String get badgeWordsmith25How => '背包里有 25 个词';

  @override
  String get badgeWordsmith50 => '词语大师';

  @override
  String get badgeWordsmith50How => '背包里有 50 个词';

  @override
  String get badgePoet => '小诗人';

  @override
  String get badgePoetHow => '小书里有 10 个句子';

  @override
  String get badgeListener => '好耳朵';

  @override
  String get badgeListenerHow => '10 次听力三颗星';

  @override
  String get badgePersistent => '坚持者';

  @override
  String get badgePersistentHow => '玩了 7 天';

  @override
  String get parentTitle => '家长专区';

  @override
  String gateQuestion(int a, int b) {
    return '$a × $b 等于多少？';
  }

  @override
  String get backToGame => '回到游戏';

  @override
  String get sectionOverview => '概览';

  @override
  String get sectionLetters => '字母';

  @override
  String get sectionTips => '在家练习建议';

  @override
  String get sectionMethod => '应用怎么教';

  @override
  String get sectionSettings => '设置';

  @override
  String get statProfile => '档案';

  @override
  String get statPlayDays => '游戏天数';

  @override
  String get statLessons => '课';

  @override
  String get statStars => '颗星';

  @override
  String get statWords => '背包里的词';

  @override
  String get statSentences => '小书里的句子';

  @override
  String get statBadges => '徽章';

  @override
  String get lettersLegend => '🟢 掌握 · 🟡 练习中 · ⚪ 还没遇到';

  @override
  String troubleWords(String letter, String words) {
    return '带 $letter 的容易混淆的词：$words';
  }

  @override
  String get tipNoData => '还没有需要练习的内容——学几课后这里会出现建议。';

  @override
  String tipWeakest(String words) {
    return '最弱的词：$words。在家按音节拍手读一读，找找以它们开头的东西。';
  }

  @override
  String tipLetter(String letter) {
    return '字母 $letter 还不牢：在家一起找以 $letter 开头的东西。';
  }

  @override
  String get tipLongPress => '长按地图上的一课，可以看到它练什么、为什么。';

  @override
  String methodLabel(String method) {
    return '方法：$method';
  }

  @override
  String get methodText =>
      '孩子按听到的顺序用手指划过字母，拼出音节或词语。先是开音节（MA、TA），再是整词、没有文字的听力、填空和最弱词语的复习。出错从不阻碍进度——卡片只会抖一下并提示。学会的词马上用到句子里（造句器），还可以存进我的小书。';

  @override
  String get settingSounds => '音效';

  @override
  String get settingAmbient => '环境声';

  @override
  String get settingMusic => '音乐';

  @override
  String get settingLeftHanded => '左撇子（镜像键盘）';

  @override
  String get settingDyslexiaFont => '阅读障碍友好字体（OpenDyslexic）';

  @override
  String get settingSeason => '地图上的季节';

  @override
  String get seasonAuto => '按日历';

  @override
  String get seasonSpring => '春';

  @override
  String get seasonSummer => '夏';

  @override
  String get seasonAutumn => '秋';

  @override
  String get seasonWinter => '冬';

  @override
  String get settingTimeLimit => '每天游戏时间限制';

  @override
  String get noLimit => '不限制';

  @override
  String minutes(int n) {
    return '$n 分钟';
  }

  @override
  String playedToday(int played) {
    return '今天玩了 $played 分钟';
  }

  @override
  String playedTodayOf(int played, int limit) {
    return '今天玩了 $played 分钟，限制 $limit 分钟';
  }

  @override
  String get guideAsleep => '——向导已经睡了';

  @override
  String extendToday(int n) {
    return '今天延长 $n 分钟';
  }

  @override
  String get profilesTitle => '档案';

  @override
  String deleteProfileTitle(String name) {
    return '删除档案 $name？';
  }

  @override
  String get deleteProfileBody => '所有进度、贴纸和小书也会一起删除，无法恢复。';

  @override
  String get cancel => '取消';

  @override
  String get delete => '删除';

  @override
  String get statMinutesToday => '今天的分钟数';

  @override
  String get statMinutesWeek => '本周的分钟数';

  @override
  String get letterMastered => '掌握';

  @override
  String get letterPracticing => '练习中';

  @override
  String get letterUnseen => '还没遇到';

  @override
  String get typeHunt => '字母音';

  @override
  String get typeJoin => '音节';

  @override
  String get typeRhyme => '押韵';

  @override
  String get promptHunt => '听到了哪个字母？点一点';

  @override
  String get promptJoin => '把音节连起来——滑出整个词';

  @override
  String get promptRhyme => '哪个押韵？点图片';

  @override
  String get expeditionTitle => '复习探险';

  @override
  String get badgeExpedition => '探险家';

  @override
  String get badgeExpeditionHow => '第一次每周复习探险';
}
