// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Malay (`ms`).
class AppLocalizationsMs extends AppLocalizations {
  AppLocalizationsMs([String locale = 'ms']) : super(locale);

  @override
  String get appTitle => 'SwypeKids';

  @override
  String get menuSyllabary => 'Abjad (Swype)';

  @override
  String get menuSentence => 'Susun ayat';

  @override
  String get menuZoo => 'Zoo';

  @override
  String get menuBook => 'Buku saya';

  @override
  String get menuParents => 'Untuk ibu bapa';

  @override
  String get practiceTitle => 'Latihan';

  @override
  String bedtimeText(String guide) {
    return '$guide sudah tidur. Jumpa esok!';
  }

  @override
  String get typeListen => 'DENGAR';

  @override
  String get typePicture => 'GAMBAR';

  @override
  String get typeGap => 'LENGKAPKAN';

  @override
  String get typeReview => 'ULANGKAJI';

  @override
  String get typeWord => 'PERKATAAN';

  @override
  String get typeSyllable => 'SUKU KATA';

  @override
  String get promptListen => 'Dengar dan leret apa yang anda dengar';

  @override
  String get promptPicture => 'Apa dalam gambar? Tulislah';

  @override
  String get promptGap => 'Huruf apa yang hilang? Leret seluruh perkataan';

  @override
  String get promptSwipeTouch => 'Leretkan jari anda merentasi gambar';

  @override
  String get promptSwipeTrackpad => 'Leret dengan dua jari merentasi gambar';

  @override
  String get successText => 'Bagus!';

  @override
  String get errorText => 'Cuba lagi!';

  @override
  String get newSticker => 'Anda dapat pelekat baharu!';

  @override
  String starsGained(int count) {
    return '+$count bintang';
  }

  @override
  String get backToMap => 'Kembali ke peta';

  @override
  String get winTitle => 'Siap!\nAnda juara!';

  @override
  String winStars(int count) {
    return 'Anda mendapat $count bintang!';
  }

  @override
  String get playAgain => 'Main lagi';

  @override
  String get builderBadge => 'AYAT';

  @override
  String get who => 'SIAPA';

  @override
  String get whatDoes => 'BUAT APA';

  @override
  String get whatWhere => 'APA / KE MANA';

  @override
  String get newLabel => 'BAHARU';

  @override
  String get clear => 'Padam';

  @override
  String get bookTitle => 'Buku saya';

  @override
  String get bookEmptyHint => 'Susun satu ayat dan simpan dalam buku';

  @override
  String get zooTitle => 'Zoo';

  @override
  String badgesTitle(int earned, int total) {
    return 'Lencana $earned/$total';
  }

  @override
  String get badgeFirstSwype => 'Leretan pertama';

  @override
  String get badgeFirstSwypeHow => 'Leretan betul pertama';

  @override
  String get badgeNoMistake => 'Tanpa kesilapan';

  @override
  String get badgeNoMistakeHow => 'Satu unit penuh dengan tiga bintang';

  @override
  String get badgeExplorer => 'Penjelajah';

  @override
  String get badgeExplorerHow => 'Pelekat pertama';

  @override
  String get badgeCollectorHalf => 'Pengumpul';

  @override
  String get badgeCollectorHalfHow => 'Separuh zoo';

  @override
  String get badgeCollectorAll => 'Pengumpul hebat';

  @override
  String get badgeCollectorAllHow => 'Seluruh zoo';

  @override
  String get badgeNightOwl => 'Burung hantu malam';

  @override
  String get badgeNightOwlHow => 'Bermain pada waktu malam';

  @override
  String get badgeEarlyBird => 'Burung pagi';

  @override
  String get badgeEarlyBirdHow => 'Bermain pada waktu pagi';

  @override
  String get badgeFourSeasons => 'Empat musim';

  @override
  String get badgeFourSeasonsHow => 'Bermain pada setiap musim';

  @override
  String get badgeWordsmith10 => 'Tukang kata';

  @override
  String get badgeWordsmith10How => '10 perkataan dalam beg';

  @override
  String get badgeWordsmith25 => 'Tukang kata hebat';

  @override
  String get badgeWordsmith25How => '25 perkataan dalam beg';

  @override
  String get badgeWordsmith50 => 'Guru perkataan';

  @override
  String get badgeWordsmith50How => '50 perkataan dalam beg';

  @override
  String get badgePoet => 'Penyair';

