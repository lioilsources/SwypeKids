// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Croatian (`hr`).
class AppLocalizationsHr extends AppLocalizations {
  AppLocalizationsHr([String locale = 'hr']) : super(locale);

  @override
  String get appTitle => 'SwypeKids';

  @override
  String get menuSyllabary => 'Slovarica (Swype)';

  @override
  String get menuSentence => 'Složi rečenicu';

  @override
  String get menuZoo => 'Zoološki vrt';

  @override
  String get menuBook => 'Moja knjiga';

  @override
  String get menuParents => 'Za roditelje';

  @override
  String get practiceTitle => 'Vježba';

  @override
  String bedtimeText(String guide) {
    return '$guide spava. Do sutra!';
  }

  @override
  String get typeListen => 'SLUŠAJ';

  @override
  String get typePicture => 'SLIKA';

  @override
  String get typeGap => 'DOPUNI';

  @override
  String get typeReview => 'PONAVLJANJE';

  @override
  String get typeWord => 'RIJEČ';

  @override
  String get typeSyllable => 'SLOG';

  @override
  String get promptListen => 'Slušaj i povuci prstom ono što čuješ';

  @override
  String get promptPicture => 'Što je na slici? Napiši';

  @override
  String get promptGap => 'Koje slovo nedostaje? Povuci cijelu riječ';

  @override
  String get promptSwipeTouch => 'Povuci prstom preko slika';

  @override
  String get promptSwipeTrackpad => 'Povuci s dva prsta preko slika';

  @override
  String get successText => 'Bravo!';

  @override
  String get errorText => 'Pokušaj ponovno!';

  @override
  String get newSticker => 'Dobio si novu naljepnicu!';

  @override
  String starsGained(int count) {
    return '+$count zvjezdica';
  }

  @override
  String get backToMap => 'Natrag na kartu';

  @override
  String get winTitle => 'Gotovo!\nTi si prvak!';

  @override
  String winStars(int count) {
    return 'Osvojio si $count zvjezdica!';
  }

  @override
  String get playAgain => 'Igraj ponovno';

  @override
  String get builderBadge => 'REČENICA';

  @override
  String get who => 'TKO';

  @override
  String get whatDoes => 'ŠTO RADI';

  @override
  String get whatWhere => 'ŠTO / GDJE';

  @override
  String get newLabel => 'NOVO';

  @override
  String get clear => 'Obriši';

  @override
  String get bookTitle => 'Moja knjiga';

  @override
  String get bookEmptyHint => 'Složi rečenicu i spremi je u knjigu';

  @override
  String get zooTitle => 'Zoološki vrt';

  @override
  String badgesTitle(int earned, int total) {
    return 'Značke $earned/$total';
  }

  @override
  String get badgeFirstSwype => 'Prvo povlačenje';

  @override
  String get badgeFirstSwypeHow => 'Prvo točno povlačenje';

  @override
  String get badgeNoMistake => 'Bez pogreške';

  @override
  String get badgeNoMistakeHow => 'Cijela cjelina s tri zvjezdice';

  @override
  String get badgeExplorer => 'Istraživač';

  @override
  String get badgeExplorerHow => 'Prva naljepnica';

  @override
  String get badgeCollectorHalf => 'Skupljač';

  @override
  String get badgeCollectorHalfHow => 'Pola zoološkog vrta';

  @override
  String get badgeCollectorAll => 'Veliki skupljač';

  @override
  String get badgeCollectorAllHow => 'Cijeli zoološki vrt';

  @override
  String get badgeNightOwl => 'Noćna sova';

  @override
  String get badgeNightOwlHow => 'Igrao je noću';

  @override
  String get badgeEarlyBird => 'Rana ptica';

  @override
  String get badgeEarlyBirdHow => 'Igrao je ujutro';

  @override
  String get badgeFourSeasons => 'Četiri godišnja doba';

  @override
  String get badgeFourSeasonsHow => 'Igrao je u svakom godišnjem dobu';

  @override
  String get badgeWordsmith10 => 'Riječar';

  @override
  String get badgeWordsmith10How => '10 riječi u torbi';

  @override
  String get badgeWordsmith25 => 'Veliki riječar';

  @override
  String get badgeWordsmith25How => '25 riječi u torbi';

  @override
  String get badgeWordsmith50 => 'Majstor riječi';

