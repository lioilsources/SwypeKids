// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Modern Greek (`el`).
class AppLocalizationsEl extends AppLocalizations {
  AppLocalizationsEl([String locale = 'el']) : super(locale);

  @override
  String get appTitle => 'SwypeKids';

  @override
  String get menuSyllabary => 'Αλφαβητάρι (Swype)';

  @override
  String get menuSentence => 'Φτιάξε πρόταση';

  @override
  String get menuZoo => 'Ζωολογικός κήπος';

  @override
  String get menuBook => 'Το βιβλίο μου';

  @override
  String get menuParents => 'Για γονείς';

  @override
  String get practiceTitle => 'Εξάσκηση';

  @override
  String bedtimeText(String guide) {
    return '$guide κοιμάται. Τα λέμε αύριο!';
  }

  @override
  String get typeListen => 'ΑΚΟΥΣΕ';

  @override
  String get typePicture => 'ΕΙΚΟΝΑ';

  @override
  String get typeGap => 'ΣΥΜΠΛΗΡΩΣΕ';

  @override
  String get typeReview => 'ΕΠΑΝΑΛΗΨΗ';

  @override
  String get typeWord => 'ΛΕΞΗ';

  @override
  String get typeSyllable => 'ΣΥΛΛΑΒΗ';

  @override
  String get promptListen => 'Άκουσε και σύρε αυτό που ακούς';

  @override
  String get promptPicture => 'Τι είναι στην εικόνα; Γράψε το';

  @override
  String get promptGap => 'Ποιο γράμμα λείπει; Σύρε ολόκληρη τη λέξη';

  @override
  String get promptSwipeTouch => 'Σύρε το δάχτυλο πάνω στις εικόνες';

  @override
  String get promptSwipeTrackpad => 'Σύρε με δύο δάχτυλα πάνω στις εικόνες';

  @override
  String get successText => 'Μπράβο!';

  @override
  String get errorText => 'Δοκίμασε ξανά!';

  @override
  String get newSticker => 'Πήρες ένα νέο αυτοκόλλητο!';

  @override
  String starsGained(int count) {
    return '+$count αστέρια';
  }

  @override
  String get backToMap => 'Πίσω στον χάρτη';

  @override
  String get winTitle => 'Τέλος!\nΕίσαι πρωταθλητής!';

  @override
  String winStars(int count) {
    return 'Κέρδισες $count αστέρια!';
  }

  @override
  String get playAgain => 'Παίξε ξανά';

  @override
  String get builderBadge => 'ΠΡΟΤΑΣΗ';

  @override
  String get who => 'ΠΟΙΟΣ';

  @override
  String get whatDoes => 'ΤΙ ΚΑΝΕΙ';

  @override
  String get whatWhere => 'ΤΙ / ΠΟΥ';

  @override
  String get newLabel => 'ΝΕΟ';

  @override
  String get clear => 'Εκκαθάριση';

  @override
  String get bookTitle => 'Το βιβλίο μου';

  @override
  String get bookEmptyHint =>
      'Φτιάξε μια πρόταση και αποθήκευσέ την στο βιβλίο';

  @override
  String get zooTitle => 'Ζωολογικός κήπος';

  @override
  String badgesTitle(int earned, int total) {
    return 'Παράσημα $earned/$total';
  }

  @override
  String get badgeFirstSwype => 'Πρώτο σύρσιμο';

  @override
  String get badgeFirstSwypeHow => 'Το πρώτο σωστό σύρσιμο';

  @override
  String get badgeNoMistake => 'Χωρίς λάθη';

  @override
  String get badgeNoMistakeHow => 'Ολόκληρη ενότητα με τρία αστέρια';

  @override
  String get badgeExplorer => 'Εξερευνητής';

  @override
  String get badgeExplorerHow => 'Το πρώτο αυτοκόλλητο';

  @override
  String get badgeCollectorHalf => 'Συλλέκτης';

