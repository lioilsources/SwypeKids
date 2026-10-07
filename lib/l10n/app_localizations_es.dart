// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'Swype Kids';

  @override
  String get menuSyllabary => 'Silabario (Swype)';

  @override
  String get menuSentence => 'Forma una frase';

  @override
  String get menuZoo => 'Zoo';

  @override
  String get menuBook => 'Mi libro';

  @override
  String get menuParents => 'Para padres';

  @override
  String get practiceTitle => 'Práctica';

  @override
  String bedtimeText(String guide) {
    return '$guide ya duerme. ¡Hasta mañana!';
  }

  @override
  String get typeListen => 'ESCUCHA';

  @override
  String get typePicture => 'IMAGEN';

  @override
  String get typeGap => 'COMPLETA';

  @override
  String get typeReview => 'REPASO';

  @override
  String get typeWord => 'PALABRA';

  @override
  String get typeSyllable => 'SÍLABA';

  @override
  String get promptListen => 'Escucha y desliza lo que oyes';

  @override
  String get promptPicture => '¿Qué hay en la imagen? Escríbelo';

  @override
  String get promptGap => '¿Qué letra falta? Desliza la palabra entera';

  @override
  String get promptSwipeTouch => 'Desliza el dedo por los dibujos';

  @override
  String get promptSwipeTrackpad => 'Desliza dos dedos por los dibujos';

  @override
  String get successText => '¡Muy bien!';

  @override
  String get errorText => '¡Inténtalo otra vez!';

  @override
  String get newSticker => '¡Tienes una pegatina nueva!';

  @override
  String starsGained(int count) {
    return '+$count estrellas';
  }

  @override
  String get backToMap => 'Volver al mapa';

  @override
  String get winTitle => '¡Listo!\n¡Eres un campeón!';

  @override
  String winStars(int count) {
    return '¡Has ganado $count estrellas!';
  }

  @override
  String get playAgain => 'Jugar otra vez';

  @override
  String get builderBadge => 'FRASE';

  @override
  String get who => 'QUIÉN';

  @override
  String get whatDoes => 'QUÉ HACE';

  @override
  String get whatWhere => 'QUÉ / DÓNDE';

  @override
  String get newLabel => 'NUEVO';

  @override
  String get clear => 'Borrar';

  @override
  String get bookTitle => 'Mi libro';

  @override
  String get bookEmptyHint => 'Forma una frase y guárdala en el libro';

  @override
  String get zooTitle => 'Zoo';

  @override
  String badgesTitle(int earned, int total) {
    return 'Insignias $earned/$total';
  }

  @override
  String get badgeFirstSwype => 'Primer trazo';

  @override
  String get badgeFirstSwypeHow => 'Primer trazo correcto';

  @override
  String get badgeNoMistake => 'Sin errores';

  @override
  String get badgeNoMistakeHow => 'Una unidad entera con tres estrellas';

  @override
  String get badgeExplorer => 'Explorador';

  @override
  String get badgeExplorerHow => 'Primera pegatina';

  @override
  String get badgeCollectorHalf => 'Coleccionista';

  @override
  String get badgeCollectorHalfHow => 'Medio zoo';

  @override
  String get badgeCollectorAll => 'Gran coleccionista';

  @override
  String get badgeCollectorAllHow => 'Todo el zoo';

  @override
  String get badgeNightOwl => 'Búho nocturno';

  @override
  String get badgeNightOwlHow => 'Jugó de noche';

  @override
  String get badgeEarlyBird => 'Madrugador';

  @override
  String get badgeEarlyBirdHow => 'Jugó por la mañana';

  @override
  String get badgeFourSeasons => 'Cuatro estaciones';

  @override
  String get badgeFourSeasonsHow => 'Jugó en cada estación';

  @override
  String get badgeWordsmith10 => 'Palabrero';

  @override
  String get badgeWordsmith10How => '10 palabras en la mochila';

  @override
  String get badgeWordsmith25 => 'Gran palabrero';

  @override
  String get badgeWordsmith25How => '25 palabras en la mochila';

  @override
  String get badgeWordsmith50 => 'Maestro de palabras';

  @override
  String get badgeWordsmith50How => '50 palabras en la mochila';

  @override
  String get badgePoet => 'Poeta';

  @override
  String get badgePoetHow => '10 frases en Mi libro';

  @override
  String get badgeListener => 'Oyente';

  @override
  String get badgeListenerHow => '10 rondas de escucha con tres estrellas';

  @override
  String get badgePersistent => 'Constante';

  @override
  String get badgePersistentHow => '7 días de juego';

  @override
  String get parentTitle => 'Para padres';

  @override
  String gateQuestion(int a, int b) {
    return '¿Cuánto es $a × $b?';
  }

  @override
  String get backToGame => 'Volver al juego';

  @override
  String get sectionOverview => 'Resumen';

  @override
  String get sectionLetters => 'Letras';

  @override
  String get sectionTips => 'Consejos para casa';

  @override
  String get sectionMethod => 'Cómo enseña la app';

  @override
  String get sectionSettings => 'Ajustes';

  @override
  String get statProfile => 'perfil';

  @override
  String get statPlayDays => 'días de juego';

  @override
  String get statLessons => 'lecciones';

  @override
  String get statStars => 'estrellas';

  @override
  String get statWords => 'palabras en la mochila';

  @override
  String get statSentences => 'frases en Mi libro';

  @override
  String get statBadges => 'insignias';

  @override
  String get lettersLegend => '🟢 dominada · 🟡 practicando · ⚪ aún no vista';

  @override
  String troubleWords(String letter, String words) {
    return 'Palabras con $letter que se confunden: $words';
  }

  @override
  String get tipNoData =>
      'Aún no hay nada que practicar: tras unas lecciones aparecerán consejos.';

  @override
  String tipWeakest(String words) {
    return 'Palabras más flojas: $words. Pruebe a palmearlas por sílabas en casa y a buscar cosas que empiecen así.';
  }

  @override
  String tipLetter(String letter) {
    return 'La letra $letter aún no asienta: busquen en casa cosas que empiecen por $letter.';
  }

  @override
  String get tipLongPress =>
      'Una pulsación larga en una lección del mapa muestra qué practica y por qué.';

  @override
  String methodLabel(String method) {
    return 'Método: $method';
  }

  @override
  String get methodText =>
      'El niño desliza el dedo por las letras en el orden en que oye la sílaba o la palabra. Primero sílabas abiertas (MA, TA), luego palabras enteras, rondas de escucha sin texto, palabras con hueco y repaso de las más flojas. Un error nunca bloquea el avance: la tarjeta solo tiembla y da una pista. Las palabras aprendidas se usan enseguida en una frase (el constructor de frases) y se pueden guardar en Mi libro.';

  @override
  String get settingSounds => 'Sonidos';

  @override
  String get settingAmbient => 'Sonidos del mundo';

  @override
  String get settingMusic => 'Música';

  @override
  String get settingLeftHanded => 'Zurdo (teclado en espejo)';

  @override
  String get settingDyslexiaFont => 'Letra para dislexia (OpenDyslexic)';

  @override
  String get settingSeason => 'Estación en el mapa';

  @override
  String get seasonAuto => 'según el calendario';

  @override
  String get seasonSpring => 'primavera';

  @override
  String get seasonSummer => 'verano';

  @override
  String get seasonAutumn => 'otoño';

  @override
  String get seasonWinter => 'invierno';

  @override
  String get settingTimeLimit => 'Límite de juego diario';

  @override
  String get noLimit => 'sin límite';

  @override
  String minutes(int n) {
    return '$n min';
  }

  @override
  String playedToday(int played) {
    return 'Hoy ha jugado $played min';
  }

  @override
  String playedTodayOf(int played, int limit) {
    return 'Hoy ha jugado $played de $limit min';
  }

  @override
  String get guideAsleep => ' — el guía ya duerme';

  @override
  String extendToday(int n) {
    return 'Ampliar hoy $n min';
  }

  @override
  String get profilesTitle => 'Perfiles';

  @override
  String deleteProfileTitle(String name) {
    return '¿Borrar el perfil $name?';
  }

  @override
  String get deleteProfileBody =>
      'Se borrará también todo el progreso, las pegatinas y el libro. No se puede deshacer.';

  @override
  String get cancel => 'Cancelar';

  @override
  String get delete => 'Borrar';

  @override
  String get statMinutesToday => 'minutos hoy';

  @override
  String get statMinutesWeek => 'minutos esta semana';

  @override
  String get letterMastered => 'dominada';

  @override
  String get letterPracticing => 'practicando';

  @override
  String get letterUnseen => 'aún no vista';

  @override
  String get typeHunt => 'SONIDO';

  @override
  String get typeJoin => 'SÍLABAS';

  @override
  String get typeRhyme => 'RIMA';

  @override
  String get promptHunt => '¿Qué letra oyes? Tócala';

  @override
  String get promptJoin => 'Une las sílabas: desliza la palabra entera';

  @override
  String get promptRhyme => '¿Qué rima? Toca el dibujo';

  @override
  String get expeditionTitle => 'Expedición de repaso';

  @override
  String get badgeExpedition => 'Expedicionario';

  @override
  String get badgeExpeditionHow => 'Primera expedición semanal de repaso';

  @override
  String get seasonStickersTitle => 'Pegatinas de las estaciones';

  @override
  String get mapLoadFailed => 'No se pudo cargar el mapa';

  @override
  String get retry => 'Reintentar';

  @override
  String get vocativeLabel => 'Vocativo en checo';

  @override
  String get vocativeHint => 'p. ej. Lauro';

  @override
  String get guideTitle => 'Tu guía';

  @override
  String get petPlay => 'Vamos a jugar';

  @override
  String get badgeHost => 'Anfitrión';

  @override
  String get badgeHostHow => '10 regalos para animales';

  @override
  String get badgeCuddler => 'Cariñoso';

  @override
  String get badgeCuddlerHow => 'Acarició 5 animales';

  @override
  String get badgeWishMaker => 'Deseo cumplido';

  @override
  String get badgeWishMakerHow => '10 deseos cumplidos';

  @override
  String get badgeFriendOfAll => 'Amigo de todos';

  @override
  String get badgeFriendOfAllHow => 'Cada animal recibió un regalo';

  @override
  String get settingPetRounds =>
      'Regalos para animales: primero escribir la palabra';

  @override
  String get petBowlFood => 'cuenco';

  @override
  String get petBowlWater => 'agua';

  @override
  String get storeIslandA => 'Isla de las letras';

  @override
  String get storeIslandB => 'Isla de las palabras';

  @override
  String get storeIslandC => 'Isla de las frases';

  @override
  String storeProductIsland(String island, String language) {
    return '$island – $language';
  }

  @override
  String storeProductIslandDesc(String language) {
    return 'Nuevas unidades, pegatinas y habitantes del mundo de los animales. Idioma: $language.';
  }

  @override
  String storeProductLanguage(String language) {
    return 'Otro idioma – $language';
  }

  @override
  String storeProductLanguageDesc(String island, String language) {
    return '$island en otro idioma: $language.';
  }

  @override
  String get storeProductBundle => 'Todo para siempre';

  @override
  String get storeProductBundleDesc =>
      'Todas las islas e idiomas, también los que están por llegar.';

  @override
  String get storeProductParent => 'Paquete para padres';

  @override
  String get storeProductParentDesc =>
      'Fichas, impresión de Mi libro, resumen semanal y traspaso del progreso.';

  @override
  String get storeStateFree => 'gratis';

  @override
  String get storeStateOwned => 'comprado';

  @override
  String storeBuy(String price) {
    return 'Comprar por $price';
  }

  @override
  String get storeRestore => 'Restaurar compras';

  @override
  String get storeDebugTitle => 'Tienda (depuración)';

  @override
  String get storeDebugEnable => 'Simular la tienda activada';

  @override
  String get storeDebugForget => 'Olvidar compras';
}
