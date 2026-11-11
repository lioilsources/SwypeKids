// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Telugu (`te`).
class AppLocalizationsTe extends AppLocalizations {
  AppLocalizationsTe([String locale = 'te']) : super(locale);

  @override
  String get appTitle => 'SwypeKids';

  @override
  String get menuSyllabary => 'అక్షరమాల (స్వైప్)';

  @override
  String get menuSentence => 'వాక్యం తయారు చేయి';

  @override
  String get menuZoo => 'జంతు ప్రదర్శనశాల';

  @override
  String get menuBook => 'నా పుస్తకం';

  @override
  String get menuParents => 'తల్లిదండ్రులకు';

  @override
  String get practiceTitle => 'సాధన';

  @override
  String bedtimeText(String guide) {
    return '$guide నిద్రపోతోంది. రేపు కలుద్దాం!';
  }

  @override
  String get typeListen => 'వినండి';

  @override
  String get typePicture => 'చిత్రం';

  @override
  String get typeGap => 'పూరించండి';

  @override
  String get typeReview => 'పునశ్చరణ';

  @override
  String get typeWord => 'పదం';

  @override
  String get typeSyllable => 'అక్షర ఖండం';

  @override
  String get promptListen => 'విని, విన్నదాన్ని స్వైప్ చేయండి';

  @override
  String get promptPicture => 'చిత్రంలో ఏముంది? రాయండి';

  @override
  String get promptGap => 'ఏ అక్షరం లేదు? మొత్తం పదాన్ని స్వైప్ చేయండి';

  @override
  String get promptSwipeTouch => 'చిత్రాల మీద వేలును జరపండి';

  @override
  String get promptSwipeTrackpad => 'రెండు వేళ్లతో చిత్రాల మీద జరపండి';

  @override
  String get successText => 'శభాష్!';

  @override
  String get errorText => 'మళ్లీ ప్రయత్నించండి!';

  @override
  String get newSticker => 'మీకు కొత్త స్టిక్కర్ వచ్చింది!';

  @override
  String starsGained(int count) {
    return '+$count నక్షత్రాలు';
  }

  @override
  String get backToMap => 'మ్యాప్‌కు తిరిగి వెళ్లండి';

  @override
  String get winTitle => 'అయిపోయింది!\nమీరు ఛాంపియన్!';

  @override
  String winStars(int count) {
    return 'మీరు $count నక్షత్రాలు సంపాదించారు!';
  }

  @override
  String get playAgain => 'మళ్లీ ఆడండి';

  @override
  String get builderBadge => 'వాక్యం';

  @override
  String get who => 'ఎవరు';

  @override
  String get whatDoes => 'ఏం చేస్తారు';

  @override
  String get whatWhere => 'ఏమిటి / ఎక్కడ';

  @override
  String get newLabel => 'కొత్తది';

  @override
  String get clear => 'తుడిచేయి';

  @override
  String get bookTitle => 'నా పుస్తకం';

  @override
  String get bookEmptyHint => 'వాక్యం తయారు చేసి పుస్తకంలో భద్రపరచండి';

  @override
  String get zooTitle => 'జంతు ప్రదర్శనశాల';

  @override
  String badgesTitle(int earned, int total) {
    return 'బ్యాడ్జ్‌లు $earned/$total';
  }

  @override
  String get badgeFirstSwype => 'మొదటి స్వైప్';

  @override
  String get badgeFirstSwypeHow => 'మొదటి సరైన స్వైప్';

  @override
  String get badgeNoMistake => 'తప్పులు లేవు';

  @override
  String get badgeNoMistakeHow => 'మొత్తం యూనిట్ మూడు నక్షత్రాలతో';

  @override
  String get badgeExplorer => 'అన్వేషకుడు';

  @override
  String get badgeExplorerHow => 'మొదటి స్టిక్కర్';

  @override
  String get badgeCollectorHalf => 'సేకరణకర్త';

  @override
  String get badgeCollectorHalfHow => 'సగం జంతు ప్రదర్శనశాల';

  @override
  String get badgeCollectorAll => 'గొప్ప సేకరణకర్త';

