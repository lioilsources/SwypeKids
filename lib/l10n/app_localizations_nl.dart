// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Dutch Flemish (`nl`).
class AppLocalizationsNl extends AppLocalizations {
  AppLocalizationsNl([String locale = 'nl']) : super(locale);

  @override
  String get appTitle => 'SwypeKids';

  @override
  String get menuSyllabary => 'Letterboek (Swype)';

  @override
  String get menuSentence => 'Bouw een zin';

  @override
  String get menuZoo => 'Dierentuin';

  @override
  String get menuBook => 'Mijn boek';

  @override
  String get menuParents => 'Voor ouders';

  @override
  String get practiceTitle => 'Oefenen';

  @override
  String bedtimeText(String guide) {
    return '$guide slaapt. Tot morgen!';
  }

  @override
  String get typeListen => 'LUISTER';

  @override
  String get typePicture => 'PLAATJE';

  @override
  String get typeGap => 'AANVULLEN';

  @override
  String get typeReview => 'HERHALING';

  @override
  String get typeWord => 'WOORD';

  @override
  String get typeSyllable => 'LETTERGREEP';

  @override
  String get promptListen => 'Luister en veeg wat je hoort';

  @override
  String get promptPicture => 'Wat staat er op het plaatje? Schrijf het op';

  @override
  String get promptGap => 'Welke letter ontbreekt? Veeg het hele woord';

  @override
  String get promptSwipeTouch => 'Veeg met je vinger over de plaatjes';

  @override
  String get promptSwipeTrackpad => 'Veeg met twee vingers over de plaatjes';

  @override
  String get successText => 'Goed gedaan!';

  @override
  String get errorText => 'Probeer het nog eens!';

  @override
  String get newSticker => 'Je hebt een nieuwe sticker!';

  @override
  String starsGained(int count) {
    return '+$count sterren';
  }

  @override
  String get backToMap => 'Terug naar de kaart';

  @override
  String get winTitle => 'Klaar!\nJij bent een kampioen!';

  @override
  String winStars(int count) {
    return 'Je hebt $count sterren verdiend!';
  }

  @override
  String get playAgain => 'Opnieuw spelen';

  @override
  String get builderBadge => 'ZIN';

  @override
  String get who => 'WIE';

  @override
  String get whatDoes => 'DOET WAT';

  @override
  String get whatWhere => 'WAT / WAARHEEN';

  @override
  String get newLabel => 'NIEUW';

  @override
  String get clear => 'Wissen';

  @override
  String get bookTitle => 'Mijn boek';

  @override
  String get bookEmptyHint => 'Bouw een zin en bewaar hem in je boek';

  @override
  String get zooTitle => 'Dierentuin';

  @override
  String badgesTitle(int earned, int total) {
    return 'Badges $earned/$total';
  }

  @override
  String get badgeFirstSwype => 'Eerste veeg';

  @override
  String get badgeFirstSwypeHow => 'Eerste goede veeg';

  @override
  String get badgeNoMistake => 'Zonder fouten';

  @override
  String get badgeNoMistakeHow => 'Een hele eenheid met drie sterren';

  @override
  String get badgeExplorer => 'Ontdekker';

  @override
  String get badgeExplorerHow => 'Eerste sticker';

  @override
  String get badgeCollectorHalf => 'Verzamelaar';

  @override
  String get badgeCollectorHalfHow => 'De helft van de dierentuin';

  @override
  String get badgeCollectorAll => 'Grote verzamelaar';

  @override
  String get badgeCollectorAllHow => 'De hele dierentuin';

  @override
  String get badgeNightOwl => 'Nachtuil';

  @override
  String get badgeNightOwlHow => 'Speelde \'s nachts';

  @override
  String get badgeEarlyBird => 'Vroege vogel';

  @override
  String get badgeEarlyBirdHow => 'Speelde \'s ochtends';

  @override
  String get badgeFourSeasons => 'Vier seizoenen';

  @override
  String get badgeFourSeasonsHow => 'Speelde in elk seizoen';

  @override
  String get badgeWordsmith10 => 'Woordsmid';

  @override
  String get badgeWordsmith10How => '10 woorden in de tas';

  @override
  String get badgeWordsmith25 => 'Grote woordsmid';

  @override
  String get badgeWordsmith25How => '25 woorden in de tas';

  @override
  String get badgeWordsmith50 => 'Woordmeester';

