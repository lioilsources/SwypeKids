// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Slovak (`sk`).
class AppLocalizationsSk extends AppLocalizations {
  AppLocalizationsSk([String locale = 'sk']) : super(locale);

  @override
  String get appTitle => 'SwypeKids';

  @override
  String get menuSyllabary => 'Slabikár (Swype)';

  @override
  String get menuSentence => 'Poskladaj vetu';

  @override
  String get menuZoo => 'Zverinec';

  @override
  String get menuBook => 'Moja knižka';

  @override
  String get menuParents => 'Pre rodičov';

  @override
  String get practiceTitle => 'Precvičovanie';

  @override
  String bedtimeText(String guide) {
    return '$guide už spí. Zajtra zase!';
  }

  @override
  String get typeListen => 'POČÚVAJ';

  @override
  String get typePicture => 'OBRÁZOK';

  @override
  String get typeGap => 'DOPLŇ';

  @override
  String get typeReview => 'OPAKOVANIE';

  @override
  String get typeWord => 'SLOVO';

  @override
  String get typeSyllable => 'SLABIKA';

  @override
  String get promptListen => 'Počúvaj a prejdi prstom, čo počuješ';

  @override
  String get promptPicture => 'Čo je na obrázku? Napíš to';

  @override
  String get promptGap => 'Ktoré písmenko chýba? Prejdi celé slovo';

  @override
  String get promptSwipeTouch => 'Prejdi prstom cez obrázky';

  @override
  String get promptSwipeTrackpad => 'Prejdi dvoma prstami cez obrázky';

  @override
  String get successText => 'Výborne!';

  @override
  String get errorText => 'Skús to znova!';

  @override
  String get newSticker => 'Máš novú nálepku!';

  @override
  String starsGained(int count) {
    return '+$count hviezdičiek';
  }

  @override
  String get backToMap => 'Späť na mapu';

  @override
  String get winTitle => 'Hotovo!\nSi šampión!';

  @override
  String winStars(int count) {
    return 'Získal si $count hviezdičiek!';
  }

  @override
  String get playAgain => 'Hrať znova';

  @override
  String get builderBadge => 'VETA';

  @override
  String get who => 'KTO';

  @override
  String get whatDoes => 'ČO ROBÍ';

  @override
  String get whatWhere => 'ČO / KAM';

  @override
  String get newLabel => 'NOVÉ';

  @override
  String get clear => 'Zmazať';

  @override
  String get bookTitle => 'Moja knižka';

  @override
  String get bookEmptyHint => 'Poskladaj vetu a ulož ju do knižky';

  @override
  String get zooTitle => 'Zverinec';

  @override
  String badgesTitle(int earned, int total) {
    return 'Odznaky $earned/$total';
  }

  @override
  String get badgeFirstSwype => 'Prvý ťah';

  @override
  String get badgeFirstSwypeHow => 'Prvý správny swype';

  @override
  String get badgeNoMistake => 'Bez chyby';

  @override
  String get badgeNoMistakeHow => 'Celá jednotka na samé tri hviezdy';

  @override
  String get badgeExplorer => 'Objaviteľ';

  @override
  String get badgeExplorerHow => 'Prvá nálepka';

  @override
  String get badgeCollectorHalf => 'Zberateľ';

  @override
  String get badgeCollectorHalfHow => 'Polovica Zverinca';

  @override
  String get badgeCollectorAll => 'Veľký zberateľ';

  @override
  String get badgeCollectorAllHow => 'Celý Zverinec';

  @override
  String get badgeNightOwl => 'Nočná sova';

  @override
  String get badgeNightOwlHow => 'Hralo v noci';

  @override
  String get badgeEarlyBird => 'Ranné vtáča';

  @override
  String get badgeEarlyBirdHow => 'Hralo ráno';

  @override
  String get badgeFourSeasons => 'Štyri ročné obdobia';

  @override
  String get badgeFourSeasonsHow => 'Hralo v každom období';

  @override
  String get badgeWordsmith10 => 'Slovíčkar';

  @override
  String get badgeWordsmith10How => '10 slov v batohu';

  @override
  String get badgeWordsmith25 => 'Veľký slovíčkar';

  @override
  String get badgeWordsmith25How => '25 slov v batohu';

  @override
  String get badgeWordsmith50 => 'Majster slov';

  @override
  String get badgeWordsmith50How => '50 slov v batohu';

