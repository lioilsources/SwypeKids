// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Korean (`ko`).
class AppLocalizationsKo extends AppLocalizations {
  AppLocalizationsKo([String locale = 'ko']) : super(locale);

  @override
  String get appTitle => 'SwypeKids';

  @override
  String get menuSyllabary => '글자판 (스와이프)';

  @override
  String get menuSentence => '문장 만들기';

  @override
  String get menuZoo => '동물원';

  @override
  String get menuBook => '내 책';

  @override
  String get menuParents => '부모님용';

  @override
  String get practiceTitle => '연습';

  @override
  String bedtimeText(String guide) {
    return '$guide가 자고 있어요. 내일 만나요!';
  }

  @override
  String get typeListen => '듣기';

  @override
  String get typePicture => '그림';

  @override
  String get typeGap => '채우기';

  @override
  String get typeReview => '복습';

  @override
  String get typeWord => '낱말';

  @override
  String get typeSyllable => '음절';

  @override
  String get promptListen => '들은 것을 손가락으로 쓸어 보세요';

  @override
  String get promptPicture => '그림에 무엇이 있나요? 써 보세요';

  @override
  String get promptGap => '어떤 글자가 빠졌나요? 낱말 전체를 쓸어 보세요';

  @override
  String get promptSwipeTouch => '그림 위로 손가락을 쓸어 보세요';

  @override
  String get promptSwipeTrackpad => '두 손가락으로 그림 위를 쓸어 보세요';

  @override
  String get successText => '잘했어요!';

  @override
  String get errorText => '다시 해 봐요!';

  @override
  String get newSticker => '새 스티커를 받았어요!';

  @override
  String starsGained(int count) {
    return '별 +$count개';
  }

  @override
  String get backToMap => '지도로 돌아가기';

  @override
  String get winTitle => '끝!\n당신은 챔피언!';

  @override
  String winStars(int count) {
    return '별 $count개를 얻었어요!';
  }

  @override
  String get playAgain => '다시 하기';

  @override
  String get builderBadge => '문장';

  @override
  String get who => '누가';

  @override
  String get whatDoes => '무엇을 해요';

  @override
  String get whatWhere => '무엇을 / 어디로';

  @override
  String get newLabel => '새로움';

  @override
  String get clear => '지우기';

  @override
  String get bookTitle => '내 책';

  @override
  String get bookEmptyHint => '문장을 만들어 책에 저장해 보세요';

  @override
  String get zooTitle => '동물원';

  @override
  String badgesTitle(int earned, int total) {
    return '배지 $earned/$total';
  }

  @override
  String get badgeFirstSwype => '첫 스와이프';

  @override
  String get badgeFirstSwypeHow => '처음으로 맞힌 스와이프';

  @override
  String get badgeNoMistake => '실수 없음';

  @override
  String get badgeNoMistakeHow => '한 단원 전체를 별 세 개로';

  @override
  String get badgeExplorer => '탐험가';

  @override
  String get badgeExplorerHow => '첫 스티커';

  @override
  String get badgeCollectorHalf => '수집가';

  @override
  String get badgeCollectorHalfHow => '동물원의 절반';

  @override
  String get badgeCollectorAll => '대수집가';

  @override
  String get badgeCollectorAllHow => '동물원 전체';

  @override
  String get badgeNightOwl => '밤 올빼미';

  @override
  String get badgeNightOwlHow => '밤에 플레이';

  @override
  String get badgeEarlyBird => '아침 새';

  @override
  String get badgeEarlyBirdHow => '아침에 플레이';

  @override
  String get badgeFourSeasons => '사계절';

  @override
  String get badgeFourSeasonsHow => '모든 계절에 플레이';

  @override
  String get badgeWordsmith10 => '낱말 장인';

  @override
  String get badgeWordsmith10How => '가방에 낱말 10개';

  @override
  String get badgeWordsmith25 => '큰 낱말 장인';

  @override
  String get badgeWordsmith25How => '가방에 낱말 25개';

  @override
  String get badgeWordsmith50 => '낱말 달인';

  @override
  String get badgeWordsmith50How => '가방에 낱말 50개';

