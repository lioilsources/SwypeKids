// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get appTitle => 'SwypeKids';

  @override
  String get menuSyllabary => 'Silbenfibel (Swype)';

  @override
  String get menuSentence => 'Satz bauen';

  @override
  String get menuZoo => 'Tiergarten';

  @override
  String get menuBook => 'Mein Buch';

  @override
  String get menuParents => 'Für Eltern';

  @override
  String get practiceTitle => 'Üben';

  @override
  String bedtimeText(String guide) {
    return '$guide schläft schon. Bis morgen!';
  }

  @override
  String get typeListen => 'HÖREN';

  @override
  String get typePicture => 'BILD';

  @override
  String get typeGap => 'ERGÄNZEN';

  @override
  String get typeReview => 'WIEDERHOLUNG';

  @override
  String get typeWord => 'WORT';

  @override
  String get typeSyllable => 'SILBE';

  @override
  String get promptListen => 'Hör zu und wische, was du hörst';

  @override
  String get promptPicture => 'Was ist auf dem Bild? Schreib es';

  @override
  String get promptGap => 'Welcher Buchstabe fehlt? Wische das ganze Wort';

  @override
  String get promptSwipeTouch => 'Wische mit dem Finger über die Bilder';

  @override
  String get promptSwipeTrackpad => 'Wische mit zwei Fingern über die Bilder';

  @override
  String get successText => 'Super!';

  @override
  String get errorText => 'Versuch es noch mal!';

  @override
  String get newSticker => 'Du hast einen neuen Sticker!';

  @override
  String starsGained(int count) {
    return '+$count Sterne';
  }

  @override
  String get backToMap => 'Zurück zur Karte';

  @override
  String get winTitle => 'Geschafft!\nDu bist ein Champion!';

  @override
  String winStars(int count) {
    return 'Du hast $count Sterne gesammelt!';
  }

  @override
  String get playAgain => 'Noch mal spielen';

  @override
  String get builderBadge => 'SATZ';

  @override
  String get who => 'WER';

  @override
  String get whatDoes => 'MACHT WAS';

  @override
  String get whatWhere => 'WAS / WOHIN';

  @override
  String get newLabel => 'NEU';

  @override
  String get clear => 'Löschen';

  @override
  String get bookTitle => 'Mein Buch';

  @override
  String get bookEmptyHint => 'Bau einen Satz und speichere ihn im Buch';

  @override
  String get zooTitle => 'Tiergarten';

  @override
  String badgesTitle(int earned, int total) {
    return 'Abzeichen $earned/$total';
  }

  @override
  String get badgeFirstSwype => 'Erster Wisch';

  @override
  String get badgeFirstSwypeHow => 'Erster richtiger Wisch';

  @override
  String get badgeNoMistake => 'Fehlerfrei';

  @override
  String get badgeNoMistakeHow => 'Eine ganze Einheit mit drei Sternen';

  @override
  String get badgeExplorer => 'Entdecker';

  @override
  String get badgeExplorerHow => 'Erster Sticker';

  @override
  String get badgeCollectorHalf => 'Sammler';

  @override
  String get badgeCollectorHalfHow => 'Halber Tiergarten';

  @override
  String get badgeCollectorAll => 'Großer Sammler';

  @override
  String get badgeCollectorAllHow => 'Ganzer Tiergarten';

  @override
  String get badgeNightOwl => 'Nachteule';

  @override
  String get badgeNightOwlHow => 'Nachts gespielt';

  @override
  String get badgeEarlyBird => 'Frühaufsteher';

  @override
  String get badgeEarlyBirdHow => 'Morgens gespielt';

  @override
  String get badgeFourSeasons => 'Vier Jahreszeiten';

  @override
  String get badgeFourSeasonsHow => 'In jeder Jahreszeit gespielt';

  @override
  String get badgeWordsmith10 => 'Wortsammler';

  @override
  String get badgeWordsmith10How => '10 Wörter im Beutel';

  @override
  String get badgeWordsmith25 => 'Großer Wortsammler';

  @override
  String get badgeWordsmith25How => '25 Wörter im Beutel';

  @override
  String get badgeWordsmith50 => 'Wortmeister';

  @override
  String get badgeWordsmith50How => '50 Wörter im Beutel';

  @override
  String get badgePoet => 'Dichter';

  @override
  String get badgePoetHow => '10 Sätze in Mein Buch';

  @override
  String get badgeListener => 'Zuhörer';

  @override
  String get badgeListenerHow => '10 Hör-Runden mit drei Sternen';

  @override
  String get badgePersistent => 'Dranbleiber';

  @override
  String get badgePersistentHow => '7 Spieltage';

  @override
  String get parentTitle => 'Für Eltern';

  @override
  String gateQuestion(int a, int b) {
    return 'Wie viel ist $a × $b?';
  }

  @override
  String get backToGame => 'Zurück zum Spiel';

  @override
  String get sectionOverview => 'Überblick';

  @override
  String get sectionLetters => 'Buchstaben';

  @override
  String get sectionTips => 'Tipps für zu Hause';

  @override
  String get sectionMethod => 'So lehrt die App';

  @override
  String get sectionSettings => 'Einstellungen';

  @override
  String get statProfile => 'Profil';

  @override
  String get statPlayDays => 'Spieltage';

  @override
  String get statLessons => 'Lektionen';

  @override
  String get statStars => 'Sterne';

  @override
  String get statWords => 'Wörter im Beutel';

  @override
  String get statSentences => 'Sätze in Mein Buch';

  @override
  String get statBadges => 'Abzeichen';

  @override
  String get lettersLegend =>
      '🟢 gekonnt · 🟡 übt noch · ⚪ noch nicht getroffen';

  @override
  String troubleWords(String letter, String words) {
    return 'Wörter mit $letter, die verwechselt werden: $words';
  }

  @override
  String get tipNoData =>
      'Noch nichts zu üben — nach ein paar Lektionen erscheinen hier Tipps.';

  @override
  String tipWeakest(String words) {
    return 'Schwächste Wörter: $words. Klatscht sie zu Hause in Silben und sucht Dinge, die so anfangen.';
  }

  @override
  String tipLetter(String letter) {
    return 'Der Buchstabe $letter sitzt noch nicht: Sucht zu Hause Dinge, die mit $letter anfangen.';
  }

  @override
  String get tipLongPress =>
      'Langes Drücken auf eine Lektion zeigt, was sie übt und warum.';

  @override
  String methodLabel(String method) {
    return 'Methode: $method';
  }

  @override
  String get methodText =>
      'Das Kind wischt über die Buchstaben in der Reihenfolge, wie es die Silbe oder das Wort hört. Zuerst offene Silben (MA, TA), dann ganze Wörter, Hör-Runden ohne Text, Lückenwörter und Wiederholung der schwächsten Wörter. Ein Fehler blockiert nie — die Karte wackelt nur und hilft. Gelernte Wörter kommen sofort in einen Satz (Satzbauer) und können in Mein Buch gespeichert werden.';

  @override
  String get settingSounds => 'Töne';

  @override
  String get settingAmbient => 'Weltgeräusche';

  @override
  String get settingMusic => 'Musik';

  @override
  String get settingLeftHanded => 'Linkshänder (gespiegelte Tastatur)';

  @override
  String get settingDyslexiaFont => 'Schrift für Legasthenie (OpenDyslexic)';

  @override
  String get settingSeason => 'Jahreszeit auf der Karte';

  @override
  String get seasonAuto => 'nach Kalender';

  @override
  String get seasonSpring => 'Frühling';

  @override
  String get seasonSummer => 'Sommer';

  @override
  String get seasonAutumn => 'Herbst';

  @override
  String get seasonWinter => 'Winter';

  @override
  String get settingTimeLimit => 'Tägliches Spielzeitlimit';

  @override
  String get noLimit => 'kein Limit';

  @override
  String minutes(int n) {
    return '$n Min';
  }

  @override
  String playedToday(int played) {
    return 'Heute gespielt: $played Min';
  }

  @override
  String playedTodayOf(int played, int limit) {
    return 'Heute gespielt: $played von $limit Min';
  }

  @override
  String get guideAsleep => ' — der Begleiter schläft schon';

  @override
  String extendToday(int n) {
    return 'Heute um $n Min verlängern';
  }

  @override
  String get profilesTitle => 'Profile';

  @override
  String deleteProfileTitle(String name) {
    return 'Profil $name löschen?';
  }

  @override
  String get deleteProfileBody =>
      'Auch der ganze Fortschritt, Sticker und das Buch werden gelöscht. Das lässt sich nicht rückgängig machen.';

  @override
  String get cancel => 'Abbrechen';

  @override
  String get delete => 'Löschen';

  @override
  String get statMinutesToday => 'Minuten heute';

  @override
  String get statMinutesWeek => 'Minuten diese Woche';

  @override
  String get letterMastered => 'gekonnt';

  @override
  String get letterPracticing => 'übt noch';

  @override
  String get letterUnseen => 'noch nicht getroffen';

  @override
  String get typeHunt => 'LAUT';

  @override
  String get typeJoin => 'SILBEN';

  @override
  String get typeRhyme => 'REIM';

  @override
  String get promptHunt => 'Welchen Buchstaben hörst du? Tipp ihn an';

  @override
  String get promptJoin => 'Verbinde die Silben — wische das ganze Wort';

  @override
  String get promptRhyme => 'Was reimt sich? Tipp auf das Bild';

  @override
  String get expeditionTitle => 'Wiederholungs-Expedition';

  @override
  String get badgeExpedition => 'Expeditionsheld';

  @override
  String get badgeExpeditionHow =>
      'Erste wöchentliche Wiederholungs-Expedition';

  @override
  String get seasonStickersTitle => 'Jahreszeiten-Sticker';

  @override
  String get mapLoadFailed => 'Die Karte konnte nicht geladen werden';

  @override
  String get retry => 'Erneut versuchen';

  @override
  String get vocativeLabel => 'Tschechische Anrede (Vokativ)';

  @override
  String get vocativeHint => 'z. B. Lauro';

  @override
  String get guideTitle => 'Dein Begleiter';

  @override
  String get petPlay => 'Komm spielen';

  @override
  String get badgeHost => 'Gastgeber';

  @override
  String get badgeHostHow => '10 Geschenke für Tiere';

  @override
  String get badgeCuddler => 'Kuschler';

  @override
  String get badgeCuddlerHow => '5 Tiere gestreichelt';

  @override
  String get badgeWishMaker => 'Wunsch erfüllt';

  @override
  String get badgeWishMakerHow => '10 Wünsche erfüllt';

  @override
  String get badgeFriendOfAll => 'Freund aller';

  @override
  String get badgeFriendOfAllHow => 'Jedes Tier hat ein Geschenk bekommen';

  @override
  String get settingPetRounds => 'Geschenke für Tiere: erst das Wort schreiben';

  @override
  String get petBowlFood => 'Napf';

  @override
  String get petBowlWater => 'Wasser';

  @override
  String get storeIslandA => 'Buchstabeninsel';

  @override
  String get storeIslandB => 'Wörterinsel';

  @override
  String get storeIslandC => 'Satzinsel';

  @override
  String storeProductIsland(String island, String language) {
    return '$island – $language';
  }

  @override
  String storeProductIslandDesc(String language) {
    return 'Neue Einheiten, Sticker und Bewohner der Tierwelt. Sprache: $language.';
  }

  @override
  String storeProductLanguage(String language) {
    return 'Weitere Sprache – $language';
  }

  @override
  String storeProductLanguageDesc(String island, String language) {
    return '$island in einer weiteren Sprache: $language.';
  }

  @override
  String get storeProductBundle => 'Alles für immer';

  @override
  String get storeProductBundleDesc =>
      'Alle Inseln und Sprachen, auch die, die noch kommen.';

  @override
  String get storeProductParent => 'Elternpaket';

  @override
  String get storeProductParentDesc =>
      'Arbeitsblätter, Druck von „Mein Buch“, Wochenübersicht und Übertragung des Fortschritts.';

  @override
  String get storeStateFree => 'gratis';

  @override
  String get storeStateOwned => 'gekauft';

  @override
  String storeBuy(String price) {
    return 'Kaufen für $price';
  }

  @override
  String get storeRestore => 'Käufe wiederherstellen';

  @override
  String get storeDebugTitle => 'Shop (Debug)';

  @override
  String get storeDebugEnable => 'Aktivierten Shop simulieren';

  @override
  String get storeDebugForget => 'Käufe vergessen';

  @override
  String get homeLanguageLabel => 'Familiensprache (Menü und Hinweise)';

  @override
  String get homeLanguageSame => 'Wie die Spielsprache';
}