  @override
  String get badgePoetHow => '10 ayat dalam Buku saya';

  @override
  String get badgeListener => 'Pendengar';

  @override
  String get badgeListenerHow => '10 pusingan mendengar dengan tiga bintang';

  @override
  String get badgePersistent => 'Gigih';

  @override
  String get badgePersistentHow => '7 hari bermain';

  @override
  String get parentTitle => 'Untuk ibu bapa';

  @override
  String gateQuestion(int a, int b) {
    return 'Berapakah $a × $b?';
  }

  @override
  String get backToGame => 'Kembali ke permainan';

  @override
  String get sectionOverview => 'Gambaran keseluruhan';

  @override
  String get sectionLetters => 'Huruf';

  @override
  String get sectionTips => 'Cadangan untuk di rumah';

  @override
  String get sectionMethod => 'Cara apl mengajar';

  @override
  String get sectionSettings => 'Tetapan';

  @override
  String get statProfile => 'profil';

  @override
  String get statPlayDays => 'hari bermain';

  @override
  String get statLessons => 'pelajaran';

  @override
  String get statStars => 'bintang';

  @override
  String get statWords => 'perkataan dalam beg';

  @override
  String get statSentences => 'ayat dalam Buku saya';

  @override
  String get statBadges => 'lencana';

  @override
  String get lettersLegend =>
      '🟢 dikuasai · 🟡 sedang berlatih · ⚪ belum ditemui';

  @override
  String troubleWords(String letter, String words) {
    return 'Perkataan dengan $letter yang sering tertukar: $words';
  }

  @override
  String get tipNoData =>
      'Belum ada apa-apa untuk dilatih — cadangan akan muncul selepas beberapa pelajaran.';

  @override
  String tipWeakest(String words) {
    return 'Perkataan paling lemah: $words. Cuba tepuk tangan mengikut suku kata di rumah dan cari benda yang bermula dengannya.';
  }

  @override
  String tipLetter(String letter) {
    return 'Huruf $letter masih belum mantap: cari bersama di rumah benda yang bermula dengan $letter.';
  }

  @override
  String get tipLongPress =>
      'Tekan lama pada pelajaran di peta untuk melihat apa yang dilatih dan mengapa.';

  @override
  String methodLabel(String method) {
    return 'Kaedah: $method';
  }

  @override
  String get methodText =>
      'Kanak-kanak meleret jari merentasi huruf mengikut urutan mereka mendengar suku kata atau perkataan. Mula-mula suku kata terbuka (MA, TA), kemudian perkataan penuh, pusingan mendengar tanpa teks, pusingan melengkapkan dan ulang kaji perkataan paling lemah. Kesilapan tidak pernah menghalang kemajuan — kad hanya bergetar dan memberi petunjuk. Perkataan yang dipelajari terus digunakan dalam ayat (penyusun ayat) dan boleh disimpan dalam Buku saya.';

  @override
  String get settingSounds => 'Bunyi';

  @override
  String get settingAmbient => 'Bunyi dunia';

  @override
  String get settingMusic => 'Muzik';

  @override
  String get settingLeftHanded => 'Kidal (papan kekunci dicerminkan)';

  @override
  String get settingDyslexiaFont => 'Fon mesra disleksia (OpenDyslexic)';

  @override
  String get settingSeason => 'Musim pada peta';

  @override
  String get seasonAuto => 'mengikut kalendar';

  @override
  String get seasonSpring => 'bunga';

  @override
  String get seasonSummer => 'panas';

  @override
  String get seasonAutumn => 'luruh';

  @override
  String get seasonWinter => 'sejuk';

  @override
  String get settingTimeLimit => 'Had masa bermain sehari';

  @override
  String get noLimit => 'tiada had';

  @override
  String minutes(int n) {
    return '$n min';
  }

  @override
  String playedToday(int played) {
    return 'Bermain hari ini: $played min';
  }

  @override
  String playedTodayOf(int played, int limit) {
    return 'Bermain hari ini: $played daripada $limit min';
  }

  @override
  String get guideAsleep => ' — pemandu sudah tidur';

  @override
  String extendToday(int n) {
    return 'Lanjutkan hari ini sebanyak $n min';
  }

  @override
  String get profilesTitle => 'Profil';

  @override
  String deleteProfileTitle(String name) {
    return 'Padam profil $name?';
  }

