// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get appTitle => 'SwypeKids';

  @override
  String get menuSyllabary => 'Silabário (Swype)';

  @override
  String get menuSentence => 'Monte uma frase';

  @override
  String get menuZoo => 'Zoológico';

  @override
  String get menuBook => 'Meu livro';

  @override
  String get menuParents => 'Para os pais';

  @override
  String get practiceTitle => 'Treino';

  @override
  String bedtimeText(String guide) {
    return '$guide já dorme. Até amanhã!';
  }

  @override
  String get typeListen => 'ESCUTA';

  @override
  String get typePicture => 'IMAGEM';

  @override
  String get typeGap => 'COMPLETE';

  @override
  String get typeReview => 'REVISÃO';

  @override
  String get typeWord => 'PALAVRA';

  @override
  String get typeSyllable => 'SÍLABA';

  @override
  String get promptListen => 'Escute e deslize o que ouviu';

  @override
  String get promptPicture => 'O que tem na imagem? Escreva';

  @override
  String get promptGap => 'Qual letra falta? Deslize a palavra inteira';

  @override
  String get promptSwipeTouch => 'Deslize o dedo pelas figuras';

  @override
  String get promptSwipeTrackpad => 'Deslize dois dedos pelas figuras';

  @override
  String get successText => 'Muito bem!';

  @override
  String get errorText => 'Tente de novo!';

  @override
  String get newSticker => 'Você ganhou uma figurinha nova!';

  @override
  String starsGained(int count) {
    return '+$count estrelas';
  }

  @override
  String get backToMap => 'Voltar ao mapa';

  @override
  String get winTitle => 'Pronto!\nVocê é campeão!';

  @override
  String winStars(int count) {
    return 'Você ganhou $count estrelas!';
  }

  @override
  String get playAgain => 'Jogar de novo';

  @override
  String get builderBadge => 'FRASE';

  @override
  String get who => 'QUEM';

  @override
  String get whatDoes => 'FAZ O QUÊ';

  @override
  String get whatWhere => 'O QUÊ / ONDE';

  @override
  String get newLabel => 'NOVO';

  @override
  String get clear => 'Apagar';

  @override
  String get bookTitle => 'Meu livro';

  @override
  String get bookEmptyHint => 'Monte uma frase e guarde no livro';

  @override
  String get zooTitle => 'Zoológico';

  @override
  String badgesTitle(int earned, int total) {
    return 'Medalhas $earned/$total';
  }

  @override
  String get badgeFirstSwype => 'Primeiro traço';

  @override
  String get badgeFirstSwypeHow => 'Primeiro traço certo';

  @override
  String get badgeNoMistake => 'Sem erros';

  @override
  String get badgeNoMistakeHow => 'Uma unidade inteira com três estrelas';

  @override
  String get badgeExplorer => 'Explorador';

  @override
  String get badgeExplorerHow => 'Primeira figurinha';

  @override
  String get badgeCollectorHalf => 'Colecionador';

  @override
  String get badgeCollectorHalfHow => 'Metade do zoológico';

  @override
  String get badgeCollectorAll => 'Grande colecionador';

  @override
  String get badgeCollectorAllHow => 'Zoológico inteiro';

  @override
  String get badgeNightOwl => 'Coruja';

  @override
  String get badgeNightOwlHow => 'Jogou à noite';

  @override
  String get badgeEarlyBird => 'Madrugador';

  @override
  String get badgeEarlyBirdHow => 'Jogou de manhã';

  @override
  String get badgeFourSeasons => 'Quatro estações';

  @override
  String get badgeFourSeasonsHow => 'Jogou em todas as estações';

  @override
  String get badgeWordsmith10 => 'Caçador de palavras';

  @override
  String get badgeWordsmith10How => '10 palavras na mochila';

  @override
  String get badgeWordsmith25 => 'Grande caçador de palavras';

  @override
  String get badgeWordsmith25How => '25 palavras na mochila';

  @override
  String get badgeWordsmith50 => 'Mestre das palavras';

  @override
  String get badgeWordsmith50How => '50 palavras na mochila';

  @override
  String get badgePoet => 'Poeta';

  @override
  String get badgePoetHow => '10 frases no Meu livro';

  @override
  String get badgeListener => 'Bom ouvinte';

  @override
  String get badgeListenerHow => '10 rodadas de escuta com três estrelas';

  @override
  String get badgePersistent => 'Persistente';

  @override
  String get badgePersistentHow => '7 dias de jogo';

  @override
  String get parentTitle => 'Para os pais';

  @override
  String gateQuestion(int a, int b) {
    return 'Quanto é $a × $b?';
  }

  @override
  String get backToGame => 'Voltar ao jogo';

  @override
  String get sectionOverview => 'Resumo';

  @override
  String get sectionLetters => 'Letras';

  @override
  String get sectionTips => 'Dicas para casa';

  @override
  String get sectionMethod => 'Como o app ensina';

  @override
  String get sectionSettings => 'Configurações';

  @override
  String get statProfile => 'perfil';

  @override
  String get statPlayDays => 'dias de jogo';

  @override
  String get statLessons => 'lições';

  @override
  String get statStars => 'estrelas';

  @override
  String get statWords => 'palavras na mochila';

  @override
  String get statSentences => 'frases no Meu livro';

  @override
  String get statBadges => 'medalhas';

  @override
  String get lettersLegend => '🟢 dominada · 🟡 praticando · ⚪ ainda não viu';

  @override
  String troubleWords(String letter, String words) {
    return 'Palavras com $letter que se confundem: $words';
  }

  @override
  String get tipNoData =>
      'Ainda não há o que treinar — depois de algumas lições aparecem dicas aqui.';

  @override
  String tipWeakest(String words) {
    return 'Palavras mais fracas: $words. Batam palmas por sílaba em casa e procurem coisas que começam assim.';
  }

  @override
  String tipLetter(String letter) {
    return 'A letra $letter ainda não firmou: procurem em casa coisas que começam com $letter.';
  }

  @override
  String get tipLongPress =>
      'Um toque longo numa lição do mapa mostra o que ela treina e por quê.';

  @override
  String methodLabel(String method) {
    return 'Método: $method';
  }

  @override
  String get methodText =>
      'A criança desliza o dedo pelas letras na ordem em que ouve a sílaba ou a palavra. Primeiro sílabas abertas (MA, TA), depois palavras inteiras, rodadas de escuta sem texto, palavras com buraco e revisão das mais fracas. Um erro nunca trava o progresso: o cartão só balança e dá uma dica. As palavras aprendidas entram logo numa frase (montador de frases) e podem ser guardadas no Meu livro.';

  @override
  String get settingSounds => 'Sons';

  @override
  String get settingAmbient => 'Sons do mundo';

  @override
  String get settingMusic => 'Música';

  @override
  String get settingLeftHanded => 'Canhoto (teclado espelhado)';

  @override
  String get settingDyslexiaFont => 'Fonte para dislexia (OpenDyslexic)';

  @override
  String get settingSeason => 'Estação no mapa';

  @override
  String get seasonAuto => 'pelo calendário';

  @override
  String get seasonSpring => 'primavera';

  @override
  String get seasonSummer => 'verão';

  @override
  String get seasonAutumn => 'outono';

  @override
  String get seasonWinter => 'inverno';

  @override
  String get settingTimeLimit => 'Limite de jogo por dia';

  @override
  String get noLimit => 'sem limite';

  @override
  String minutes(int n) {
    return '$n min';
  }

  @override
  String playedToday(int played) {
    return 'Hoje jogou $played min';
  }

  @override
  String playedTodayOf(int played, int limit) {
    return 'Hoje jogou $played de $limit min';
  }

  @override
  String get guideAsleep => ' — o guia já dorme';

  @override
  String extendToday(int n) {
    return 'Estender hoje em $n min';
  }

  @override
  String get profilesTitle => 'Perfis';

  @override
  String deleteProfileTitle(String name) {
    return 'Apagar o perfil $name?';
  }

  @override
  String get deleteProfileBody =>
      'Todo o progresso, as figurinhas e o livro também serão apagados. Não dá para desfazer.';

  @override
  String get cancel => 'Cancelar';

  @override
  String get delete => 'Apagar';

  @override
  String get statMinutesToday => 'minutos hoje';

  @override
  String get statMinutesWeek => 'minutos nesta semana';

  @override
  String get letterMastered => 'dominada';

  @override
  String get letterPracticing => 'praticando';

  @override
  String get letterUnseen => 'ainda não viu';

  @override
  String get typeHunt => 'SOM';

  @override
  String get typeJoin => 'SÍLABAS';

  @override
  String get typeRhyme => 'RIMA';

  @override
  String get promptHunt => 'Que letra você ouviu? Toque nela';

  @override
  String get promptJoin => 'Junte as sílabas: deslize a palavra inteira';

  @override
  String get promptRhyme => 'O que rima? Toque na figura';

  @override
  String get expeditionTitle => 'Expedição de revisão';

  @override
  String get badgeExpedition => 'Expedicionário';

  @override
  String get badgeExpeditionHow => 'Primeira expedição semanal de revisão';

  @override
  String get seasonStickersTitle => 'Figurinhas das estações';

  @override
  String get mapLoadFailed => 'Não foi possível carregar o mapa';

  @override
  String get retry => 'Tentar de novo';

  @override
  String get vocativeLabel => 'Vocativo em tcheco';

  @override
  String get vocativeHint => 'ex.: Lauro';

  @override
  String get guideTitle => 'Seu guia';

  @override
  String get petPlay => 'Vamos brincar';

  @override
  String get badgeHost => 'Anfitrião';

  @override
  String get badgeHostHow => '10 presentes para os bichos';

  @override
  String get badgeCuddler => 'Carinhoso';

  @override
  String get badgeCuddlerHow => 'Fez carinho em 5 bichos';

  @override
  String get badgeWishMaker => 'Desejo realizado';

  @override
  String get badgeWishMakerHow => '10 desejos realizados';

  @override
  String get badgeFriendOfAll => 'Amigo de todos';

  @override
  String get badgeFriendOfAllHow => 'Cada bicho ganhou um presente';

  @override
  String get settingPetRounds =>
      'Presentes para os bichos: primeiro escrever a palavra';

  @override
  String get petBowlFood => 'tigela';

  @override
  String get petBowlWater => 'água';

  @override
  String get storeIslandA => 'Ilha das letras';

  @override
  String get storeIslandB => 'Ilha das palavras';

  @override
  String get storeIslandC => 'Ilha das frases';

  @override
  String storeProductIsland(String island, String language) {
    return '$island – $language';
  }

  @override
  String storeProductIslandDesc(String language) {
    return 'Novas unidades, figurinhas e moradores do mundo dos bichinhos. Idioma: $language.';
  }

  @override
  String storeProductLanguage(String language) {
    return 'Outro idioma – $language';
  }

  @override
  String storeProductLanguageDesc(String island, String language) {
    return '$island em outro idioma: $language.';
  }

  @override
  String get storeProductBundle => 'Tudo para sempre';

  @override
  String get storeProductBundleDesc =>
      'Todas as ilhas e idiomas, inclusive os que ainda vão chegar.';

  @override
  String get storeProductParent => 'Pacote para pais';

  @override
  String get storeProductParentDesc =>
      'Fichas, impressão de Meu livro, resumo semanal e transferência do progresso.';

  @override
  String get storeStateFree => 'grátis';

  @override
  String get storeStateOwned => 'comprado';

  @override
  String storeBuy(String price) {
    return 'Comprar por $price';
  }

  @override
  String get storeRestore => 'Restaurar compras';

  @override
  String get storeDebugTitle => 'Loja (depuração)';

  @override
  String get storeDebugEnable => 'Simular a loja ativada';

  @override
  String get storeDebugForget => 'Esquecer compras';

  @override
  String get homeLanguageLabel => 'Idioma da família (menus e dicas)';

  @override
  String get homeLanguageSame => 'O mesmo do jogo';

  @override
  String get parentPrivacy => 'Política de privacidade';
}