  @override
  String get badgePoet => '시인';

  @override
  String get badgePoetHow => '내 책에 문장 10개';

  @override
  String get badgeListener => '경청가';

  @override
  String get badgeListenerHow => '별 세 개로 듣기 10라운드';

  @override
  String get badgePersistent => '끈기왕';

  @override
  String get badgePersistentHow => '플레이 7일';

  @override
  String get parentTitle => '부모님용';

  @override
  String gateQuestion(int a, int b) {
    return '$a × $b는 얼마일까요?';
  }

  @override
  String get backToGame => '게임으로 돌아가기';

  @override
  String get sectionOverview => '개요';

  @override
  String get sectionLetters => '글자';

  @override
  String get sectionTips => '집에서 해 볼 것';

  @override
  String get sectionMethod => '앱이 가르치는 방법';

  @override
  String get sectionSettings => '설정';

  @override
  String get statProfile => '프로필';

  @override
  String get statPlayDays => '플레이한 날';

  @override
  String get statLessons => '레슨';

  @override
  String get statStars => '별';

  @override
  String get statWords => '가방 속 낱말';

  @override
  String get statSentences => '내 책 속 문장';

  @override
  String get statBadges => '배지';

  @override
  String get lettersLegend => '🟢 익힘 · 🟡 연습 중 · ⚪ 아직 못 만남';

  @override
  String troubleWords(String letter, String words) {
    return '$letter가 들어가서 헷갈리는 낱말: $words';
  }

  @override
  String get tipNoData => '아직 연습할 것이 없어요. 몇 레슨 뒤에 팁이 나타나요.';

  @override
  String tipWeakest(String words) {
    return '가장 약한 낱말: $words. 집에서 음절마다 박수를 치며 말하고, 그 글자로 시작하는 물건을 찾아 보세요.';
  }

  @override
  String tipLetter(String letter) {
    return '글자 $letter가 아직 자리 잡는 중이에요. 집에서 $letter로 시작하는 물건을 함께 찾아 보세요.';
  }

  @override
  String get tipLongPress => '지도에서 레슨을 길게 누르면 무엇을 왜 연습하는지 보여 줘요.';

  @override
  String methodLabel(String method) {
    return '방법: $method';
  }

  @override
  String get methodText =>
      '아이는 음절이나 낱말을 들은 순서대로 글자 위를 손가락으로 쓸어요. 먼저 열린 음절(MA, TA), 그다음 온전한 낱말, 글 없이 듣기 라운드, 빈칸 채우기 라운드, 가장 약한 낱말 복습 순서예요. 실수가 진행을 막지는 않아요. 카드가 흔들리며 힌트를 줄 뿐이에요. 배운 낱말은 바로 문장(문장 만들기)에 쓰이고 내 책에 저장할 수 있어요.';

  @override
  String get settingSounds => '소리';

  @override
  String get settingAmbient => '세상의 소리';

  @override
  String get settingMusic => '음악';

  @override
  String get settingLeftHanded => '왼손잡이 (좌우 반전 키보드)';

  @override
  String get settingDyslexiaFont => '난독증 친화 글꼴 (OpenDyslexic)';

  @override
  String get settingSeason => '지도의 계절';

  @override
  String get seasonAuto => '달력에 맞춤';

  @override
  String get seasonSpring => '봄';

  @override
  String get seasonSummer => '여름';

  @override
  String get seasonAutumn => '가을';

  @override
  String get seasonWinter => '겨울';

  @override
  String get settingTimeLimit => '하루 플레이 시간 제한';

  @override
  String get noLimit => '제한 없음';

  @override
  String minutes(int n) {
    return '$n분';
  }

  @override
  String playedToday(int played) {
    return '오늘 플레이: $played분';
  }

  @override
  String playedTodayOf(int played, int limit) {
    return '오늘 플레이: $limit분 중 $played분';
  }

  @override
  String get guideAsleep => ' — 안내자가 자고 있어요';

  @override
  String extendToday(int n) {
    return '오늘 $n분 연장';
  }

  @override
  String get profilesTitle => '프로필';

