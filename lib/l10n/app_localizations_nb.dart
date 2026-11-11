// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Norwegian Bokmål (`nb`).
class AppLocalizationsNb extends AppLocalizations {
  AppLocalizationsNb([String locale = 'nb']) : super(locale);

  @override
  String get appTitle => 'SwypeKids';

  @override
  String get menuSyllabary => 'Bokstavbok (Swype)';

  @override
  String get menuSentence => 'Bygg en setning';

  @override
  String get menuZoo => 'Dyrehage';

  @override
  String get menuBook => 'Min bok';

  @override
  String get menuParents => 'For foreldre';

  @override
  String get practiceTitle => 'Øving';

  @override
  String bedtimeText(String guide) {
    return '$guide sover. Vi sees i morgen!';
  }

  @override
  String get typeListen => 'LYTT';

  @override
  String get typePicture => 'BILDE';

  @override
  String get typeGap => 'FYLL UT';

  @override
  String get typeReview => 'REPETISJON';

  @override
  String get typeWord => 'ORD';

  @override
  String get typeSyllable => 'STAVELSE';

  @override
  String get promptListen => 'Lytt og sveip det du hører';

  @override
  String get promptPicture => 'Hva er på bildet? Skriv det';

  @override
  String get promptGap => 'Hvilken bokstav mangler? Sveip hele ordet';

  @override
  String get promptSwipeTouch => 'Sveip fingeren over bildene';

  @override
  String get promptSwipeTrackpad => 'Sveip med to fingre over bildene';

  @override
  String get successText => 'Bra jobbet!';

  @override
  String get errorText => 'Prøv igjen!';

  @override
  String get newSticker => 'Du fikk et nytt klistremerke!';

  @override
  String starsGained(int count) {
    return '+$count stjerner';
  }

  @override
  String get backToMap => 'Tilbake til kartet';

  @override
  String get winTitle => 'Ferdig!\nDu er en mester!';

  @override
  String winStars(int count) {
    return 'Du fikk $count stjerner!';
  }

  @override
  String get playAgain => 'Spill igjen';

  @override
  String get builderBadge => 'SETNING';

  @override
  String get who => 'HVEM';

  @override
  String get whatDoes => 'GJØR HVA';

  @override
  String get whatWhere => 'HVA / HVOR';

  @override
  String get newLabel => 'NYTT';

  @override
  String get clear => 'Fjern';

  @override
  String get bookTitle => 'Min bok';

  @override
  String get bookEmptyHint => 'Bygg en setning og lagre den i boken';

  @override
  String get zooTitle => 'Dyrehage';

  @override
  String badgesTitle(int earned, int total) {
    return 'Merker $earned/$total';
  }

  @override
  String get badgeFirstSwype => 'Første sveip';

  @override
  String get badgeFirstSwypeHow => 'Første riktige sveip';

  @override
  String get badgeNoMistake => 'Uten feil';

  @override
  String get badgeNoMistakeHow => 'En hel enhet med tre stjerner';

  @override
  String get badgeExplorer => 'Oppdager';

  @override
  String get badgeExplorerHow => 'Første klistremerke';

  @override
  String get badgeCollectorHalf => 'Samler';

  @override
  String get badgeCollectorHalfHow => 'Halve dyrehagen';

  @override
  String get badgeCollectorAll => 'Stor samler';

  @override
  String get badgeCollectorAllHow => 'Hele dyrehagen';

  @override
  String get badgeNightOwl => 'Nattugle';

  @override
  String get badgeNightOwlHow => 'Spilte om natten';

  @override
  String get badgeEarlyBird => 'Morgenfugl';

  @override
  String get badgeEarlyBirdHow => 'Spilte om morgenen';

  @override
  String get badgeFourSeasons => 'Fire årstider';

  @override
  String get badgeFourSeasonsHow => 'Spilte i hver årstid';

  @override
  String get badgeWordsmith10 => 'Ordsmed';

  @override
  String get badgeWordsmith10How => '10 ord i sekken';

  @override
  String get badgeWordsmith25 => 'Stor ordsmed';

  @override
  String get badgeWordsmith25How => '25 ord i sekken';

  @override
  String get badgeWordsmith50 => 'Ordmester';