/// The translations for Portuguese, as used in Portugal (`pt_PT`).
class AppLocalizationsPtPt extends AppLocalizationsPt {
  AppLocalizationsPtPt() : super('pt_PT');

  @override
  String get appTitle => 'SwypeKids';

  @override
  String get menuSyllabary => 'Abecedário (Swype)';

  @override
  String get menuSentence => 'Constrói uma frase';

  @override
  String get menuZoo => 'Zoo';

  @override
  String get menuBook => 'O meu livro';

  @override
  String get menuParents => 'Para os pais';

  @override
  String get practiceTitle => 'Treino';

  @override
  String bedtimeText(String guide) {
    return '$guide já dorme. Até amanhã!';
  }

  @override
  String get typeListen => 'OUVE';

  @override
  String get typePicture => 'IMAGEM';

  @override
  String get typeGap => 'COMPLETA';

  @override
  String get typeReview => 'REVISÃO';

  @override
  String get typeWord => 'PALAVRA';

  @override
  String get typeSyllable => 'SÍLABA';

  @override
  String get promptListen => 'Ouve e desliza o dedo no que ouviste';

  @override
  String get promptPicture => 'O que está na imagem? Escreve';

  @override
  String get promptGap => 'Que letra falta? Desliza a palavra toda';

  @override
  String get promptSwipeTouch => 'Desliza o dedo pelas imagens';

