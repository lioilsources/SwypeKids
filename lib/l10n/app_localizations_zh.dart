// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get appTitle => 'SwypeKids';

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
  String bedtimeText(String guide) {
    return '$guide睡着了，明天见！';
  }

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

  @override
  String get seasonStickersTitle => '季节贴纸';

  @override
  String get mapLoadFailed => '地图加载失败';

  @override
  String get retry => '重试';

  @override
  String get vocativeLabel => '捷克语称呼（呼格）';

  @override
  String get vocativeHint => '例如 Lauro';

  @override
  String get guideTitle => '你的小伙伴';

  @override
  String get petPlay => '一起玩';

  @override
  String get badgeHost => '小主人';

  @override
  String get badgeHostHow => '给小动物10份礼物';

  @override
  String get badgeCuddler => '抱抱';

  @override
  String get badgeCuddlerHow => '摸过5只小动物';

  @override
  String get badgeWishMaker => '愿望成真';

  @override
  String get badgeWishMakerHow => '实现10个愿望';

  @override
  String get badgeFriendOfAll => '大家的朋友';

  @override
  String get badgeFriendOfAllHow => '每只小动物都收到礼物';

  @override
  String get settingPetRounds => '给小动物送礼物：先写出这个词';

  @override
  String get petBowlFood => '碗';

  @override
  String get petBowlWater => '水';

  @override
  String get storeIslandA => '字母岛';

  @override
  String get storeIslandB => '词语岛';

  @override
  String get storeIslandC => '句子岛';

  @override
  String storeProductIsland(String island, String language) {
    return '$island – $language';
  }

  @override
  String storeProductIslandDesc(String language) {
    return '新的单元、贴纸和动物世界的居民。语言：$language。';
  }

  @override
  String storeProductLanguage(String language) {
    return '另一种语言 – $language';
  }

  @override
  String storeProductLanguageDesc(String island, String language) {
    return '另一种语言的$island：$language。';
  }

  @override
  String get storeProductBundle => '永久全部';

  @override
  String get storeProductBundleDesc => '所有岛屿和语言，包括以后新增的内容。';

  @override
  String get storeProductParent => '家长包';

  @override
  String get storeProductParentDesc => '练习纸、打印“我的书”、每周概览和进度转移。';

  @override
  String get storeStateFree => '免费';

  @override
  String get storeStateOwned => '已拥有';

  @override
  String storeBuy(String price) {
    return '以 $price 购买';
  }

  @override
  String get storeRestore => '恢复购买';

  @override
  String get storeDebugTitle => '商店（调试）';

  @override
  String get storeDebugEnable => '模拟已开启的商店';

  @override
  String get storeDebugForget => '清除购买记录';

  @override
  String get homeLanguageLabel => '家庭语言（菜单和提示）';

  @override
  String get homeLanguageSame => '与游戏语言相同';

  @override
  String get parentPrivacy => '隐私政策';
}

/// The translations for Chinese, using the Han script (`zh_Hant`).
class AppLocalizationsZhHant extends AppLocalizationsZh {
  AppLocalizationsZhHant() : super('zh_Hant');

  @override
  String get appTitle => 'SwypeKids';

  @override
  String get menuSyllabary => '字母表（滑一滑）';

  @override
  String get menuSentence => '造句';

  @override
  String get menuZoo => '動物園';

  @override
  String get menuBook => '我的書';

  @override
  String get menuParents => '給家長';

  @override
  String get practiceTitle => '練習';

  @override
  String bedtimeText(String guide) {
    return '$guide睡著了。明天見！';
  }

  @override
  String get typeListen => '聆聽';

  @override
  String get typePicture => '圖片';

  @override
  String get typeGap => '填空';

  @override
  String get typeReview => '複習';

  @override
  String get typeWord => '單字';

  @override
  String get typeSyllable => '音節';

  @override
  String get promptListen => '聽一聽，把聽到的滑出來';

  @override
  String get promptPicture => '圖片裡是什麼？把它寫出來';

  @override
  String get promptGap => '少了哪個字母？把整個單字滑出來';

  @override
  String get promptSwipeTouch => '用手指滑過圖片';

  @override
  String get promptSwipeTrackpad => '用兩根手指滑過圖片';

  @override
  String get successText => '太棒了！';

  @override
  String get errorText => '再試一次！';

  @override
  String get newSticker => '你得到一張新貼紙！';

  @override
  String starsGained(int count) {
    return '+$count 顆星';
  }

  @override
  String get backToMap => '回到地圖';

  @override
  String get winTitle => '完成了！\n你是冠軍！';

  @override
  String winStars(int count) {
    return '你贏得了 $count 顆星！';
  }

  @override
  String get playAgain => '再玩一次';

  @override
  String get builderBadge => '句子';

