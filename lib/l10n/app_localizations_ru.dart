// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get appTitle => 'SwypeKids';

  @override
  String get menuSyllabary => 'Букварь (Swype)';

  @override
  String get menuSentence => 'Составь предложение';

  @override
  String get menuZoo => 'Зоопарк';

  @override
  String get menuBook => 'Моя книжка';

  @override
  String get menuParents => 'Для родителей';

  @override
  String get practiceTitle => 'Тренировка';

  @override
  String bedtimeText(String guide) {
    return '$guide уже спит. До завтра!';
  }

  @override
  String get typeListen => 'СЛУШАЙ';

  @override
  String get typePicture => 'КАРТИНКА';

  @override
  String get typeGap => 'ВСТАВЬ';

  @override
  String get typeReview => 'ПОВТОРЕНИЕ';

  @override
  String get typeWord => 'СЛОВО';

  @override
  String get typeSyllable => 'СЛОГ';

  @override
  String get promptListen => 'Послушай и проведи то, что слышишь';

  @override
  String get promptPicture => 'Что на картинке? Напиши';

  @override
  String get promptGap => 'Какой буквы не хватает? Проведи всё слово';

  @override
  String get promptSwipeTouch => 'Проведи пальцем по картинкам';

  @override
  String get promptSwipeTrackpad => 'Проведи двумя пальцами по картинкам';

  @override
  String get successText => 'Молодец!';

  @override
  String get errorText => 'Попробуй ещё раз!';

  @override
  String get newSticker => 'У тебя новая наклейка!';

  @override
  String starsGained(int count) {
    return 'Звёзды: +$count';
  }

  @override
  String get backToMap => 'Назад на карту';

  @override
  String get winTitle => 'Готово!\nТы чемпион!';

  @override
  String winStars(int count) {
    return 'Твои звёзды: $count!';
  }

  @override
  String get playAgain => 'Играть снова';

  @override
  String get builderBadge => 'ПРЕДЛОЖЕНИЕ';

  @override
  String get who => 'КТО';

  @override
  String get whatDoes => 'ЧТО ДЕЛАЕТ';

  @override
  String get whatWhere => 'ЧТО / КУДА';

  @override
  String get newLabel => 'НОВОЕ';

  @override
  String get clear => 'Стереть';

  @override
  String get bookTitle => 'Моя книжка';

  @override
  String get bookEmptyHint => 'Составь предложение и сохрани его в книжку';

  @override
  String get zooTitle => 'Зоопарк';

  @override
  String badgesTitle(int earned, int total) {
    return 'Значки $earned/$total';
  }

  @override
  String get badgeFirstSwype => 'Первый свайп';

  @override
  String get badgeFirstSwypeHow => 'Первый правильный свайп';

  @override
  String get badgeNoMistake => 'Без ошибок';

  @override
  String get badgeNoMistakeHow => 'Весь раздел на три звезды';

  @override
  String get badgeExplorer => 'Первооткрыватель';

  @override
  String get badgeExplorerHow => 'Первая наклейка';

  @override
  String get badgeCollectorHalf => 'Коллекционер';

  @override
  String get badgeCollectorHalfHow => 'Половина Зоопарка';

  @override
  String get badgeCollectorAll => 'Великий коллекционер';

  @override
  String get badgeCollectorAllHow => 'Весь Зоопарк';

  @override
  String get badgeNightOwl => 'Ночная сова';

  @override
  String get badgeNightOwlHow => 'Игра ночью';

  @override
  String get badgeEarlyBird => 'Ранняя пташка';

  @override
  String get badgeEarlyBirdHow => 'Игра утром';

  @override
  String get badgeFourSeasons => 'Четыре времени года';

  @override
  String get badgeFourSeasonsHow => 'Игра в каждое время года';

  @override
  String get badgeWordsmith10 => 'Словознайка';

  @override
  String get badgeWordsmith10How => '10 слов в рюкзаке';

  @override
  String get badgeWordsmith25 => 'Большой словознайка';

  @override
  String get badgeWordsmith25How => '25 слов в рюкзаке';

  @override
  String get badgeWordsmith50 => 'Мастер слов';

  @override
  String get badgeWordsmith50How => '50 слов в рюкзаке';

  @override
  String get badgePoet => 'Поэт';

  @override
  String get badgePoetHow => '10 предложений в Моей книжке';

  @override
  String get badgeListener => 'Слушатель';

  @override
  String get badgeListenerHow => '10 раундов на слух на три звезды';

  @override
  String get badgePersistent => 'Упорство';

  @override
  String get badgePersistentHow => '7 дней игры';

  @override
  String get parentTitle => 'Для родителей';

  @override
  String gateQuestion(int a, int b) {
    return 'Сколько будет $a × $b?';
  }

  @override
  String get backToGame => 'Назад к игре';

  @override
  String get sectionOverview => 'Обзор';

  @override
  String get sectionLetters => 'Буквы';

  @override
  String get sectionTips => 'Советы для дома';

  @override
  String get sectionMethod => 'Как учит приложение';

  @override
  String get sectionSettings => 'Настройки';

  @override
  String get statProfile => 'профиль';

  @override
  String get statPlayDays => 'дней игры';

  @override
  String get statLessons => 'уроков';

  @override
  String get statStars => 'звёзд';

  @override
  String get statWords => 'слов в рюкзаке';

  @override
  String get statSentences => 'предложений в Моей книжке';

  @override
  String get statBadges => 'значков';

  @override
  String get lettersLegend =>
      '🟢 освоена · 🟡 закрепляется · ⚪ ещё не встречалась';

  @override
  String troubleWords(String letter, String words) {
    return 'Слова с $letter, в которых бывают ошибки: $words';
  }

  @override
  String get tipNoData =>
      'Пока тренировать нечего — советы появятся после нескольких уроков.';

  @override
  String tipWeakest(String words) {
    return 'Самые трудные слова: $words. Попробуйте дома прохлопать их по слогам и поискать предметы, которые с них начинаются.';
  }

  @override
  String tipLetter(String letter) {
    return 'Буква $letter ещё закрепляется: поищите вместе дома предметы, которые начинаются на $letter.';
  }

  @override
  String get tipLongPress =>
      'Долгое нажатие на урок на карте покажет, что в нём отрабатывается и зачем.';

  @override
  String methodLabel(String method) {
    return 'Метод: $method';
  }

  @override
  String get methodText =>
      'Ребёнок проводит пальцем по буквам в том порядке, в каком слышит слог или слово. Сначала открытые слоги (MA, TA), затем целые слова, раунды на слух без текста, задания с пропущенной буквой и повторение самых трудных слов. Ошибка никогда не останавливает продвижение — карточка лишь вздрогнет и подскажет. Выученные слова ребёнок сразу использует в предложении (конструктор предложений) и может сохранить их в Моей книжке.';

  @override
  String get settingSounds => 'Звуки';

  @override
  String get settingAmbient => 'Звуки мира';

  @override
  String get settingMusic => 'Музыка';

  @override
  String get settingLeftHanded => 'Левша (зеркальная клавиатура)';

  @override
  String get settingDyslexiaFont =>
      'Шрифт для людей с дислексией (OpenDyslexic)';

  @override
  String get settingSeason => 'Время года на карте';

  @override
  String get seasonAuto => 'по календарю';

  @override
  String get seasonSpring => 'весна';

  @override
  String get seasonSummer => 'лето';

  @override
  String get seasonAutumn => 'осень';

  @override
  String get seasonWinter => 'зима';

  @override
  String get settingTimeLimit => 'Лимит времени игры в день';

  @override
  String get noLimit => 'без лимита';

  @override
  String minutes(int n) {
    return '$n мин';
  }

  @override
  String playedToday(int played) {
    return 'Сегодня сыграно: $played мин';
  }

  @override
  String playedTodayOf(int played, int limit) {
    return 'Сегодня сыграно: $played из $limit мин';
  }

  @override
  String get guideAsleep => ' — помощник уже спит';

  @override
  String extendToday(int n) {
    return 'Продлить сегодня на $n мин';
  }

  @override
  String get profilesTitle => 'Профили';

  @override
  String deleteProfileTitle(String name) {
    return 'Удалить профиль $name?';
  }

  @override
  String get deleteProfileBody =>
      'Будут удалены весь прогресс, наклейки и книжка. Отменить это нельзя.';

  @override
  String get cancel => 'Отмена';

  @override
  String get delete => 'Удалить';

  @override
  String get statMinutesToday => 'минут сегодня';

  @override
  String get statMinutesWeek => 'минут за эту неделю';

  @override
  String get letterMastered => 'освоена';

  @override
  String get letterPracticing => 'закрепляется';

  @override
  String get letterUnseen => 'ещё не встречалась';

  @override
  String get typeHunt => 'ЗВУК';

  @override
  String get typeJoin => 'СЛОГИ';

  @override
  String get typeRhyme => 'РИФМА';

  @override
  String get promptHunt => 'Какую букву ты слышишь? Нажми на неё';

  @override
  String get promptJoin => 'Соедини слоги — проведи всё слово';

  @override
  String get promptRhyme => 'Что рифмуется? Нажми на картинку';

  @override
  String get expeditionTitle => 'Поход за повторением';

  @override
  String get badgeExpedition => 'Путешественник';

  @override
  String get badgeExpeditionHow => 'Первый еженедельный поход за повторением';

  @override
  String get seasonStickersTitle => 'Наклейки времён года';

  @override
  String get mapLoadFailed => 'Не удалось загрузить карту';

  @override
  String get retry => 'Попробовать снова';

  @override
  String get vocativeLabel => 'Обращение по-чешски (звательный падеж)';

  @override
  String get vocativeHint => 'напр. Lauro';

  @override
  String get guideTitle => 'Твой помощник';

  @override
  String get petPlay => 'Давай поиграем';

  @override
  String get badgeHost => 'Радушный хозяин';

  @override
  String get badgeHostHow => '10 подарков зверятам';

  @override
  String get badgeCuddler => 'Ласковые ручки';

  @override
  String get badgeCuddlerHow => 'Поглажено 5 зверят';

  @override
  String get badgeWishMaker => 'Желание сбылось';

  @override
  String get badgeWishMakerHow => '10 исполненных желаний';

  @override
  String get badgeFriendOfAll => 'Друг для всех';

  @override
  String get badgeFriendOfAllHow => 'Каждый зверёк получил подарок';

  @override
  String get settingPetRounds => 'Подарки зверятам: сначала написать слово';

  @override
  String get petBowlFood => 'миска';

  @override
  String get petBowlWater => 'вода';

  @override
  String get storeIslandA => 'Остров букв';

  @override
  String get storeIslandB => 'Остров слов';

  @override
  String get storeIslandC => 'Остров предложений';

  @override
  String storeProductIsland(String island, String language) {
    return '$island – $language';
  }

  @override
  String storeProductIslandDesc(String language) {
    return 'Новые разделы, наклейки и жители мира зверят. Язык: $language.';
  }

  @override
  String storeProductLanguage(String language) {
    return 'Ещё один язык – $language';
  }

  @override
  String storeProductLanguageDesc(String island, String language) {
    return '$island на другом языке: $language.';
  }

  @override
  String get storeProductBundle => 'Всё и навсегда';

  @override
  String get storeProductBundleDesc =>
      'Все острова и языки, включая те, что появятся позже.';

  @override
  String get storeProductParent => 'Набор для родителей';

  @override
  String get storeProductParentDesc =>
      'Рабочие листы, печать Моей книжки, недельный обзор и перенос прогресса.';

  @override
  String get storeStateFree => 'бесплатно';

  @override
  String get storeStateOwned => 'у вас есть';

  @override
  String storeBuy(String price) {
    return 'Купить за $price';
  }

  @override
  String get storeRestore => 'Восстановить покупки';

  @override
  String get storeDebugTitle => 'Магазин (отладка)';

  @override
  String get storeDebugEnable => 'Имитировать включённый магазин';

  @override
  String get storeDebugForget => 'Забыть покупки';

  @override
  String get homeLanguageLabel => 'Язык семьи (меню и подсказки)';

  @override
  String get homeLanguageSame => 'Такой же, как язык игры';
}
