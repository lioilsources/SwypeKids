// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Romanian Moldavian Moldovan (`ro`).
class AppLocalizationsRo extends AppLocalizations {
  AppLocalizationsRo([String locale = 'ro']) : super(locale);

  @override
  String get appTitle => 'SwypeKids';

  @override
  String get menuSyllabary => 'Abecedar (Swype)';

  @override
  String get menuSentence => 'Alcătuiește o propoziție';

  @override
  String get menuZoo => 'Grădina zoologică';

  @override
  String get menuBook => 'Cartea mea';

  @override
  String get menuParents => 'Pentru părinți';

  @override
  String get practiceTitle => 'Exersare';

  @override
  String bedtimeText(String guide) {
    return '$guide doarme. Pe mâine!';
  }

  @override
  String get typeListen => 'ASCULTĂ';

  @override
  String get typePicture => 'IMAGINE';

  @override
  String get typeGap => 'COMPLETEAZĂ';

  @override
  String get typeReview => 'REPETIȚIE';

  @override
  String get typeWord => 'CUVÂNT';

  @override
  String get typeSyllable => 'SILABĂ';

  @override
  String get promptListen => 'Ascultă și trage degetul peste ce auzi';

  @override
  String get promptPicture => 'Ce este în imagine? Scrie';

  @override
  String get promptGap =>
      'Ce literă lipsește? Trage degetul peste tot cuvântul';

  @override
  String get promptSwipeTouch => 'Trage degetul peste imagini';

  @override
  String get promptSwipeTrackpad => 'Trage cu două degete peste imagini';

  @override
  String get successText => 'Bravo!';

  @override
  String get errorText => 'Încearcă din nou!';

  @override
  String get newSticker => 'Ai primit un abțibild nou!';

  @override
  String starsGained(int count) {
    return '+$count stele';
  }

  @override
  String get backToMap => 'Înapoi la hartă';

  @override
  String get winTitle => 'Gata!\nEști un campion!';

  @override
  String winStars(int count) {
    return 'Ai câștigat $count stele!';
  }

  @override
  String get playAgain => 'Joacă din nou';

  @override
  String get builderBadge => 'PROPOZIȚIE';

  @override
  String get who => 'CINE';

  @override
  String get whatDoes => 'CE FACE';

  @override
  String get whatWhere => 'CE / UNDE';

  @override
  String get newLabel => 'NOU';

  @override
  String get clear => 'Șterge';

  @override
  String get bookTitle => 'Cartea mea';

  @override
  String get bookEmptyHint => 'Alcătuiește o propoziție și salveaz-o în carte';

  @override
  String get zooTitle => 'Grădina zoologică';

  @override
  String badgesTitle(int earned, int total) {
    return 'Insigne $earned/$total';
  }

  @override
  String get badgeFirstSwype => 'Prima trasare';

  @override
  String get badgeFirstSwypeHow => 'Prima trasare corectă';

  @override
  String get badgeNoMistake => 'Fără greșeli';

  @override
  String get badgeNoMistakeHow => 'O unitate întreagă cu trei stele';

  @override
  String get badgeExplorer => 'Explorator';

  @override
  String get badgeExplorerHow => 'Primul abțibild';

  @override
  String get badgeCollectorHalf => 'Colecționar';

  @override
  String get badgeCollectorHalfHow => 'Jumătate din grădina zoologică';

  @override
  String get badgeCollectorAll => 'Mare colecționar';

  @override
  String get badgeCollectorAllHow => 'Toată grădina zoologică';

  @override
  String get badgeNightOwl => 'Bufniță de noapte';

  @override
  String get badgeNightOwlHow => 'A jucat noaptea';

  @override
  String get badgeEarlyBird => 'Pasăre matinală';

  @override
  String get badgeEarlyBirdHow => 'A jucat dimineața';

  @override
  String get badgeFourSeasons => 'Patru anotimpuri';

  @override
  String get badgeFourSeasonsHow => 'A jucat în fiecare anotimp';

  @override
  String get badgeWordsmith10 => 'Făuritor de cuvinte';

  @override
  String get badgeWordsmith10How => '10 cuvinte în ghiozdan';

  @override
  String get badgeWordsmith25 => 'Mare făuritor de cuvinte';

  @override
  String get badgeWordsmith25How => '25 de cuvinte în ghiozdan';

