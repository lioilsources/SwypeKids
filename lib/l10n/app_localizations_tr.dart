// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Turkish (`tr`).
class AppLocalizationsTr extends AppLocalizations {
  AppLocalizationsTr([String locale = 'tr']) : super(locale);

  @override
  String get appTitle => 'SwypeKids';

  @override
  String get menuSyllabary => 'Alfabe (Swype)';

  @override
  String get menuSentence => 'Cümle kur';

  @override
  String get menuZoo => 'Hayvanat bahçesi';

  @override
  String get menuBook => 'Kitabım';

  @override
  String get menuParents => 'Ebeveynler için';

  @override
  String get practiceTitle => 'Alıştırma';

  @override
  String bedtimeText(String guide) {
    return '$guide uyuyor. Yarın görüşürüz!';
  }

  @override
  String get typeListen => 'DİNLE';

  @override
  String get typePicture => 'RESİM';

  @override
  String get typeGap => 'TAMAMLA';

  @override
  String get typeReview => 'TEKRAR';

  @override
  String get typeWord => 'KELİME';

  @override
  String get typeSyllable => 'HECE';

  @override
  String get promptListen => 'Dinle ve duyduğunu kaydır';

  @override
  String get promptPicture => 'Resimde ne var? Yaz';

  @override
  String get promptGap => 'Hangi harf eksik? Kelimenin tamamını kaydır';

  @override
  String get promptSwipeTouch => 'Parmağını resimlerin üzerinde kaydır';

  @override
  String get promptSwipeTrackpad => 'İki parmakla resimlerin üzerinde kaydır';

  @override
  String get successText => 'Aferin!';

  @override
  String get errorText => 'Tekrar dene!';

  @override
  String get newSticker => 'Yeni bir çıkartma kazandın!';

  @override
  String starsGained(int count) {
    return '+$count yıldız';
  }

  @override
  String get backToMap => 'Haritaya dön';

  @override
  String get winTitle => 'Bitti!\nSen bir şampiyonsun!';

  @override
  String winStars(int count) {
    return '$count yıldız kazandın!';
  }

  @override
  String get playAgain => 'Tekrar oyna';

  @override
  String get builderBadge => 'CÜMLE';

  @override
  String get who => 'KİM';

  @override
  String get whatDoes => 'NE YAPIYOR';

  @override
  String get whatWhere => 'NE / NEREYE';

  @override
  String get newLabel => 'YENİ';

  @override
  String get clear => 'Temizle';

  @override
  String get bookTitle => 'Kitabım';

  @override
  String get bookEmptyHint => 'Bir cümle kur ve kitaba kaydet';

  @override
  String get zooTitle => 'Hayvanat bahçesi';

  @override
  String badgesTitle(int earned, int total) {
    return 'Rozetler $earned/$total';
  }

  @override
  String get badgeFirstSwype => 'İlk kaydırma';

  @override
  String get badgeFirstSwypeHow => 'İlk doğru kaydırma';

  @override
  String get badgeNoMistake => 'Hatasız';

  @override
  String get badgeNoMistakeHow => 'Bütün bir ünite üç yıldızla';

  @override
  String get badgeExplorer => 'Kâşif';

  @override
  String get badgeExplorerHow => 'İlk çıkartma';

  @override
  String get badgeCollectorHalf => 'Koleksiyoncu';

  @override
  String get badgeCollectorHalfHow => 'Hayvanat bahçesinin yarısı';

  @override
  String get badgeCollectorAll => 'Büyük koleksiyoncu';

  @override
  String get badgeCollectorAllHow => 'Bütün hayvanat bahçesi';

  @override
  String get badgeNightOwl => 'Gece baykuşu';

  @override
  String get badgeNightOwlHow => 'Gece oynadı';

  @override
  String get badgeEarlyBird => 'Erkenci kuş';

  @override
  String get badgeEarlyBirdHow => 'Sabah oynadı';

  @override
  String get badgeFourSeasons => 'Dört mevsim';

  @override
  String get badgeFourSeasonsHow => 'Her mevsimde oynadı';

  @override
  String get badgeWordsmith10 => 'Kelime ustası';

  @override
  String get badgeWordsmith10How => 'Çantada 10 kelime';

  @override
  String get badgeWordsmith25 => 'Büyük kelime ustası';

  @override
  String get badgeWordsmith25How => 'Çantada 25 kelime';

  @override
  String get badgeWordsmith50 => 'Kelime üstadı';