  @override
  String get badgeWordsmith50How => '50 ord i sekken';

  @override
  String get badgePoet => 'Dikter';

  @override
  String get badgePoetHow => '10 setninger i Min bok';

  @override
  String get badgeListener => 'Lytter';

  @override
  String get badgeListenerHow => '10 lytterunder med tre stjerner';

  @override
  String get badgePersistent => 'Utholdende';

  @override
  String get badgePersistentHow => '7 spilledager';

  @override
  String get parentTitle => 'For foreldre';

  @override
  String gateQuestion(int a, int b) {
    return 'Hva er $a × $b?';
  }

  @override
  String get backToGame => 'Tilbake til spillet';

  @override
  String get sectionOverview => 'Oversikt';

  @override
  String get sectionLetters => 'Bokstaver';

  @override
  String get sectionTips => 'Tips til hjemmet';

  @override
  String get sectionMethod => 'Slik lærer appen bort';

  @override
  String get sectionSettings => 'Innstillinger';

  @override
  String get statProfile => 'profil';

  @override
  String get statPlayDays => 'spilledager';

  @override
  String get statLessons => 'leksjoner';

  @override
  String get statStars => 'stjerner';

  @override
  String get statWords => 'ord i sekken';

  @override
  String get statSentences => 'setninger i Min bok';

  @override
  String get statBadges => 'merker';

  @override
  String get lettersLegend => '🟢 mestret · 🟡 øves · ⚪ ikke møtt ennå';

  @override
  String troubleWords(String letter, String words) {
    return 'Ord med $letter som blandes sammen: $words';
  }

  @override
  String get tipNoData =>
      'Ingenting å øve på ennå – tips dukker opp etter noen leksjoner.';

  @override
  String tipWeakest(String words) {
    return 'Svakeste ord: $words. Prøv å klappe dem stavelse for stavelse hjemme og finn ting som begynner med dem.';
  }

  @override
  String tipLetter(String letter) {
    return 'Bokstaven $letter sitter ikke helt ennå: let sammen hjemme etter ting som begynner med $letter.';
  }

  @override
  String get tipLongPress =>
      'Et langt trykk på en leksjon på kartet viser hva den øver på og hvorfor.';

  @override
  String methodLabel(String method) {
    return 'Metode: $method';
  }

  @override
  String get methodText =>
      'Barnet sveiper fingeren over bokstavene i den rekkefølgen det hører stavelsen eller ordet. Først åpne stavelser (MA, TA), så hele ord, lytterunder uten tekst, utfyllingsrunder og repetisjon av de svakeste ordene. En feil stopper aldri framgangen – kortet rister bare og gir et hint. Ord barnet har lært, brukes straks i en setning (setningsbyggeren) og kan lagres i Min bok.';

  @override
  String get settingSounds => 'Lyder';

  @override
  String get settingAmbient => 'Lyder fra verden';

  @override
  String get settingMusic => 'Musikk';

  @override
  String get settingLeftHanded => 'Venstrehendt (speilvendt tastatur)';

  @override
  String get settingDyslexiaFont => 'Skrifttype for dysleksi (OpenDyslexic)';

  @override
  String get settingSeason => 'Årstid på kartet';

  @override
  String get seasonAuto => 'etter kalenderen';

  @override
  String get seasonSpring => 'vår';

  @override
  String get seasonSummer => 'sommer';

  @override
  String get seasonAutumn => 'høst';

  @override
  String get seasonWinter => 'vinter';

  @override
  String get settingTimeLimit => 'Daglig tidsgrense for spilling';

  @override
  String get noLimit => 'ingen grense';

  @override
  String minutes(int n) {
    return '$n min';
  }

  @override
  String playedToday(int played) {
    return 'Spilt i dag: $played min';
  }

  @override
  String playedTodayOf(int played, int limit) {
    return 'Spilt i dag: $played av $limit min';
  }

  @override
  String get guideAsleep => ' – guiden sover';

  @override
  String extendToday(int n) {
    return 'Forleng i dag med $n min';
  }

  @override
  String get profilesTitle => 'Profiler';

  @override
  String deleteProfileTitle(String name) {
    return 'Slette profilen $name?';
  }

