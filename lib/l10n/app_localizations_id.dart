// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Indonesian (`id`).
class AppLocalizationsId extends AppLocalizations {
  AppLocalizationsId([String locale = 'id']) : super(locale);

  @override
  String get appTitle => 'SwypeKids';

  @override
  String get menuSyllabary => 'Abjad (Swype)';

  @override
  String get menuSentence => 'Susun kalimat';

  @override
  String get menuZoo => 'Kebun binatang';

  @override
  String get menuBook => 'Bukuku';

  @override
  String get menuParents => 'Untuk orang tua';

  @override
  String get practiceTitle => 'Latihan';

  @override
  String bedtimeText(String guide) {
    return '$guide sudah tidur. Sampai besok!';
  }

  @override
  String get typeListen => 'DENGAR';

  @override
  String get typePicture => 'GAMBAR';

  @override
  String get typeGap => 'LENGKAPI';

  @override
  String get typeReview => 'ULANGAN';

  @override
  String get typeWord => 'KATA';

  @override
  String get typeSyllable => 'SUKU KATA';

  @override
  String get promptListen => 'Dengarkan lalu geser apa yang kamu dengar';

  @override
  String get promptPicture => 'Apa yang ada di gambar? Tulislah';

  @override
  String get promptGap => 'Huruf apa yang hilang? Geser seluruh kata';

  @override
  String get promptSwipeTouch => 'Geser jarimu di atas gambar-gambar';

  @override
  String get promptSwipeTrackpad =>
      'Geser dengan dua jari di atas gambar-gambar';

  @override
  String get successText => 'Hebat!';

  @override
  String get errorText => 'Coba lagi!';

  @override
  String get newSticker => 'Kamu dapat stiker baru!';

  @override
  String starsGained(int count) {
    return '+$count bintang';
  }

  @override
  String get backToMap => 'Kembali ke peta';

  @override
  String get winTitle => 'Selesai!\nKamu juara!';

  @override
  String winStars(int count) {
    return 'Kamu dapat $count bintang!';
  }

  @override
  String get playAgain => 'Main lagi';

  @override
  String get builderBadge => 'KALIMAT';

  @override
  String get who => 'SIAPA';

  @override
  String get whatDoes => 'MELAKUKAN APA';

  @override
  String get whatWhere => 'APA / KE MANA';

  @override
  String get newLabel => 'BARU';

  @override
  String get clear => 'Hapus';

  @override
  String get bookTitle => 'Bukuku';

  @override
  String get bookEmptyHint => 'Susun kalimat lalu simpan di buku';

  @override
  String get zooTitle => 'Kebun binatang';

  @override
  String badgesTitle(int earned, int total) {
    return 'Lencana $earned/$total';
  }

  @override
  String get badgeFirstSwype => 'Geseran pertama';

  @override
  String get badgeFirstSwypeHow => 'Geseran benar pertama';

  @override
  String get badgeNoMistake => 'Tanpa salah';

  @override
  String get badgeNoMistakeHow => 'Satu unit penuh dengan tiga bintang';

  @override
  String get badgeExplorer => 'Penjelajah';

  @override
  String get badgeExplorerHow => 'Stiker pertama';

  @override
  String get badgeCollectorHalf => 'Kolektor';

  @override
  String get badgeCollectorHalfHow => 'Setengah kebun binatang';

  @override
  String get badgeCollectorAll => 'Kolektor besar';

  @override
  String get badgeCollectorAllHow => 'Seluruh kebun binatang';

  @override
  String get badgeNightOwl => 'Burung hantu malam';

  @override
  String get badgeNightOwlHow => 'Bermain di malam hari';

  @override
  String get badgeEarlyBird => 'Burung pagi';

  @override
  String get badgeEarlyBirdHow => 'Bermain di pagi hari';

  @override
  String get badgeFourSeasons => 'Empat musim';

  @override
  String get badgeFourSeasonsHow => 'Bermain di setiap musim';

  @override
  String get badgeWordsmith10 => 'Pengrajin kata';

  @override
  String get badgeWordsmith10How => '10 kata di tas';

  @override
  String get badgeWordsmith25 => 'Pengrajin kata hebat';

  @override
  String get badgeWordsmith25How => '25 kata di tas';

