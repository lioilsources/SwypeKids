// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Danish (`da`).
class AppLocalizationsDa extends AppLocalizations {
  AppLocalizationsDa([String locale = 'da']) : super(locale);

  @override
  String get appTitle => 'SwypeKids';

  @override
  String get menuSyllabary => 'Staveplan (Swype)';

  @override
  String get menuSentence => 'Byg en sætning';

  @override
  String get menuZoo => 'Zoo';

  @override
  String get menuBook => 'Min bog';

  @override
  String get menuParents => 'Til forældre';

  @override
  String get practiceTitle => 'Øvelse';

  @override
  String bedtimeText(String guide) {
    return '$guide sover nu. Vi ses i morgen!';
  }

  @override
  String get typeListen => 'LYT';

  @override
  String get typePicture => 'BILLEDE';

  @override
  String get typeGap => 'UDFYLD';

  @override
  String get typeReview => 'REPETITION';

  @override
  String get typeWord => 'ORD';

  @override
  String get typeSyllable => 'STAVELSE';

  @override
  String get promptListen => 'Lyt og stryg det, du hører';

  @override
  String get promptPicture => 'Hvad er på billedet? Skriv det';

  @override
  String get promptGap => 'Hvilket bogstav mangler? Stryg hele ordet';

  @override
  String get promptSwipeTouch => 'Stryg fingeren hen over billederne';

  @override
  String get promptSwipeTrackpad => 'Stryg med to fingre hen over billederne';

  @override
  String get successText => 'Flot!';

  @override
  String get errorText => 'Prøv igen!';

  @override
  String get newSticker => 'Du har fået et nyt klistermærke!';

  @override
  String starsGained(int count) {
    return '+$count stjerner';
  }

  @override
  String get backToMap => 'Tilbage til kortet';

  @override
  String get winTitle => 'Færdig!\nDu er en mester!';

  @override
  String winStars(int count) {
    return 'Du har fået $count stjerner!';
  }

  @override
  String get playAgain => 'Spil igen';

  @override
  String get builderBadge => 'SÆTNING';

  @override
  String get who => 'HVEM';

  @override
  String get whatDoes => 'GØR HVAD';

  @override
  String get whatWhere => 'HVAD / HVOR';

  @override
  String get newLabel => 'NYT';

  @override
  String get clear => 'Ryd';

  @override
  String get bookTitle => 'Min bog';

  @override
  String get bookEmptyHint => 'Byg en sætning og gem den i bogen';

  @override
  String get zooTitle => 'Zoo';

  @override
  String badgesTitle(int earned, int total) {
    return 'Mærker $earned/$total';
  }

  @override
  String get badgeFirstSwype => 'Første stryg';

  @override
  String get badgeFirstSwypeHow => 'Første rigtige stryg';

  @override
  String get badgeNoMistake => 'Uden fejl';

  @override
  String get badgeNoMistakeHow => 'En hel enhed med tre stjerner';

  @override
  String get badgeExplorer => 'Opdagelsesrejsende';

  @override
  String get badgeExplorerHow => 'Første klistermærke';

  @override
  String get badgeCollectorHalf => 'Samler';

  @override
  String get badgeCollectorHalfHow => 'Halvdelen af zoo';

  @override
  String get badgeCollectorAll => 'Stor samler';

  @override
  String get badgeCollectorAllHow => 'Hele zoo';

  @override
  String get badgeNightOwl => 'Natugle';

  @override
  String get badgeNightOwlHow => 'Har spillet om natten';

  @override
  String get badgeEarlyBird => 'Morgenfugl';

  @override
  String get badgeEarlyBirdHow => 'Har spillet om morgenen';

  @override
  String get badgeFourSeasons => 'Fire årstider';

  @override
  String get badgeFourSeasonsHow => 'Har spillet i hver årstid';

  @override
  String get badgeWordsmith10 => 'Ordsmed';

  @override
  String get badgeWordsmith10How => '10 ord i tasken';

  @override
  String get badgeWordsmith25 => 'Stor ordsmed';

  @override
  String get badgeWordsmith25How => '25 ord i tasken';

  @override
  String get badgeWordsmith50 => 'Ordmester';

