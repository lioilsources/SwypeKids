// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get appTitle => 'Swype Kids';

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
  String get bedtimeText => 'O Pipi já dorme. Até amanhã!';

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
}