  @override
  String get badgeWordsmith50 => 'Ahli kata';

  @override
  String get badgeWordsmith50How => '50 kata di tas';

  @override
  String get badgePoet => 'Penyair';

  @override
  String get badgePoetHow => '10 kalimat di Bukuku';

  @override
  String get badgeListener => 'Pendengar';

  @override
  String get badgeListenerHow => '10 ronde mendengar dengan tiga bintang';

  @override
  String get badgePersistent => 'Gigih';

  @override
  String get badgePersistentHow => '7 hari bermain';

  @override
  String get parentTitle => 'Untuk orang tua';

  @override
  String gateQuestion(int a, int b) {
    return 'Berapa $a × $b?';
  }

  @override
  String get backToGame => 'Kembali ke permainan';

  @override
  String get sectionOverview => 'Ringkasan';

  @override
  String get sectionLetters => 'Huruf';

  @override
  String get sectionTips => 'Saran untuk di rumah';

  @override
  String get sectionMethod => 'Cara aplikasi mengajar';

  @override
  String get sectionSettings => 'Pengaturan';

  @override
  String get statProfile => 'profil';

  @override
  String get statPlayDays => 'hari bermain';

  @override
  String get statLessons => 'pelajaran';

  @override
  String get statStars => 'bintang';

  @override
  String get statWords => 'kata di tas';

  @override
  String get statSentences => 'kalimat di Bukuku';

  @override
  String get statBadges => 'lencana';

  @override
  String get lettersLegend => '🟢 dikuasai · 🟡 berlatih · ⚪ belum ditemui';

  @override
  String troubleWords(String letter, String words) {
    return 'Kata dengan $letter yang sering tertukar: $words';
  }

  @override
  String get tipNoData =>
      'Belum ada yang perlu dilatih — saran akan muncul setelah beberapa pelajaran.';

  @override
  String tipWeakest(String words) {
    return 'Kata terlemah: $words. Coba bertepuk per suku kata di rumah dan cari benda yang diawali kata itu.';
  }

  @override
  String tipLetter(String letter) {
    return 'Huruf $letter masih belum mantap: carilah bersama di rumah benda yang diawali $letter.';
  }

  @override
  String get tipLongPress =>
      'Tekan lama sebuah pelajaran di peta untuk melihat apa yang dilatih dan mengapa.';

  @override
  String methodLabel(String method) {
    return 'Metode: $method';
  }

  @override
  String get methodText =>
      'Anak menggeser jari di atas huruf dengan urutan yang ia dengar untuk suku kata atau kata. Mulai dari suku kata terbuka (MA, TA), lalu kata utuh, ronde mendengar tanpa teks, ronde melengkapi, dan ulangan kata yang paling lemah. Kesalahan tidak pernah menghalangi kemajuan — kartu hanya bergetar dan memberi petunjuk. Kata yang dipelajari langsung dipakai dalam kalimat (penyusun kalimat) dan bisa disimpan di Bukuku.';

  @override
  String get settingSounds => 'Suara';

  @override
  String get settingAmbient => 'Suara dunia';

  @override
  String get settingMusic => 'Musik';

  @override
  String get settingLeftHanded => 'Kidal (papan ketik dicerminkan)';

  @override
  String get settingDyslexiaFont => 'Font ramah disleksia (OpenDyslexic)';

  @override
  String get settingSeason => 'Musim di peta';

  @override
  String get seasonAuto => 'sesuai kalender';

  @override
  String get seasonSpring => 'semi';

  @override
  String get seasonSummer => 'panas';

  @override
  String get seasonAutumn => 'gugur';

  @override
  String get seasonWinter => 'dingin';

  @override
  String get settingTimeLimit => 'Batas waktu bermain per hari';

  @override
  String get noLimit => 'tanpa batas';

  @override
  String minutes(int n) {
    return '$n mnt';
  }

  @override
  String playedToday(int played) {
    return 'Hari ini bermain: $played mnt';
  }

  @override
  String playedTodayOf(int played, int limit) {
    return 'Hari ini bermain: $played dari $limit mnt';
  }

  @override
  String get guideAsleep => ' — pemandu sudah tidur';

  @override
  String extendToday(int n) {
    return 'Perpanjang hari ini $n mnt';
  }

  @override
  String get profilesTitle => 'Profil';

