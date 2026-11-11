// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Slovenian (`sl`).
class AppLocalizationsSl extends AppLocalizations {
  AppLocalizationsSl([String locale = 'sl']) : super(locale);

  @override
  String get appTitle => 'SwypeKids';

  @override
  String get menuSyllabary => 'Abecednik (Swype)';

  @override
  String get menuSentence => 'Sestavi stavek';

  @override
  String get menuZoo => 'Živalski vrt';

  @override
  String get menuBook => 'Moja knjiga';

  @override
  String get menuParents => 'Za starše';

  @override
  String get practiceTitle => 'Vadba';

  @override
  String bedtimeText(String guide) {
    return '$guide že spi. Do jutri!';
  }

  @override
  String get typeListen => 'POSLUŠAJ';

  @override
  String get typePicture => 'SLIKA';

  @override
  String get typeGap => 'DOPOLNI';

  @override
  String get typeReview => 'PONAVLJANJE';

  @override
  String get typeWord => 'BESEDA';

  @override
  String get typeSyllable => 'SLOG';

  @override
  String get promptListen => 'Poslušaj in podrsaj, kar slišiš';

  @override
  String get promptPicture => 'Kaj je na sliki? Napiši';

  @override
  String get promptGap => 'Katera črka manjka? Podrsaj celo besedo';

  @override
  String get promptSwipeTouch => 'Podrsaj s prstom čez slike';

  @override
  String get promptSwipeTrackpad => 'Podrsaj z dvema prstoma čez slike';

  @override
  String get successText => 'Odlično!';

  @override
  String get errorText => 'Poskusi znova!';

  @override
  String get newSticker => 'Dobil si novo nalepko!';

  @override
  String starsGained(int count) {
    return '+$count zvezdic';
  }

  @override
  String get backToMap => 'Nazaj na zemljevid';

  @override
  String get winTitle => 'Končano!\nTi si prvak!';

  @override
  String winStars(int count) {
    return 'Osvojil si $count zvezdic!';
  }

  @override
  String get playAgain => 'Igraj znova';

  @override
  String get builderBadge => 'STAVEK';

  @override
  String get who => 'KDO';

  @override
  String get whatDoes => 'KAJ DELA';

  @override
  String get whatWhere => 'KAJ / KAM';

  @override
  String get newLabel => 'NOVO';

  @override
  String get clear => 'Počisti';

  @override
  String get bookTitle => 'Moja knjiga';

  @override
  String get bookEmptyHint => 'Sestavi stavek in ga shrani v knjigo';

  @override
  String get zooTitle => 'Živalski vrt';

  @override
  String badgesTitle(int earned, int total) {
    return 'Značke $earned/$total';
  }

  @override
  String get badgeFirstSwype => 'Prvi poteg';

  @override
  String get badgeFirstSwypeHow => 'Prvi pravilni poteg';

  @override
  String get badgeNoMistake => 'Brez napake';

  @override
  String get badgeNoMistakeHow => 'Cela enota s tremi zvezdicami';

  @override
  String get badgeExplorer => 'Raziskovalec';

  @override
  String get badgeExplorerHow => 'Prva nalepka';

  @override
  String get badgeCollectorHalf => 'Zbiratelj';

  @override
  String get badgeCollectorHalfHow => 'Polovica živalskega vrta';

  @override
  String get badgeCollectorAll => 'Veliki zbiratelj';

  @override
  String get badgeCollectorAllHow => 'Ves živalski vrt';

  @override
  String get badgeNightOwl => 'Nočna sova';

  @override
  String get badgeNightOwlHow => 'Igral je ponoči';

  @override
  String get badgeEarlyBird => 'Jutranja ptica';

  @override
  String get badgeEarlyBirdHow => 'Igral je zjutraj';

  @override
  String get badgeFourSeasons => 'Štirje letni časi';

  @override
  String get badgeFourSeasonsHow => 'Igral je v vsakem letnem času';

  @override
  String get badgeWordsmith10 => 'Besednjak';

  @override
  String get badgeWordsmith10How => '10 besed v nahrbtniku';

  @override
  String get badgeWordsmith25 => 'Veliki besednjak';

  @override
  String get badgeWordsmith25How => '25 besed v nahrbtniku';

  @override
  String get badgeWordsmith50 => 'Mojster besed';