  @override
  String deleteProfileTitle(String name) {
    return '$name 프로필을 삭제할까요?';
  }

  @override
  String get deleteProfileBody => '모든 진행 상황, 스티커, 책도 함께 삭제됩니다. 되돌릴 수 없어요.';

  @override
  String get cancel => '취소';

  @override
  String get delete => '삭제';

  @override
  String get statMinutesToday => '오늘 분';

  @override
  String get statMinutesWeek => '이번 주 분';

  @override
  String get letterMastered => '익힘';

  @override
  String get letterPracticing => '연습 중';

  @override
  String get letterUnseen => '아직 못 만남';

  @override
  String get typeHunt => '소리';

  @override
  String get typeJoin => '음절';

  @override
  String get typeRhyme => '운';

  @override
  String get promptHunt => '어떤 글자가 들렸나요? 눌러 보세요';

  @override
  String get promptJoin => '음절을 이어요. 낱말 전체를 쓸어 보세요';

  @override
  String get promptRhyme => '무엇과 운이 맞나요? 그림을 눌러 보세요';

  @override
  String get expeditionTitle => '복습 탐험';

  @override
  String get badgeExpedition => '탐험대원';

  @override
  String get badgeExpeditionHow => '첫 주간 복습 탐험';

  @override
  String get seasonStickersTitle => '계절 스티커';

  @override
  String get mapLoadFailed => '지도를 불러오지 못했어요';

  @override
  String get retry => '다시 시도';

  @override
  String get vocativeLabel => '체코어 호칭 형태(호격)';

  @override
  String get vocativeHint => '예: Lauro';

  @override
  String get guideTitle => '나의 안내자';

  @override
  String get petPlay => '같이 놀자';

  @override
  String get badgeHost => '집주인';

  @override
  String get badgeHostHow => '동물에게 선물 10개';

  @override
  String get badgeCuddler => '쓰다듬이';

  @override
  String get badgeCuddlerHow => '동물 5마리 쓰다듬기';

  @override
  String get badgeWishMaker => '이루어진 소원';

  @override
  String get badgeWishMakerHow => '소원 10개 이루기';

  @override
  String get badgeFriendOfAll => '모두의 친구';

  @override
  String get badgeFriendOfAllHow => '모든 동물이 선물을 받았어요';

  @override
  String get settingPetRounds => '동물에게 선물: 먼저 낱말 쓰기';

  @override
  String get petBowlFood => '그릇';

  @override
  String get petBowlWater => '물';

  @override
  String get storeIslandA => '글자 섬';

  @override
  String get storeIslandB => '낱말 섬';

  @override
  String get storeIslandC => '문장 섬';

  @override
  String storeProductIsland(String island, String language) {
    return '$island – $language';
  }

  @override
  String storeProductIslandDesc(String language) {
    return '새 단원, 스티커, 동물 세계의 주민들. 언어: $language.';
  }

  @override
  String storeProductLanguage(String language) {
    return '다른 언어 – $language';
  }

  @override
  String storeProductLanguageDesc(String island, String language) {
    return '다른 언어의 $island: $language.';
  }

  @override
  String get storeProductBundle => '모두 영원히';

  @override
  String get storeProductBundleDesc => '모든 섬과 언어, 앞으로 추가될 것까지.';

  @override
  String get storeProductParent => '부모님 팩';

  @override
  String get storeProductParentDesc => '학습지, 내 책 인쇄, 주간 요약, 진행 상황 옮기기.';

  @override
  String get storeStateFree => '무료';

  @override
  String get storeStateOwned => '보유 중';

  @override
  String storeBuy(String price) {
    return '$price에 구매';
  }

  @override
  String get storeRestore => '구매 복원';

  @override
  String get storeDebugTitle => '스토어 (디버그)';

  @override
  String get storeDebugEnable => '활성화된 스토어 시뮬레이션';

  @override
  String get storeDebugForget => '구매 기록 지우기';

  @override
  String get homeLanguageLabel => '가족 언어 (메뉴와 도움말)';

  @override
  String get homeLanguageSame => '게임 언어와 같게';

  @override
  String get parentPrivacy => '개인정보 처리방침';
}
