// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Vietnamese (`vi`).
class AppLocalizationsVi extends AppLocalizations {
  AppLocalizationsVi([String locale = 'vi']) : super(locale);

  @override
  String get appTitle => 'SwypeKids';

  @override
  String get menuSyllabary => 'Tập đánh vần (Swype)';

  @override
  String get menuSentence => 'Ghép câu';

  @override
  String get menuZoo => 'Vườn thú';

  @override
  String get menuBook => 'Sách của mình';

  @override
  String get menuParents => 'Dành cho phụ huynh';

  @override
  String get practiceTitle => 'Luyện tập';

  @override
  String bedtimeText(String guide) {
    return '$guide ngủ rồi. Mai gặp lại nhé!';
  }

  @override
  String get typeListen => 'NGHE';

  @override
  String get typePicture => 'HÌNH';

  @override
  String get typeGap => 'ĐIỀN CHỮ';

  @override
  String get typeReview => 'ÔN TẬP';

  @override
  String get typeWord => 'TỪ';

  @override
  String get typeSyllable => 'ÂM TIẾT';

  @override
  String get promptListen => 'Nghe rồi vuốt theo điều bạn nghe được';

  @override
  String get promptPicture => 'Trong hình là gì? Viết ra nhé';

  @override
  String get promptGap => 'Thiếu chữ cái nào? Vuốt cả từ nhé';

  @override
  String get promptSwipeTouch => 'Vuốt ngón tay qua các hình';

  @override
  String get promptSwipeTrackpad => 'Vuốt hai ngón tay qua các hình';

  @override
  String get successText => 'Giỏi lắm!';

  @override
  String get errorText => 'Thử lại nhé!';

  @override
  String get newSticker => 'Bạn có hình dán mới!';

  @override
  String starsGained(int count) {
    return '+$count sao';
  }

  @override
  String get backToMap => 'Về bản đồ';

  @override
  String get winTitle => 'Xong rồi!\nBạn là nhà vô địch!';

  @override
  String winStars(int count) {
    return 'Bạn đã giành được $count sao!';
  }

  @override
  String get playAgain => 'Chơi lại';

  @override
  String get builderBadge => 'CÂU';

  @override
  String get who => 'AI';

  @override
  String get whatDoes => 'LÀM GÌ';

  @override
  String get whatWhere => 'CÁI GÌ / Ở ĐÂU';

  @override
  String get newLabel => 'MỚI';

  @override
  String get clear => 'Xóa';

  @override
  String get bookTitle => 'Sách của mình';

  @override
  String get bookEmptyHint => 'Ghép một câu rồi lưu vào sách nhé';

  @override
  String get zooTitle => 'Vườn thú';

  @override
  String badgesTitle(int earned, int total) {
    return 'Huy hiệu $earned/$total';
  }

  @override
  String get badgeFirstSwype => 'Lần vuốt đầu tiên';

  @override
  String get badgeFirstSwypeHow => 'Lần vuốt đúng đầu tiên';

  @override
  String get badgeNoMistake => 'Không sai lần nào';

  @override
  String get badgeNoMistakeHow => 'Cả chủ đề đều đạt ba sao';

  @override
  String get badgeExplorer => 'Nhà thám hiểm';

  @override
  String get badgeExplorerHow => 'Hình dán đầu tiên';

  @override
  String get badgeCollectorHalf => 'Nhà sưu tầm';

  @override
  String get badgeCollectorHalfHow => 'Một nửa Vườn thú';

  @override
  String get badgeCollectorAll => 'Nhà sưu tầm lớn';

  @override
  String get badgeCollectorAllHow => 'Cả Vườn thú';

  @override
  String get badgeNightOwl => 'Cú đêm';

  @override
  String get badgeNightOwlHow => 'Đã chơi vào ban đêm';

  @override
  String get badgeEarlyBird => 'Chim dậy sớm';

  @override
  String get badgeEarlyBirdHow => 'Đã chơi vào buổi sáng';

  @override
  String get badgeFourSeasons => 'Bốn mùa';

  @override
  String get badgeFourSeasonsHow => 'Đã chơi trong cả bốn mùa';

  @override
  String get badgeWordsmith10 => 'Bạn nhỏ gom từ';

  @override
  String get badgeWordsmith10How => '10 từ trong túi';

  @override
  String get badgeWordsmith25 => 'Tay gom từ cừ khôi';

  @override
  String get badgeWordsmith25How => '25 từ trong túi';

  @override
  String get badgeWordsmith50 => 'Bậc thầy từ ngữ';

  @override
  String get badgeWordsmith50How => '50 từ trong túi';

  @override
  String get badgePoet => 'Nhà thơ';