  @override
  String get promptSwipeTrackpad => 'Desliza com dois dedos pelas imagens';

  @override
  String get successText => 'Muito bem!';

  @override
  String get errorText => 'Tenta outra vez!';

  @override
  String get newSticker => 'Ganhaste um autocolante novo!';

  @override
  String starsGained(int count) {
    return '+$count estrelas';
  }

  @override
  String get backToMap => 'Voltar ao mapa';

  @override
  String get winTitle => 'Feito!\nÉs um campeão!';

  @override
  String winStars(int count) {
    return 'Ganhaste $count estrelas!';
  }

  @override
  String get playAgain => 'Jogar outra vez';

  @override
  String get builderBadge => 'FRASE';

  @override
  String get who => 'QUEM';

  @override
  String get whatDoes => 'FAZ O QUÊ';

  @override
  String get whatWhere => 'O QUÊ / ONDE';

  @override
  String get newLabel => 'NOVO';

  @override
  String get clear => 'Limpar';

  @override
  String get bookTitle => 'O meu livro';

  @override
  String get bookEmptyHint => 'Constrói uma frase e guarda-a no livro';

  @override
  String get zooTitle => 'Zoo';

  @override
  String badgesTitle(int earned, int total) {
    return 'Medalhas $earned/$total';
  }