  @override
  String get badgeWordsmith50How => '50 riječi u torbi';

  @override
  String get badgePoet => 'Pjesnik';

  @override
  String get badgePoetHow => '10 rečenica u Mojoj knjizi';

  @override
  String get badgeListener => 'Slušatelj';

  @override
  String get badgeListenerHow => '10 krugova slušanja s tri zvjezdice';

  @override
  String get badgePersistent => 'Ustrajan';

  @override
  String get badgePersistentHow => '7 dana igranja';

  @override
  String get parentTitle => 'Za roditelje';

  @override
  String gateQuestion(int a, int b) {
    return 'Koliko je $a × $b?';
  }

  @override
  String get backToGame => 'Natrag u igru';

  @override
  String get sectionOverview => 'Pregled';

  @override
  String get sectionLetters => 'Slova';

  @override
  String get sectionTips => 'Savjeti za dom';

  @override
  String get sectionMethod => 'Kako aplikacija uči';

  @override
  String get sectionSettings => 'Postavke';

  @override
  String get statProfile => 'profil';

  @override
  String get statPlayDays => 'dana igranja';

  @override
  String get statLessons => 'lekcija';

  @override
  String get statStars => 'zvjezdica';

  @override
  String get statWords => 'riječi u torbi';

  @override
  String get statSentences => 'rečenica u Mojoj knjizi';

  @override
  String get statBadges => 'znački';

  @override
  String get lettersLegend =>
      '🟢 svladano · 🟡 vježba se · ⚪ još nije upoznato';

  @override
  String troubleWords(String letter, String words) {
    return 'Riječi sa slovom $letter koje se miješaju: $words';
  }

  @override
  String get tipNoData =>
      'Još nema što vježbati – savjeti se pojave nakon nekoliko lekcija.';

  @override
  String tipWeakest(String words) {
    return 'Najslabije riječi: $words. Probajte ih kod kuće pljeskati po slogovima i tražiti stvari koje počinju njima.';
  }

  @override
  String tipLetter(String letter) {
    return 'Slovo $letter se još sliježe: tražite zajedno kod kuće stvari koje počinju na $letter.';
  }

  @override
  String get tipLongPress =>
      'Dugi pritisak na lekciju na karti pokazuje što se u njoj vježba i zašto.';

  @override
  String methodLabel(String method) {
    return 'Metoda: $method';
  }

  @override
  String get methodText =>
      'Dijete povlači prstom preko slova redoslijedom kojim čuje slog ili riječ. Najprije otvoreni slogovi (MA, TA), zatim cijele riječi, krugovi slušanja bez teksta, popunjavanje praznina i ponavljanje najslabijih riječi. Pogreška nikad ne blokira napredak – kartica se samo zatrese i nagovijesti. Naučene riječi odmah ulaze u rečenicu (slagalica rečenica) i mogu se spremiti u Moju knjigu.';

  @override
  String get settingSounds => 'Zvukovi';

  @override
  String get settingAmbient => 'Zvukovi svijeta';

  @override
  String get settingMusic => 'Glazba';

  @override
  String get settingLeftHanded => 'Ljevoruk (zrcaljena tipkovnica)';

  @override
  String get settingDyslexiaFont => 'Font prilagođen disleksiji (OpenDyslexic)';

  @override
  String get settingSeason => 'Godišnje doba na karti';

  @override
  String get seasonAuto => 'prema kalendaru';

  @override
  String get seasonSpring => 'proljeće';

  @override
  String get seasonSummer => 'ljeto';

  @override
  String get seasonAutumn => 'jesen';

  @override
  String get seasonWinter => 'zima';

  @override
  String get settingTimeLimit => 'Dnevno ograničenje igranja';

  @override
  String get noLimit => 'bez ograničenja';

  @override
  String minutes(int n) {
    return '$n min';
  }

  @override
  String playedToday(int played) {
    return 'Danas odigrano: $played min';
  }

  @override
  String playedTodayOf(int played, int limit) {
    return 'Danas odigrano: $played od $limit min';
  }

  @override
  String get guideAsleep => ' – vodič spava';

  @override
  String extendToday(int n) {
    return 'Produži današnji dan za $n min';
  }

  @override
  String get profilesTitle => 'Profili';

  @override
  String deleteProfileTitle(String name) {
    return 'Izbrisati profil $name?';
  }