  @override
  String get badgeCollectorHalfHow => 'Το μισό ζωολογικό κήπο';

  @override
  String get badgeCollectorAll => 'Μεγάλος συλλέκτης';

  @override
  String get badgeCollectorAllHow => 'Ολόκληρος ο ζωολογικός κήπος';

  @override
  String get badgeNightOwl => 'Νυχτοκόρακας';

  @override
  String get badgeNightOwlHow => 'Έπαιξε τη νύχτα';

  @override
  String get badgeEarlyBird => 'Πρωινό πουλί';

  @override
  String get badgeEarlyBirdHow => 'Έπαιξε το πρωί';

  @override
  String get badgeFourSeasons => 'Τέσσερις εποχές';

  @override
  String get badgeFourSeasonsHow => 'Έπαιξε σε κάθε εποχή';

  @override
  String get badgeWordsmith10 => 'Λεξιπλάστης';

  @override
  String get badgeWordsmith10How => '10 λέξεις στο σακίδιο';

  @override
  String get badgeWordsmith25 => 'Μεγάλος λεξιπλάστης';

  @override
  String get badgeWordsmith25How => '25 λέξεις στο σακίδιο';

  @override
  String get badgeWordsmith50 => 'Μάστορας των λέξεων';

  @override
  String get badgeWordsmith50How => '50 λέξεις στο σακίδιο';

  @override
  String get badgePoet => 'Ποιητής';

  @override
  String get badgePoetHow => '10 προτάσεις στο Βιβλίο μου';

  @override
  String get badgeListener => 'Ακροατής';

  @override
  String get badgeListenerHow => '10 γύροι ακρόασης με τρία αστέρια';

  @override
  String get badgePersistent => 'Επίμονος';

  @override
  String get badgePersistentHow => '7 ημέρες παιχνιδιού';

  @override
  String get parentTitle => 'Για γονείς';

  @override
  String gateQuestion(int a, int b) {
    return 'Πόσο κάνει $a × $b;';
  }

  @override
  String get backToGame => 'Πίσω στο παιχνίδι';

  @override
  String get sectionOverview => 'Επισκόπηση';

  @override
  String get sectionLetters => 'Γράμματα';

  @override
  String get sectionTips => 'Συμβουλές για το σπίτι';

  @override
  String get sectionMethod => 'Πώς διδάσκει η εφαρμογή';

  @override
  String get sectionSettings => 'Ρυθμίσεις';

  @override
  String get statProfile => 'προφίλ';

  @override
  String get statPlayDays => 'ημέρες παιχνιδιού';

  @override
  String get statLessons => 'μαθήματα';

  @override
  String get statStars => 'αστέρια';

  @override
  String get statWords => 'λέξεις στο σακίδιο';

  @override
  String get statSentences => 'προτάσεις στο Βιβλίο μου';

  @override
  String get statBadges => 'παράσημα';

  @override
  String get lettersLegend =>
      '🟢 κατακτημένα · 🟡 σε εξάσκηση · ⚪ δεν έχουν εμφανιστεί';

  @override
  String troubleWords(String letter, String words) {
    return 'Λέξεις με $letter που μπερδεύονται: $words';
  }

  @override
  String get tipNoData =>
      'Δεν υπάρχει τίποτα για εξάσκηση ακόμη — οι συμβουλές εμφανίζονται μετά από λίγα μαθήματα.';

  @override
  String tipWeakest(String words) {
    return 'Πιο αδύναμες λέξεις: $words. Δοκιμάστε στο σπίτι να τις χτυπήσετε παλαμάκια ανά συλλαβή και να βρείτε πράγματα που αρχίζουν από αυτές.';
  }

  @override
  String tipLetter(String letter) {
    return 'Το γράμμα $letter ακόμη κάθεται: ψάξτε μαζί στο σπίτι πράγματα που αρχίζουν από $letter.';
  }

