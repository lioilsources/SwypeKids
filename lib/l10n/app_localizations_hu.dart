// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hungarian (`hu`).
class AppLocalizationsHu extends AppLocalizations {
  AppLocalizationsHu([String locale = 'hu']) : super(locale);

  @override
  String get appTitle => 'SwypeKids';

  @override
  String get menuSyllabary => 'Ábécéskönyv (Swype)';

  @override
  String get menuSentence => 'Állíts össze egy mondatot';

  @override
  String get menuZoo => 'Állatkert';

  @override
  String get menuBook => 'Könyvem';

  @override
  String get menuParents => 'Szülőknek';

  @override
  String get practiceTitle => 'Gyakorlás';

  @override
  String bedtimeText(String guide) {
    return '$guide alszik. Holnap találkozunk!';
  }

  @override
  String get typeListen => 'HALLGASD';

  @override
  String get typePicture => 'KÉP';

  @override
  String get typeGap => 'PÓTOLD';

  @override
  String get typeReview => 'ISMÉTLÉS';

  @override
  String get typeWord => 'SZÓ';

  @override
  String get typeSyllable => 'SZÓTAG';

  @override
  String get promptListen =>
      'Hallgasd meg, és húzd végig az ujjad azon, amit hallasz';

  @override
  String get promptPicture => 'Mi van a képen? Írd le';

  @override
  String get promptGap => 'Melyik betű hiányzik? Húzd végig az egész szót';

  @override
  String get promptSwipeTouch => 'Húzd végig az ujjad a képeken';

  @override
  String get promptSwipeTrackpad => 'Húzz két ujjal a képeken';

  @override
  String get successText => 'Szuper!';

  @override
  String get errorText => 'Próbáld újra!';

  @override
  String get newSticker => 'Új matricát kaptál!';

  @override
  String starsGained(int count) {
    return '+$count csillag';
  }

  @override
  String get backToMap => 'Vissza a térképre';

  @override
  String get winTitle => 'Kész!\nTe vagy a bajnok!';

  @override
  String winStars(int count) {
    return '$count csillagot szereztél!';
  }

  @override
  String get playAgain => 'Játssz újra';

  @override
  String get builderBadge => 'MONDAT';

  @override
  String get who => 'KI';

  @override
  String get whatDoes => 'MIT CSINÁL';

  @override
  String get whatWhere => 'MIT / HOVÁ';

  @override
  String get newLabel => 'ÚJ';

  @override
  String get clear => 'Törlés';

  @override
  String get bookTitle => 'Könyvem';

  @override
  String get bookEmptyHint => 'Állíts össze egy mondatot, és mentsd a könyvbe';

  @override
  String get zooTitle => 'Állatkert';

  @override
  String badgesTitle(int earned, int total) {
    return 'Jelvények $earned/$total';
  }

  @override
  String get badgeFirstSwype => 'Első húzás';

  @override
  String get badgeFirstSwypeHow => 'Az első helyes húzás';

  @override
  String get badgeNoMistake => 'Hiba nélkül';

  @override
  String get badgeNoMistakeHow => 'Egy egész egység három csillaggal';

  @override
  String get badgeExplorer => 'Felfedező';

  @override
  String get badgeExplorerHow => 'Az első matrica';

  @override
  String get badgeCollectorHalf => 'Gyűjtő';

  @override
  String get badgeCollectorHalfHow => 'Az állatkert fele';

  @override
  String get badgeCollectorAll => 'Nagy gyűjtő';

  @override
  String get badgeCollectorAllHow => 'Az egész állatkert';

  @override
  String get badgeNightOwl => 'Éjjeli bagoly';

  @override
  String get badgeNightOwlHow => 'Éjjel játszott';

  @override
  String get badgeEarlyBird => 'Korán kelő';

  @override
  String get badgeEarlyBirdHow => 'Reggel játszott';

  @override
  String get badgeFourSeasons => 'Négy évszak';

  @override
  String get badgeFourSeasonsHow => 'Minden évszakban játszott';

  @override
  String get badgeWordsmith10 => 'Szókovács';

  @override
  String get badgeWordsmith10How => '10 szó a táskában';

  @override
  String get badgeWordsmith25 => 'Nagy szókovács';

  @override
  String get badgeWordsmith25How => '25 szó a táskában';

  @override
  String get badgeWordsmith50 => 'Szómester';

