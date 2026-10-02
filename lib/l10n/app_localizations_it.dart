// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Italian (`it`).
class AppLocalizationsIt extends AppLocalizations {
  AppLocalizationsIt([String locale = 'it']) : super(locale);

  @override
  String get appTitle => 'Swype Kids';

  @override
  String get menuSyllabary => 'Sillabario (Swype)';

  @override
  String get menuSentence => 'Costruisci una frase';

  @override
  String get menuZoo => 'Zoo';

  @override
  String get menuBook => 'Il mio libro';

  @override
  String get menuParents => 'Per i genitori';

  @override
  String get practiceTitle => 'Esercizio';

  @override
  String get bedtimeText => 'Pipi dorme già. A domani!';

  @override
  String get typeListen => 'ASCOLTA';

  @override
  String get typePicture => 'IMMAGINE';

  @override
  String get typeGap => 'COMPLETA';

  @override
  String get typeReview => 'RIPASSO';

  @override
  String get typeWord => 'PAROLA';

  @override
  String get typeSyllable => 'SILLABA';

  @override
  String get promptListen => 'Ascolta e scorri quello che senti';

  @override
  String get promptPicture => 'Cosa c\'è nell\'immagine? Scrivilo';

  @override
  String get promptGap => 'Quale lettera manca? Scorri tutta la parola';

  @override
  String get promptSwipeTouch => 'Scorri il dito sulle figure';

  @override
  String get promptSwipeTrackpad => 'Scorri con due dita sulle figure';

  @override
  String get successText => 'Bravissimo!';

  @override
  String get errorText => 'Riprova!';

  @override
  String get newSticker => 'Hai un nuovo adesivo!';

  @override
  String starsGained(int count) {
    return '+$count stelle';
  }

  @override
  String get backToMap => 'Torna alla mappa';

  @override
  String get winTitle => 'Fatto!\nSei un campione!';

  @override
  String winStars(int count) {
    return 'Hai guadagnato $count stelle!';
  }

  @override
  String get playAgain => 'Gioca ancora';

  @override
  String get builderBadge => 'FRASE';

  @override
  String get who => 'CHI';

  @override
  String get whatDoes => 'COSA FA';

  @override
  String get whatWhere => 'COSA / DOVE';

  @override
  String get newLabel => 'NUOVO';

  @override
  String get clear => 'Cancella';

  @override
  String get bookTitle => 'Il mio libro';

  @override
  String get bookEmptyHint => 'Costruisci una frase e salvala nel libro';

  @override
  String get zooTitle => 'Zoo';

  @override
  String badgesTitle(int earned, int total) {
    return 'Distintivi $earned/$total';
  }

  @override
  String get badgeFirstSwype => 'Primo tratto';

  @override
  String get badgeFirstSwypeHow => 'Primo tratto giusto';

  @override
  String get badgeNoMistake => 'Senza errori';

  @override
  String get badgeNoMistakeHow => 'Un\'unità intera a tre stelle';

  @override
  String get badgeExplorer => 'Esploratore';

  @override
  String get badgeExplorerHow => 'Primo adesivo';

  @override
  String get badgeCollectorHalf => 'Collezionista';

  @override
  String get badgeCollectorHalfHow => 'Metà zoo';

  @override
  String get badgeCollectorAll => 'Gran collezionista';

  @override
  String get badgeCollectorAllHow => 'Tutto lo zoo';

  @override
  String get badgeNightOwl => 'Gufo notturno';

  @override
  String get badgeNightOwlHow => 'Ha giocato di notte';

  @override
  String get badgeEarlyBird => 'Mattiniero';

  @override
  String get badgeEarlyBirdHow => 'Ha giocato di mattina';

  @override
  String get badgeFourSeasons => 'Quattro stagioni';

  @override
  String get badgeFourSeasonsHow => 'Ha giocato in ogni stagione';

  @override
  String get badgeWordsmith10 => 'Parolaio';

  @override
  String get badgeWordsmith10How => '10 parole nello zaino';

  @override
  String get badgeWordsmith25 => 'Gran parolaio';

  @override
  String get badgeWordsmith25How => '25 parole nello zaino';

  @override
  String get badgeWordsmith50 => 'Maestro di parole';

  @override
  String get badgeWordsmith50How => '50 parole nello zaino';

  @override
  String get badgePoet => 'Poeta';

  @override
  String get badgePoetHow => '10 frasi nel Mio libro';

  @override
  String get badgeListener => 'Ascoltatore';

  @override
  String get badgeListenerHow => '10 round di ascolto a tre stelle';

  @override
  String get badgePersistent => 'Costante';

  @override
  String get badgePersistentHow => '7 giorni di gioco';

  @override
  String get parentTitle => 'Per i genitori';

  @override
  String gateQuestion(int a, int b) {
    return 'Quanto fa $a × $b?';
  }

  @override
  String get backToGame => 'Torna al gioco';

  @override
  String get sectionOverview => 'Riepilogo';

