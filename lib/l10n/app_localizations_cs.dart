// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Czech (`cs`).
class AppLocalizationsCs extends AppLocalizations {
  AppLocalizationsCs([String locale = 'cs']) : super(locale);

  @override
  String get appTitle => 'Swype Kids';

  @override
  String get menuSyllabary => 'Slabikář (Swype)';

  @override
  String get menuSentence => 'Skládej větu';

  @override
  String get menuZoo => 'Zvěřinec';

  @override
  String get menuBook => 'Má knížka';

  @override
  String get menuParents => 'Pro rodiče';

  @override
  String get practiceTitle => 'Procvičování';

  @override
  String bedtimeText(String guide) {
    return '$guide už spí. Zítra zase!';
  }

  @override
  String get typeListen => 'POSLECH';

  @override
  String get typePicture => 'OBRÁZEK';

  @override
  String get typeGap => 'DOPLŇ';

  @override
  String get typeReview => 'OPAKOVÁNÍ';

  @override
  String get typeWord => 'SLOVO';

  @override
  String get typeSyllable => 'SLABIKA';

  @override
  String get promptListen => 'Poslouchej a přejeď, co slyšíš';

  @override
  String get promptPicture => 'Co je na obrázku? Napiš to';

  @override
  String get promptGap => 'Které písmenko chybí? Přejeď celé slovo';

  @override
  String get promptSwipeTouch => 'Přejeď prstem přes obrázky';

  @override
  String get promptSwipeTrackpad => 'Přejeď dvěma prsty přes obrázky';

  @override
  String get successText => 'Výborně!';

  @override
  String get errorText => 'Zkus to znovu!';

  @override
  String get newSticker => 'Máš novou nálepku!';

  @override
  String starsGained(int count) {
    return '+$count hvězdiček';
  }

  @override
  String get backToMap => 'Zpět na mapu';

  @override
  String get winTitle => 'Hotovo!\nJsi šampion!';

  @override
  String winStars(int count) {
    return 'Získal jsi $count hvězdiček!';
  }

  @override
  String get playAgain => 'Hrát znovu';

  @override
  String get builderBadge => 'VĚTA';

  @override
  String get who => 'KDO';

  @override
  String get whatDoes => 'CO DĚLÁ';

  @override
  String get whatWhere => 'CO / KAM';

  @override
  String get newLabel => 'NOVÉ';

  @override
  String get clear => 'Smazat';

  @override
  String get bookTitle => 'Má knížka';

  @override
  String get bookEmptyHint => 'Slož větu a ulož ji do knížky';

  @override
  String get zooTitle => 'Zvěřinec';

  @override
  String badgesTitle(int earned, int total) {
    return 'Odznaky $earned/$total';
  }

  @override
  String get badgeFirstSwype => 'První tah';

  @override
  String get badgeFirstSwypeHow => 'První správný swype';

  @override
  String get badgeNoMistake => 'Bez chyby';

  @override
  String get badgeNoMistakeHow => 'Celá jednotka na samé tři hvězdy';

  @override
  String get badgeExplorer => 'Objevitel';

  @override
  String get badgeExplorerHow => 'První nálepka';

  @override
  String get badgeCollectorHalf => 'Sběratel';

  @override
  String get badgeCollectorHalfHow => 'Polovina Zvěřince';

  @override
  String get badgeCollectorAll => 'Velký sběratel';

  @override
  String get badgeCollectorAllHow => 'Celý Zvěřinec';

  @override
  String get badgeNightOwl => 'Noční sova';

  @override
  String get badgeNightOwlHow => 'Hrálo v noci';

  @override
  String get badgeEarlyBird => 'Ranní ptáče';

  @override
  String get badgeEarlyBirdHow => 'Hrálo ráno';

  @override
  String get badgeFourSeasons => 'Čtyři roční období';

  @override
  String get badgeFourSeasonsHow => 'Hrálo v každém období';

  @override
  String get badgeWordsmith10 => 'Slovíčkář';

  @override
  String get badgeWordsmith10How => '10 slov v batohu';

  @override
  String get badgeWordsmith25 => 'Velký slovíčkář';

  @override
  String get badgeWordsmith25How => '25 slov v batohu';

  @override
  String get badgeWordsmith50 => 'Mistr slov';

  @override
  String get badgeWordsmith50How => '50 slov v batohu';

  @override
  String get badgePoet => 'Básník';

  @override
  String get badgePoetHow => '10 vět v Mé knížce';

  @override
  String get badgeListener => 'Posluchač';

  @override
  String get badgeListenerHow => '10 poslechových kol na tři hvězdy';

  @override
  String get badgePersistent => 'Vytrvalec';

  @override
  String get badgePersistentHow => '7 hracích dnů';

  @override
  String get parentTitle => 'Pro rodiče';

  @override
  String gateQuestion(int a, int b) {
    return 'Kolik je $a × $b?';
  }

  @override
  String get backToGame => 'Zpět ke hře';

  @override
  String get sectionOverview => 'Přehled';