  @override
  String get badgeCollectorAllHow => 'మొత్తం జంతు ప్రదర్శనశాల';

  @override
  String get badgeNightOwl => 'రాత్రి గుడ్లగూబ';

  @override
  String get badgeNightOwlHow => 'రాత్రి ఆడింది';

  @override
  String get badgeEarlyBird => 'ఉదయపు పక్షి';

  @override
  String get badgeEarlyBirdHow => 'ఉదయం ఆడింది';

  @override
  String get badgeFourSeasons => 'నాలుగు రుతువులు';

  @override
  String get badgeFourSeasonsHow => 'ప్రతి రుతువులో ఆడింది';

  @override
  String get badgeWordsmith10 => 'పద శిల్పి';

  @override
  String get badgeWordsmith10How => 'సంచిలో 10 పదాలు';

  @override
  String get badgeWordsmith25 => 'గొప్ప పద శిల్పి';

  @override
  String get badgeWordsmith25How => 'సంచిలో 25 పదాలు';

  @override
  String get badgeWordsmith50 => 'పద గురువు';

  @override
  String get badgeWordsmith50How => 'సంచిలో 50 పదాలు';

  @override
  String get badgePoet => 'కవి';

  @override
  String get badgePoetHow => 'నా పుస్తకంలో 10 వాక్యాలు';

  @override
  String get badgeListener => 'శ్రోత';

  @override
  String get badgeListenerHow => 'మూడు నక్షత్రాలతో 10 వినే రౌండ్లు';

  @override
  String get badgePersistent => 'పట్టుదల గలవాడు';

  @override
  String get badgePersistentHow => '7 ఆట రోజులు';

  @override
  String get parentTitle => 'తల్లిదండ్రులకు';

  @override
  String gateQuestion(int a, int b) {
    return '$a × $b ఎంత?';
  }

  @override
  String get backToGame => 'ఆటకు తిరిగి వెళ్లండి';

  @override
  String get sectionOverview => 'సారాంశం';

  @override
  String get sectionLetters => 'అక్షరాలు';

  @override
  String get sectionTips => 'ఇంటికి సూచనలు';

  @override
  String get sectionMethod => 'యాప్ ఎలా నేర్పుతుంది';

  @override
  String get sectionSettings => 'సెట్టింగ్‌లు';

  @override
  String get statProfile => 'ప్రొఫైల్';

  @override
  String get statPlayDays => 'ఆట రోజులు';

  @override
  String get statLessons => 'పాఠాలు';

  @override
  String get statStars => 'నక్షత్రాలు';

  @override
  String get statWords => 'సంచిలో పదాలు';

  @override
  String get statSentences => 'నా పుస్తకంలో వాక్యాలు';

  @override
  String get statBadges => 'బ్యాడ్జ్‌లు';

  @override
  String get lettersLegend =>
      '🟢 నేర్చుకున్నవి · 🟡 సాధనలో · ⚪ ఇంకా ఎదురుపడలేదు';

  @override
  String troubleWords(String letter, String words) {
    return '$letter ఉన్న, తికమకపడే పదాలు: $words';
  }

  @override
  String get tipNoData =>
      'సాధన చేయడానికి ఇంకా ఏమీ లేదు — కొన్ని పాఠాల తర్వాత సూచనలు కనిపిస్తాయి.';

  @override
  String tipWeakest(String words) {
    return 'బలహీనమైన పదాలు: $words. ఇంట్లో వాటిని అక్షర ఖండాలుగా చప్పట్లు కొడుతూ చెప్పండి, వాటితో మొదలయ్యే వస్తువులను వెతకండి.';
  }

  @override
  String tipLetter(String letter) {
    return '$letter అక్షరం ఇంకా నిలదొక్కుకుంటోంది: ఇంట్లో కలిసి $letter తో మొదలయ్యే వస్తువులను వెతకండి.';
  }

  @override
  String get tipLongPress =>
      'మ్యాప్‌లో పాఠాన్ని ఎక్కువసేపు నొక్కితే అందులో ఏమి, ఎందుకు సాధన చేస్తారో చూపిస్తుంది.';

