// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Finnish (`fi`).
class AppLocalizationsFi extends AppLocalizations {
  AppLocalizationsFi([String locale = 'fi']) : super(locale);

  @override
  String get appTitle => 'SwypeKids';

  @override
  String get menuSyllabary => 'Tavutaulu (Swype)';

  @override
  String get menuSentence => 'Rakenna lause';

  @override
  String get menuZoo => 'Eläintarha';

  @override
  String get menuBook => 'Oma kirjani';

  @override
  String get menuParents => 'Vanhemmille';

  @override
  String get practiceTitle => 'Harjoittelu';

  @override
  String bedtimeText(String guide) {
    return '$guide nukkuu. Nähdään huomenna!';
  }

  @override
  String get typeListen => 'KUUNTELE';

  @override
  String get typePicture => 'KUVA';

  @override
  String get typeGap => 'TÄYDENNÄ';

  @override
  String get typeReview => 'KERTAUS';

  @override
  String get typeWord => 'SANA';

  @override
  String get typeSyllable => 'TAVU';

  @override
  String get promptListen => 'Kuuntele ja pyyhkäise, mitä kuulet';

  @override
  String get promptPicture => 'Mitä kuvassa on? Kirjoita se';

  @override
  String get promptGap => 'Mikä kirjain puuttuu? Pyyhkäise koko sana';

  @override
  String get promptSwipeTouch => 'Pyyhkäise sormella kuvien yli';

  @override
  String get promptSwipeTrackpad => 'Pyyhkäise kahdella sormella kuvien yli';

  @override
  String get successText => 'Hienoa!';

  @override
  String get errorText => 'Yritä uudelleen!';

  @override
  String get newSticker => 'Sait uuden tarran!';

  @override
  String starsGained(int count) {
    return '+$count tähteä';
  }

  @override
  String get backToMap => 'Takaisin kartalle';

  @override
  String get winTitle => 'Valmis!\nOlet mestari!';

  @override
  String winStars(int count) {
    return 'Ansaitsit $count tähteä!';
  }

  @override
  String get playAgain => 'Pelaa uudelleen';

  @override
  String get builderBadge => 'LAUSE';

  @override
  String get who => 'KUKA';

  @override
  String get whatDoes => 'MITÄ TEKEE';

  @override
  String get whatWhere => 'MITÄ / MIHIN';

  @override
  String get newLabel => 'UUSI';

  @override
  String get clear => 'Tyhjennä';

  @override
  String get bookTitle => 'Oma kirjani';

  @override
  String get bookEmptyHint => 'Rakenna lause ja tallenna se kirjaan';

  @override
  String get zooTitle => 'Eläintarha';

  @override
  String badgesTitle(int earned, int total) {
    return 'Merkit $earned/$total';
  }

  @override
  String get badgeFirstSwype => 'Ensimmäinen pyyhkäisy';

  @override
  String get badgeFirstSwypeHow => 'Ensimmäinen oikea pyyhkäisy';

  @override
  String get badgeNoMistake => 'Ei virheitä';

  @override
  String get badgeNoMistakeHow => 'Koko yksikkö kolmella tähdellä';

  @override
  String get badgeExplorer => 'Tutkimusmatkailija';

  @override
  String get badgeExplorerHow => 'Ensimmäinen tarra';

  @override
  String get badgeCollectorHalf => 'Keräilijä';

  @override
  String get badgeCollectorHalfHow => 'Puolet eläintarhasta';

  @override
  String get badgeCollectorAll => 'Suuri keräilijä';

  @override
  String get badgeCollectorAllHow => 'Koko eläintarha';

  @override
  String get badgeNightOwl => 'Yökukkuja';

  @override
  String get badgeNightOwlHow => 'Pelannut yöllä';

  @override
  String get badgeEarlyBird => 'Aamuvirkku';

  @override
  String get badgeEarlyBirdHow => 'Pelannut aamulla';

  @override
  String get badgeFourSeasons => 'Neljä vuodenaikaa';

  @override
  String get badgeFourSeasonsHow => 'Pelannut jokaisena vuodenaikana';

  @override
  String get badgeWordsmith10 => 'Sanasepän aluke';

  @override
  String get badgeWordsmith10How => '10 sanaa laukussa';

  @override
  String get badgeWordsmith25 => 'Sanaseppä';

  @override
  String get badgeWordsmith25How => '25 sanaa laukussa';

  @override
  String get badgeWordsmith50 => 'Sanamestari';

  @override
  String get badgeWordsmith50How => '50 sanaa laukussa';