  @override
  String get sectionLetters => 'Lettere';

  @override
  String get sectionTips => 'Consigli per casa';

  @override
  String get sectionMethod => 'Come insegna l\'app';

  @override
  String get sectionSettings => 'Impostazioni';

  @override
  String get statProfile => 'profilo';

  @override
  String get statPlayDays => 'giorni di gioco';

  @override
  String get statLessons => 'lezioni';

  @override
  String get statStars => 'stelle';

  @override
  String get statWords => 'parole nello zaino';

  @override
  String get statSentences => 'frasi nel Mio libro';

  @override
  String get statBadges => 'distintivi';

  @override
  String get lettersLegend =>
      '🟢 acquisita · 🟡 in esercizio · ⚪ non ancora vista';

  @override
  String troubleWords(String letter, String words) {
    return 'Parole con $letter che si confondono: $words';
  }

  @override
  String get tipNoData =>
      'Niente da esercitare per ora: dopo qualche lezione qui compaiono i consigli.';

  @override
  String tipWeakest(String words) {
    return 'Parole più deboli: $words. Provate a batterle a sillabe a casa e a cercare cose che iniziano così.';
  }

  @override
  String tipLetter(String letter) {
    return 'La lettera $letter non è ancora salda: cercate a casa cose che iniziano con $letter.';
  }

  @override
  String get tipLongPress =>
      'Una pressione lunga su una lezione nella mappa mostra cosa esercita e perché.';

  @override
  String methodLabel(String method) {
    return 'Metodo: $method';
  }

  @override
  String get methodText =>
      'Il bambino scorre il dito sulle lettere nell\'ordine in cui sente la sillaba o la parola. Prima sillabe aperte (MA, TA), poi parole intere, round di ascolto senza testo, parole con buco e ripasso delle più deboli. Un errore non blocca mai: la carta trema e suggerisce. Le parole imparate si usano subito in una frase (costruttore di frasi) e si possono salvare nel Mio libro.';

  @override
  String get settingSounds => 'Suoni';

  @override
  String get settingAmbient => 'Suoni del mondo';

  @override
  String get settingMusic => 'Musica';

  @override
  String get settingLeftHanded => 'Mancino (tastiera a specchio)';

  @override
  String get settingDyslexiaFont => 'Carattere per dislessia (OpenDyslexic)';

  @override
  String get settingSeason => 'Stagione sulla mappa';

  @override
  String get seasonAuto => 'secondo il calendario';

  @override
  String get seasonSpring => 'primavera';

  @override
  String get seasonSummer => 'estate';

  @override
  String get seasonAutumn => 'autunno';

  @override
  String get seasonWinter => 'inverno';

  @override
  String get settingTimeLimit => 'Limite di gioco giornaliero';

  @override
  String get noLimit => 'nessun limite';

  @override
  String minutes(int n) {
    return '$n min';
  }

  @override
  String playedToday(int played) {
    return 'Oggi ha giocato $played min';
  }

  @override
  String playedTodayOf(int played, int limit) {
    return 'Oggi ha giocato $played di $limit min';
  }

  @override
  String get guideAsleep => ' — la guida dorme già';

  @override
  String extendToday(int n) {
    return 'Prolunga oggi di $n min';
  }

  @override
  String get profilesTitle => 'Profili';

  @override
  String deleteProfileTitle(String name) {
    return 'Eliminare il profilo $name?';
  }

  @override
  String get deleteProfileBody =>
      'Verranno eliminati anche tutti i progressi, gli adesivi e il libro. Non si può annullare.';

  @override
  String get cancel => 'Annulla';

  @override
  String get delete => 'Elimina';

  @override
  String get statMinutesToday => 'minuti oggi';

  @override
  String get statMinutesWeek => 'minuti questa settimana';

  @override
  String get letterMastered => 'acquisita';

  @override
  String get letterPracticing => 'in esercizio';

  @override
  String get letterUnseen => 'non ancora vista';

  @override
  String get typeHunt => 'SUONO';

  @override
  String get typeJoin => 'SILLABE';

  @override
  String get typeRhyme => 'RIMA';

  @override
  String get promptHunt => 'Quale lettera senti? Toccala';

  @override
  String get promptJoin => 'Unisci le sillabe: scorri tutta la parola';

  @override
  String get promptRhyme => 'Cosa fa rima? Tocca la figura';

  @override
  String get expeditionTitle => 'Spedizione di ripasso';

  @override
  String get badgeExpedition => 'Esploratore del ripasso';

  @override
  String get badgeExpeditionHow => 'Prima spedizione settimanale di ripasso';

  @override
  String get seasonStickersTitle => 'Adesivi delle stagioni';

  @override
  String get mapLoadFailed => 'Impossibile caricare la mappa';

  @override
  String get retry => 'Riprova';

  @override
  String get vocativeLabel => 'Vocativo in ceco';

  @override
  String get vocativeHint => 'es. Lauro';
}