  @override
  String get badgePoetHow => '10 câu trong Sách của mình';

  @override
  String get badgeListener => 'Đôi tai thính';

  @override
  String get badgeListenerHow => '10 lượt nghe đạt ba sao';

  @override
  String get badgePersistent => 'Bền bỉ';

  @override
  String get badgePersistentHow => '7 ngày chơi';

  @override
  String get parentTitle => 'Dành cho phụ huynh';

  @override
  String gateQuestion(int a, int b) {
    return '$a × $b bằng bao nhiêu?';
  }

  @override
  String get backToGame => 'Quay lại trò chơi';

  @override
  String get sectionOverview => 'Tổng quan';

  @override
  String get sectionLetters => 'Chữ cái';

  @override
  String get sectionTips => 'Gợi ý luyện ở nhà';

  @override
  String get sectionMethod => 'Ứng dụng dạy như thế nào';

  @override
  String get sectionSettings => 'Cài đặt';

  @override
  String get statProfile => 'hồ sơ';

  @override
  String get statPlayDays => 'ngày chơi';

  @override
  String get statLessons => 'bài học';

  @override
  String get statStars => 'sao';

  @override
  String get statWords => 'từ trong túi';

  @override
  String get statSentences => 'câu trong Sách của mình';

  @override
  String get statBadges => 'huy hiệu';

  @override
  String get lettersLegend => '🟢 đã thành thạo · 🟡 đang luyện · ⚪ chưa gặp';

  @override
  String troubleWords(String letter, String words) {
    return 'Các từ có chữ $letter hay bị nhầm: $words';
  }

  @override
  String get tipNoData =>
      'Chưa có gì để luyện — gợi ý sẽ hiện ra sau vài bài học.';

  @override
  String tipWeakest(String words) {
    return 'Các từ còn yếu nhất: $words. Ở nhà, hãy thử cùng bé vỗ tay theo từng âm tiết và tìm những thứ bắt đầu bằng các âm đó.';
  }

  @override
  String tipLetter(String letter) {
    return 'Chữ $letter bé vẫn chưa vững: hãy cùng bé tìm trong nhà những thứ bắt đầu bằng chữ $letter.';
  }

  @override
  String get tipLongPress =>
      'Nhấn giữ một bài học trên bản đồ để xem bài đó luyện gì và vì sao.';

  @override
  String methodLabel(String method) {
    return 'Phương pháp: $method';
  }

  @override
  String get methodText =>
      'Bé vuốt ngón tay qua các chữ cái theo đúng thứ tự bé nghe thấy trong âm tiết hoặc từ. Đầu tiên là các âm tiết mở (MA, TA), sau đó là cả từ, các lượt nghe không có chữ, các lượt điền chữ còn thiếu và ôn lại những từ còn yếu nhất. Lỗi sai không bao giờ chặn bước tiến của bé — thẻ chỉ rung nhẹ và đưa ra gợi ý. Từ đã học được bé dùng ngay trong câu (phần ghép câu) và có thể lưu vào Sách của mình.';

  @override
  String get settingSounds => 'Âm thanh';

  @override
  String get settingAmbient => 'Âm thanh thế giới';

  @override
  String get settingMusic => 'Nhạc';

  @override
  String get settingLeftHanded => 'Thuận tay trái (bàn phím đảo chiều)';

  @override
  String get settingDyslexiaFont =>
      'Phông chữ cho người khó đọc (OpenDyslexic)';

  @override
  String get settingSeason => 'Mùa trên bản đồ';

  @override
  String get seasonAuto => 'theo lịch';

  @override
  String get seasonSpring => 'xuân';

  @override
  String get seasonSummer => 'hạ';

  @override
  String get seasonAutumn => 'thu';

  @override
  String get seasonWinter => 'đông';

  @override
  String get settingTimeLimit => 'Giới hạn thời gian chơi mỗi ngày';

  @override
  String get noLimit => 'không giới hạn';

  @override
  String minutes(int n) {
    return '$n phút';
  }

  @override
  String playedToday(int played) {
    return 'Hôm nay đã chơi $played phút';
  }

  @override
  String playedTodayOf(int played, int limit) {
    return 'Hôm nay đã chơi $played trên $limit phút';
  }

  @override
  String get guideAsleep => ' — bạn dẫn đường ngủ rồi';

  @override
  String extendToday(int n) {
    return 'Thêm $n phút cho hôm nay';
  }

  @override
  String get profilesTitle => 'Hồ sơ';

  @override
  String deleteProfileTitle(String name) {
    return 'Xóa hồ sơ $name?';
  }