  @override
  String get badgePoet => 'Runoilija';

  @override
  String get badgePoetHow => '10 lausetta Omassa kirjassani';

  @override
  String get badgeListener => 'Kuuntelija';

  @override
  String get badgeListenerHow => '10 kuuntelukierrosta kolmella tähdellä';

  @override
  String get badgePersistent => 'Sinnikäs';

  @override
  String get badgePersistentHow => '7 pelipäivää';

  @override
  String get parentTitle => 'Vanhemmille';

  @override
  String gateQuestion(int a, int b) {
    return 'Mitä on $a × $b?';
  }

  @override
  String get backToGame => 'Takaisin peliin';

  @override
  String get sectionOverview => 'Yleiskatsaus';

  @override
  String get sectionLetters => 'Kirjaimet';

  @override
  String get sectionTips => 'Vinkkejä kotiin';

  @override
  String get sectionMethod => 'Näin sovellus opettaa';

  @override
  String get sectionSettings => 'Asetukset';

  @override
  String get statProfile => 'profiili';

  @override
  String get statPlayDays => 'pelipäivää';

  @override
  String get statLessons => 'oppituntia';

  @override
  String get statStars => 'tähteä';

  @override
  String get statWords => 'sanaa laukussa';

  @override
  String get statSentences => 'lausetta Omassa kirjassani';

  @override
  String get statBadges => 'merkkiä';

  @override
  String get lettersLegend =>
      '🟢 hallitsee · 🟡 harjoittelee · ⚪ ei vielä vastaan tullut';

  @override
  String troubleWords(String letter, String words) {
    return 'Sanat, joissa $letter menee sekaisin: $words';
  }

  @override
  String get tipNoData =>
      'Harjoiteltavaa ei vielä ole – vinkit ilmestyvät muutaman oppitunnin jälkeen.';

  @override
  String tipWeakest(String words) {
    return 'Heikoimmat sanat: $words. Kokeilkaa kotona taputtaa ne tavuittain ja etsiä asioita, jotka alkavat niillä.';
  }

  @override
  String tipLetter(String letter) {
    return 'Kirjain $letter on vielä hakusessa: etsikää yhdessä kotoa asioita, jotka alkavat kirjaimella $letter.';
  }

  @override
  String get tipLongPress =>
      'Oppitunnin pitkä painallus kartalla näyttää, mitä se harjoittaa ja miksi.';

  @override
  String methodLabel(String method) {
    return 'Menetelmä: $method';
  }

  @override
  String get methodText =>
      'Lapsi pyyhkäisee sormella kirjainten yli siinä järjestyksessä, jossa hän kuulee tavun tai sanan. Ensin avotavut (MA, TA), sitten kokonaiset sanat, kuunteluyksiköt ilman tekstiä, aukkotehtävät ja heikoimpien sanojen kertaus. Virhe ei koskaan estä etenemistä – kortti vain tärisee ja antaa vihjeen. Opitut sanat pääsevät heti lauseeseen (lauseenrakentaja) ja ne voi tallentaa Omaan kirjaani.';

  @override
  String get settingSounds => 'Äänet';

  @override
  String get settingAmbient => 'Maailman äänet';

  @override
  String get settingMusic => 'Musiikki';

  @override
  String get settingLeftHanded => 'Vasenkätinen (peilattu näppäimistö)';

  @override
  String get settingDyslexiaFont =>
      'Lukihäiriöystävällinen kirjasin (OpenDyslexic)';

  @override
  String get settingSeason => 'Vuodenaika kartalla';

  @override
  String get seasonAuto => 'kalenterin mukaan';

  @override
  String get seasonSpring => 'kevät';

  @override
  String get seasonSummer => 'kesä';

  @override
  String get seasonAutumn => 'syksy';

  @override
  String get seasonWinter => 'talvi';

  @override
  String get settingTimeLimit => 'Päivittäinen peliaikaraja';

  @override
  String get noLimit => 'ei rajaa';

  @override
  String minutes(int n) {
    return '$n min';
  }

  @override
  String playedToday(int played) {
    return 'Tänään pelattu: $played min';
  }

  @override
  String playedTodayOf(int played, int limit) {
    return 'Tänään pelattu: $played / $limit min';
  }

  @override
  String get guideAsleep => ' – opas nukkuu';

  @override
  String extendToday(int n) {
    return 'Pidennä tätä päivää $n min';
  }

  @override
  String get profilesTitle => 'Profiilit';

  @override
  String deleteProfileTitle(String name) {
    return 'Poistetaanko profiili $name?';
  }