  @override
  String get badgeFirstSwype => 'Primeiro deslize';

  @override
  String get badgeFirstSwypeHow => 'Primeiro deslize certo';

  @override
  String get badgeNoMistake => 'Sem erros';

  @override
  String get badgeNoMistakeHow => 'Uma unidade inteira com três estrelas';

  @override
  String get badgeExplorer => 'Explorador';

  @override
  String get badgeExplorerHow => 'Primeiro autocolante';

  @override
  String get badgeCollectorHalf => 'Colecionador';

  @override
  String get badgeCollectorHalfHow => 'Metade do zoo';

  @override
  String get badgeCollectorAll => 'Grande colecionador';

  @override
  String get badgeCollectorAllHow => 'O zoo todo';

  @override
  String get badgeNightOwl => 'Coruja noturna';

  @override
  String get badgeNightOwlHow => 'Jogou de noite';

  @override
  String get badgeEarlyBird => 'Madrugador';

  @override
  String get badgeEarlyBirdHow => 'Jogou de manhã';

  @override
  String get badgeFourSeasons => 'Quatro estações';

  @override
  String get badgeFourSeasonsHow => 'Jogou em todas as estações';

  @override
  String get badgeWordsmith10 => 'Palavreiro';

  @override
  String get badgeWordsmith10How => '10 palavras na mochila';

  @override
  String get badgeWordsmith25 => 'Grande palavreiro';

  @override
  String get badgeWordsmith25How => '25 palavras na mochila';

  @override
  String get badgeWordsmith50 => 'Mestre das palavras';

  @override
  String get badgeWordsmith50How => '50 palavras na mochila';