  @override
  String get badgeWordsmith50How => '50 woorden in de tas';

  @override
  String get badgePoet => 'Dichter';

  @override
  String get badgePoetHow => '10 zinnen in Mijn boek';

  @override
  String get badgeListener => 'Luisteraar';

  @override
  String get badgeListenerHow => '10 luisterrondes met drie sterren';

  @override
  String get badgePersistent => 'Volhouder';

  @override
  String get badgePersistentHow => '7 speeldagen';

  @override
  String get parentTitle => 'Voor ouders';

  @override
  String gateQuestion(int a, int b) {
    return 'Hoeveel is $a × $b?';
  }

  @override
  String get backToGame => 'Terug naar het spel';

  @override
  String get sectionOverview => 'Overzicht';

  @override
  String get sectionLetters => 'Letters';

  @override
  String get sectionTips => 'Tips voor thuis';

  @override
  String get sectionMethod => 'Zo leert de app';

  @override
  String get sectionSettings => 'Instellingen';

  @override
  String get statProfile => 'profiel';

  @override
  String get statPlayDays => 'speeldagen';

  @override
  String get statLessons => 'lessen';

  @override
  String get statStars => 'sterren';

  @override
  String get statWords => 'woorden in de tas';

  @override
  String get statSentences => 'zinnen in Mijn boek';

  @override
  String get statBadges => 'badges';

  @override
  String get lettersLegend =>
      '🟢 beheerst · 🟡 aan het oefenen · ⚪ nog niet tegengekomen';

  @override
  String troubleWords(String letter, String words) {
    return 'Woorden met $letter die door elkaar raken: $words';
  }

  @override
  String get tipNoData =>
      'Nog niets om te oefenen — na een paar lessen verschijnen hier tips.';

  @override
  String tipWeakest(String words) {
    return 'Zwakste woorden: $words. Probeer ze thuis per lettergreep te klappen en zoek dingen die ermee beginnen.';
  }

  @override
  String tipLetter(String letter) {
    return 'De letter $letter zit nog niet helemaal: zoek samen thuis naar dingen die met $letter beginnen.';
  }

  @override
  String get tipLongPress =>
      'Lang drukken op een les op de kaart laat zien wat er geoefend wordt en waarom.';

  @override
  String methodLabel(String method) {
    return 'Methode: $method';
  }

  @override
  String get methodText =>
      'Het kind veegt met een vinger over de letters in de volgorde waarin het de lettergreep of het woord hoort. Eerst open lettergrepen (MA, TA), dan hele woorden, luisterrondes zonder tekst, invulrondes en herhaling van de zwakste woorden. Een fout blokkeert nooit de voortgang — de kaart schudt alleen en geeft een hint. Geleerde woorden komen meteen in een zin (de zinnenbouwer) en kunnen in Mijn boek worden bewaard.';

  @override
  String get settingSounds => 'Geluiden';

  @override
  String get settingAmbient => 'Geluiden van de wereld';

  @override
  String get settingMusic => 'Muziek';

  @override
  String get settingLeftHanded => 'Linkshandig (gespiegeld toetsenbord)';

  @override
  String get settingDyslexiaFont =>
      'Dyslexievriendelijk lettertype (OpenDyslexic)';

  @override
  String get settingSeason => 'Seizoen op de kaart';

  @override
  String get seasonAuto => 'volgens de kalender';

  @override
  String get seasonSpring => 'lente';

  @override
  String get seasonSummer => 'zomer';

  @override
  String get seasonAutumn => 'herfst';

  @override
  String get seasonWinter => 'winter';

  @override
  String get settingTimeLimit => 'Dagelijkse speeltijdlimiet';

  @override
  String get noLimit => 'geen limiet';

  @override
  String minutes(int n) {
    return '$n min';
  }

  @override
  String playedToday(int played) {
    return 'Vandaag gespeeld: $played min';
  }

  @override
  String playedTodayOf(int played, int limit) {
    return 'Vandaag gespeeld: $played van $limit min';
  }

  @override
  String get guideAsleep => ' — de gids slaapt';

  @override
  String extendToday(int n) {
    return 'Verleng vandaag met $n min';
  }

  @override
  String get profilesTitle => 'Profielen';

  @override
  String deleteProfileTitle(String name) {
    return 'Profiel $name verwijderen?';
  }