  @override
  String get badgeWordsmith50How => '50 ord i tasken';

  @override
  String get badgePoet => 'Digter';

  @override
  String get badgePoetHow => '10 sætninger i Min bog';

  @override
  String get badgeListener => 'Lytter';

  @override
  String get badgeListenerHow => '10 lytterunder med tre stjerner';

  @override
  String get badgePersistent => 'Udholdende';

  @override
  String get badgePersistentHow => '7 spilledage';

  @override
  String get parentTitle => 'Til forældre';

  @override
  String gateQuestion(int a, int b) {
    return 'Hvad er $a × $b?';
  }

  @override
  String get backToGame => 'Tilbage til spillet';

  @override
  String get sectionOverview => 'Overblik';

  @override
  String get sectionLetters => 'Bogstaver';

  @override
  String get sectionTips => 'Tips til hjemmet';

  @override
  String get sectionMethod => 'Sådan lærer appen';

  @override
  String get sectionSettings => 'Indstillinger';

  @override
  String get statProfile => 'profil';

  @override
  String get statPlayDays => 'spilledage';

  @override
  String get statLessons => 'lektioner';

  @override
  String get statStars => 'stjerner';

  @override
  String get statWords => 'ord i tasken';

  @override
  String get statSentences => 'sætninger i Min bog';

  @override
  String get statBadges => 'mærker';

  @override
  String get lettersLegend => '🟢 beherskes · 🟡 øves · ⚪ ikke mødt endnu';

  @override
  String troubleWords(String letter, String words) {
    return 'Ord med $letter, som bliver forvekslet: $words';
  }

  @override
  String get tipNoData =>
      'Der er ikke noget at øve endnu – tips dukker op efter nogle lektioner.';

  @override
  String tipWeakest(String words) {
    return 'Svageste ord: $words. Prøv at klappe dem i stavelser derhjemme og find ting, der starter med dem.';
  }

  @override
  String tipLetter(String letter) {
    return 'Bogstavet $letter sidder ikke helt fast endnu: led sammen efter ting derhjemme, der starter med $letter.';
  }

  @override
  String get tipLongPress =>
      'Et langt tryk på en lektion på kortet viser, hvad den øver, og hvorfor.';

  @override
  String methodLabel(String method) {
    return 'Metode: $method';
  }

  @override
  String get methodText =>
      'Barnet stryger fingeren hen over bogstaverne i den rækkefølge, det hører stavelsen eller ordet. Først åbne stavelser (MA, TA), så hele ord, lytterunder uden tekst, udfyldningsrunder og repetition af de svageste ord. En fejl blokerer aldrig for fremgang – kortet ryster bare og giver et hint. Lærte ord bruges straks i en sætning (sætningsbyggeren) og kan gemmes i Min bog.';

  @override
  String get settingSounds => 'Lyde';

  @override
  String get settingAmbient => 'Lyde fra verden';

  @override
  String get settingMusic => 'Musik';

  @override
  String get settingLeftHanded => 'Venstrehåndet (spejlvendt tastatur)';

  @override
  String get settingDyslexiaFont => 'Skrifttype til ordblinde (OpenDyslexic)';

  @override
  String get settingSeason => 'Årstid på kortet';

  @override
  String get seasonAuto => 'efter kalenderen';

  @override
  String get seasonSpring => 'forår';

  @override
  String get seasonSummer => 'sommer';

  @override
  String get seasonAutumn => 'efterår';

  @override
  String get seasonWinter => 'vinter';

  @override
  String get settingTimeLimit => 'Daglig spilletidsgrænse';

  @override
  String get noLimit => 'ingen grænse';

  @override
  String minutes(int n) {
    return '$n min';
  }

  @override
  String playedToday(int played) {
    return 'Spillet i dag: $played min';
  }

  @override
  String playedTodayOf(int played, int limit) {
    return 'Spillet i dag: $played af $limit min';
  }

  @override
  String get guideAsleep => ' — guiden sover';

  @override
  String extendToday(int n) {
    return 'Forlæng i dag med $n min';
  }

  @override
  String get profilesTitle => 'Profiler';

  @override
  String deleteProfileTitle(String name) {
    return 'Slet profilen $name?';
  }