  @override
  String methodLabel(String method) {
    return 'పద్ధతి: $method';
  }

  @override
  String get methodText =>
      'పిల్లవాడు అక్షర ఖండాన్ని లేదా పదాన్ని విన్న క్రమంలోనే అక్షరాల మీద వేలు జరుపుతాడు. మొదట తెరిచిన అక్షర ఖండాలు (MA, TA), తర్వాత పూర్తి పదాలు, పాఠ్యం లేని వినే రౌండ్లు, ఖాళీ పూరించే రౌండ్లు, బలహీనమైన పదాల పునశ్చరణ. తప్పు ఎప్పుడూ ముందుకు వెళ్లడాన్ని ఆపదు — కార్డు కొద్దిగా కదిలి సూచన ఇస్తుంది. నేర్చుకున్న పదాలు వెంటనే వాక్యంలో (వాక్య నిర్మాత) వాడబడతాయి, నా పుస్తకంలో భద్రపరచవచ్చు.';

  @override
  String get settingSounds => 'శబ్దాలు';

  @override
  String get settingAmbient => 'ప్రపంచ శబ్దాలు';

  @override
  String get settingMusic => 'సంగీతం';

  @override
  String get settingLeftHanded => 'ఎడమచేతివాటం (ప్రతిబింబ కీబోర్డ్)';

  @override
  String get settingDyslexiaFont =>
      'డిస్లెక్సియాకు అనుకూల ఫాంట్ (OpenDyslexic)';

  @override
  String get settingSeason => 'మ్యాప్‌లో రుతువు';

  @override
  String get seasonAuto => 'క్యాలెండర్ ప్రకారం';

  @override
  String get seasonSpring => 'వసంతం';

  @override
  String get seasonSummer => 'వేసవి';

  @override
  String get seasonAutumn => 'శరదృతువు';

  @override
  String get seasonWinter => 'శీతాకాలం';

  @override
  String get settingTimeLimit => 'రోజువారీ ఆట సమయ పరిమితి';

  @override
  String get noLimit => 'పరిమితి లేదు';

  @override
  String minutes(int n) {
    return '$n నిమి';
  }

  @override
  String playedToday(int played) {
    return 'ఈ రోజు ఆడింది: $played నిమి';
  }

  @override
  String playedTodayOf(int played, int limit) {
    return 'ఈ రోజు ఆడింది: $limit లో $played నిమి';
  }

  @override
  String get guideAsleep => ' — గైడ్ నిద్రపోతున్నాడు';

  @override
  String extendToday(int n) {
    return 'ఈ రోజును $n నిమి పొడిగించండి';
  }

  @override
  String get profilesTitle => 'ప్రొఫైల్‌లు';

  @override
  String deleteProfileTitle(String name) {
    return '$name ప్రొఫైల్‌ను తొలగించాలా?';
  }

  @override
  String get deleteProfileBody =>
      'మొత్తం పురోగతి, స్టిక్కర్లు, పుస్తకం కూడా తొలగిపోతాయి. దీన్ని వెనక్కి తీసుకోలేరు.';

  @override
  String get cancel => 'రద్దు చేయండి';

  @override
  String get delete => 'తొలగించండి';

  @override
  String get statMinutesToday => 'ఈ రోజు నిమిషాలు';

  @override
  String get statMinutesWeek => 'ఈ వారం నిమిషాలు';

  @override
  String get letterMastered => 'నేర్చుకున్నవి';

  @override
  String get letterPracticing => 'సాధనలో';

  @override
  String get letterUnseen => 'ఇంకా ఎదురుపడలేదు';

  @override
  String get typeHunt => 'ధ్వని';

  @override
  String get typeJoin => 'అక్షర ఖండాలు';

  @override
  String get typeRhyme => 'ప్రాస';

  @override
  String get promptHunt => 'ఏ అక్షరం విన్నారు? దాన్ని తాకండి';

  @override
  String get promptJoin =>
      'అక్షర ఖండాలను కలపండి — మొత్తం పదాన్ని స్వైప్ చేయండి';