  @override
  String get deleteProfileBody =>
      'Semua kemajuan, pelekat dan buku turut dipadam. Ini tidak boleh dibatalkan.';

  @override
  String get cancel => 'Batal';

  @override
  String get delete => 'Padam';

  @override
  String get statMinutesToday => 'minit hari ini';

  @override
  String get statMinutesWeek => 'minit minggu ini';

  @override
  String get letterMastered => 'dikuasai';

  @override
  String get letterPracticing => 'sedang berlatih';

  @override
  String get letterUnseen => 'belum ditemui';

  @override
  String get typeHunt => 'BUNYI';

  @override
  String get typeJoin => 'SUKU KATA';

  @override
  String get typeRhyme => 'SAJAK';

  @override
  String get promptHunt => 'Huruf mana yang anda dengar? Ketik padanya';

  @override
  String get promptJoin => 'Cantumkan suku kata — leret seluruh perkataan';

  @override
  String get promptRhyme => 'Apa yang berima? Ketik gambar';

  @override
  String get expeditionTitle => 'Ekspedisi ulang kaji';

  @override
  String get badgeExpedition => 'Pengembara';

  @override
  String get badgeExpeditionHow => 'Ekspedisi ulang kaji mingguan pertama';

  @override
  String get seasonStickersTitle => 'Pelekat musim';

  @override
  String get mapLoadFailed => 'Peta tidak dapat dimuatkan';

  @override
  String get retry => 'Cuba lagi';

  @override
  String get vocativeLabel => 'Bentuk panggilan dalam bahasa Czech (vokatif)';

  @override
  String get vocativeHint => 'cth. Lauro';

  @override
  String get guideTitle => 'Pemandu anda';

  @override
  String get petPlay => 'Jom bermain';

  @override
  String get badgeHost => 'Tuan rumah';

  @override
  String get badgeHostHow => '10 hadiah untuk haiwan';

  @override
  String get badgeCuddler => 'Penyayang';

  @override
  String get badgeCuddlerHow => 'Membelai 5 haiwan';

  @override
  String get badgeWishMaker => 'Hajat tercapai';

  @override
  String get badgeWishMakerHow => '10 hajat tercapai';

  @override
  String get badgeFriendOfAll => 'Kawan semua';

  @override
  String get badgeFriendOfAllHow => 'Setiap haiwan mendapat hadiah';

  @override
  String get settingPetRounds => 'Hadiah untuk haiwan: tulis perkataan dahulu';

  @override
  String get petBowlFood => 'mangkuk';

  @override
  String get petBowlWater => 'air';

  @override
  String get storeIslandA => 'Pulau Huruf';

  @override
  String get storeIslandB => 'Pulau Perkataan';

  @override
  String get storeIslandC => 'Pulau Ayat';

  @override
  String storeProductIsland(String island, String language) {
    return '$island – $language';
  }

  @override
  String storeProductIslandDesc(String language) {
    return 'Unit baharu, pelekat dan penghuni dunia haiwan. Bahasa: $language.';
  }

  @override
  String storeProductLanguage(String language) {
    return 'Bahasa lain – $language';
  }

  @override
  String storeProductLanguageDesc(String island, String language) {
    return '$island dalam bahasa lain: $language.';
  }

  @override
  String get storeProductBundle => 'Semuanya selama-lamanya';

  @override
  String get storeProductBundleDesc =>
      'Semua pulau dan bahasa, termasuk yang akan datang.';

  @override
  String get storeProductParent => 'Pek ibu bapa';

  @override
  String get storeProductParentDesc =>
      'Lembaran kerja, cetakan Buku saya, ringkasan mingguan dan pemindahan kemajuan.';

  @override
  String get storeStateFree => 'percuma';

  @override
  String get storeStateOwned => 'dimiliki';

  @override
  String storeBuy(String price) {
    return 'Beli dengan harga $price';
  }

  @override
  String get storeRestore => 'Pulihkan pembelian';

  @override
  String get storeDebugTitle => 'Kedai (nyahpepijat)';

  @override
  String get storeDebugEnable => 'Simulasikan kedai yang diaktifkan';

  @override
  String get storeDebugForget => 'Lupakan pembelian';

  @override
  String get homeLanguageLabel => 'Bahasa keluarga (menu dan petunjuk)';

  @override
  String get homeLanguageSame => 'Sama dengan bahasa permainan';

  @override
  String get parentPrivacy => 'Dasar privasi';
}