  @override
  String get badgeWordsmith50How => '50 szó a táskában';

  @override
  String get badgePoet => 'Költő';

  @override
  String get badgePoetHow => '10 mondat a Könyvemben';

  @override
  String get badgeListener => 'Hallgató';

  @override
  String get badgeListenerHow => '10 hallgatós kör három csillaggal';

  @override
  String get badgePersistent => 'Kitartó';

  @override
  String get badgePersistentHow => '7 játéknap';

  @override
  String get parentTitle => 'Szülőknek';

  @override
  String gateQuestion(int a, int b) {
    return 'Mennyi $a × $b?';
  }

  @override
  String get backToGame => 'Vissza a játékhoz';

  @override
  String get sectionOverview => 'Áttekintés';

  @override
  String get sectionLetters => 'Betűk';

  @override
  String get sectionTips => 'Tippek otthonra';

  @override
  String get sectionMethod => 'Hogyan tanít az app';

  @override
  String get sectionSettings => 'Beállítások';

  @override
  String get statProfile => 'profil';

  @override
  String get statPlayDays => 'játéknap';

  @override
  String get statLessons => 'lecke';

  @override
  String get statStars => 'csillag';

  @override
  String get statWords => 'szó a táskában';

  @override
  String get statSentences => 'mondat a Könyvemben';

  @override
  String get statBadges => 'jelvény';

  @override
  String get lettersLegend =>
      '🟢 megy · 🟡 gyakorolja · ⚪ még nem találkozott vele';

  @override
  String troubleWords(String letter, String words) {
    return 'Összekeveredő szavak $letter betűvel: $words';
  }

  @override
  String get tipNoData =>
      'Még nincs mit gyakorolni – néhány lecke után megjelennek a tippek.';

  @override
  String tipWeakest(String words) {
    return 'Leggyengébb szavak: $words. Otthon próbáljátok szótagonként elütni tapssal, és keressetek olyan dolgokat, amik ezzel kezdődnek.';
  }

  @override
  String tipLetter(String letter) {
    return 'A(z) $letter betű még ülepedik: keressetek együtt otthon olyan dolgokat, amik $letter betűvel kezdődnek.';
  }

  @override
  String get tipLongPress =>
      'A térképen egy leckére hosszan nyomva kiderül, mit gyakorol, és miért.';

  @override
  String methodLabel(String method) {
    return 'Módszer: $method';
  }

  @override
  String get methodText =>
      'A gyerek abban a sorrendben húzza végig az ujját a betűkön, ahogy a szótagot vagy a szót hallja. Először a nyílt szótagok (MA, TA), aztán egész szavak, szöveg nélküli hallgatós körök, kiegészítős körök és a leggyengébb szavak ismétlése. A hiba sosem akadályozza a haladást – a kártya csak megremeg, és súg. A megtanult szavak rögtön mondatba kerülnek (mondatépítő), és elmenthetők a Könyvembe.';

  @override
  String get settingSounds => 'Hangok';

  @override
  String get settingAmbient => 'A világ hangjai';

  @override
  String get settingMusic => 'Zene';

  @override
  String get settingLeftHanded => 'Balkezes (tükrözött billentyűzet)';

  @override
  String get settingDyslexiaFont => 'Diszlexiabarát betűtípus (OpenDyslexic)';

  @override
  String get settingSeason => 'Évszak a térképen';

  @override
  String get seasonAuto => 'a naptár szerint';

  @override
  String get seasonSpring => 'tavasz';

  @override
  String get seasonSummer => 'nyár';

  @override
  String get seasonAutumn => 'ősz';

  @override
  String get seasonWinter => 'tél';

  @override
  String get settingTimeLimit => 'Napi játékidő-korlát';

  @override
  String get noLimit => 'nincs korlát';

  @override
  String minutes(int n) {
    return '$n perc';
  }

  @override
  String playedToday(int played) {
    return 'Ma játszott: $played perc';
  }

  @override
  String playedTodayOf(int played, int limit) {
    return 'Ma játszott: $played / $limit perc';
  }

  @override
  String get guideAsleep => ' – a vezető alszik';

  @override
  String extendToday(int n) {
    return 'A mai nap meghosszabbítása $n perccel';
  }

  @override
  String get profilesTitle => 'Profilok';

  @override
  String deleteProfileTitle(String name) {
    return 'Törlöd a(z) $name profilt?';
  }