  @override
  String get badgePoet => 'Poeta';

  @override
  String get badgePoetHow => '10 frases em O meu livro';

  @override
  String get badgeListener => 'Ouvinte';

  @override
  String get badgeListenerHow => '10 rondas de audição com três estrelas';

  @override
  String get badgePersistent => 'Persistente';

  @override
  String get badgePersistentHow => '7 dias de jogo';

  @override
  String get parentTitle => 'Para os pais';

  @override
  String gateQuestion(int a, int b) {
    return 'Quanto é $a × $b?';
  }

  @override
  String get backToGame => 'Voltar ao jogo';

  @override
  String get sectionOverview => 'Resumo';

  @override
  String get sectionLetters => 'Letras';

  @override
  String get sectionTips => 'Sugestões para casa';

  @override
  String get sectionMethod => 'Como a app ensina';

  @override
  String get sectionSettings => 'Definições';

  @override
  String get statProfile => 'perfil';

  @override
  String get statPlayDays => 'dias de jogo';

  @override
  String get statLessons => 'lições';

  @override
  String get statStars => 'estrelas';

  @override
  String get statWords => 'palavras na mochila';

  @override
  String get statSentences => 'frases em O meu livro';

  @override
  String get statBadges => 'medalhas';

  @override
  String get lettersLegend =>
      '🟢 dominadas · 🟡 a treinar · ⚪ ainda não vistas';

  @override
  String troubleWords(String letter, String words) {
    return 'Palavras com $letter que se confundem: $words';
  }

  @override
  String get tipNoData =>
      'Ainda não há nada para treinar — as sugestões aparecem após algumas lições.';

  @override
  String tipWeakest(String words) {
    return 'Palavras mais fracas: $words. Experimentem batê-las em palmas por sílabas em casa e procurar coisas que comecem por elas.';
  }

  @override
  String tipLetter(String letter) {
    return 'A letra $letter ainda está a assentar: procurem juntos em casa coisas que comecem por $letter.';
  }

  @override
  String get tipLongPress =>
      'Um toque longo numa lição do mapa mostra o que se treina nela e porquê.';

  @override
  String methodLabel(String method) {
    return 'Método: $method';
  }

  @override
  String get methodText =>
      'A criança desliza o dedo pelas letras pela ordem em que ouve a sílaba ou a palavra. Primeiro sílabas abertas (MA, TA), depois palavras inteiras, rondas de audição sem texto, rondas de completar e revisão das palavras mais fracas. Um erro nunca bloqueia o progresso — a carta só abana e dá uma pista. As palavras aprendidas passam logo para uma frase (o construtor de frases) e podem ser guardadas em O meu livro.';

  @override
  String get settingSounds => 'Sons';

  @override
  String get settingAmbient => 'Sons do mundo';

  @override
  String get settingMusic => 'Música';

  @override
  String get settingLeftHanded => 'Canhoto (teclado espelhado)';

  @override
  String get settingDyslexiaFont => 'Letra para dislexia (OpenDyslexic)';

  @override
  String get settingSeason => 'Estação no mapa';

  @override
  String get seasonAuto => 'segundo o calendário';

  @override
  String get seasonSpring => 'primavera';

  @override
  String get seasonSummer => 'verão';

  @override
  String get seasonAutumn => 'outono';

  @override
  String get seasonWinter => 'inverno';

  @override
  String get settingTimeLimit => 'Limite diário de tempo de jogo';

  @override
  String get noLimit => 'sem limite';

  @override
  String minutes(int n) {
    return '$n min';
  }

  @override
  String playedToday(int played) {
    return 'Jogado hoje: $played min';
  }

  @override
  String playedTodayOf(int played, int limit) {
    return 'Jogado hoje: $played de $limit min';
  }

  @override
  String get guideAsleep => ' — o guia está a dormir';

  @override
  String extendToday(int n) {
    return 'Prolongar hoje $n min';
  }

  @override
  String get profilesTitle => 'Perfis';

  @override
  String deleteProfileTitle(String name) {
    return 'Eliminar o perfil $name?';
  }

  @override
  String get deleteProfileBody =>
      'Todo o progresso, autocolantes e o livro também serão eliminados. Não é possível desfazer.';

