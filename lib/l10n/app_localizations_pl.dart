// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Polish (`pl`).
class AppLocalizationsPl extends AppLocalizations {
  AppLocalizationsPl([String locale = 'pl']) : super(locale);

  @override
  String get appTitle => 'SwypeKids';

  @override
  String get menuSyllabary => 'Elementarz (Swype)';

  @override
  String get menuSentence => 'Ułóż zdanie';

  @override
  String get menuZoo => 'Zoo';

  @override
  String get menuBook => 'Moja książka';

  @override
  String get menuParents => 'Dla rodziców';

  @override
  String get practiceTitle => 'Ćwiczenie';

  @override
  String bedtimeText(String guide) {
    return '$guide śpi. Do jutra!';
  }

  @override
  String get typeListen => 'POSŁUCHAJ';

  @override
  String get typePicture => 'OBRAZEK';

  @override
  String get typeGap => 'UZUPEŁNIJ';

  @override
  String get typeReview => 'POWTÓRKA';

  @override
  String get typeWord => 'SŁOWO';

  @override
  String get typeSyllable => 'SYLABA';

  @override
  String get promptListen => 'Posłuchaj i przesuń palcem to, co słyszysz';

  @override
  String get promptPicture => 'Co jest na obrazku? Napisz to';

  @override
  String get promptGap => 'Której litery brakuje? Przesuń palcem całe słowo';

  @override
  String get promptSwipeTouch => 'Przesuń palcem po obrazkach';

  @override
  String get promptSwipeTrackpad => 'Przesuń dwoma palcami po obrazkach';

  @override
  String get successText => 'Świetnie!';

  @override
  String get errorText => 'Spróbuj jeszcze raz!';

  @override
  String get newSticker => 'Masz nową naklejkę!';

  @override
  String starsGained(int count) {
    return '+$count gwiazdek';
  }

  @override
  String get backToMap => 'Wróć do mapy';

  @override
  String get winTitle => 'Gotowe!\nJesteś mistrzem!';

  @override
  String winStars(int count) {
    return 'Zdobyłeś $count gwiazdek!';
  }

  @override
  String get playAgain => 'Zagraj jeszcze raz';

  @override
  String get builderBadge => 'ZDANIE';

  @override
  String get who => 'KTO';

  @override
  String get whatDoes => 'CO ROBI';

  @override
  String get whatWhere => 'CO / GDZIE';

  @override
  String get newLabel => 'NOWE';

  @override
  String get clear => 'Wyczyść';

  @override
  String get bookTitle => 'Moja książka';

  @override
  String get bookEmptyHint => 'Ułóż zdanie i zapisz je w książce';

  @override
  String get zooTitle => 'Zoo';

  @override
  String badgesTitle(int earned, int total) {
    return 'Odznaki $earned/$total';
  }

  @override
  String get badgeFirstSwype => 'Pierwsze przesunięcie';

  @override
  String get badgeFirstSwypeHow => 'Pierwsze poprawne przesunięcie';

  @override
  String get badgeNoMistake => 'Bez błędu';

  @override
  String get badgeNoMistakeHow => 'Cała jednostka na trzy gwiazdki';

  @override
  String get badgeExplorer => 'Odkrywca';

  @override
  String get badgeExplorerHow => 'Pierwsza naklejka';

  @override
  String get badgeCollectorHalf => 'Kolekcjoner';

  @override
  String get badgeCollectorHalfHow => 'Połowa zoo';

  @override
  String get badgeCollectorAll => 'Wielki kolekcjoner';

  @override
  String get badgeCollectorAllHow => 'Całe zoo';

  @override
  String get badgeNightOwl => 'Nocna sowa';

  @override
  String get badgeNightOwlHow => 'Grał w nocy';

  @override
  String get badgeEarlyBird => 'Ranny ptaszek';

  @override
  String get badgeEarlyBirdHow => 'Grał rano';

  @override
  String get badgeFourSeasons => 'Cztery pory roku';

  @override
  String get badgeFourSeasonsHow => 'Grał w każdej porze roku';

  @override
  String get badgeWordsmith10 => 'Słowotwórca';

  @override
  String get badgeWordsmith10How => '10 słów w plecaku';

  @override
  String get badgeWordsmith25 => 'Wielki słowotwórca';

  @override
  String get badgeWordsmith25How => '25 słów w plecaku';

  @override
  String get badgeWordsmith50 => 'Mistrz słów';