  @override
  String get badgeWordsmith50How => 'Çantada 50 kelime';

  @override
  String get badgePoet => 'Şair';

  @override
  String get badgePoetHow => 'Kitabım\'da 10 cümle';

  @override
  String get badgeListener => 'Dinleyici';

  @override
  String get badgeListenerHow => 'Üç yıldızla 10 dinleme turu';

  @override
  String get badgePersistent => 'Azimli';

  @override
  String get badgePersistentHow => '7 oyun günü';

  @override
  String get parentTitle => 'Ebeveynler için';

  @override
  String gateQuestion(int a, int b) {
    return '$a × $b kaç eder?';
  }

  @override
  String get backToGame => 'Oyuna dön';

  @override
  String get sectionOverview => 'Genel bakış';

  @override
  String get sectionLetters => 'Harfler';

  @override
  String get sectionTips => 'Evde için öneriler';

  @override
  String get sectionMethod => 'Uygulama nasıl öğretir';

  @override
  String get sectionSettings => 'Ayarlar';

  @override
  String get statProfile => 'profil';

  @override
  String get statPlayDays => 'oyun günü';

  @override
  String get statLessons => 'ders';

  @override
  String get statStars => 'yıldız';

  @override
  String get statWords => 'çantada kelime';

  @override
  String get statSentences => 'Kitabım\'da cümle';

  @override
  String get statBadges => 'rozet';

  @override
  String get lettersLegend =>
      '🟢 öğrenildi · 🟡 çalışılıyor · ⚪ henüz karşılaşılmadı';

  @override
  String troubleWords(String letter, String words) {
    return '$letter içeren, karışan kelimeler: $words';
  }

  @override
  String get tipNoData =>
      'Çalışılacak bir şey yok — birkaç dersten sonra öneriler görünür.';

  @override
  String tipWeakest(String words) {
    return 'En zayıf kelimeler: $words. Evde bunları hece hece alkışlayarak söyleyin ve bunlarla başlayan şeyler arayın.';
  }

  @override
  String tipLetter(String letter) {
    return '$letter harfi henüz oturmadı: evde birlikte $letter ile başlayan şeyler arayın.';
  }

  @override
  String get tipLongPress =>
      'Haritada bir derse uzun basmak, onda neyin ve neden çalışıldığını gösterir.';

  @override
  String methodLabel(String method) {
    return 'Yöntem: $method';
  }

  @override
  String get methodText =>
      'Çocuk, heceyi ya da kelimeyi duyduğu sırayla harflerin üzerinde parmağını kaydırır. Önce açık heceler (MA, TA), sonra bütün kelimeler, metinsiz dinleme turları, boşluk doldurma turları ve en zayıf kelimelerin tekrarı. Hata hiçbir zaman ilerlemeyi engellemez — kart sadece sallanır ve ipucu verir. Öğrenilen kelimeler hemen cümlede (cümle kurucu) kullanılır ve Kitabım\'a kaydedilebilir.';

  @override
  String get settingSounds => 'Sesler';

  @override
  String get settingAmbient => 'Dünyanın sesleri';

  @override
  String get settingMusic => 'Müzik';

  @override
  String get settingLeftHanded => 'Solak (aynalı klavye)';

  @override
  String get settingDyslexiaFont => 'Disleksi dostu yazı tipi (OpenDyslexic)';

  @override
  String get settingSeason => 'Haritada mevsim';

  @override
  String get seasonAuto => 'takvime göre';

  @override
  String get seasonSpring => 'ilkbahar';

  @override
  String get seasonSummer => 'yaz';

  @override
  String get seasonAutumn => 'sonbahar';

  @override
  String get seasonWinter => 'kış';

  @override
  String get settingTimeLimit => 'Günlük oyun süresi sınırı';

  @override
  String get noLimit => 'sınır yok';

  @override
  String minutes(int n) {
    return '$n dk';
  }

  @override
  String playedToday(int played) {
    return 'Bugün oynanan: $played dk';
  }

  @override
  String playedTodayOf(int played, int limit) {
    return 'Bugün oynanan: $limit dk\'nın $played dk\'sı';
  }

  @override
  String get guideAsleep => ' — rehber uyuyor';

  @override
  String extendToday(int n) {
    return 'Bugünü $n dk uzat';
  }

  @override
  String get profilesTitle => 'Profiller';

  @override
  String deleteProfileTitle(String name) {
    return '$name profili silinsin mi?';
  }