  @override
  String get badgeWordsmith50How => '50 besed v nahrbtniku';

  @override
  String get badgePoet => 'Pesnik';

  @override
  String get badgePoetHow => '10 stavkov v Moji knjigi';

  @override
  String get badgeListener => 'Poslušalec';

  @override
  String get badgeListenerHow => '10 krogov poslušanja s tremi zvezdicami';

  @override
  String get badgePersistent => 'Vztrajnež';

  @override
  String get badgePersistentHow => '7 dni igranja';

  @override
  String get parentTitle => 'Za starše';

  @override
  String gateQuestion(int a, int b) {
    return 'Koliko je $a × $b?';
  }

  @override
  String get backToGame => 'Nazaj v igro';

  @override
  String get sectionOverview => 'Pregled';

  @override
  String get sectionLetters => 'Črke';

  @override
  String get sectionTips => 'Nasveti za dom';

  @override
  String get sectionMethod => 'Kako uči aplikacija';

  @override
  String get sectionSettings => 'Nastavitve';

  @override
  String get statProfile => 'profil';

  @override
  String get statPlayDays => 'dni igranja';

  @override
  String get statLessons => 'lekcij';

  @override
  String get statStars => 'zvezdic';

  @override
  String get statWords => 'besed v nahrbtniku';

  @override
  String get statSentences => 'stavkov v Moji knjigi';

  @override
  String get statBadges => 'značk';

  @override
  String get lettersLegend => '🟢 obvladane · 🟡 vadi · ⚪ še ni srečal';

  @override
  String troubleWords(String letter, String words) {
    return 'Besede s črko $letter, ki se mešajo: $words';
  }

  @override
  String get tipNoData =>
      'Še ni česa vaditi — nasveti se pojavijo po nekaj lekcijah.';

  @override
  String tipWeakest(String words) {
    return 'Najšibkejše besede: $words. Doma jih poskusite ploskati po zlogih in iskati stvari, ki se z njimi začnejo.';
  }

  @override
  String tipLetter(String letter) {
    return 'Črka $letter se še utrjuje: skupaj doma iščite stvari, ki se začnejo na $letter.';
  }

  @override
  String get tipLongPress =>
      'Dolg pritisk na lekcijo na zemljevidu pokaže, kaj se v njej vadi in zakaj.';

  @override
  String methodLabel(String method) {
    return 'Metoda: $method';
  }

  @override
  String get methodText =>
      'Otrok s prstom drsi po črkah v vrstnem redu, v katerem sliši zlog ali besedo. Najprej odprti zlogi (MA, TA), nato cele besede, krogi poslušanja brez besedila, dopolnjevanke in ponavljanje najšibkejših besed. Napaka nikoli ne ovira napredka — kartica se samo strese in namigne. Naučene besede otrok takoj uporabi v stavku (sestavljalnik stavkov) in jih lahko shrani v Mojo knjigo.';

  @override
  String get settingSounds => 'Zvoki';

  @override
  String get settingAmbient => 'Zvoki sveta';

  @override
  String get settingMusic => 'Glasba';

  @override
  String get settingLeftHanded => 'Levičar (zrcalna tipkovnica)';

  @override
  String get settingDyslexiaFont => 'Pisava za disleksijo (OpenDyslexic)';

  @override
  String get settingSeason => 'Letni čas na zemljevidu';

  @override
  String get seasonAuto => 'po koledarju';

  @override
  String get seasonSpring => 'pomlad';

  @override
  String get seasonSummer => 'poletje';

  @override
  String get seasonAutumn => 'jesen';

  @override
  String get seasonWinter => 'zima';

  @override
  String get settingTimeLimit => 'Dnevna omejitev igranja';

  @override
  String get noLimit => 'brez omejitve';

  @override
  String minutes(int n) {
    return '$n min';
  }

  @override
  String playedToday(int played) {
    return 'Danes odigrano: $played min';
  }

  @override
  String playedTodayOf(int played, int limit) {
    return 'Danes odigrano: $played od $limit min';
  }

  @override
  String get guideAsleep => ' — vodnik spi';

  @override
  String extendToday(int n) {
    return 'Podaljšaj današnji dan za $n min';
  }

  @override
  String get profilesTitle => 'Profili';

  @override
  String deleteProfileTitle(String name) {
    return 'Izbrišem profil $name?';
  }

