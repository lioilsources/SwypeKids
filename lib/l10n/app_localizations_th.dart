// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Thai (`th`).
class AppLocalizationsTh extends AppLocalizations {
  AppLocalizationsTh([String locale = 'th']) : super(locale);

  @override
  String get appTitle => 'SwypeKids';

  @override
  String get menuSyllabary => 'แบบเรียน (สไวป์)';

  @override
  String get menuSentence => 'ต่อประโยค';

  @override
  String get menuZoo => 'สวนสัตว์';

  @override
  String get menuBook => 'หนังสือของฉัน';

  @override
  String get menuParents => 'สำหรับผู้ปกครอง';

  @override
  String get practiceTitle => 'ฝึกฝน';

  @override
  String bedtimeText(String guide) {
    return '$guide หลับแล้ว พบกันพรุ่งนี้!';
  }

  @override
  String get typeListen => 'ฟัง';

  @override
  String get typePicture => 'ภาพ';

  @override
  String get typeGap => 'เติมคำ';

  @override
  String get typeReview => 'ทบทวน';

  @override
  String get typeWord => 'คำ';

  @override
  String get typeSyllable => 'พยางค์';

  @override
  String get promptListen => 'ฟังแล้วลากนิ้วตามที่ได้ยิน';

  @override
  String get promptPicture => 'ในภาพมีอะไร? เขียนคำนั้น';

  @override
  String get promptGap => 'ตัวอักษรไหนหายไป? ลากนิ้วทั้งคำ';

  @override
  String get promptSwipeTouch => 'ลากนิ้วผ่านรูปภาพ';

  @override
  String get promptSwipeTrackpad => 'ลากสองนิ้วผ่านรูปภาพ';

  @override
  String get successText => 'เก่งมาก!';

  @override
  String get errorText => 'ลองอีกครั้งนะ!';

  @override
  String get newSticker => 'คุณได้สติกเกอร์ใหม่!';

  @override
  String starsGained(int count) {
    return '+$count ดาว';
  }

  @override
  String get backToMap => 'กลับไปที่แผนที่';

  @override
  String get winTitle => 'เสร็จแล้ว!\nคุณคือแชมป์!';

  @override
  String winStars(int count) {
    return 'คุณได้ $count ดาว!';
  }

  @override
  String get playAgain => 'เล่นอีกครั้ง';

  @override
  String get builderBadge => 'ประโยค';

  @override
  String get who => 'ใคร';

  @override
  String get whatDoes => 'ทำอะไร';

  @override
  String get whatWhere => 'อะไร / ที่ไหน';

  @override
  String get newLabel => 'ใหม่';

  @override
  String get clear => 'ล้าง';

  @override
  String get bookTitle => 'หนังสือของฉัน';

  @override
  String get bookEmptyHint => 'ต่อประโยคแล้วเก็บไว้ในหนังสือ';

  @override
  String get zooTitle => 'สวนสัตว์';

  @override
  String badgesTitle(int earned, int total) {
    return 'เหรียญ $earned/$total';
  }

  @override
  String get badgeFirstSwype => 'ลากครั้งแรก';

  @override
  String get badgeFirstSwypeHow => 'ลากถูกต้องครั้งแรก';

  @override
  String get badgeNoMistake => 'ไม่ผิดเลย';

  @override
  String get badgeNoMistakeHow => 'ทั้งหน่วยได้สามดาว';

  @override
  String get badgeExplorer => 'นักสำรวจ';

  @override
  String get badgeExplorerHow => 'สติกเกอร์แรก';

  @override
  String get badgeCollectorHalf => 'นักสะสม';

  @override
  String get badgeCollectorHalfHow => 'ครึ่งหนึ่งของสวนสัตว์';

  @override
  String get badgeCollectorAll => 'นักสะสมตัวยง';

  @override
  String get badgeCollectorAllHow => 'ทั้งสวนสัตว์';

  @override
  String get badgeNightOwl => 'นกฮูกกลางคืน';

  @override
  String get badgeNightOwlHow => 'เล่นตอนกลางคืน';

  @override
  String get badgeEarlyBird => 'นกตื่นเช้า';

  @override
  String get badgeEarlyBirdHow => 'เล่นตอนเช้า';

  @override
  String get badgeFourSeasons => 'สี่ฤดู';

  @override
  String get badgeFourSeasonsHow => 'เล่นทุกฤดู';

  @override
  String get badgeWordsmith10 => 'ช่างคำ';

  @override
  String get badgeWordsmith10How => '10 คำในกระเป๋า';

  @override
  String get badgeWordsmith25 => 'ช่างคำตัวยง';

  @override
  String get badgeWordsmith25How => '25 คำในกระเป๋า';

  @override
  String get badgeWordsmith50 => 'เจ้าแห่งคำ';

  @override
  String get badgeWordsmith50How => '50 คำในกระเป๋า';

  @override
  String get badgePoet => 'กวี';

  @override
  String get badgePoetHow => '10 ประโยคในหนังสือของฉัน';

