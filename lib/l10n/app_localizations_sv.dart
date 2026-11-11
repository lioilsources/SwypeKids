// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Swedish (`sv`).
class AppLocalizationsSv extends AppLocalizations {
  AppLocalizationsSv([String locale = 'sv']) : super(locale);

  @override
  String get appTitle => 'SwypeKids';

  @override
  String get menuSyllabary => 'Bokstavsbok (Swype)';

  @override
  String get menuSentence => 'Bygg en mening';

  @override
  String get menuZoo => 'Djurpark';

  @override
  String get menuBook => 'Min bok';

  @override
  String get menuParents => 'För föräldrar';

  @override
  String get practiceTitle => 'Övning';

  @override
  String bedtimeText(String guide) {
    return '$guide sover. Vi ses imorgon!';
  }

  @override
  String get typeListen => 'LYSSNA';

  @override
  String get typePicture => 'BILD';

  @override
  String get typeGap => 'FYLL I';

  @override
  String get typeReview => 'REPETITION';

  @override
  String get typeWord => 'ORD';

  @override
  String get typeSyllable => 'STAVELSE';

  @override
  String get promptListen => 'Lyssna och svep över det du hör';

  @override
  String get promptPicture => 'Vad finns på bilden? Skriv det';

  @override
  String get promptGap => 'Vilken bokstav saknas? Svep över hela ordet';

  @override
  String get promptSwipeTouch => 'Svep med fingret över bilderna';

  @override
  String get promptSwipeTrackpad => 'Svep med två fingrar över bilderna';

  @override
  String get successText => 'Bra jobbat!';

  @override
  String get errorText => 'Försök igen!';

  @override
  String get newSticker => 'Du fick ett nytt klistermärke!';

  @override
  String starsGained(int count) {
    return '+$count stjärnor';
  }

  @override
  String get backToMap => 'Tillbaka till kartan';

  @override
  String get winTitle => 'Klart!\nDu är en mästare!';

  @override
  String winStars(int count) {
    return 'Du fick $count stjärnor!';
  }

  @override
  String get playAgain => 'Spela igen';

  @override
  String get builderBadge => 'MENING';

  @override
  String get who => 'VEM';

  @override
  String get whatDoes => 'GÖR VAD';

  @override
  String get whatWhere => 'VAD / VART';

  @override
  String get newLabel => 'NYTT';

  @override
  String get clear => 'Rensa';

  @override
  String get bookTitle => 'Min bok';

  @override
  String get bookEmptyHint => 'Bygg en mening och spara den i boken';

  @override
  String get zooTitle => 'Djurpark';

  @override
  String badgesTitle(int earned, int total) {
    return 'Märken $earned/$total';
  }

  @override
  String get badgeFirstSwype => 'Första svepet';

  @override
  String get badgeFirstSwypeHow => 'Första rätta svepet';

  @override
  String get badgeNoMistake => 'Utan fel';

  @override
  String get badgeNoMistakeHow => 'En hel enhet med tre stjärnor';

  @override
  String get badgeExplorer => 'Upptäckare';

  @override
  String get badgeExplorerHow => 'Första klistermärket';

  @override
  String get badgeCollectorHalf => 'Samlare';

  @override
  String get badgeCollectorHalfHow => 'Halva djurparken';

  @override
  String get badgeCollectorAll => 'Storsamlare';

  @override
  String get badgeCollectorAllHow => 'Hela djurparken';

  @override
  String get badgeNightOwl => 'Nattuggla';

  @override
  String get badgeNightOwlHow => 'Spelade på natten';

  @override
  String get badgeEarlyBird => 'Morgonfågel';

  @override
  String get badgeEarlyBirdHow => 'Spelade på morgonen';

  @override
  String get badgeFourSeasons => 'Fyra årstider';

  @override
  String get badgeFourSeasonsHow => 'Spelade under varje årstid';

  @override
  String get badgeWordsmith10 => 'Ordsmed';

  @override
  String get badgeWordsmith10How => '10 ord i väskan';

  @override
  String get badgeWordsmith25 => 'Stor ordsmed';

  @override
  String get badgeWordsmith25How => '25 ord i väskan';