  @override
  String get deleteProfileBody =>
      'Izbrisani bodo tudi ves napredek, nalepke in knjiga. Tega ni mogoče razveljaviti.';

  @override
  String get cancel => 'Prekliči';

  @override
  String get delete => 'Izbriši';

  @override
  String get statMinutesToday => 'minut danes';

  @override
  String get statMinutesWeek => 'minut ta teden';

  @override
  String get letterMastered => 'obvladane';

  @override
  String get letterPracticing => 'vadi';

  @override
  String get letterUnseen => 'še ni srečal';

  @override
  String get typeHunt => 'GLAS';

  @override
  String get typeJoin => 'ZLOGI';

  @override
  String get typeRhyme => 'RIM';

  @override
  String get promptHunt => 'Katero črko si slišal? Tapni nanjo';

  @override
  String get promptJoin => 'Poveži zloge — podrsaj celo besedo';

  @override
  String get promptRhyme => 'Kaj se rima? Tapni sliko';

  @override
  String get expeditionTitle => 'Odprava po ponavljanje';

  @override
  String get badgeExpedition => 'Odpravnik';

  @override
  String get badgeExpeditionHow => 'Prva tedenska odprava po ponavljanje';

  @override
  String get seasonStickersTitle => 'Nalepke letnih časov';

  @override
  String get mapLoadFailed => 'Zemljevida ni bilo mogoče naložiti';

  @override
  String get retry => 'Poskusi znova';

  @override
  String get vocativeLabel => 'Češka oblika nagovora (zvalnik)';

  @override
  String get vocativeHint => 'npr. Lauro';

  @override
  String get guideTitle => 'Tvoj vodnik';

  @override
  String get petPlay => 'Pridi se igrat';

  @override
  String get badgeHost => 'Gostitelj';

  @override
  String get badgeHostHow => '10 daril živalim';

  @override
  String get badgeCuddler => 'Crkljavec';

  @override
  String get badgeCuddlerHow => 'Pobožal je 5 živali';

  @override
  String get badgeWishMaker => 'Izpolnjena želja';

  @override
  String get badgeWishMakerHow => '10 izpolnjenih želja';

  @override
  String get badgeFriendOfAll => 'Prijatelj vseh';

  @override
  String get badgeFriendOfAllHow => 'Vsaka žival je dobila darilo';

  @override
  String get settingPetRounds => 'Darila za živali: najprej napiši besedo';

  @override
  String get petBowlFood => 'skodelica';

  @override
  String get petBowlWater => 'voda';

  @override
  String get storeIslandA => 'Otok črk';

  @override
  String get storeIslandB => 'Otok besed';

  @override
  String get storeIslandC => 'Otok stavkov';

  @override
  String storeProductIsland(String island, String language) {
    return '$island – $language';
  }

  @override
  String storeProductIslandDesc(String language) {
    return 'Nove enote, nalepke in prebivalci sveta živali. Jezik: $language.';
  }

  @override
  String storeProductLanguage(String language) {
    return 'Še en jezik – $language';
  }

  @override
  String storeProductLanguageDesc(String island, String language) {
    return '$island v drugem jeziku: $language.';
  }

  @override
  String get storeProductBundle => 'Vse za vedno';

  @override
  String get storeProductBundleDesc =>
      'Vsi otoki in jeziki, tudi tisti, ki šele pridejo.';

  @override
  String get storeProductParent => 'Paket za starše';

  @override
  String get storeProductParentDesc =>
      'Delovni listi, tisk Moje knjige, tedenski pregled in prenos napredka.';

  @override
  String get storeStateFree => 'brezplačno';

  @override
  String get storeStateOwned => 'imate';

  @override
  String storeBuy(String price) {
    return 'Kupi za $price';
  }

  @override
  String get storeRestore => 'Obnovi nakupe';

  @override
  String get storeDebugTitle => 'Trgovina (razhroščevanje)';

  @override
  String get storeDebugEnable => 'Simuliraj vklopljeno trgovino';

  @override
  String get storeDebugForget => 'Pozabi nakupe';

  @override
  String get homeLanguageLabel => 'Jezik družine (meniji in namigi)';

  @override
  String get homeLanguageSame => 'Enak kot jezik igre';

  @override
  String get parentPrivacy => 'Pravilnik o zasebnosti';
}