  @override
  String get badgeWordsmith50 => 'Maestru al cuvintelor';

  @override
  String get badgeWordsmith50How => '50 de cuvinte în ghiozdan';

  @override
  String get badgePoet => 'Poet';

  @override
  String get badgePoetHow => '10 propoziții în Cartea mea';

  @override
  String get badgeListener => 'Ascultător';

  @override
  String get badgeListenerHow => '10 runde de ascultare cu trei stele';

  @override
  String get badgePersistent => 'Perseverent';

  @override
  String get badgePersistentHow => '7 zile de joc';

  @override
  String get parentTitle => 'Pentru părinți';

  @override
  String gateQuestion(int a, int b) {
    return 'Cât fac $a × $b?';
  }

  @override
  String get backToGame => 'Înapoi la joc';

  @override
  String get sectionOverview => 'Prezentare generală';

  @override
  String get sectionLetters => 'Litere';

  @override
  String get sectionTips => 'Sfaturi pentru acasă';

  @override
  String get sectionMethod => 'Cum învață aplicația';

  @override
  String get sectionSettings => 'Setări';

  @override
  String get statProfile => 'profil';

  @override
  String get statPlayDays => 'zile de joc';

  @override
  String get statLessons => 'lecții';

  @override
  String get statStars => 'stele';

  @override
  String get statWords => 'cuvinte în ghiozdan';

  @override
  String get statSentences => 'propoziții în Cartea mea';

  @override
  String get statBadges => 'insigne';

  @override
  String get lettersLegend =>
      '🟢 stăpânite · 🟡 în exersare · ⚪ încă neîntâlnite';

  @override
  String troubleWords(String letter, String words) {
    return 'Cuvinte cu $letter care se încurcă: $words';
  }

  @override
  String get tipNoData =>
      'Încă nu e nimic de exersat — sfaturile apar după câteva lecții.';

  @override
  String tipWeakest(String words) {
    return 'Cele mai slabe cuvinte: $words. Încercați acasă să le bateți din palme pe silabe și să căutați lucruri care încep cu ele.';
  }

  @override
  String tipLetter(String letter) {
    return 'Litera $letter încă se așază: căutați împreună acasă lucruri care încep cu $letter.';
  }

  @override
  String get tipLongPress =>
      'O apăsare lungă pe o lecție de pe hartă arată ce se exersează în ea și de ce.';

  @override
  String methodLabel(String method) {
    return 'Metoda: $method';
  }

  @override
  String get methodText =>
      'Copilul trage degetul peste litere în ordinea în care aude silaba sau cuvântul. Mai întâi silabe deschise (MA, TA), apoi cuvinte întregi, runde de ascultare fără text, runde de completare și repetarea celor mai slabe cuvinte. O greșeală nu blochează niciodată progresul — cartonașul doar se scutură și dă un indiciu. Cuvintele învățate intră imediat într-o propoziție (constructorul de propoziții) și pot fi salvate în Cartea mea.';

  @override
  String get settingSounds => 'Sunete';

  @override
  String get settingAmbient => 'Sunetele lumii';

  @override
  String get settingMusic => 'Muzică';

  @override
  String get settingLeftHanded => 'Stângaci (tastatură în oglindă)';

  @override
  String get settingDyslexiaFont => 'Font pentru dislexie (OpenDyslexic)';

  @override
  String get settingSeason => 'Anotimpul pe hartă';

  @override
  String get seasonAuto => 'după calendar';

  @override
  String get seasonSpring => 'primăvară';

  @override
  String get seasonSummer => 'vară';

  @override
  String get seasonAutumn => 'toamnă';

  @override
  String get seasonWinter => 'iarnă';

  @override
  String get settingTimeLimit => 'Limita zilnică de timp de joc';

  @override
  String get noLimit => 'fără limită';

  @override
  String minutes(int n) {
    return '$n min';
  }

  @override
  String playedToday(int played) {
    return 'Jucat azi: $played min';
  }

  @override
  String playedTodayOf(int played, int limit) {
    return 'Jucat azi: $played din $limit min';
  }

  @override
  String get guideAsleep => ' — ghidul doarme';

  @override
  String extendToday(int n) {
    return 'Prelungește ziua de azi cu $n min';
  }

  @override
  String get profilesTitle => 'Profiluri';

  @override
  String deleteProfileTitle(String name) {
    return 'Ștergi profilul $name?';
  }