  @override
  String get deleteProfileBody =>
      'Toàn bộ tiến độ, hình dán và cuốn sách cũng sẽ bị xóa. Không thể hoàn tác.';

  @override
  String get cancel => 'Hủy';

  @override
  String get delete => 'Xóa';

  @override
  String get statMinutesToday => 'phút hôm nay';

  @override
  String get statMinutesWeek => 'phút tuần này';

  @override
  String get letterMastered => 'đã thành thạo';

  @override
  String get letterPracticing => 'đang luyện';

  @override
  String get letterUnseen => 'chưa gặp';

  @override
  String get typeHunt => 'ÂM';

  @override
  String get typeJoin => 'GHÉP VẦN';

  @override
  String get typeRhyme => 'VẦN';

  @override
  String get promptHunt => 'Bạn nghe thấy chữ cái nào? Chạm vào nhé';

  @override
  String get promptJoin => 'Ghép các âm tiết — vuốt cả từ nhé';

  @override
  String get promptRhyme => 'Từ nào vần với nhau? Chạm vào hình nhé';

  @override
  String get expeditionTitle => 'Chuyến thám hiểm ôn tập';

  @override
  String get badgeExpedition => 'Nhà thám hiểm ôn tập';

  @override
  String get badgeExpeditionHow => 'Chuyến thám hiểm ôn tập hằng tuần đầu tiên';

  @override
  String get seasonStickersTitle => 'Hình dán bốn mùa';

  @override
  String get mapLoadFailed => 'Không tải được bản đồ';

  @override
  String get retry => 'Thử lại';

  @override
  String get vocativeLabel => 'Cách gọi tên trong tiếng Séc (hô cách)';

  @override
  String get vocativeHint => 'ví dụ: Lauro';

  @override
  String get guideTitle => 'Bạn dẫn đường của bạn';

  @override
  String get petPlay => 'Cùng chơi nào';

  @override
  String get badgeHost => 'Chủ nhà hiếu khách';

  @override
  String get badgeHostHow => '10 món quà cho các bạn thú';

  @override
  String get badgeCuddler => 'Bạn nhỏ âu yếm';

  @override
  String get badgeCuddlerHow => 'Đã vuốt ve 5 bạn thú';

  @override
  String get badgeWishMaker => 'Điều ước thành thật';

  @override
  String get badgeWishMakerHow => '10 điều ước được thực hiện';

  @override
  String get badgeFriendOfAll => 'Bạn của muôn loài';

  @override
  String get badgeFriendOfAllHow => 'Bạn thú nào cũng đã được tặng quà';

  @override
  String get settingPetRounds => 'Quà cho các bạn thú: viết từ trước đã';

  @override
  String get petBowlFood => 'bát ăn';

  @override
  String get petBowlWater => 'nước';

  @override
  String get storeIslandA => 'Đảo Chữ cái';

  @override
  String get storeIslandB => 'Đảo Từ';

  @override
  String get storeIslandC => 'Đảo Câu';

  @override
  String storeProductIsland(String island, String language) {
    return '$island – $language';
  }

  @override
  String storeProductIslandDesc(String language) {
    return 'Chủ đề mới, hình dán mới và những cư dân mới của thế giới thú cưng. Ngôn ngữ: $language.';
  }

  @override
  String storeProductLanguage(String language) {
    return 'Thêm ngôn ngữ – $language';
  }

  @override
  String storeProductLanguageDesc(String island, String language) {
    return '$island bằng một ngôn ngữ khác: $language.';
  }

  @override
  String get storeProductBundle => 'Tất cả, mãi mãi';

  @override
  String get storeProductBundleDesc =>
      'Tất cả các đảo và ngôn ngữ, kể cả những phần sẽ ra mắt sau này.';

  @override
  String get storeProductParent => 'Gói dành cho phụ huynh';

  @override
  String get storeProductParentDesc =>
      'Phiếu bài tập, in Sách của mình, tổng quan hằng tuần và chuyển tiến độ.';

  @override
  String get storeStateFree => 'miễn phí';

  @override
  String get storeStateOwned => 'đã có';

  @override
  String storeBuy(String price) {
    return 'Mua với giá $price';
  }

  @override
  String get storeRestore => 'Khôi phục giao dịch mua';

  @override
  String get storeDebugTitle => 'Cửa hàng (gỡ lỗi)';

  @override
  String get storeDebugEnable => 'Mô phỏng cửa hàng đang bật';

  @override
  String get storeDebugForget => 'Quên các giao dịch mua';

  @override
  String get homeLanguageLabel => 'Ngôn ngữ của gia đình (menu và gợi ý)';

  @override
  String get homeLanguageSame => 'Giống ngôn ngữ của trò chơi';
}