  @override
  String get who => '誰';

  @override
  String get whatDoes => '做什麼';

  @override
  String get whatWhere => '什麼／去哪裡';

  @override
  String get newLabel => '新';

  @override
  String get clear => '清除';

  @override
  String get bookTitle => '我的書';

  @override
  String get bookEmptyHint => '造一個句子並存進書裡';

  @override
  String get zooTitle => '動物園';

  @override
  String badgesTitle(int earned, int total) {
    return '徽章 $earned/$total';
  }

  @override
  String get badgeFirstSwype => '第一次滑動';

  @override
  String get badgeFirstSwypeHow => '第一次滑對';

  @override
  String get badgeNoMistake => '零失誤';

  @override
  String get badgeNoMistakeHow => '整個單元全拿三顆星';

  @override
  String get badgeExplorer => '探險家';

  @override
  String get badgeExplorerHow => '第一張貼紙';

  @override
  String get badgeCollectorHalf => '收集者';

  @override
  String get badgeCollectorHalfHow => '動物園的一半';

  @override
  String get badgeCollectorAll => '大收集家';

  @override
  String get badgeCollectorAllHow => '整座動物園';

  @override
  String get badgeNightOwl => '夜貓子';

  @override
  String get badgeNightOwlHow => '在夜晚玩過';

  @override
  String get badgeEarlyBird => '早起鳥';

  @override
  String get badgeEarlyBirdHow => '在早晨玩過';

  @override
  String get badgeFourSeasons => '四季';

  @override
  String get badgeFourSeasonsHow => '每個季節都玩過';

  @override
  String get badgeWordsmith10 => '單字匠';

  @override
  String get badgeWordsmith10How => '背包裡有 10 個單字';

  @override
  String get badgeWordsmith25 => '大單字匠';

  @override
  String get badgeWordsmith25How => '背包裡有 25 個單字';

  @override
  String get badgeWordsmith50 => '單字大師';

  @override
  String get badgeWordsmith50How => '背包裡有 50 個單字';

  @override
  String get badgePoet => '詩人';

  @override
  String get badgePoetHow => '我的書裡有 10 個句子';

  @override
  String get badgeListener => '聆聽者';

  @override
  String get badgeListenerHow => '10 個聆聽回合拿三顆星';

  @override
  String get badgePersistent => '堅持不懈';

  @override
  String get badgePersistentHow => '玩了 7 天';

  @override
  String get parentTitle => '給家長';

  @override
  String gateQuestion(int a, int b) {
    return '$a × $b 等於多少？';
  }

  @override
  String get backToGame => '回到遊戲';

  @override
  String get sectionOverview => '總覽';

  @override
  String get sectionLetters => '字母';

  @override
  String get sectionTips => '在家的建議';

  @override
  String get sectionMethod => 'App 如何教學';

  @override
  String get sectionSettings => '設定';

  @override
  String get statProfile => '個人檔案';

  @override
  String get statPlayDays => '遊玩天數';

  @override
  String get statLessons => '課程';

  @override
  String get statStars => '星星';

  @override
  String get statWords => '背包裡的單字';

  @override
  String get statSentences => '我的書裡的句子';

  @override
  String get statBadges => '徽章';

  @override
  String get lettersLegend => '🟢 已掌握 · 🟡 練習中 · ⚪ 還沒遇到';

  @override
  String troubleWords(String letter, String words) {
    return '含有 $letter 容易搞混的單字：$words';
  }

  @override
  String get tipNoData => '目前沒有需要練習的內容，上幾堂課後就會出現建議。';

  @override
  String tipWeakest(String words) {
    return '最弱的單字：$words。在家可以照音節拍手念，並一起找以它們開頭的東西。';
  }

  @override
  String tipLetter(String letter) {
    return '字母 $letter 還不太穩：在家一起找以 $letter 開頭的東西。';
  }

  @override
  String get tipLongPress => '在地圖上長按一堂課，就能看到它練習什麼、為什麼。';

  @override
  String methodLabel(String method) {
    return '方法：$method';
  }

  @override
  String get methodText =>
      '孩子照著聽到音節或單字的順序，用手指滑過字母。先是開音節（MA、TA），接著是完整單字、沒有文字的聆聽回合、填空回合，以及最弱單字的複習。錯誤從不會擋住進度，卡片只會抖一下並給提示。學過的單字馬上用在句子裡（造句器），還能存進「我的書」。';

  @override
  String get settingSounds => '聲音';

  @override
  String get settingAmbient => '世界的聲音';

  @override
  String get settingMusic => '音樂';

  @override
  String get settingLeftHanded => '左撇子（鏡像鍵盤）';

  @override
  String get settingDyslexiaFont => '閱讀障礙友善字體（OpenDyslexic）';