  @override
  String get deleteProfileBody =>
      'Az összes haladás, a matricák és a könyv is törlődik. Ez nem vonható vissza.';

  @override
  String get cancel => 'Mégse';

  @override
  String get delete => 'Törlés';

  @override
  String get statMinutesToday => 'perc ma';

  @override
  String get statMinutesWeek => 'perc ezen a héten';

  @override
  String get letterMastered => 'megy';

  @override
  String get letterPracticing => 'gyakorolja';

  @override
  String get letterUnseen => 'még nem találkozott vele';

  @override
  String get typeHunt => 'HANG';

  @override
  String get typeJoin => 'SZÓTAGOK';

  @override
  String get typeRhyme => 'RÍM';

  @override
  String get promptHunt => 'Melyik betűt hallottad? Koppints rá';

  @override
  String get promptJoin =>
      'Kapcsold össze a szótagokat – húzd végig az egész szót';

  @override
  String get promptRhyme => 'Mi rímel? Koppints a képre';

  @override
  String get expeditionTitle => 'Ismétlő expedíció';

  @override
  String get badgeExpedition => 'Expedíciós';

  @override
  String get badgeExpeditionHow => 'Az első heti ismétlő expedíció';

  @override
  String get seasonStickersTitle => 'Évszakmatricák';

  @override
  String get mapLoadFailed => 'A térképet nem sikerült betölteni';

  @override
  String get retry => 'Próbáld újra';

  @override
  String get vocativeLabel => 'Cseh megszólító alak (vokatívusz)';

  @override
  String get vocativeHint => 'pl. Lauro';

  @override
  String get guideTitle => 'A vezetőd';

  @override
  String get petPlay => 'Gyere játszani';

  @override
  String get badgeHost => 'Házigazda';

  @override
  String get badgeHostHow => '10 ajándék az állatoknak';

  @override
  String get badgeCuddler => 'Simogató';

  @override
  String get badgeCuddlerHow => '5 állatot megsimogatott';

  @override
  String get badgeWishMaker => 'Teljesült kívánság';

  @override
  String get badgeWishMakerHow => '10 teljesült kívánság';

  @override
  String get badgeFriendOfAll => 'Mindenki barátja';

  @override
  String get badgeFriendOfAllHow => 'Minden állat kapott ajándékot';

  @override
  String get settingPetRounds => 'Ajándék az állatoknak: előbb írd le a szót';

  @override
  String get petBowlFood => 'tál';

  @override
  String get petBowlWater => 'víz';

  @override
  String get storeIslandA => 'Betűsziget';

  @override
  String get storeIslandB => 'Szósziget';

  @override
  String get storeIslandC => 'Mondatsziget';

  @override
  String storeProductIsland(String island, String language) {
    return '$island – $language';
  }

  @override
  String storeProductIslandDesc(String language) {
    return 'Új egységek, matricák és az állatvilág lakói. Nyelv: $language.';
  }

  @override
  String storeProductLanguage(String language) {
    return 'Újabb nyelv – $language';
  }

  @override
  String storeProductLanguageDesc(String island, String language) {
    return '$island egy másik nyelven: $language.';
  }

  @override
  String get storeProductBundle => 'Minden örökre';

  @override
  String get storeProductBundleDesc =>
      'Az összes sziget és nyelv, a később érkezők is.';

  @override
  String get storeProductParent => 'Szülői csomag';

  @override
  String get storeProductParentDesc =>
      'Munkalapok, a Könyvem nyomtatása, heti áttekintés és a haladás átvitele.';

  @override
  String get storeStateFree => 'ingyenes';

  @override
  String get storeStateOwned => 'megvan';

  @override
  String storeBuy(String price) {
    return 'Vásárlás $price áron';
  }

  @override
  String get storeRestore => 'Vásárlások visszaállítása';

  @override
  String get storeDebugTitle => 'Bolt (hibakeresés)';

  @override
  String get storeDebugEnable => 'Bekapcsolt bolt szimulálása';

  @override
  String get storeDebugForget => 'Vásárlások elfelejtése';

  @override
  String get homeLanguageLabel => 'A család nyelve (menük és súgó)';

  @override
  String get homeLanguageSame => 'Ugyanaz, mint a játék nyelve';

  @override
  String get parentPrivacy => 'Adatvédelmi irányelvek';
}