  @override
  String get sectionLetters => 'Písmena';

  @override
  String get sectionTips => 'Doporučení pro doma';

  @override
  String get sectionMethod => 'Jak appka učí';

  @override
  String get sectionSettings => 'Nastavení';

  @override
  String get statProfile => 'profil';

  @override
  String get statPlayDays => 'hracích dnů';

  @override
  String get statLessons => 'lekcí';

  @override
  String get statStars => 'hvězd';

  @override
  String get statWords => 'slov v batohu';

  @override
  String get statSentences => 'vět v Mé knížce';

  @override
  String get statBadges => 'odznaků';

  @override
  String get lettersLegend =>
      '🟢 zvládnuté · 🟡 procvičuje · ⚪ ještě nepotkalo';

  @override
  String troubleWords(String letter, String words) {
    return 'Slova s $letter, která se pletou: $words';
  }

  @override
  String get tipNoData =>
      'Zatím není co procvičovat — po pár lekcích se tu objeví tipy.';

  @override
  String tipWeakest(String words) {
    return 'Nejslabší slova: $words. Zkuste je doma vytleskat po slabikách a hledat, co jimi začíná.';
  }

  @override
  String tipLetter(String letter) {
    return 'Písmeno $letter ještě sedá: hledejte spolu doma věci, které začínají na $letter.';
  }

  @override
  String get tipLongPress =>
      'Dlouhý stisk lekce na mapě ukáže, co se v ní procvičuje a proč.';

  @override
  String methodLabel(String method) {
    return 'Metoda: $method';
  }

  @override
  String get methodText =>
      'Dítě přejíždí prstem po písmenech v pořadí, jak slabiku nebo slovo slyší. Nejdřív otevřené slabiky (MA, TA), pak celá slova, poslechová kola bez textu, doplňovačky a opakování nejslabších slov. Chyba nikdy neblokuje postup — karta se jen zatřese a napoví. Naučená slova dítě hned použije ve větě (builder vět) a může si je uložit do Mé knížky.';

  @override
  String get settingSounds => 'Zvuky';

  @override
  String get settingAmbient => 'Zvuky světa';

  @override
  String get settingMusic => 'Hudba';

  @override
  String get settingLeftHanded => 'Levák (zrcadlená klávesnice)';

  @override
  String get settingDyslexiaFont => 'Písmo pro dyslektiky (OpenDyslexic)';

  @override
  String get settingSeason => 'Roční období na mapě';

  @override
  String get seasonAuto => 'podle kalendáře';

  @override
  String get seasonSpring => 'jaro';

  @override
  String get seasonSummer => 'léto';

  @override
  String get seasonAutumn => 'podzim';

  @override
  String get seasonWinter => 'zima';

  @override
  String get settingTimeLimit => 'Časový limit hraní za den';

  @override
  String get noLimit => 'bez limitu';

  @override
  String minutes(int n) {
    return '$n min';
  }

  @override
  String playedToday(int played) {
    return 'Dnes odehráno $played min';
  }

  @override
  String playedTodayOf(int played, int limit) {
    return 'Dnes odehráno $played z $limit min';
  }

  @override
  String get guideAsleep => ' — průvodce už spí';

  @override
  String extendToday(int n) {
    return 'Prodloužit dnešek o $n min';
  }

  @override
  String get profilesTitle => 'Profily';

  @override
  String deleteProfileTitle(String name) {
    return 'Smazat profil $name?';
  }

  @override
  String get deleteProfileBody =>
      'Smaže se i celý postup, nálepky a knížka. Nejde to vrátit.';

  @override
  String get cancel => 'Zrušit';

  @override
  String get delete => 'Smazat';

  @override
  String get statMinutesToday => 'minut dnes';

  @override
  String get statMinutesWeek => 'minut tento týden';

  @override
  String get letterMastered => 'zvládnuté';

  @override
  String get letterPracticing => 'procvičuje';

  @override
  String get letterUnseen => 'ještě nepotkalo';

  @override
  String get typeHunt => 'HLÁSKA';

  @override
  String get typeJoin => 'SLABIKY';

  @override
  String get typeRhyme => 'RÝM';

  @override
  String get promptHunt => 'Které písmenko slyšíš? Ťukni na něj';

  @override
  String get promptJoin => 'Spoj slabiky — přejeď celé slovo';

  @override
  String get promptRhyme => 'Co se rýmuje? Ťukni na obrázek';

  @override
  String get expeditionTitle => 'Výprava za opakováním';

  @override
  String get badgeExpedition => 'Výpravník';

  @override
  String get badgeExpeditionHow => 'První týdenní výprava za opakováním';

  @override
  String get seasonStickersTitle => 'Nálepky ročních období';

  @override
  String get mapLoadFailed => 'Mapu se nepodařilo načíst';

  @override
  String get retry => 'Zkusit znovu';

  @override
  String get vocativeLabel => 'Oslovení v češtině (5. pád)';

  @override
  String get vocativeHint => 'např. Lauro';

  @override
  String get guideTitle => 'Tvůj průvodce';
}