  @override
  String get settingSeason => '地圖上的季節';

  @override
  String get seasonAuto => '依照日曆';

  @override
  String get seasonSpring => '春';

  @override
  String get seasonSummer => '夏';

  @override
  String get seasonAutumn => '秋';

  @override
  String get seasonWinter => '冬';

  @override
  String get settingTimeLimit => '每日遊玩時間上限';

  @override
  String get noLimit => '無上限';

  @override
  String minutes(int n) {
    return '$n 分鐘';
  }

  @override
  String playedToday(int played) {
    return '今天已玩：$played 分鐘';
  }

  @override
  String playedTodayOf(int played, int limit) {
    return '今天已玩：$played / $limit 分鐘';
  }

  @override
  String get guideAsleep => ' ，嚮導睡著了';

  @override
  String extendToday(int n) {
    return '今天延長 $n 分鐘';
  }

  @override
  String get profilesTitle => '個人檔案';

  @override
  String deleteProfileTitle(String name) {
    return '刪除個人檔案「$name」？';
  }

  @override
  String get deleteProfileBody => '所有進度、貼紙和書也會一併刪除，無法復原。';

  @override
  String get cancel => '取消';

  @override
  String get delete => '刪除';

  @override
  String get statMinutesToday => '今天的分鐘數';

  @override
  String get statMinutesWeek => '本週的分鐘數';

  @override
  String get letterMastered => '已掌握';

  @override
  String get letterPracticing => '練習中';

  @override
  String get letterUnseen => '還沒遇到';

  @override
  String get typeHunt => '發音';

  @override
  String get typeJoin => '音節';

  @override
  String get typeRhyme => '押韻';

  @override
  String get promptHunt => '你聽到哪個字母？點一下它';

  @override
  String get promptJoin => '把音節連起來，滑出整個單字';

  @override
  String get promptRhyme => '哪個押韻？點一下圖片';

  @override
  String get expeditionTitle => '複習遠征';

  @override
  String get badgeExpedition => '遠征隊員';

  @override
  String get badgeExpeditionHow => '第一次每週複習遠征';

  @override
  String get seasonStickersTitle => '季節貼紙';

  @override
  String get mapLoadFailed => '無法載入地圖';

  @override
  String get retry => '再試一次';

  @override
  String get vocativeLabel => '捷克語稱呼形式（呼格）';

  @override
  String get vocativeHint => '例如 Lauro';

  @override
  String get guideTitle => '你的嚮導';

  @override
  String get petPlay => '來玩吧';

  @override
  String get badgeHost => '小主人';

  @override
  String get badgeHostHow => '送給動物 10 份禮物';

  @override
  String get badgeCuddler => '愛撫者';

  @override
  String get badgeCuddlerHow => '摸了 5 隻動物';

  @override
  String get badgeWishMaker => '願望成真';

  @override
  String get badgeWishMakerHow => '實現了 10 個願望';

  @override
  String get badgeFriendOfAll => '大家的朋友';

  @override
  String get badgeFriendOfAllHow => '每隻動物都收到了禮物';

  @override
  String get settingPetRounds => '送動物禮物：先寫出單字';

  @override
  String get petBowlFood => '碗';

  @override
  String get petBowlWater => '水';

  @override
  String get storeIslandA => '字母島';

  @override
  String get storeIslandB => '單字島';

  @override
  String get storeIslandC => '句子島';

  @override
  String storeProductIsland(String island, String language) {
    return '$island – $language';
  }

  @override
  String storeProductIslandDesc(String language) {
    return '新的單元、貼紙和動物世界的居民。語言：$language。';
  }

  @override
  String storeProductLanguage(String language) {
    return '另一種語言 – $language';
  }

  @override
  String storeProductLanguageDesc(String island, String language) {
    return '另一種語言的$island：$language。';
  }

  @override
  String get storeProductBundle => '全部，永久擁有';

  @override
  String get storeProductBundleDesc => '所有島嶼和語言，包括之後新增的。';

  @override
  String get storeProductParent => '家長包';

  @override
  String get storeProductParentDesc => '練習單、列印「我的書」、每週總覽以及進度轉移。';

  @override
  String get storeStateFree => '免費';

  @override
  String get storeStateOwned => '已擁有';

  @override
  String storeBuy(String price) {
    return '以 $price 購買';
  }

  @override
  String get storeRestore => '還原購買';

  @override
  String get storeDebugTitle => '商店（除錯）';

  @override
  String get storeDebugEnable => '模擬已啟用的商店';

  @override
  String get storeDebugForget => '忘記購買紀錄';

  @override
  String get homeLanguageLabel => '家庭語言（選單與提示）';

  @override
  String get homeLanguageSame => '與遊戲語言相同';

  @override
  String get parentPrivacy => '隱私權政策';
}