  @override
  String get tipLongPress =>
      'Το παρατεταμένο πάτημα σε ένα μάθημα στον χάρτη δείχνει τι εξασκεί και γιατί.';

  @override
  String methodLabel(String method) {
    return 'Μέθοδος: $method';
  }

  @override
  String get methodText =>
      'Το παιδί σύρει το δάχτυλο πάνω στα γράμματα με τη σειρά που ακούει τη συλλαβή ή τη λέξη. Πρώτα ανοιχτές συλλαβές (MA, TA), μετά ολόκληρες λέξεις, γύροι ακρόασης χωρίς κείμενο, συμπλήρωση κενών και επανάληψη των πιο αδύναμων λέξεων. Το λάθος δεν εμποδίζει ποτέ την πρόοδο — η κάρτα απλώς κουνιέται και δίνει υπόδειξη. Οι λέξεις που μαθαίνει μπαίνουν αμέσως σε πρόταση (δημιουργός προτάσεων) και μπορούν να αποθηκευτούν στο Βιβλίο μου.';

  @override
  String get settingSounds => 'Ήχοι';

  @override
  String get settingAmbient => 'Ήχοι του κόσμου';

  @override
  String get settingMusic => 'Μουσική';

  @override
  String get settingLeftHanded => 'Αριστερόχειρας (κατοπτρικό πληκτρολόγιο)';

  @override
  String get settingDyslexiaFont => 'Γραμματοσειρά για δυσλεξία (OpenDyslexic)';

  @override
  String get settingSeason => 'Εποχή στον χάρτη';

  @override
  String get seasonAuto => 'σύμφωνα με το ημερολόγιο';

  @override
  String get seasonSpring => 'άνοιξη';

  @override
  String get seasonSummer => 'καλοκαίρι';

  @override
  String get seasonAutumn => 'φθινόπωρο';

  @override
  String get seasonWinter => 'χειμώνας';

  @override
  String get settingTimeLimit => 'Ημερήσιο όριο χρόνου παιχνιδιού';

  @override
  String get noLimit => 'χωρίς όριο';

  @override
  String minutes(int n) {
    return '$n λεπτά';
  }

  @override
  String playedToday(int played) {
    return 'Σήμερα έπαιξε: $played λεπτά';
  }

  @override
  String playedTodayOf(int played, int limit) {
    return 'Σήμερα έπαιξε: $played από $limit λεπτά';
  }

  @override
  String get guideAsleep => ' — ο οδηγός κοιμάται';

  @override
  String extendToday(int n) {
    return 'Παράταση σήμερα κατά $n λεπτά';
  }

  @override
  String get profilesTitle => 'Προφίλ';

  @override
  String deleteProfileTitle(String name) {
    return 'Διαγραφή του προφίλ $name;';
  }

  @override
  String get deleteProfileBody =>
      'Θα διαγραφούν και όλη η πρόοδος, τα αυτοκόλλητα και το βιβλίο. Δεν γίνεται αναίρεση.';

  @override
  String get cancel => 'Ακύρωση';

  @override
  String get delete => 'Διαγραφή';

  @override
  String get statMinutesToday => 'λεπτά σήμερα';

  @override
  String get statMinutesWeek => 'λεπτά αυτή την εβδομάδα';

  @override
  String get letterMastered => 'κατακτημένα';

  @override
  String get letterPracticing => 'σε εξάσκηση';

  @override
  String get letterUnseen => 'δεν έχουν εμφανιστεί';

  @override
  String get typeHunt => 'ΗΧΟΣ';

  @override
  String get typeJoin => 'ΣΥΛΛΑΒΕΣ';

  @override
  String get typeRhyme => 'ΡΥΜΑ';

  @override
  String get promptHunt => 'Ποιο γράμμα άκουσες; Πάτησέ το';

  @override
  String get promptJoin => 'Ένωσε τις συλλαβές — σύρε ολόκληρη τη λέξη';

  @override
  String get promptRhyme => 'Τι ομοιοκαταληκτεί; Πάτησε την εικόνα';

