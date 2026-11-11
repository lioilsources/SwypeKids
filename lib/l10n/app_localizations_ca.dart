// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Catalan Valencian (`ca`).
class AppLocalizationsCa extends AppLocalizations {
  AppLocalizationsCa([String locale = 'ca']) : super(locale);

  @override
  String get appTitle => 'SwypeKids';

  @override
  String get menuSyllabary => 'Abecedari (Swype)';

  @override
  String get menuSentence => 'Munta una frase';

  @override
  String get menuZoo => 'Zoo';

  @override
  String get menuBook => 'El meu llibre';

  @override
  String get menuParents => 'Per als pares';

  @override
  String get practiceTitle => 'Pràctica';

  @override
  String bedtimeText(String guide) {
    return '$guide ja dorm. Fins demà!';
  }

  @override
  String get typeListen => 'ESCOLTA';

  @override
  String get typePicture => 'IMATGE';

  @override
  String get typeGap => 'COMPLETA';

  @override
  String get typeReview => 'REPÀS';

  @override
  String get typeWord => 'PARAULA';

  @override
  String get typeSyllable => 'SIL·LABA';

  @override
  String get promptListen => 'Escolta i fes lliscar el dit pel que sents';

  @override
  String get promptPicture => 'Què hi ha a la imatge? Escriu-ho';

  @override
  String get promptGap => 'Quina lletra falta? Llisca tota la paraula';

  @override
  String get promptSwipeTouch => 'Llisca el dit per les imatges';

  @override
  String get promptSwipeTrackpad => 'Llisca amb dos dits per les imatges';

  @override
  String get successText => 'Molt bé!';

  @override
  String get errorText => 'Torna-ho a provar!';

  @override
  String get newSticker => 'Has aconseguit un nou adhesiu!';

  @override
  String starsGained(int count) {
    return '+$count estrelles';
  }

  @override
  String get backToMap => 'Torna al mapa';

  @override
  String get winTitle => 'Fet!\nEts un campió!';

  @override
  String winStars(int count) {
    return 'Has guanyat $count estrelles!';
  }

  @override
  String get playAgain => 'Torna a jugar';

  @override
  String get builderBadge => 'FRASE';

  @override
  String get who => 'QUI';

  @override
  String get whatDoes => 'QUÈ FA';

  @override
  String get whatWhere => 'QUÈ / ON';

  @override
  String get newLabel => 'NOU';

  @override
  String get clear => 'Esborra';

  @override
  String get bookTitle => 'El meu llibre';

  @override
  String get bookEmptyHint => 'Munta una frase i desa-la al llibre';

  @override
  String get zooTitle => 'Zoo';

  @override
  String badgesTitle(int earned, int total) {
    return 'Insígnies $earned/$total';
  }

  @override
  String get badgeFirstSwype => 'Primer llisc';

  @override
  String get badgeFirstSwypeHow => 'Primer llisc correcte';

  @override
  String get badgeNoMistake => 'Sense errors';

  @override
  String get badgeNoMistakeHow => 'Tota una unitat amb tres estrelles';

  @override
  String get badgeExplorer => 'Explorador';

  @override
  String get badgeExplorerHow => 'Primer adhesiu';

  @override
  String get badgeCollectorHalf => 'Col·leccionista';

  @override
  String get badgeCollectorHalfHow => 'La meitat del zoo';

  @override
  String get badgeCollectorAll => 'Gran col·leccionista';

  @override
  String get badgeCollectorAllHow => 'Tot el zoo';

  @override
  String get badgeNightOwl => 'Mussol nocturn';

  @override
  String get badgeNightOwlHow => 'Ha jugat de nit';

  @override
  String get badgeEarlyBird => 'Matinador';

  @override
  String get badgeEarlyBirdHow => 'Ha jugat al matí';

  @override
  String get badgeFourSeasons => 'Quatre estacions';

  @override
  String get badgeFourSeasonsHow => 'Ha jugat a totes les estacions';

  @override
  String get badgeWordsmith10 => 'Paraulaire';

  @override
  String get badgeWordsmith10How => '10 paraules a la motxilla';

  @override
  String get badgeWordsmith25 => 'Gran paraulaire';

  @override
  String get badgeWordsmith25How => '25 paraules a la motxilla';