  @override
  String get deleteProfileBody =>
      'Se șterg și tot progresul, abțibildurile și cartea. Nu se poate anula.';

  @override
  String get cancel => 'Anulează';

  @override
  String get delete => 'Șterge';

  @override
  String get statMinutesToday => 'minute azi';

  @override
  String get statMinutesWeek => 'minute săptămâna aceasta';

  @override
  String get letterMastered => 'stăpânite';

  @override
  String get letterPracticing => 'în exersare';

  @override
  String get letterUnseen => 'încă neîntâlnite';

  @override
  String get typeHunt => 'SUNET';

  @override
  String get typeJoin => 'SILABE';

  @override
  String get typeRhyme => 'RIMĂ';

  @override
  String get promptHunt => 'Ce literă ai auzit? Atinge-o';

  @override
  String get promptJoin => 'Unește silabele — trage degetul peste tot cuvântul';

  @override
  String get promptRhyme => 'Ce rimează? Atinge imaginea';

  @override
  String get expeditionTitle => 'Expediție de repetare';

  @override
  String get badgeExpedition => 'Expediționar';

  @override
  String get badgeExpeditionHow => 'Prima expediție săptămânală de repetare';

  @override
  String get seasonStickersTitle => 'Abțibilduri de anotimp';

  @override
  String get mapLoadFailed => 'Harta nu a putut fi încărcată';

  @override
  String get retry => 'Încearcă din nou';

  @override
  String get vocativeLabel => 'Forma de adresare în cehă (vocativ)';

  @override
  String get vocativeHint => 'de ex. Lauro';

  @override
  String get guideTitle => 'Ghidul tău';

  @override
  String get petPlay => 'Vino să ne jucăm';

  @override
  String get badgeHost => 'Gazdă';

  @override
  String get badgeHostHow => '10 cadouri pentru animale';

  @override
  String get badgeCuddler => 'Mângâietor';

  @override
  String get badgeCuddlerHow => 'A mângâiat 5 animale';

  @override
  String get badgeWishMaker => 'Dorință împlinită';

  @override
  String get badgeWishMakerHow => '10 dorințe împlinite';

  @override
  String get badgeFriendOfAll => 'Prieten al tuturor';

  @override
  String get badgeFriendOfAllHow => 'Fiecare animal a primit un cadou';

  @override
  String get settingPetRounds => 'Cadouri pentru animale: întâi scrie cuvântul';

  @override
  String get petBowlFood => 'castron';

  @override
  String get petBowlWater => 'apă';

  @override
  String get storeIslandA => 'Insula literelor';

  @override
  String get storeIslandB => 'Insula cuvintelor';

  @override
  String get storeIslandC => 'Insula propozițiilor';

  @override
  String storeProductIsland(String island, String language) {
    return '$island – $language';
  }

  @override
  String storeProductIslandDesc(String language) {
    return 'Unități noi, abțibilduri și locuitori ai lumii animalelor. Limba: $language.';
  }

  @override
  String storeProductLanguage(String language) {
    return 'Încă o limbă – $language';
  }

  @override
  String storeProductLanguageDesc(String island, String language) {
    return '$island într-o altă limbă: $language.';
  }

  @override
  String get storeProductBundle => 'Totul pentru totdeauna';

  @override
  String get storeProductBundleDesc =>
      'Toate insulele și limbile, inclusiv cele care vor veni.';

  @override
  String get storeProductParent => 'Pachet pentru părinți';

  @override
  String get storeProductParentDesc =>
      'Fișe de lucru, tipărirea Cărții mele, rezumat săptămânal și transfer al progresului.';

  @override
  String get storeStateFree => 'gratuit';

  @override
  String get storeStateOwned => 'îl aveți';

  @override
  String storeBuy(String price) {
    return 'Cumpără cu $price';
  }

  @override
  String get storeRestore => 'Restaurează achizițiile';

  @override
  String get storeDebugTitle => 'Magazin (depanare)';

  @override
  String get storeDebugEnable => 'Simulează un magazin activat';

  @override
  String get storeDebugForget => 'Uită achizițiile';

  @override
  String get homeLanguageLabel => 'Limba familiei (meniuri și indicii)';

  @override
  String get homeLanguageSame => 'Aceeași cu limba jocului';

  @override
  String get parentPrivacy => 'Politica de confidențialitate';
}