  @override
  String get expeditionTitle => 'Αποστολή επανάληψης';

  @override
  String get badgeExpedition => 'Εξερευνητής αποστολών';

  @override
  String get badgeExpeditionHow => 'Η πρώτη εβδομαδιαία αποστολή επανάληψης';

  @override
  String get seasonStickersTitle => 'Αυτοκόλλητα εποχών';

  @override
  String get mapLoadFailed => 'Ο χάρτης δεν φορτώθηκε';

  @override
  String get retry => 'Δοκίμασε ξανά';

  @override
  String get vocativeLabel => 'Τσεχική προσφώνηση (κλητική)';

  @override
  String get vocativeHint => 'π.χ. Lauro';

  @override
  String get guideTitle => 'Ο οδηγός σου';

  @override
  String get petPlay => 'Έλα να παίξουμε';

  @override
  String get badgeHost => 'Οικοδεσπότης';

  @override
  String get badgeHostHow => '10 δώρα στα ζωάκια';

  @override
  String get badgeCuddler => 'Χαϊδευτής';

  @override
  String get badgeCuddlerHow => 'Χάιδεψε 5 ζωάκια';

  @override
  String get badgeWishMaker => 'Εκπληρωμένη ευχή';

  @override
  String get badgeWishMakerHow => '10 εκπληρωμένες ευχές';

  @override
  String get badgeFriendOfAll => 'Φίλος όλων';

  @override
  String get badgeFriendOfAllHow => 'Κάθε ζωάκι πήρε δώρο';

  @override
  String get settingPetRounds => 'Δώρα στα ζωάκια: πρώτα γράψε τη λέξη';

  @override
  String get petBowlFood => 'μπολ';

  @override
  String get petBowlWater => 'νερό';

  @override
  String get storeIslandA => 'Νησί των γραμμάτων';

  @override
  String get storeIslandB => 'Νησί των λέξεων';

  @override
  String get storeIslandC => 'Νησί των προτάσεων';

  @override
  String storeProductIsland(String island, String language) {
    return '$island – $language';
  }

  @override
  String storeProductIslandDesc(String language) {
    return 'Νέες ενότητες, αυτοκόλλητα και κάτοικοι του κόσμου των ζώων. Γλώσσα: $language.';
  }

  @override
  String storeProductLanguage(String language) {
    return 'Άλλη μια γλώσσα – $language';
  }

  @override
  String storeProductLanguageDesc(String island, String language) {
    return '$island σε άλλη γλώσσα: $language.';
  }

  @override
  String get storeProductBundle => 'Όλα για πάντα';

  @override
  String get storeProductBundleDesc =>
      'Όλα τα νησιά και οι γλώσσες, και όσα θα προστεθούν.';

  @override
  String get storeProductParent => 'Πακέτο γονέων';

  @override
  String get storeProductParentDesc =>
      'Φύλλα εργασίας, εκτύπωση του Βιβλίου μου, εβδομαδιαία επισκόπηση και μεταφορά προόδου.';

  @override
  String get storeStateFree => 'δωρεάν';

  @override
  String get storeStateOwned => 'το έχετε';

  @override
  String storeBuy(String price) {
    return 'Αγορά με $price';
  }

  @override
  String get storeRestore => 'Επαναφορά αγορών';

  @override
  String get storeDebugTitle => 'Κατάστημα (αποσφαλμάτωση)';

  @override
  String get storeDebugEnable => 'Προσομοίωση ενεργού καταστήματος';

  @override
  String get storeDebugForget => 'Διαγραφή αγορών';

  @override
  String get homeLanguageLabel =>
      'Γλώσσα της οικογένειας (μενού και υποδείξεις)';

  @override
  String get homeLanguageSame => 'Ίδια με τη γλώσσα του παιχνιδιού';

  @override
  String get parentPrivacy => 'Πολιτική απορρήτου';
}