  @override
  String get badgePoet => 'Básnik';

  @override
  String get badgePoetHow => '10 viet v Mojej knižke';

  @override
  String get badgeListener => 'Poslucháč';

  @override
  String get badgeListenerHow => '10 počúvacích kôl na tri hviezdy';

  @override
  String get badgePersistent => 'Vytrvalec';

  @override
  String get badgePersistentHow => '7 hracích dní';

  @override
  String get parentTitle => 'Pre rodičov';

  @override
  String gateQuestion(int a, int b) {
    return 'Koľko je $a × $b?';
  }

  @override
  String get backToGame => 'Späť do hry';

  @override
  String get sectionOverview => 'Prehľad';

  @override
  String get sectionLetters => 'Písmená';

  @override
  String get sectionTips => 'Odporúčania pre domov';

  @override
  String get sectionMethod => 'Ako aplikácia učí';

  @override
  String get sectionSettings => 'Nastavenia';

  @override
  String get statProfile => 'profil';

  @override
  String get statPlayDays => 'hracích dní';

  @override
  String get statLessons => 'lekcií';

  @override
  String get statStars => 'hviezd';

  @override
  String get statWords => 'slov v batohu';

  @override
  String get statSentences => 'viet v Mojej knižke';

  @override
  String get statBadges => 'odznakov';

  @override
  String get lettersLegend => '🟢 zvládnuté · 🟡 precvičuje · ⚪ ešte nestretlo';

  @override
  String troubleWords(String letter, String words) {
    return 'Slová s $letter, ktoré sa pletú: $words';
  }

  @override
  String get tipNoData =>
      'Zatiaľ nie je čo precvičovať — po pár lekciách sa tu objavia tipy.';

  @override
  String tipWeakest(String words) {
    return 'Najslabšie slová: $words. Skúste ich doma vytlieskať po slabikách a hľadať, čo nimi začína.';
  }

  @override
  String tipLetter(String letter) {
    return 'Písmeno $letter ešte sedí: hľadajte spolu doma veci, ktoré začínajú na $letter.';
  }

  @override
  String get tipLongPress =>
      'Dlhý stisk lekcie na mape ukáže, čo sa v nej precvičuje a prečo.';

  @override
  String methodLabel(String method) {
    return 'Metóda: $method';
  }

  @override
  String get methodText =>
      'Dieťa prechádza prstom po písmenách v poradí, v akom slabiku alebo slovo počuje. Najprv otvorené slabiky (MA, TA), potom celé slová, počúvacie kolá bez textu, dopĺňačky a opakovanie najslabších slov. Chyba nikdy neblokuje postup — karta sa len zatrasie a napovie. Naučené slová dieťa hneď použije vo vete (skladač viet) a môže si ich uložiť do Mojej knižky.';

  @override
  String get settingSounds => 'Zvuky';

  @override
  String get settingAmbient => 'Zvuky sveta';

  @override
  String get settingMusic => 'Hudba';

  @override
  String get settingLeftHanded => 'Ľavák (zrkadlená klávesnica)';

  @override
  String get settingDyslexiaFont => 'Písmo pre dyslektikov (OpenDyslexic)';

  @override
  String get settingSeason => 'Ročné obdobie na mape';

  @override
  String get seasonAuto => 'podľa kalendára';

  @override
  String get seasonSpring => 'jar';

  @override
  String get seasonSummer => 'leto';

  @override
  String get seasonAutumn => 'jeseň';

  @override
  String get seasonWinter => 'zima';

  @override
  String get settingTimeLimit => 'Denný časový limit hrania';

  @override
  String get noLimit => 'bez limitu';

  @override
  String minutes(int n) {
    return '$n min';
  }

  @override
  String playedToday(int played) {
    return 'Dnes odohrané $played min';
  }

  @override
  String playedTodayOf(int played, int limit) {
    return 'Dnes odohrané $played z $limit min';
  }

  @override
  String get guideAsleep => ' — sprievodca už spí';

  @override
  String extendToday(int n) {
    return 'Predĺžiť dnešok o $n min';
  }

  @override
  String get profilesTitle => 'Profily';

  @override
  String deleteProfileTitle(String name) {
    return 'Zmazať profil $name?';
  }

  @override
  String get deleteProfileBody =>
      'Zmaže sa aj celý postup, nálepky a knižka. Nedá sa to vrátiť.';