  @override
  String get badgeWordsmith50 => 'Mestre de paraules';

  @override
  String get badgeWordsmith50How => '50 paraules a la motxilla';

  @override
  String get badgePoet => 'Poeta';

  @override
  String get badgePoetHow => '10 frases al Meu llibre';

  @override
  String get badgeListener => 'Oient';

  @override
  String get badgeListenerHow => '10 rondes d’escolta amb tres estrelles';

  @override
  String get badgePersistent => 'Persistent';

  @override
  String get badgePersistentHow => '7 dies de joc';

  @override
  String get parentTitle => 'Per als pares';

  @override
  String gateQuestion(int a, int b) {
    return 'Quant és $a × $b?';
  }

  @override
  String get backToGame => 'Torna al joc';

  @override
  String get sectionOverview => 'Resum';

  @override
  String get sectionLetters => 'Lletres';

  @override
  String get sectionTips => 'Consells per a casa';

  @override
  String get sectionMethod => 'Com ensenya l’app';

  @override
  String get sectionSettings => 'Configuració';

  @override
  String get statProfile => 'perfil';

  @override
  String get statPlayDays => 'dies de joc';

  @override
  String get statLessons => 'lliçons';

  @override
  String get statStars => 'estrelles';

  @override
  String get statWords => 'paraules a la motxilla';

  @override
  String get statSentences => 'frases al Meu llibre';

  @override
  String get statBadges => 'insígnies';

  @override
  String get lettersLegend =>
      '🟢 dominades · 🟡 en pràctica · ⚪ encara no vistes';

  @override
  String troubleWords(String letter, String words) {
    return 'Paraules amb $letter que es confonen: $words';
  }

  @override
  String get tipNoData =>
      'Encara no hi ha res per practicar: els consells apareixeran després d’unes quantes lliçons.';

  @override
  String tipWeakest(String words) {
    return 'Paraules més fluixes: $words. A casa, proveu d’aplaudir-les per síl·labes i de buscar coses que hi comencin.';
  }

  @override
  String tipLetter(String letter) {
    return 'La lletra $letter encara s’està assentant: busqueu junts a casa coses que comencin per $letter.';
  }

  @override
  String get tipLongPress =>
      'Una pulsació llarga a una lliçó del mapa mostra què hi practica i per què.';

  @override
  String methodLabel(String method) {
    return 'Mètode: $method';
  }

  @override
  String get methodText =>
      'L’infant llisca el dit per les lletres en l’ordre en què sent la síl·laba o la paraula. Primer síl·labes obertes (MA, TA), després paraules senceres, rondes d’escolta sense text, rondes per completar i repàs de les paraules més fluixes. Un error no bloqueja mai el progrés: la carta només es mou i dona una pista. Les paraules apreses passen de seguida a una frase (el constructor de frases) i es poden desar al Meu llibre.';

  @override
  String get settingSounds => 'Sons';

  @override
  String get settingAmbient => 'Sons del món';

  @override
  String get settingMusic => 'Música';

  @override
  String get settingLeftHanded => 'Esquerrà (teclat emmirallat)';

  @override
  String get settingDyslexiaFont => 'Lletra per a la dislèxia (OpenDyslexic)';

  @override
  String get settingSeason => 'Estació al mapa';

  @override
  String get seasonAuto => 'segons el calendari';

  @override
  String get seasonSpring => 'primavera';

  @override
  String get seasonSummer => 'estiu';

  @override
  String get seasonAutumn => 'tardor';

  @override
  String get seasonWinter => 'hivern';

  @override
  String get settingTimeLimit => 'Límit de joc diari';

  @override
  String get noLimit => 'sense límit';

  @override
  String minutes(int n) {
    return '$n min';
  }

  @override
  String playedToday(int played) {
    return 'Avui s’ha jugat $played min';
  }

  @override
  String playedTodayOf(int played, int limit) {
    return 'Avui s’ha jugat $played de $limit min';
  }

  @override
  String get guideAsleep => ' — el guia dorm';

  @override
  String extendToday(int n) {
    return 'Amplia avui $n min';
  }

  @override
  String get profilesTitle => 'Perfils';

  @override
  String deleteProfileTitle(String name) {
    return 'Vols esborrar el perfil $name?';
  }