  @override
  String get deleteProfileBody =>
      'Al fremgang, alle klistermærker og bogen slettes også. Det kan ikke fortrydes.';

  @override
  String get cancel => 'Annuller';

  @override
  String get delete => 'Slet';

  @override
  String get statMinutesToday => 'minutter i dag';

  @override
  String get statMinutesWeek => 'minutter denne uge';

  @override
  String get letterMastered => 'beherskes';

  @override
  String get letterPracticing => 'øves';

  @override
  String get letterUnseen => 'ikke mødt endnu';

  @override
  String get typeHunt => 'LYD';

  @override
  String get typeJoin => 'STAVELSER';

  @override
  String get typeRhyme => 'RIM';

  @override
  String get promptHunt => 'Hvilket bogstav hørte du? Tryk på det';

  @override
  String get promptJoin => 'Sæt stavelserne sammen – stryg hele ordet';

  @override
  String get promptRhyme => 'Hvad rimer? Tryk på billedet';

  @override
  String get expeditionTitle => 'Repetitionsekspedition';

  @override
  String get badgeExpedition => 'Ekspeditionsdeltager';

  @override
  String get badgeExpeditionHow => 'Første ugentlige repetitionsekspedition';

  @override
  String get seasonStickersTitle => 'Årstidsklistermærker';

  @override
  String get mapLoadFailed => 'Kortet kunne ikke indlæses';

  @override
  String get retry => 'Prøv igen';

  @override
  String get vocativeLabel => 'Tjekkisk tiltaleform (vokativ)';

  @override
  String get vocativeHint => 'f.eks. Lauro';

  @override
  String get guideTitle => 'Din guide';

  @override
  String get petPlay => 'Kom og leg';

  @override
  String get badgeHost => 'Vært';

  @override
  String get badgeHostHow => '10 gaver til dyrene';

  @override
  String get badgeCuddler => 'Krammer';

  @override
  String get badgeCuddlerHow => 'Har aet 5 dyr';

  @override
  String get badgeWishMaker => 'Opfyldt ønske';

  @override
  String get badgeWishMakerHow => '10 opfyldte ønsker';

  @override
  String get badgeFriendOfAll => 'Alles ven';

  @override
  String get badgeFriendOfAllHow => 'Hvert dyr har fået en gave';

  @override
  String get settingPetRounds => 'Gaver til dyrene: skriv først ordet';

  @override
  String get petBowlFood => 'skål';

  @override
  String get petBowlWater => 'vand';

  @override
  String get storeIslandA => 'Bogstavøen';

  @override
  String get storeIslandB => 'Ordøen';

  @override
  String get storeIslandC => 'Sætningsøen';

  @override
  String storeProductIsland(String island, String language) {
    return '$island – $language';
  }

  @override
  String storeProductIslandDesc(String language) {
    return 'Nye enheder, klistermærker og beboere i dyrenes verden. Sprog: $language.';
  }

  @override
  String storeProductLanguage(String language) {
    return 'Endnu et sprog – $language';
  }

  @override
  String storeProductLanguageDesc(String island, String language) {
    return '$island på et andet sprog: $language.';
  }

  @override
  String get storeProductBundle => 'Alt for evigt';

  @override
  String get storeProductBundleDesc =>
      'Alle øer og sprog, også dem der endnu mangler.';

  @override
  String get storeProductParent => 'Forældrepakke';

  @override
  String get storeProductParentDesc =>
      'Arbejdsark, udskrift af Min bog, ugeoversigt og overførsel af fremgang.';

  @override
  String get storeStateFree => 'gratis';

  @override
  String get storeStateOwned => 'ejet';

  @override
  String storeBuy(String price) {
    return 'Køb for $price';
  }

  @override
  String get storeRestore => 'Gendan køb';

  @override
  String get storeDebugTitle => 'Butik (fejlsøgning)';

  @override
  String get storeDebugEnable => 'Simuler en aktiveret butik';

  @override
  String get storeDebugForget => 'Glem køb';

  @override
  String get homeLanguageLabel => 'Familiens sprog (menuer og hjælp)';

  @override
  String get homeLanguageSame => 'Samme som spillets sprog';

  @override
  String get parentPrivacy => 'Privatlivspolitik';
}
