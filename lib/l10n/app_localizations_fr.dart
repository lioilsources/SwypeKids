// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => 'Swype Kids';

  @override
  String get menuSyllabary => 'Syllabaire (Swype)';

  @override
  String get menuSentence => 'Construis une phrase';

  @override
  String get menuZoo => 'Zoo';

  @override
  String get menuBook => 'Mon livre';

  @override
  String get menuParents => 'Pour les parents';

  @override
  String get practiceTitle => 'Entraînement';

  @override
  String bedtimeText(String guide) {
    return '$guide dort déjà. À demain !';
  }

  @override
  String get typeListen => 'ÉCOUTE';

  @override
  String get typePicture => 'IMAGE';

  @override
  String get typeGap => 'COMPLÈTE';

  @override
  String get typeReview => 'RÉVISION';

  @override
  String get typeWord => 'MOT';

  @override
  String get typeSyllable => 'SYLLABE';

  @override
  String get promptListen => 'Écoute et glisse ce que tu entends';

  @override
  String get promptPicture => 'Qu\'y a-t-il sur l\'image ? Écris-le';

  @override
  String get promptGap => 'Quelle lettre manque ? Glisse tout le mot';

  @override
  String get promptSwipeTouch => 'Glisse ton doigt sur les images';

  @override
  String get promptSwipeTrackpad => 'Glisse deux doigts sur les images';

  @override
  String get successText => 'Bravo !';

  @override
  String get errorText => 'Essaie encore !';

  @override
  String get newSticker => 'Tu as un nouvel autocollant !';

  @override
  String starsGained(int count) {
    return '+$count étoiles';
  }

  @override
  String get backToMap => 'Retour à la carte';

  @override
  String get winTitle => 'Terminé !\nTu es un champion !';

  @override
  String winStars(int count) {
    return 'Tu as gagné $count étoiles !';
  }

  @override
  String get playAgain => 'Rejouer';

  @override
  String get builderBadge => 'PHRASE';

  @override
  String get who => 'QUI';

  @override
  String get whatDoes => 'FAIT QUOI';

  @override
  String get whatWhere => 'QUOI / OÙ';

  @override
  String get newLabel => 'NOUVEAU';

  @override
  String get clear => 'Effacer';

  @override
  String get bookTitle => 'Mon livre';

  @override
  String get bookEmptyHint => 'Construis une phrase et range-la dans ton livre';

  @override
  String get zooTitle => 'Zoo';

  @override
  String badgesTitle(int earned, int total) {
    return 'Badges $earned/$total';
  }

  @override
  String get badgeFirstSwype => 'Premier tracé';

  @override
  String get badgeFirstSwypeHow => 'Premier tracé réussi';

  @override
  String get badgeNoMistake => 'Sans faute';

  @override
  String get badgeNoMistakeHow => 'Une unité entière à trois étoiles';

  @override
  String get badgeExplorer => 'Explorateur';

  @override
  String get badgeExplorerHow => 'Premier autocollant';

  @override
  String get badgeCollectorHalf => 'Collectionneur';

  @override
  String get badgeCollectorHalfHow => 'La moitié du zoo';

  @override
  String get badgeCollectorAll => 'Grand collectionneur';

  @override
  String get badgeCollectorAllHow => 'Tout le zoo';

  @override
  String get badgeNightOwl => 'Hibou de nuit';

  @override
  String get badgeNightOwlHow => 'A joué la nuit';

  @override
  String get badgeEarlyBird => 'Lève-tôt';

  @override
  String get badgeEarlyBirdHow => 'A joué le matin';

  @override
  String get badgeFourSeasons => 'Quatre saisons';

  @override
  String get badgeFourSeasonsHow => 'A joué à chaque saison';

  @override
  String get badgeWordsmith10 => 'Chasseur de mots';

  @override
  String get badgeWordsmith10How => '10 mots dans le sac';

  @override
  String get badgeWordsmith25 => 'Grand chasseur de mots';

  @override
  String get badgeWordsmith25How => '25 mots dans le sac';

  @override
  String get badgeWordsmith50 => 'Maître des mots';

  @override
  String get badgeWordsmith50How => '50 mots dans le sac';

  @override
  String get badgePoet => 'Poète';

  @override
  String get badgePoetHow => '10 phrases dans Mon livre';

  @override
  String get badgeListener => 'Bonne oreille';

  @override
  String get badgeListenerHow => '10 rounds d\'écoute à trois étoiles';

  @override
  String get badgePersistent => 'Persévérant';

  @override
  String get badgePersistentHow => '7 jours de jeu';

  @override
  String get parentTitle => 'Pour les parents';

  @override
  String gateQuestion(int a, int b) {
    return 'Combien font $a × $b ?';
  }

  @override
  String get backToGame => 'Retour au jeu';

  @override
  String get sectionOverview => 'Aperçu';

  @override
  String get sectionLetters => 'Lettres';

  @override
  String get sectionTips => 'Conseils pour la maison';

  @override
  String get sectionMethod => 'Comment l\'appli enseigne';

  @override
  String get sectionSettings => 'Réglages';

  @override
  String get statProfile => 'profil';

  @override
  String get statPlayDays => 'jours de jeu';

  @override
  String get statLessons => 'leçons';

  @override
  String get statStars => 'étoiles';

  @override
  String get statWords => 'mots dans le sac';

  @override
  String get statSentences => 'phrases dans Mon livre';

  @override
  String get statBadges => 'badges';

  @override
  String get lettersLegend => '🟢 acquise · 🟡 en cours · ⚪ pas encore vue';

  @override
  String troubleWords(String letter, String words) {
    return 'Mots avec $letter qui se mélangent : $words';
  }

  @override
  String get tipNoData =>
      'Rien à réviser pour l\'instant : des conseils apparaîtront après quelques leçons.';

  @override
  String tipWeakest(String words) {
    return 'Mots les plus fragiles : $words. Frappez-les en syllabes à la maison et cherchez des choses qui commencent pareil.';
  }

  @override
  String tipLetter(String letter) {
    return 'La lettre $letter n\'est pas encore acquise : cherchez à la maison des choses qui commencent par $letter.';
  }

  @override
  String get tipLongPress =>
      'Un appui long sur une leçon de la carte montre ce qu\'elle travaille et pourquoi.';

  @override
  String methodLabel(String method) {
    return 'Méthode : $method';
  }

  @override
  String get methodText =>
      'L\'enfant glisse le doigt sur les lettres dans l\'ordre où il entend la syllabe ou le mot. D\'abord les syllabes ouvertes (MA, TA), puis les mots entiers, des rounds d\'écoute sans texte, des mots à trou et la révision des mots fragiles. Une erreur ne bloque jamais : la carte tremble et donne un indice. Les mots appris servent tout de suite dans une phrase (le constructeur de phrases) et peuvent être rangés dans Mon livre.';

  @override
  String get settingSounds => 'Sons';

  @override
  String get settingAmbient => 'Sons du monde';

  @override
  String get settingMusic => 'Musique';

  @override
  String get settingLeftHanded => 'Gaucher (clavier en miroir)';

  @override
  String get settingDyslexiaFont => 'Police pour la dyslexie (OpenDyslexic)';

  @override
  String get settingSeason => 'Saison sur la carte';

  @override
  String get seasonAuto => 'selon le calendrier';

  @override
  String get seasonSpring => 'printemps';

  @override
  String get seasonSummer => 'été';

  @override
  String get seasonAutumn => 'automne';

  @override
  String get seasonWinter => 'hiver';

  @override
  String get settingTimeLimit => 'Limite de jeu par jour';

  @override
  String get noLimit => 'sans limite';

  @override
  String minutes(int n) {
    return '$n min';
  }

  @override
  String playedToday(int played) {
    return 'Joué aujourd\'hui : $played min';
  }

  @override
  String playedTodayOf(int played, int limit) {
    return 'Joué aujourd\'hui : $played min sur $limit';
  }

  @override
  String get guideAsleep => ' — le guide dort déjà';

  @override
  String extendToday(int n) {
    return 'Prolonger aujourd\'hui de $n min';
  }

  @override
  String get profilesTitle => 'Profils';

  @override
  String deleteProfileTitle(String name) {
    return 'Supprimer le profil $name ?';
  }

  @override
  String get deleteProfileBody =>
      'Toute la progression, les autocollants et le livre seront aussi supprimés. C\'est irréversible.';

  @override
  String get cancel => 'Annuler';

  @override
  String get delete => 'Supprimer';

  @override
  String get statMinutesToday => 'minutes aujourd\'hui';

  @override
  String get statMinutesWeek => 'minutes cette semaine';

  @override
  String get letterMastered => 'acquise';

  @override
  String get letterPracticing => 'en cours';

  @override
  String get letterUnseen => 'pas encore vue';

  @override
  String get typeHunt => 'SON';

  @override
  String get typeJoin => 'SYLLABES';

  @override
  String get typeRhyme => 'RIME';

  @override
  String get promptHunt => 'Quelle lettre entends-tu ? Touche-la';

  @override
  String get promptJoin => 'Relie les syllabes : glisse tout le mot';

  @override
  String get promptRhyme => 'Qu\'est-ce qui rime ? Touche l\'image';

  @override
  String get expeditionTitle => 'Expédition de révision';

  @override
  String get badgeExpedition => 'Expéditionnaire';

  @override
  String get badgeExpeditionHow =>
      'Première expédition de révision de la semaine';

  @override
  String get seasonStickersTitle => 'Autocollants des saisons';

  @override
  String get mapLoadFailed => 'Impossible de charger la carte';

  @override
  String get retry => 'Réessayer';

  @override
  String get vocativeLabel => 'Vocatif en tchèque';

  @override
  String get vocativeHint => 'p. ex. Lauro';

  @override
  String get guideTitle => 'Ton guide';

  @override
  String get petPlay => 'On joue';

  @override
  String get badgeHost => 'Hôte';

  @override
  String get badgeHostHow => '10 cadeaux aux animaux';

  @override
  String get badgeCuddler => 'Câlin';

  @override
  String get badgeCuddlerHow => '5 animaux caressés';

  @override
  String get badgeWishMaker => 'Vœu exaucé';

  @override
  String get badgeWishMakerHow => '10 vœux exaucés';

  @override
  String get badgeFriendOfAll => 'Ami de tous';

  @override
  String get badgeFriendOfAllHow => 'Chaque animal a reçu un cadeau';

  @override
  String get settingPetRounds => 'Cadeaux aux animaux : d\'abord écrire le mot';

  @override
  String get petBowlFood => 'gamelle';

  @override
  String get petBowlWater => 'eau';

  @override
  String get storeIslandA => 'Île des lettres';

  @override
  String get storeIslandB => 'Île des mots';

  @override
  String get storeIslandC => 'Île des phrases';

  @override
  String storeProductIsland(String island, String language) {
    return '$island – $language';
  }

  @override
  String storeProductIslandDesc(String language) {
    return 'Nouvelles unités, autocollants et habitants du monde des animaux. Langue : $language.';
  }

  @override
  String storeProductLanguage(String language) {
    return 'Autre langue – $language';
  }

  @override
  String storeProductLanguageDesc(String island, String language) {
    return '$island dans une autre langue : $language.';
  }

  @override
  String get storeProductBundle => 'Tout pour toujours';

  @override
  String get storeProductBundleDesc =>
      'Toutes les îles et toutes les langues, y compris celles à venir.';

  @override
  String get storeProductParent => 'Pack parents';

  @override
  String get storeProductParentDesc =>
      'Fiches, impression de Mon livre, bilan hebdomadaire et transfert de la progression.';

  @override
  String get storeStateFree => 'gratuit';

  @override
  String get storeStateOwned => 'acheté';

  @override
  String storeBuy(String price) {
    return 'Acheter pour $price';
  }

  @override
  String get storeRestore => 'Restaurer les achats';

  @override
  String get storeDebugTitle => 'Boutique (débogage)';

  @override
  String get storeDebugEnable => 'Simuler la boutique activée';

  @override
  String get storeDebugForget => 'Oublier les achats';
}