  @override
  String get deleteProfileBody =>
      'Izbrisat će se i sav napredak, naljepnice i knjiga. To se ne može poništiti.';

  @override
  String get cancel => 'Odustani';

  @override
  String get delete => 'Izbriši';

  @override
  String get statMinutesToday => 'minuta danas';

  @override
  String get statMinutesWeek => 'minuta ovaj tjedan';

  @override
  String get letterMastered => 'svladano';

  @override
  String get letterPracticing => 'vježba se';

  @override
  String get letterUnseen => 'još nije upoznato';

  @override
  String get typeHunt => 'GLAS';

  @override
  String get typeJoin => 'SLOGOVI';

  @override
  String get typeRhyme => 'RIMA';

  @override
  String get promptHunt => 'Koje si slovo čuo? Dodirni ga';

  @override
  String get promptJoin => 'Spoji slogove – povuci cijelu riječ';

  @override
  String get promptRhyme => 'Što se rimuje? Dodirni sliku';

  @override
  String get expeditionTitle => 'Pohod na ponavljanje';

  @override
  String get badgeExpedition => 'Pohodnik';

  @override
  String get badgeExpeditionHow => 'Prvi tjedni pohod na ponavljanje';

  @override
  String get seasonStickersTitle => 'Naljepnice godišnjih doba';

  @override
  String get mapLoadFailed => 'Karta se nije mogla učitati';

  @override
  String get retry => 'Pokušaj ponovno';

  @override
  String get vocativeLabel => 'Češki oblik oslovljavanja (vokativ)';

  @override
  String get vocativeHint => 'npr. Lauro';

  @override
  String get guideTitle => 'Tvoj vodič';

  @override
  String get petPlay => 'Hajde da se igramo';

  @override
  String get badgeHost => 'Domaćin';

  @override
  String get badgeHostHow => '10 darova životinjama';

  @override
  String get badgeCuddler => 'Maziša';

  @override
  String get badgeCuddlerHow => 'Pomazio je 5 životinja';

  @override
  String get badgeWishMaker => 'Ispunjena želja';

  @override
  String get badgeWishMakerHow => '10 ispunjenih želja';

  @override
  String get badgeFriendOfAll => 'Prijatelj svih';

  @override
  String get badgeFriendOfAllHow => 'Svaka je životinja dobila dar';

  @override
  String get settingPetRounds => 'Darovi životinjama: najprije napiši riječ';

  @override
  String get petBowlFood => 'zdjelica';

  @override
  String get petBowlWater => 'voda';

  @override
  String get storeIslandA => 'Otok slova';

  @override
  String get storeIslandB => 'Otok riječi';

  @override
  String get storeIslandC => 'Otok rečenica';

  @override
  String storeProductIsland(String island, String language) {
    return '$island – $language';
  }

  @override
  String storeProductIslandDesc(String language) {
    return 'Nove cjeline, naljepnice i stanovnici svijeta životinja. Jezik: $language.';
  }

  @override
  String storeProductLanguage(String language) {
    return 'Još jedan jezik – $language';
  }

  @override
  String storeProductLanguageDesc(String island, String language) {
    return '$island na drugom jeziku: $language.';
  }

  @override
  String get storeProductBundle => 'Sve zauvijek';

  @override
  String get storeProductBundleDesc =>
      'Svi otoci i jezici, i oni koji tek stižu.';

  @override
  String get storeProductParent => 'Paket za roditelje';

  @override
  String get storeProductParentDesc =>
      'Radni listovi, ispis Moje knjige, tjedni pregled i prijenos napretka.';

  @override
  String get storeStateFree => 'besplatno';

  @override
  String get storeStateOwned => 'imate';

  @override
  String storeBuy(String price) {
    return 'Kupi za $price';
  }

  @override
  String get storeRestore => 'Vrati kupnje';

  @override
  String get storeDebugTitle => 'Trgovina (otklanjanje pogrešaka)';

  @override
  String get storeDebugEnable => 'Simuliraj uključenu trgovinu';

  @override
  String get storeDebugForget => 'Zaboravi kupnje';

  @override
  String get homeLanguageLabel => 'Jezik obitelji (izbornici i pomoć)';

  @override
  String get homeLanguageSame => 'Isti kao jezik igre';

  @override
  String get parentPrivacy => 'Pravila privatnosti';
}