  @override
  String get deleteProfileBody =>
      'All framgang, alle klistremerker og boken slettes også. Dette kan ikke angres.';

  @override
  String get cancel => 'Avbryt';

  @override
  String get delete => 'Slett';

  @override
  String get statMinutesToday => 'minutter i dag';

  @override
  String get statMinutesWeek => 'minutter denne uken';

  @override
  String get letterMastered => 'mestret';

  @override
  String get letterPracticing => 'øves';

  @override
  String get letterUnseen => 'ikke møtt ennå';

  @override
  String get typeHunt => 'LYD';

  @override
  String get typeJoin => 'STAVELSER';

  @override
  String get typeRhyme => 'RIM';

  @override
  String get promptHunt => 'Hvilken bokstav hørte du? Trykk på den';

  @override
  String get promptJoin => 'Sett sammen stavelsene – sveip hele ordet';

  @override
  String get promptRhyme => 'Hva rimer? Trykk på bildet';

  @override
  String get expeditionTitle => 'Repetisjonsekspedisjon';

  @override
  String get badgeExpedition => 'Ekspedisjonsdeltaker';

  @override
  String get badgeExpeditionHow => 'Første ukentlige repetisjonsekspedisjon';

  @override
  String get seasonStickersTitle => 'Årstidsklistremerker';

  @override
  String get mapLoadFailed => 'Kartet kunne ikke lastes';

  @override
  String get retry => 'Prøv igjen';

  @override
  String get vocativeLabel => 'Tsjekkisk tiltaleform (vokativ)';

  @override
  String get vocativeHint => 'f.eks. Lauro';

  @override
  String get guideTitle => 'Din guide';

  @override
  String get petPlay => 'Kom og lek';

  @override
  String get badgeHost => 'Vert';

  @override
  String get badgeHostHow => '10 gaver til dyrene';

  @override
  String get badgeCuddler => 'Kosekatt';

  @override
  String get badgeCuddlerHow => 'Klappet 5 dyr';

  @override
  String get badgeWishMaker => 'Oppfylt ønske';

  @override
  String get badgeWishMakerHow => '10 oppfylte ønsker';

  @override
  String get badgeFriendOfAll => 'Alles venn';

  @override
  String get badgeFriendOfAllHow => 'Hvert dyr fikk en gave';

  @override
  String get settingPetRounds => 'Gaver til dyrene: skriv ordet først';

  @override
  String get petBowlFood => 'skål';

  @override
  String get petBowlWater => 'vann';

  @override
  String get storeIslandA => 'Bokstavøya';

  @override
  String get storeIslandB => 'Ordøya';

  @override
  String get storeIslandC => 'Setningsøya';

  @override
  String storeProductIsland(String island, String language) {
    return '$island – $language';
  }

  @override
  String storeProductIslandDesc(String language) {
    return 'Nye enheter, klistremerker og innbyggere i dyreverdenen. Språk: $language.';
  }

  @override
  String storeProductLanguage(String language) {
    return 'Et språk til – $language';
  }

  @override
  String storeProductLanguageDesc(String island, String language) {
    return '$island på et annet språk: $language.';
  }

  @override
  String get storeProductBundle => 'Alt for alltid';

  @override
  String get storeProductBundleDesc =>
      'Alle øyer og språk, også de som ennå skal komme.';

  @override
  String get storeProductParent => 'Foreldrepakke';

  @override
  String get storeProductParentDesc =>
      'Arbeidsark, utskrift av Min bok, ukeoversikt og overføring av framgang.';

  @override
  String get storeStateFree => 'gratis';

  @override
  String get storeStateOwned => 'eies';

  @override
  String storeBuy(String price) {
    return 'Kjøp for $price';
  }

  @override
  String get storeRestore => 'Gjenopprett kjøp';

  @override
  String get storeDebugTitle => 'Butikk (feilsøking)';

  @override
  String get storeDebugEnable => 'Simuler en aktivert butikk';

  @override
  String get storeDebugForget => 'Glem kjøp';

  @override
  String get homeLanguageLabel => 'Familiens språk (menyer og hjelp)';

  @override
  String get homeLanguageSame => 'Samme som spillspråket';

  @override
  String get parentPrivacy => 'Personvernerklæring';
}