  @override
  String get badgeWordsmith50 => 'Ordmästare';

  @override
  String get badgeWordsmith50How => '50 ord i väskan';

  @override
  String get badgePoet => 'Skald';

  @override
  String get badgePoetHow => '10 meningar i Min bok';

  @override
  String get badgeListener => 'Lyssnare';

  @override
  String get badgeListenerHow => '10 lyssningsrundor med tre stjärnor';

  @override
  String get badgePersistent => 'Uthållig';

  @override
  String get badgePersistentHow => '7 speldagar';

  @override
  String get parentTitle => 'För föräldrar';

  @override
  String gateQuestion(int a, int b) {
    return 'Hur mycket är $a × $b?';
  }

  @override
  String get backToGame => 'Tillbaka till spelet';

  @override
  String get sectionOverview => 'Översikt';

  @override
  String get sectionLetters => 'Bokstäver';

  @override
  String get sectionTips => 'Tips för hemmet';

  @override
  String get sectionMethod => 'Så lär appen ut';

  @override
  String get sectionSettings => 'Inställningar';

  @override
  String get statProfile => 'profil';

  @override
  String get statPlayDays => 'speldagar';

  @override
  String get statLessons => 'lektioner';

  @override
  String get statStars => 'stjärnor';

  @override
  String get statWords => 'ord i väskan';

  @override
  String get statSentences => 'meningar i Min bok';

  @override
  String get statBadges => 'märken';

  @override
  String get lettersLegend => '🟢 behärskas · 🟡 övas · ⚪ inte mötta än';

  @override
  String troubleWords(String letter, String words) {
    return 'Ord med $letter som blandas ihop: $words';
  }

  @override
  String get tipNoData =>
      'Inget att öva på än – tips dyker upp efter några lektioner.';

  @override
  String tipWeakest(String words) {
    return 'Svagaste orden: $words. Prova att klappa dem stavelse för stavelse hemma och leta efter saker som börjar med dem.';
  }

  @override
  String tipLetter(String letter) {
    return 'Bokstaven $letter sitter inte riktigt än: leta tillsammans hemma efter saker som börjar på $letter.';
  }

  @override
  String get tipLongPress =>
      'Ett långt tryck på en lektion på kartan visar vad den övar och varför.';

  @override
  String methodLabel(String method) {
    return 'Metod: $method';
  }

  @override
  String get methodText =>
      'Barnet sveper med fingret över bokstäverna i den ordning det hör stavelsen eller ordet. Först öppna stavelser (MA, TA), sedan hela ord, lyssningsrundor utan text, ifyllnadsrundor och repetition av de svagaste orden. Ett fel hindrar aldrig framsteg – kortet skakar bara och ger en ledtråd. Inlärda ord används direkt i en mening (meningsbyggaren) och kan sparas i Min bok.';

  @override
  String get settingSounds => 'Ljud';

  @override
  String get settingAmbient => 'Ljud från världen';

  @override
  String get settingMusic => 'Musik';

  @override
  String get settingLeftHanded => 'Vänsterhänt (speglat tangentbord)';

  @override
  String get settingDyslexiaFont => 'Dyslexivänligt typsnitt (OpenDyslexic)';

  @override
  String get settingSeason => 'Årstid på kartan';

  @override
  String get seasonAuto => 'enligt kalendern';

  @override
  String get seasonSpring => 'vår';

  @override
  String get seasonSummer => 'sommar';

  @override
  String get seasonAutumn => 'höst';

  @override
  String get seasonWinter => 'vinter';

  @override
  String get settingTimeLimit => 'Daglig speltidsgräns';

  @override
  String get noLimit => 'ingen gräns';

  @override
  String minutes(int n) {
    return '$n min';
  }

  @override
  String playedToday(int played) {
    return 'Spelat idag: $played min';
  }

  @override
  String playedTodayOf(int played, int limit) {
    return 'Spelat idag: $played av $limit min';
  }

  @override
  String get guideAsleep => ' – guiden sover';

  @override
  String extendToday(int n) {
    return 'Förläng idag med $n min';
  }

  @override
  String get profilesTitle => 'Profiler';

  @override
  String deleteProfileTitle(String name) {
    return 'Radera profilen $name?';
  }