  @override
  String get badgeListener => 'นักฟัง';

  @override
  String get badgeListenerHow => 'ฟัง 10 รอบได้สามดาว';

  @override
  String get badgePersistent => 'ผู้มุ่งมั่น';

  @override
  String get badgePersistentHow => 'เล่น 7 วัน';

  @override
  String get parentTitle => 'สำหรับผู้ปกครอง';

  @override
  String gateQuestion(int a, int b) {
    return '$a × $b เท่ากับเท่าไร?';
  }

  @override
  String get backToGame => 'กลับไปที่เกม';

  @override
  String get sectionOverview => 'ภาพรวม';

  @override
  String get sectionLetters => 'ตัวอักษร';

  @override
  String get sectionTips => 'คำแนะนำสำหรับที่บ้าน';

  @override
  String get sectionMethod => 'แอปสอนอย่างไร';

  @override
  String get sectionSettings => 'การตั้งค่า';

  @override
  String get statProfile => 'โปรไฟล์';

  @override
  String get statPlayDays => 'วันที่เล่น';

  @override
  String get statLessons => 'บทเรียน';

  @override
  String get statStars => 'ดาว';

  @override
  String get statWords => 'คำในกระเป๋า';

  @override
  String get statSentences => 'ประโยคในหนังสือของฉัน';

  @override
  String get statBadges => 'เหรียญ';

  @override
  String get lettersLegend => '🟢 ทำได้แล้ว · 🟡 กำลังฝึก · ⚪ ยังไม่เจอ';

  @override
  String troubleWords(String letter, String words) {
    return 'คำที่มี $letter ซึ่งมักสับสน: $words';
  }

  @override
  String get tipNoData =>
      'ยังไม่มีอะไรให้ฝึก คำแนะนำจะปรากฏหลังเรียนไปสองสามบท';

  @override
  String tipWeakest(String words) {
    return 'คำที่อ่อนที่สุด: $words ลองปรบมือตามพยางค์ที่บ้านและหาสิ่งของที่ขึ้นต้นด้วยคำเหล่านั้น';
  }

  @override
  String tipLetter(String letter) {
    return 'ตัว $letter ยังไม่แม่น ลองช่วยกันหาสิ่งของที่ขึ้นต้นด้วย $letter ที่บ้าน';
  }

  @override
  String get tipLongPress =>
      'กดบทเรียนในแผนที่ค้างไว้เพื่อดูว่าฝึกอะไรและเพราะอะไร';

  @override
  String methodLabel(String method) {
    return 'วิธีการ: $method';
  }

  @override
  String get methodText =>
      'เด็กลากนิ้วผ่านตัวอักษรตามลำดับที่ได้ยินพยางค์หรือคำ เริ่มจากพยางค์เปิด (MA, TA) แล้วคำเต็ม รอบฟังโดยไม่มีข้อความ รอบเติมคำ และทบทวนคำที่อ่อนที่สุด ความผิดพลาดไม่เคยขวางการไปต่อ การ์ดแค่สั่นและให้คำใบ้ คำที่เรียนแล้วจะถูกนำไปใช้ในประโยคทันที (ตัวต่อประโยค) และเก็บไว้ในหนังสือของฉันได้';

  @override
  String get settingSounds => 'เสียง';

  @override
  String get settingAmbient => 'เสียงของโลก';

  @override
  String get settingMusic => 'ดนตรี';

  @override
  String get settingLeftHanded => 'ถนัดซ้าย (แป้นพิมพ์กลับด้าน)';

  @override
  String get settingDyslexiaFont =>
      'แบบอักษรสำหรับผู้มีภาวะดิสเล็กเซีย (OpenDyslexic)';

  @override
  String get settingSeason => 'ฤดูบนแผนที่';

  @override
  String get seasonAuto => 'ตามปฏิทิน';

  @override
  String get seasonSpring => 'ฤดูใบไม้ผลิ';

  @override
  String get seasonSummer => 'ฤดูร้อน';

  @override
  String get seasonAutumn => 'ฤดูใบไม้ร่วง';

  @override
  String get seasonWinter => 'ฤดูหนาว';

  @override
  String get settingTimeLimit => 'ขีดจำกัดเวลาเล่นต่อวัน';

  @override
  String get noLimit => 'ไม่จำกัด';

  @override
  String minutes(int n) {
    return '$n นาที';
  }

  @override
  String playedToday(int played) {
    return 'วันนี้เล่นไป $played นาที';
  }

  @override
  String playedTodayOf(int played, int limit) {
    return 'วันนี้เล่นไป $played จาก $limit นาที';
  }

  @override
  String get guideAsleep => ' — ผู้นำทางหลับอยู่';

  @override
  String extendToday(int n) {
    return 'เพิ่มเวลาวันนี้ $n นาที';
  }

  @override
  String get profilesTitle => 'โปรไฟล์';

  @override
  String deleteProfileTitle(String name) {
    return 'ลบโปรไฟล์ $name หรือไม่?';
  }