  @override
  String deleteProfileTitle(String name) {
    return 'Hapus profil $name?';
  }

  @override
  String get deleteProfileBody =>
      'Semua kemajuan, stiker, dan buku ikut terhapus. Tindakan ini tidak dapat dibatalkan.';

  @override
  String get cancel => 'Batal';

  @override
  String get delete => 'Hapus';

  @override
  String get statMinutesToday => 'menit hari ini';

  @override
  String get statMinutesWeek => 'menit minggu ini';

  @override
  String get letterMastered => 'dikuasai';

  @override
  String get letterPracticing => 'berlatih';

  @override
  String get letterUnseen => 'belum ditemui';

  @override
  String get typeHunt => 'BUNYI';

  @override
  String get typeJoin => 'SUKU KATA';

  @override
  String get typeRhyme => 'SAJAK';

  @override
  String get promptHunt => 'Huruf apa yang kamu dengar? Ketuk huruf itu';

  @override
  String get promptJoin => 'Gabungkan suku kata — geser seluruh kata';

  @override
  String get promptRhyme => 'Apa yang berima? Ketuk gambarnya';

  @override
  String get expeditionTitle => 'Ekspedisi ulangan';

  @override
  String get badgeExpedition => 'Petualang ulangan';

  @override
  String get badgeExpeditionHow => 'Ekspedisi ulangan mingguan pertama';

  @override
  String get seasonStickersTitle => 'Stiker musim';

  @override
  String get mapLoadFailed => 'Peta tidak dapat dimuat';

  @override
  String get retry => 'Coba lagi';

  @override
  String get vocativeLabel => 'Bentuk sapaan dalam bahasa Ceko (vokatif)';

  @override
  String get vocativeHint => 'mis. Lauro';

  @override
  String get guideTitle => 'Pemandumu';

  @override
  String get petPlay => 'Ayo bermain';

  @override
  String get badgeHost => 'Tuan rumah';

  @override
  String get badgeHostHow => '10 hadiah untuk hewan';

  @override
  String get badgeCuddler => 'Penyayang';

  @override
  String get badgeCuddlerHow => 'Membelai 5 hewan';

  @override
  String get badgeWishMaker => 'Harapan terwujud';

  @override
  String get badgeWishMakerHow => '10 harapan terkabul';

  @override
  String get badgeFriendOfAll => 'Sahabat semua';

  @override
  String get badgeFriendOfAllHow => 'Setiap hewan mendapat hadiah';

  @override
  String get settingPetRounds => 'Hadiah untuk hewan: tulis kata dulu';

  @override
  String get petBowlFood => 'mangkuk';

  @override
  String get petBowlWater => 'air';

  @override
  String get storeIslandA => 'Pulau Huruf';

  @override
  String get storeIslandB => 'Pulau Kata';

  @override
  String get storeIslandC => 'Pulau Kalimat';

  @override
  String storeProductIsland(String island, String language) {
    return '$island – $language';
  }

  @override
  String storeProductIslandDesc(String language) {
    return 'Unit baru, stiker, dan penghuni dunia hewan. Bahasa: $language.';
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
  String get storeProductBundle => 'Semuanya selamanya';

  @override
  String get storeProductBundleDesc =>
      'Semua pulau dan bahasa, termasuk yang akan datang.';

  @override
  String get storeProductParent => 'Paket orang tua';

  @override
  String get storeProductParentDesc =>
      'Lembar kerja, cetak Bukuku, ringkasan mingguan, dan pemindahan kemajuan.';

  @override
  String get storeStateFree => 'gratis';

  @override
  String get storeStateOwned => 'dimiliki';

  @override
  String storeBuy(String price) {
    return 'Beli seharga $price';
  }

  @override
  String get storeRestore => 'Pulihkan pembelian';

  @override
  String get storeDebugTitle => 'Toko (debug)';

  @override
  String get storeDebugEnable => 'Simulasikan toko aktif';

  @override
  String get storeDebugForget => 'Lupakan pembelian';

  @override
  String get homeLanguageLabel => 'Bahasa keluarga (menu dan petunjuk)';

  @override
  String get homeLanguageSame => 'Sama dengan bahasa permainan';

  @override
  String get parentPrivacy => 'Kebijakan privasi';
}