  @override
  String get cancel => 'Cancelar';

  @override
  String get delete => 'Eliminar';

  @override
  String get statMinutesToday => 'minutos hoje';

  @override
  String get statMinutesWeek => 'minutos esta semana';

  @override
  String get letterMastered => 'dominadas';

  @override
  String get letterPracticing => 'a treinar';

  @override
  String get letterUnseen => 'ainda não vistas';

  @override
  String get typeHunt => 'SOM';

  @override
  String get typeJoin => 'SÍLABAS';

  @override
  String get typeRhyme => 'RIMA';

  @override
  String get promptHunt => 'Que letra ouviste? Toca nela';

  @override
  String get promptJoin => 'Junta as sílabas — desliza a palavra toda';

  @override
  String get promptRhyme => 'O que rima? Toca na imagem';

  @override
  String get expeditionTitle => 'Expedição de revisão';

  @override
  String get badgeExpedition => 'Expedicionário';

  @override
  String get badgeExpeditionHow => 'Primeira expedição semanal de revisão';

  @override
  String get seasonStickersTitle => 'Autocolantes das estações';

  @override
  String get mapLoadFailed => 'Não foi possível carregar o mapa';

  @override
  String get retry => 'Tentar de novo';

  @override
  String get vocativeLabel => 'Forma de tratamento em checo (vocativo)';

  @override
  String get vocativeHint => 'p. ex. Lauro';

  @override
  String get guideTitle => 'O teu guia';

  @override
  String get petPlay => 'Anda brincar';

  @override
  String get badgeHost => 'Anfitrião';

  @override
  String get badgeHostHow => '10 presentes para os animais';

  @override
  String get badgeCuddler => 'Miminhos';

  @override
  String get badgeCuddlerHow => 'Fez festas a 5 animais';

  @override
  String get badgeWishMaker => 'Desejo cumprido';

  @override
  String get badgeWishMakerHow => '10 desejos cumpridos';

  @override
  String get badgeFriendOfAll => 'Amigo de todos';

  @override
  String get badgeFriendOfAllHow => 'Cada animal recebeu um presente';

  @override
  String get settingPetRounds =>
      'Presentes para os animais: escrever primeiro a palavra';

  @override
  String get petBowlFood => 'tigela';

  @override
  String get petBowlWater => 'água';

  @override
  String get storeIslandA => 'Ilha das letras';

  @override
  String get storeIslandB => 'Ilha das palavras';

  @override
  String get storeIslandC => 'Ilha das frases';

  @override
  String storeProductIsland(String island, String language) {
    return '$island – $language';
  }

  @override
  String storeProductIslandDesc(String language) {
    return 'Novas unidades, autocolantes e habitantes do mundo dos animais. Idioma: $language.';
  }

  @override
  String storeProductLanguage(String language) {
    return 'Mais um idioma – $language';
  }

  @override
  String storeProductLanguageDesc(String island, String language) {
    return '$island noutro idioma: $language.';
  }

  @override
  String get storeProductBundle => 'Tudo para sempre';

  @override
  String get storeProductBundleDesc =>
      'Todas as ilhas e idiomas, incluindo os que ainda vão chegar.';

  @override
  String get storeProductParent => 'Pacote para os pais';

  @override
  String get storeProductParentDesc =>
      'Fichas de trabalho, impressão de O meu livro, resumo semanal e transferência do progresso.';

  @override
  String get storeStateFree => 'grátis';

  @override
  String get storeStateOwned => 'já tem';

  @override
  String storeBuy(String price) {
    return 'Comprar por $price';
  }

  @override
  String get storeRestore => 'Restaurar compras';

  @override
  String get storeDebugTitle => 'Loja (depuração)';

  @override
  String get storeDebugEnable => 'Simular uma loja ativada';

  @override
  String get storeDebugForget => 'Esquecer compras';

  @override
  String get homeLanguageLabel => 'Idioma da família (menus e ajuda)';

  @override
  String get homeLanguageSame => 'Igual ao idioma do jogo';

  @override
  String get parentPrivacy => 'Política de privacidade';
}