  @override
  String get deleteProfileBody =>
      'All utveckling, alla klistermärken och boken raderas också. Det går inte att ångra.';

  @override
  String get cancel => 'Avbryt';

  @override
  String get delete => 'Radera';

  @override
  String get statMinutesToday => 'minuter idag';

  @override
  String get statMinutesWeek => 'minuter denna vecka';

  @override
  String get letterMastered => 'behärskas';

  @override
  String get letterPracticing => 'övas';

  @override
  String get letterUnseen => 'inte mötta än';

  @override
  String get typeHunt => 'LJUD';

  @override
  String get typeJoin => 'STAVELSER';

  @override
  String get typeRhyme => 'RIM';

  @override
  String get promptHunt => 'Vilken bokstav hörde du? Tryck på den';

  @override
  String get promptJoin => 'Foga ihop stavelserna – svep över hela ordet';

  @override
  String get promptRhyme => 'Vad rimmar? Tryck på bilden';

  @override
  String get expeditionTitle => 'Repetitionsexpedition';

  @override
  String get badgeExpedition => 'Expeditionsdeltagare';

  @override
  String get badgeExpeditionHow => 'Första veckovisa repetitionsexpeditionen';

  @override
  String get seasonStickersTitle => 'Årstidsklistermärken';

  @override
  String get mapLoadFailed => 'Kartan kunde inte laddas';

  @override
  String get retry => 'Försök igen';

  @override
  String get vocativeLabel => 'Tjeckisk tilltalsform (vokativ)';

  @override
  String get vocativeHint => 't.ex. Lauro';

  @override
  String get guideTitle => 'Din guide';

  @override
  String get petPlay => 'Kom och lek';

  @override
  String get badgeHost => 'Värd';

  @override
  String get badgeHostHow => '10 presenter till djuren';

  @override
  String get badgeCuddler => 'Gosekrama';

  @override
  String get badgeCuddlerHow => 'Klappade 5 djur';

  @override
  String get badgeWishMaker => 'Uppfylld önskan';

  @override
  String get badgeWishMakerHow => '10 uppfyllda önskningar';

  @override
  String get badgeFriendOfAll => 'Allas vän';

  @override
  String get badgeFriendOfAllHow => 'Varje djur fick en present';

  @override
  String get settingPetRounds => 'Presenter till djuren: skriv ordet först';

  @override
  String get petBowlFood => 'skål';

  @override
  String get petBowlWater => 'vatten';

  @override
  String get storeIslandA => 'Bokstavsön';

  @override
  String get storeIslandB => 'Ordön';

  @override
  String get storeIslandC => 'Meningsön';

  @override
  String storeProductIsland(String island, String language) {
    return '$island – $language';
  }

  @override
  String storeProductIslandDesc(String language) {
    return 'Nya enheter, klistermärken och invånare i djurens värld. Språk: $language.';
  }

  @override
  String storeProductLanguage(String language) {
    return 'Ännu ett språk – $language';
  }

  @override
  String storeProductLanguageDesc(String island, String language) {
    return '$island på ett annat språk: $language.';
  }

  @override
  String get storeProductBundle => 'Allt för alltid';

  @override
  String get storeProductBundleDesc =>
      'Alla öar och språk, även de som ännu ska komma.';

  @override
  String get storeProductParent => 'Föräldrapaket';

  @override
  String get storeProductParentDesc =>
      'Arbetsblad, utskrift av Min bok, veckoöversikt och överföring av utveckling.';

  @override
  String get storeStateFree => 'gratis';

  @override
  String get storeStateOwned => 'ägs';

  @override
  String storeBuy(String price) {
    return 'Köp för $price';
  }

  @override
  String get storeRestore => 'Återställ köp';

  @override
  String get storeDebugTitle => 'Butik (felsökning)';

  @override
  String get storeDebugEnable => 'Simulera en aktiverad butik';

  @override
  String get storeDebugForget => 'Glöm köp';

  @override
  String get homeLanguageLabel => 'Familjens språk (menyer och hjälp)';

  @override
  String get homeLanguageSame => 'Samma som spelets språk';

  @override
  String get parentPrivacy => 'Integritetspolicy';
}