  @override
  String get deleteProfileBody =>
      'També s’esborraran tot el progrés, els adhesius i el llibre. No es pot desfer.';

  @override
  String get cancel => 'Cancel·la';

  @override
  String get delete => 'Esborra';

  @override
  String get statMinutesToday => 'minuts avui';

  @override
  String get statMinutesWeek => 'minuts aquesta setmana';

  @override
  String get letterMastered => 'dominades';

  @override
  String get letterPracticing => 'en pràctica';

  @override
  String get letterUnseen => 'encara no vistes';

  @override
  String get typeHunt => 'SO';

  @override
  String get typeJoin => 'SIL·LABES';

  @override
  String get typeRhyme => 'RIMA';

  @override
  String get promptHunt => 'Quina lletra has sentit? Toca-la';

  @override
  String get promptJoin => 'Uneix les síl·labes: llisca tota la paraula';

  @override
  String get promptRhyme => 'Què rima? Toca la imatge';

  @override
  String get expeditionTitle => 'Expedició de repàs';

  @override
  String get badgeExpedition => 'Expedicionari';

  @override
  String get badgeExpeditionHow => 'Primera expedició setmanal de repàs';

  @override
  String get seasonStickersTitle => 'Adhesius de les estacions';

  @override
  String get mapLoadFailed => 'No s’ha pogut carregar el mapa';

  @override
  String get retry => 'Torna-ho a provar';

  @override
  String get vocativeLabel => 'Forma de tractament en txec (vocatiu)';

  @override
  String get vocativeHint => 'p. ex. Lauro';

  @override
  String get guideTitle => 'El teu guia';

  @override
  String get petPlay => 'Anem a jugar';

  @override
  String get badgeHost => 'Amfitrió';

  @override
  String get badgeHostHow => '10 regals per als animals';

  @override
  String get badgeCuddler => 'Carinyós';

  @override
  String get badgeCuddlerHow => 'Ha acaronat 5 animals';

  @override
  String get badgeWishMaker => 'Desig complert';

  @override
  String get badgeWishMakerHow => '10 desitjos complerts';

  @override
  String get badgeFriendOfAll => 'Amic de tots';

  @override
  String get badgeFriendOfAllHow => 'Cada animal ha rebut un regal';

  @override
  String get settingPetRounds =>
      'Regals per als animals: primer escriure la paraula';

  @override
  String get petBowlFood => 'bol';

  @override
  String get petBowlWater => 'aigua';

  @override
  String get storeIslandA => 'Illa de les lletres';

  @override
  String get storeIslandB => 'Illa de les paraules';

  @override
  String get storeIslandC => 'Illa de les frases';

  @override
  String storeProductIsland(String island, String language) {
    return '$island – $language';
  }

  @override
  String storeProductIslandDesc(String language) {
    return 'Unitats noves, adhesius i habitants del món dels animals. Idioma: $language.';
  }

  @override
  String storeProductLanguage(String language) {
    return 'Un altre idioma – $language';
  }

  @override
  String storeProductLanguageDesc(String island, String language) {
    return '$island en un altre idioma: $language.';
  }

  @override
  String get storeProductBundle => 'Tot per sempre';

  @override
  String get storeProductBundleDesc =>
      'Totes les illes i idiomes, també els que encara han d’arribar.';

  @override
  String get storeProductParent => 'Paquet per als pares';

  @override
  String get storeProductParentDesc =>
      'Fitxes de treball, impressió del Meu llibre, resum setmanal i transferència del progrés.';

  @override
  String get storeStateFree => 'gratis';

  @override
  String get storeStateOwned => 'el teniu';

  @override
  String storeBuy(String price) {
    return 'Compra per $price';
  }

  @override
  String get storeRestore => 'Restaura les compres';

  @override
  String get storeDebugTitle => 'Botiga (depuració)';

  @override
  String get storeDebugEnable => 'Simula una botiga activada';

  @override
  String get storeDebugForget => 'Oblida les compres';

  @override
  String get homeLanguageLabel => 'Idioma de la família (menús i ajuda)';

  @override
  String get homeLanguageSame => 'El mateix que l’idioma del joc';

  @override
  String get parentPrivacy => 'Política de privadesa';
}