  @override
  String get promptRhyme => 'దేనికి ప్రాస కుదురుతుంది? చిత్రాన్ని తాకండి';

  @override
  String get expeditionTitle => 'పునశ్చరణ యాత్ర';

  @override
  String get badgeExpedition => 'యాత్రికుడు';

  @override
  String get badgeExpeditionHow => 'మొదటి వారపు పునశ్చరణ యాత్ర';

  @override
  String get seasonStickersTitle => 'రుతువుల స్టిక్కర్లు';

  @override
  String get mapLoadFailed => 'మ్యాప్‌ను లోడ్ చేయలేకపోయాం';

  @override
  String get retry => 'మళ్లీ ప్రయత్నించండి';

  @override
  String get vocativeLabel => 'చెక్ భాషలో సంబోధన రూపం (సంబోధన విభక్తి)';

  @override
  String get vocativeHint => 'ఉదా. Lauro';

  @override
  String get guideTitle => 'మీ గైడ్';

  @override
  String get petPlay => 'రండి ఆడుకుందాం';

  @override
  String get badgeHost => 'ఆతిథేయి';

  @override
  String get badgeHostHow => 'జంతువులకు 10 బహుమతులు';

  @override
  String get badgeCuddler => 'ముద్దుగా చూసుకునేవాడు';

  @override
  String get badgeCuddlerHow => '5 జంతువులను నిమిరాడు';

  @override
  String get badgeWishMaker => 'నెరవేరిన కోరిక';

  @override
  String get badgeWishMakerHow => '10 కోరికలు నెరవేరాయి';

  @override
  String get badgeFriendOfAll => 'అందరి స్నేహితుడు';

  @override
  String get badgeFriendOfAllHow => 'ప్రతి జంతువుకు బహుమతి దొరికింది';

  @override
  String get settingPetRounds => 'జంతువులకు బహుమతులు: ముందు పదం రాయండి';

  @override
  String get petBowlFood => 'గిన్నె';

  @override
  String get petBowlWater => 'నీళ్లు';

  @override
  String get storeIslandA => 'అక్షరాల దీవి';

  @override
  String get storeIslandB => 'పదాల దీవి';

  @override
  String get storeIslandC => 'వాక్యాల దీవి';

  @override
  String storeProductIsland(String island, String language) {
    return '$island – $language';
  }

  @override
  String storeProductIslandDesc(String language) {
    return 'కొత్త యూనిట్లు, స్టిక్కర్లు, జంతు ప్రపంచ నివాసులు. భాష: $language.';
  }

  @override
  String storeProductLanguage(String language) {
    return 'మరో భాష – $language';
  }

  @override
  String storeProductLanguageDesc(String island, String language) {
    return '$island మరో భాషలో: $language.';
  }

  @override
  String get storeProductBundle => 'అన్నీ శాశ్వతంగా';

  @override
  String get storeProductBundleDesc => 'అన్ని దీవులు, భాషలు — రాబోయేవి కూడా.';

  @override
  String get storeProductParent => 'తల్లిదండ్రుల ప్యాక్';

  @override
  String get storeProductParentDesc =>
      'వర్క్‌షీట్లు, నా పుస్తకం ప్రింటింగ్, వారపు సారాంశం, పురోగతి బదిలీ.';

  @override
  String get storeStateFree => 'ఉచితం';

  @override
  String get storeStateOwned => 'మీ వద్ద ఉంది';

  @override
  String storeBuy(String price) {
    return '$price కు కొనండి';
  }

  @override
  String get storeRestore => 'కొనుగోళ్లను పునరుద్ధరించండి';

  @override
  String get storeDebugTitle => 'స్టోర్ (డీబగ్)';

  @override
  String get storeDebugEnable => 'ప్రారంభించిన స్టోర్‌ను అనుకరించండి';

  @override
  String get storeDebugForget => 'కొనుగోళ్లను మరచిపోండి';

  @override
  String get homeLanguageLabel => 'కుటుంబ భాష (మెనూలు, సూచనలు)';

  @override
  String get homeLanguageSame => 'ఆట భాషలాగే';

  @override
  String get parentPrivacy => 'గోప్యతా విధానం';
}