  @override
  String get badgeWordsmith50How => '50 słów w plecaku';

  @override
  String get badgePoet => 'Poeta';

  @override
  String get badgePoetHow => '10 zdań w Mojej książce';

  @override
  String get badgeListener => 'Słuchacz';

  @override
  String get badgeListenerHow => '10 rund słuchania na trzy gwiazdki';

  @override
  String get badgePersistent => 'Wytrwały';

  @override
  String get badgePersistentHow => '7 dni grania';

  @override
  String get parentTitle => 'Dla rodziców';

  @override
  String gateQuestion(int a, int b) {
    return 'Ile to $a × $b?';
  }

  @override
  String get backToGame => 'Wróć do gry';

  @override
  String get sectionOverview => 'Przegląd';

  @override
  String get sectionLetters => 'Litery';

  @override
  String get sectionTips => 'Wskazówki na dom';

  @override
  String get sectionMethod => 'Jak uczy aplikacja';

  @override
  String get sectionSettings => 'Ustawienia';

  @override
  String get statProfile => 'profil';

  @override
  String get statPlayDays => 'dni grania';

  @override
  String get statLessons => 'lekcji';

  @override
  String get statStars => 'gwiazdek';

  @override
  String get statWords => 'słów w plecaku';

  @override
  String get statSentences => 'zdań w Mojej książce';

  @override
  String get statBadges => 'odznak';

  @override
  String get lettersLegend =>
      '🟢 opanowane · 🟡 ćwiczone · ⚪ jeszcze nie spotkane';

  @override
  String troubleWords(String letter, String words) {
    return 'Słowa z literą $letter, które się mylą: $words';
  }

  @override
  String get tipNoData =>
      'Nie ma jeszcze czego ćwiczyć — wskazówki pojawią się po kilku lekcjach.';

  @override
  String tipWeakest(String words) {
    return 'Najsłabsze słowa: $words. Spróbujcie w domu wyklaskać je sylabami i poszukać rzeczy, które się od nich zaczynają.';
  }

  @override
  String tipLetter(String letter) {
    return 'Litera $letter jeszcze się utrwala: poszukajcie razem w domu rzeczy zaczynających się na $letter.';
  }

  @override
  String get tipLongPress =>
      'Długie przytrzymanie lekcji na mapie pokaże, co się w niej ćwiczy i dlaczego.';

  @override
  String methodLabel(String method) {
    return 'Metoda: $method';
  }

  @override
  String get methodText =>
      'Dziecko przesuwa palcem po literach w kolejności, w jakiej słyszy sylabę lub słowo. Najpierw sylaby otwarte (MA, TA), potem całe słowa, rundy słuchania bez tekstu, uzupełnianki i powtórki najsłabszych słów. Błąd nigdy nie blokuje postępu — karta tylko się trzęsie i podpowiada. Poznane słowa od razu trafiają do zdania (układanka zdań) i można je zapisać w Mojej książce.';

  @override
  String get settingSounds => 'Dźwięki';

  @override
  String get settingAmbient => 'Dźwięki świata';

  @override
  String get settingMusic => 'Muzyka';

  @override
  String get settingLeftHanded => 'Leworęczny (lustrzana klawiatura)';

  @override
  String get settingDyslexiaFont => 'Czcionka dla dyslektyków (OpenDyslexic)';

  @override
  String get settingSeason => 'Pora roku na mapie';

  @override
  String get seasonAuto => 'według kalendarza';

  @override
  String get seasonSpring => 'wiosna';

  @override
  String get seasonSummer => 'lato';

  @override
  String get seasonAutumn => 'jesień';

  @override
  String get seasonWinter => 'zima';

  @override
  String get settingTimeLimit => 'Dzienny limit czasu gry';

  @override
  String get noLimit => 'bez limitu';

  @override
  String minutes(int n) {
    return '$n min';
  }

  @override
  String playedToday(int played) {
    return 'Dziś zagrano: $played min';
  }

  @override
  String playedTodayOf(int played, int limit) {
    return 'Dziś zagrano: $played z $limit min';
  }

  @override
  String get guideAsleep => ' — przewodnik śpi';

  @override
  String extendToday(int n) {
    return 'Wydłuż dzisiejszy dzień o $n min';
  }

  @override
  String get profilesTitle => 'Profile';

  @override
  String deleteProfileTitle(String name) {
    return 'Usunąć profil $name?';
  }