  @override
  String get cancel => 'Zrušiť';

  @override
  String get delete => 'Zmazať';

  @override
  String get statMinutesToday => 'minút dnes';

  @override
  String get statMinutesWeek => 'minút tento týždeň';

  @override
  String get letterMastered => 'zvládnuté';

  @override
  String get letterPracticing => 'precvičuje';

  @override
  String get letterUnseen => 'ešte nestretlo';

  @override
  String get typeHunt => 'HLÁSKA';

  @override
  String get typeJoin => 'SLABIKY';

  @override
  String get typeRhyme => 'RÝM';

  @override
  String get promptHunt => 'Ktoré písmenko počuješ? Ťukni naň';

  @override
  String get promptJoin => 'Spoj slabiky — prejdi celé slovo';

  @override
  String get promptRhyme => 'Čo sa rýmuje? Ťukni na obrázok';

  @override
  String get expeditionTitle => 'Výprava za opakovaním';

  @override
  String get badgeExpedition => 'Výpravník';

  @override
  String get badgeExpeditionHow => 'Prvá týždenná výprava za opakovaním';

  @override
  String get seasonStickersTitle => 'Nálepky ročných období';

  @override
  String get mapLoadFailed => 'Mapu sa nepodarilo načítať';

  @override
  String get retry => 'Skúsiť znova';

  @override
  String get vocativeLabel => 'Oslovenie v češtine (5. pád)';

  @override
  String get vocativeHint => 'napr. Lauro';

  @override
  String get guideTitle => 'Tvoj sprievodca';

  @override
  String get petPlay => 'Poď sa hrať';

  @override
  String get badgeHost => 'Hostiteľ';

  @override
  String get badgeHostHow => '10 darčekov zvieratkám';

  @override
  String get badgeCuddler => 'Maznáčik';

  @override
  String get badgeCuddlerHow => 'Pohladil(a) 5 zvieratiek';

  @override
  String get badgeWishMaker => 'Splnené želanie';

  @override
  String get badgeWishMakerHow => '10 splnených želaní';

  @override
  String get badgeFriendOfAll => 'Kamarát všetkých';

  @override
  String get badgeFriendOfAllHow => 'Každé zvieratko dostalo darček';

  @override
  String get settingPetRounds => 'Darčeky zvieratkám: najprv napísať slovo';

  @override
  String get petBowlFood => 'miska';

  @override
  String get petBowlWater => 'voda';

  @override
  String get storeIslandA => 'Ostrov písmenok';

  @override
  String get storeIslandB => 'Ostrov slov';

  @override
  String get storeIslandC => 'Ostrov viet';

  @override
  String storeProductIsland(String island, String language) {
    return '$island – $language';
  }

  @override
  String storeProductIslandDesc(String language) {
    return 'Nové jednotky, nálepky a obyvatelia sveta zvieratiek. Jazyk: $language.';
  }

  @override
  String storeProductLanguage(String language) {
    return 'Ďalší jazyk – $language';
  }

  @override
  String storeProductLanguageDesc(String island, String language) {
    return '$island v ďalšom jazyku: $language.';
  }

  @override
  String get storeProductBundle => 'Všetko navždy';

  @override
  String get storeProductBundleDesc =>
      'Všetky ostrovy a jazyky, aj tie, ktoré ešte len pribudnú.';

  @override
  String get storeProductParent => 'Balíček pre rodičov';

  @override
  String get storeProductParentDesc =>
      'Pracovné listy, tlač Mojej knižky, týždenný prehľad a prenos postupu.';

  @override
  String get storeStateFree => 'zadarmo';

  @override
  String get storeStateOwned => 'máte';

  @override
  String storeBuy(String price) {
    return 'Kúpiť za $price';
  }

  @override
  String get storeRestore => 'Obnoviť nákupy';

  @override
  String get storeDebugTitle => 'Obchod (ladenie)';

  @override
  String get storeDebugEnable => 'Simulovať zapnutý obchod';

  @override
  String get storeDebugForget => 'Zabudnúť nákupy';

  @override
  String get homeLanguageLabel => 'Jazyk rodiny (menu a nápoveda)';

  @override
  String get homeLanguageSame => 'Rovnaký ako jazyk hry';

  @override
  String get parentPrivacy => 'Zásady ochrany súkromia';
}