  @override
  String get deleteProfileBody =>
      'Myös koko eteneminen, tarrat ja kirja poistetaan. Tätä ei voi perua.';

  @override
  String get cancel => 'Peruuta';

  @override
  String get delete => 'Poista';

  @override
  String get statMinutesToday => 'minuuttia tänään';

  @override
  String get statMinutesWeek => 'minuuttia tällä viikolla';

  @override
  String get letterMastered => 'hallitsee';

  @override
  String get letterPracticing => 'harjoittelee';

  @override
  String get letterUnseen => 'ei vielä vastaan tullut';

  @override
  String get typeHunt => 'ÄÄNNE';

  @override
  String get typeJoin => 'TAVUT';

  @override
  String get typeRhyme => 'LORU';

  @override
  String get promptHunt => 'Minkä kirjaimen kuulit? Napauta sitä';

  @override
  String get promptJoin => 'Yhdistä tavut – pyyhkäise koko sana';

  @override
  String get promptRhyme => 'Mikä riimittyy? Napauta kuvaa';

  @override
  String get expeditionTitle => 'Kertausretki';

  @override
  String get badgeExpedition => 'Retkeilijä';

  @override
  String get badgeExpeditionHow => 'Ensimmäinen viikoittainen kertausretki';

  @override
  String get seasonStickersTitle => 'Vuodenaikatarrat';

  @override
  String get mapLoadFailed => 'Karttaa ei voitu ladata';

  @override
  String get retry => 'Yritä uudelleen';

  @override
  String get vocativeLabel => 'Tšekin kielen puhuttelumuoto (vokatiivi)';

  @override
  String get vocativeHint => 'esim. Lauro';

  @override
  String get guideTitle => 'Oppaasi';

  @override
  String get petPlay => 'Tule leikkimään';

  @override
  String get badgeHost => 'Isäntä';

  @override
  String get badgeHostHow => '10 lahjaa eläimille';

  @override
  String get badgeCuddler => 'Hellittelijä';

  @override
  String get badgeCuddlerHow => 'Silitti 5 eläintä';

  @override
  String get badgeWishMaker => 'Toteutunut toive';

  @override
  String get badgeWishMakerHow => '10 toteutunutta toivetta';

  @override
  String get badgeFriendOfAll => 'Kaikkien ystävä';

  @override
  String get badgeFriendOfAllHow => 'Jokainen eläin sai lahjan';

  @override
  String get settingPetRounds => 'Lahjat eläimille: kirjoita ensin sana';

  @override
  String get petBowlFood => 'kuppi';

  @override
  String get petBowlWater => 'vesi';

  @override
  String get storeIslandA => 'Kirjainsaari';

  @override
  String get storeIslandB => 'Sanasaari';

  @override
  String get storeIslandC => 'Lausesaari';

  @override
  String storeProductIsland(String island, String language) {
    return '$island – $language';
  }

  @override
  String storeProductIslandDesc(String language) {
    return 'Uusia yksiköitä, tarroja ja eläinmaailman asukkaita. Kieli: $language.';
  }

  @override
  String storeProductLanguage(String language) {
    return 'Toinen kieli – $language';
  }

  @override
  String storeProductLanguageDesc(String island, String language) {
    return '$island toisella kielellä: $language.';
  }

  @override
  String get storeProductBundle => 'Kaikki ikuisesti';

  @override
  String get storeProductBundleDesc =>
      'Kaikki saaret ja kielet, myös ne, jotka vasta tulevat.';

  @override
  String get storeProductParent => 'Vanhempien paketti';

  @override
  String get storeProductParentDesc =>
      'Tehtävämonisteet, Oman kirjani tulostus, viikkoyhteenveto ja etenemisen siirto.';

  @override
  String get storeStateFree => 'ilmainen';

  @override
  String get storeStateOwned => 'omistat';

  @override
  String storeBuy(String price) {
    return 'Osta hintaan $price';
  }

  @override
  String get storeRestore => 'Palauta ostot';

  @override
  String get storeDebugTitle => 'Kauppa (vianetsintä)';

  @override
  String get storeDebugEnable => 'Simuloi käytössä oleva kauppa';

  @override
  String get storeDebugForget => 'Unohda ostot';

  @override
  String get homeLanguageLabel => 'Perheen kieli (valikot ja vihjeet)';

  @override
  String get homeLanguageSame => 'Sama kuin pelin kieli';

  @override
  String get parentPrivacy => 'Tietosuojakäytäntö';
}