  @override
  String get deleteProfileBody =>
      'Alle voortgang, stickers en het boek worden ook verwijderd. Dit kan niet ongedaan worden gemaakt.';

  @override
  String get cancel => 'Annuleren';

  @override
  String get delete => 'Verwijderen';

  @override
  String get statMinutesToday => 'minuten vandaag';

  @override
  String get statMinutesWeek => 'minuten deze week';

  @override
  String get letterMastered => 'beheerst';

  @override
  String get letterPracticing => 'aan het oefenen';

  @override
  String get letterUnseen => 'nog niet tegengekomen';

  @override
  String get typeHunt => 'KLANK';

  @override
  String get typeJoin => 'LETTERGREPEN';

  @override
  String get typeRhyme => 'RIJM';

  @override
  String get promptHunt => 'Welke letter hoorde je? Tik erop';

  @override
  String get promptJoin => 'Verbind de lettergrepen — veeg het hele woord';

  @override
  String get promptRhyme => 'Wat rijmt er? Tik op het plaatje';

  @override
  String get expeditionTitle => 'Herhalingsexpeditie';

  @override
  String get badgeExpedition => 'Expeditielid';

  @override
  String get badgeExpeditionHow => 'Eerste wekelijkse herhalingsexpeditie';

  @override
  String get seasonStickersTitle => 'Seizoensstickers';

  @override
  String get mapLoadFailed => 'De kaart kon niet worden geladen';

  @override
  String get retry => 'Probeer opnieuw';

  @override
  String get vocativeLabel => 'Tsjechische aanspreekvorm (vocatief)';

  @override
  String get vocativeHint => 'bijv. Lauro';

  @override
  String get guideTitle => 'Jouw gids';

  @override
  String get petPlay => 'Kom spelen';

  @override
  String get badgeHost => 'Gastheer';

  @override
  String get badgeHostHow => '10 cadeaus voor dieren';

  @override
  String get badgeCuddler => 'Knuffelaar';

  @override
  String get badgeCuddlerHow => '5 dieren geaaid';

  @override
  String get badgeWishMaker => 'Vervulde wens';

  @override
  String get badgeWishMakerHow => '10 vervulde wensen';

  @override
  String get badgeFriendOfAll => 'Vriend van allemaal';

  @override
  String get badgeFriendOfAllHow => 'Elk dier kreeg een cadeau';

  @override
  String get settingPetRounds => 'Cadeaus voor dieren: schrijf eerst het woord';

  @override
  String get petBowlFood => 'bak';

  @override
  String get petBowlWater => 'water';

  @override
  String get storeIslandA => 'Letter-eiland';

  @override
  String get storeIslandB => 'Woorden-eiland';

  @override
  String get storeIslandC => 'Zinnen-eiland';

  @override
  String storeProductIsland(String island, String language) {
    return '$island – $language';
  }

  @override
  String storeProductIslandDesc(String language) {
    return 'Nieuwe eenheden, stickers en bewoners van de dierenwereld. Taal: $language.';
  }

  @override
  String storeProductLanguage(String language) {
    return 'Nog een taal – $language';
  }

  @override
  String storeProductLanguageDesc(String island, String language) {
    return '$island in een andere taal: $language.';
  }

  @override
  String get storeProductBundle => 'Alles voor altijd';

  @override
  String get storeProductBundleDesc =>
      'Alle eilanden en talen, ook de talen die nog komen.';

  @override
  String get storeProductParent => 'Ouderpakket';

  @override
  String get storeProductParentDesc =>
      'Werkbladen, Mijn boek printen, weekoverzicht en voortgang overzetten.';

  @override
  String get storeStateFree => 'gratis';

  @override
  String get storeStateOwned => 'in bezit';

  @override
  String storeBuy(String price) {
    return 'Koop voor $price';
  }

  @override
  String get storeRestore => 'Aankopen herstellen';

  @override
  String get storeDebugTitle => 'Winkel (debug)';

  @override
  String get storeDebugEnable => 'Simuleer een ingeschakelde winkel';

  @override
  String get storeDebugForget => 'Aankopen vergeten';

  @override
  String get homeLanguageLabel => 'Taal van het gezin (menu\'s en hints)';

  @override
  String get homeLanguageSame => 'Dezelfde als de speltaal';

  @override
  String get parentPrivacy => 'Privacybeleid';
}