  @override
  String get deleteProfileBody =>
      'ความคืบหน้า สติกเกอร์ และหนังสือทั้งหมดจะถูกลบด้วย ย้อนกลับไม่ได้';

  @override
  String get cancel => 'ยกเลิก';

  @override
  String get delete => 'ลบ';

  @override
  String get statMinutesToday => 'นาทีวันนี้';

  @override
  String get statMinutesWeek => 'นาทีสัปดาห์นี้';

  @override
  String get letterMastered => 'ทำได้แล้ว';

  @override
  String get letterPracticing => 'กำลังฝึก';

  @override
  String get letterUnseen => 'ยังไม่เจอ';

  @override
  String get typeHunt => 'เสียง';

  @override
  String get typeJoin => 'พยางค์';

  @override
  String get typeRhyme => 'สัมผัส';

  @override
  String get promptHunt => 'ได้ยินตัวอักษรอะไร? แตะที่ตัวนั้น';

  @override
  String get promptJoin => 'ต่อพยางค์ แล้วลากนิ้วทั้งคำ';

  @override
  String get promptRhyme => 'อะไรสัมผัสกัน? แตะที่ภาพ';

  @override
  String get expeditionTitle => 'การเดินทางทบทวน';

  @override
  String get badgeExpedition => 'นักเดินทาง';

  @override
  String get badgeExpeditionHow => 'การเดินทางทบทวนประจำสัปดาห์ครั้งแรก';

  @override
  String get seasonStickersTitle => 'สติกเกอร์ฤดูกาล';

  @override
  String get mapLoadFailed => 'โหลดแผนที่ไม่สำเร็จ';

  @override
  String get retry => 'ลองอีกครั้ง';

  @override
  String get vocativeLabel => 'รูปการเรียกขานในภาษาเช็ก (กรณีเรียกขาน)';

  @override
  String get vocativeHint => 'เช่น Lauro';

  @override
  String get guideTitle => 'ผู้นำทางของคุณ';

  @override
  String get petPlay => 'มาเล่นกัน';

  @override
  String get badgeHost => 'เจ้าบ้าน';

  @override
  String get badgeHostHow => 'ของขวัญ 10 ชิ้นให้สัตว์';

  @override
  String get badgeCuddler => 'ขี้อ้อน';

  @override
  String get badgeCuddlerHow => 'ลูบสัตว์ 5 ตัว';

  @override
  String get badgeWishMaker => 'พรที่เป็นจริง';

  @override
  String get badgeWishMakerHow => 'พร 10 ข้อเป็นจริง';

  @override
  String get badgeFriendOfAll => 'เพื่อนของทุกตัว';

  @override
  String get badgeFriendOfAllHow => 'สัตว์ทุกตัวได้รับของขวัญ';

  @override
  String get settingPetRounds => 'ของขวัญให้สัตว์: เขียนคำก่อน';

  @override
  String get petBowlFood => 'ชาม';

  @override
  String get petBowlWater => 'น้ำ';

  @override
  String get storeIslandA => 'เกาะตัวอักษร';

  @override
  String get storeIslandB => 'เกาะคำ';

  @override
  String get storeIslandC => 'เกาะประโยค';

  @override
  String storeProductIsland(String island, String language) {
    return '$island – $language';
  }

  @override
  String storeProductIslandDesc(String language) {
    return 'หน่วยใหม่ สติกเกอร์ และชาวโลกสัตว์ ภาษา: $language';
  }

  @override
  String storeProductLanguage(String language) {
    return 'อีกหนึ่งภาษา – $language';
  }

  @override
  String storeProductLanguageDesc(String island, String language) {
    return '$island ในอีกภาษา: $language';
  }

  @override
  String get storeProductBundle => 'ทุกอย่างตลอดไป';

  @override
  String get storeProductBundleDesc => 'ทุกเกาะและทุกภาษา รวมถึงที่จะมาในอนาคต';

  @override
  String get storeProductParent => 'แพ็กผู้ปกครอง';

  @override
  String get storeProductParentDesc =>
      'ใบงาน การพิมพ์หนังสือของฉัน สรุปรายสัปดาห์ และการย้ายความคืบหน้า';

  @override
  String get storeStateFree => 'ฟรี';

  @override
  String get storeStateOwned => 'มีแล้ว';

  @override
  String storeBuy(String price) {
    return 'ซื้อในราคา $price';
  }

  @override
  String get storeRestore => 'กู้คืนการซื้อ';

  @override
  String get storeDebugTitle => 'ร้านค้า (ดีบัก)';

  @override
  String get storeDebugEnable => 'จำลองร้านค้าที่เปิดใช้งาน';

  @override
  String get storeDebugForget => 'ลืมการซื้อ';

  @override
  String get homeLanguageLabel => 'ภาษาของครอบครัว (เมนูและคำใบ้)';

  @override
  String get homeLanguageSame => 'เหมือนภาษาของเกม';

  @override
  String get parentPrivacy => 'นโยบายความเป็นส่วนตัว';
}