  @override
  String get deleteProfileBody =>
      'Bütün ilerleme, çıkartmalar ve kitap da silinecek. Bu geri alınamaz.';

  @override
  String get cancel => 'İptal';

  @override
  String get delete => 'Sil';

  @override
  String get statMinutesToday => 'bugünün dakikası';

  @override
  String get statMinutesWeek => 'bu haftanın dakikası';

  @override
  String get letterMastered => 'öğrenildi';

  @override
  String get letterPracticing => 'çalışılıyor';

  @override
  String get letterUnseen => 'henüz karşılaşılmadı';

  @override
  String get typeHunt => 'SES';

  @override
  String get typeJoin => 'HECELER';

  @override
  String get typeRhyme => 'KAFİYE';

  @override
  String get promptHunt => 'Hangi harfi duydun? Dokun';

  @override
  String get promptJoin => 'Heceleri birleştir — kelimenin tamamını kaydır';

  @override
  String get promptRhyme => 'Hangisi kafiyeli? Resme dokun';

  @override
  String get expeditionTitle => 'Tekrar seferi';

  @override
  String get badgeExpedition => 'Seferci';

  @override
  String get badgeExpeditionHow => 'İlk haftalık tekrar seferi';

  @override
  String get seasonStickersTitle => 'Mevsim çıkartmaları';

  @override
  String get mapLoadFailed => 'Harita yüklenemedi';

  @override
  String get retry => 'Tekrar dene';

  @override
  String get vocativeLabel => 'Çekçe hitap biçimi (seslenme hâli)';

  @override
  String get vocativeHint => 'örn. Lauro';

  @override
  String get guideTitle => 'Rehberin';

  @override
  String get petPlay => 'Gel oynayalım';

  @override
  String get badgeHost => 'Ev sahibi';

  @override
  String get badgeHostHow => 'Hayvanlara 10 hediye';

  @override
  String get badgeCuddler => 'Sevimli';

  @override
  String get badgeCuddlerHow => '5 hayvanı sevdi';

  @override
  String get badgeWishMaker => 'Gerçekleşen dilek';

  @override
  String get badgeWishMakerHow => '10 dilek gerçekleşti';

  @override
  String get badgeFriendOfAll => 'Herkesin dostu';

  @override
  String get badgeFriendOfAllHow => 'Her hayvan bir hediye aldı';

  @override
  String get settingPetRounds => 'Hayvanlara hediye: önce kelimeyi yaz';

  @override
  String get petBowlFood => 'kase';

  @override
  String get petBowlWater => 'su';

  @override
  String get storeIslandA => 'Harf Adası';

  @override
  String get storeIslandB => 'Kelime Adası';

  @override
  String get storeIslandC => 'Cümle Adası';

  @override
  String storeProductIsland(String island, String language) {
    return '$island – $language';
  }

  @override
  String storeProductIslandDesc(String language) {
    return 'Yeni üniteler, çıkartmalar ve hayvanlar dünyasının sakinleri. Dil: $language.';
  }

  @override
  String storeProductLanguage(String language) {
    return 'Bir dil daha – $language';
  }

  @override
  String storeProductLanguageDesc(String island, String language) {
    return '$island başka bir dilde: $language.';
  }

  @override
  String get storeProductBundle => 'Her şey sonsuza dek';

  @override
  String get storeProductBundleDesc =>
      'Bütün adalar ve diller, ileride gelecekler de dahil.';

  @override
  String get storeProductParent => 'Ebeveyn paketi';

  @override
  String get storeProductParentDesc =>
      'Çalışma kâğıtları, Kitabım baskısı, haftalık özet ve ilerleme aktarımı.';

  @override
  String get storeStateFree => 'ücretsiz';

  @override
  String get storeStateOwned => 'sahipsiniz';

  @override
  String storeBuy(String price) {
    return '$price karşılığında al';
  }

  @override
  String get storeRestore => 'Satın alımları geri yükle';

  @override
  String get storeDebugTitle => 'Mağaza (hata ayıklama)';

  @override
  String get storeDebugEnable => 'Etkin bir mağazayı simüle et';

  @override
  String get storeDebugForget => 'Satın alımları unut';

  @override
  String get homeLanguageLabel => 'Ailenin dili (menüler ve ipuçları)';

  @override
  String get homeLanguageSame => 'Oyun diliyle aynı';

  @override
  String get parentPrivacy => 'Gizlilik politikası';
}