  @override
  String get deleteProfileBody =>
      'Usunięte zostaną też cały postęp, naklejki i książka. Tego nie można cofnąć.';

  @override
  String get cancel => 'Anuluj';

  @override
  String get delete => 'Usuń';

  @override
  String get statMinutesToday => 'minut dziś';

  @override
  String get statMinutesWeek => 'minut w tym tygodniu';

  @override
  String get letterMastered => 'opanowane';

  @override
  String get letterPracticing => 'ćwiczone';

  @override
  String get letterUnseen => 'jeszcze nie spotkane';

  @override
  String get typeHunt => 'GŁOSKA';

  @override
  String get typeJoin => 'SYLABY';

  @override
  String get typeRhyme => 'RYM';

  @override
  String get promptHunt => 'Którą literę usłyszałeś? Dotknij jej';

  @override
  String get promptJoin => 'Połącz sylaby — przesuń palcem całe słowo';

  @override
  String get promptRhyme => 'Co się rymuje? Dotknij obrazka';

  @override
  String get expeditionTitle => 'Wyprawa po powtórkę';

  @override
  String get badgeExpedition => 'Wyprawowicz';

  @override
  String get badgeExpeditionHow => 'Pierwsza tygodniowa wyprawa po powtórkę';

  @override
  String get seasonStickersTitle => 'Naklejki pór roku';

  @override
  String get mapLoadFailed => 'Nie udało się wczytać mapy';

  @override
  String get retry => 'Spróbuj ponownie';

  @override
  String get vocativeLabel => 'Czeska forma zwracania się (wołacz)';

  @override
  String get vocativeHint => 'np. Lauro';

  @override
  String get guideTitle => 'Twój przewodnik';

  @override
  String get petPlay => 'Chodź się bawić';

  @override
  String get badgeHost => 'Gospodarz';

  @override
  String get badgeHostHow => '10 prezentów dla zwierząt';

  @override
  String get badgeCuddler => 'Przytulasek';

  @override
  String get badgeCuddlerHow => 'Pogłaskał 5 zwierząt';

  @override
  String get badgeWishMaker => 'Spełnione życzenie';

  @override
  String get badgeWishMakerHow => '10 spełnionych życzeń';

  @override
  String get badgeFriendOfAll => 'Przyjaciel wszystkich';

  @override
  String get badgeFriendOfAllHow => 'Każde zwierzę dostało prezent';

  @override
  String get settingPetRounds => 'Prezenty dla zwierząt: najpierw napisz słowo';

  @override
  String get petBowlFood => 'miska';

  @override
  String get petBowlWater => 'woda';

  @override
  String get storeIslandA => 'Wyspa liter';

  @override
  String get storeIslandB => 'Wyspa słów';

  @override
  String get storeIslandC => 'Wyspa zdań';

  @override
  String storeProductIsland(String island, String language) {
    return '$island – $language';
  }

  @override
  String storeProductIslandDesc(String language) {
    return 'Nowe jednostki, naklejki i mieszkańcy świata zwierząt. Język: $language.';
  }

  @override
  String storeProductLanguage(String language) {
    return 'Kolejny język – $language';
  }

  @override
  String storeProductLanguageDesc(String island, String language) {
    return '$island w innym języku: $language.';
  }

  @override
  String get storeProductBundle => 'Wszystko na zawsze';

  @override
  String get storeProductBundleDesc =>
      'Wszystkie wyspy i języki, także te, które dopiero będą.';

  @override
  String get storeProductParent => 'Pakiet dla rodziców';

  @override
  String get storeProductParentDesc =>
      'Karty pracy, wydruk Mojej książki, przegląd tygodniowy i przenoszenie postępu.';

  @override
  String get storeStateFree => 'za darmo';

  @override
  String get storeStateOwned => 'masz';

  @override
  String storeBuy(String price) {
    return 'Kup za $price';
  }

  @override
  String get storeRestore => 'Przywróć zakupy';

  @override
  String get storeDebugTitle => 'Sklep (debug)';

  @override
  String get storeDebugEnable => 'Symuluj włączony sklep';

  @override
  String get storeDebugForget => 'Zapomnij zakupy';

  @override
  String get homeLanguageLabel => 'Język rodziny (menu i podpowiedzi)';

  @override
  String get homeLanguageSame => 'Taki sam jak język gry';

  @override
  String get parentPrivacy => 'Polityka prywatności';
}
