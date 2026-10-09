// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Ukrainian (`uk`).
class AppLocalizationsUk extends AppLocalizations {
  AppLocalizationsUk([String locale = 'uk']) : super(locale);

  @override
  String get appTitle => 'SwypeKids';

  @override
  String get menuSyllabary => 'Буквар (Swype)';

  @override
  String get menuSentence => 'Склади речення';

  @override
  String get menuZoo => 'Звіринець';

  @override
  String get menuBook => 'Моя книжечка';

  @override
  String get menuParents => 'Для батьків';

  @override
  String get practiceTitle => 'Тренування';

  @override
  String bedtimeText(String guide) {
    return '$guide уже спить. До завтра!';
  }

  @override
  String get typeListen => 'НА СЛУХ';

  @override
  String get typePicture => 'КАРТИНКА';

  @override
  String get typeGap => 'ДОПОВНИ';

  @override
  String get typeReview => 'ПОВТОРЕННЯ';

  @override
  String get typeWord => 'СЛОВО';

  @override
  String get typeSyllable => 'СКЛАД';

  @override
  String get promptListen => 'Послухай і проведи пальцем по літерах';

  @override
  String get promptPicture => 'Що на картинці? Напиши';

  @override
  String get promptGap => 'Якої літери бракує? Проведи по всьому слову';

  @override
  String get promptSwipeTouch => 'Проведи пальцем по картинках';

  @override
  String get promptSwipeTrackpad => 'Проведи двома пальцями по картинках';

  @override
  String get successText => 'Чудово!';

  @override
  String get errorText => 'Спробуй ще раз!';

  @override
  String get newSticker => 'У тебе нова наліпка!';

  @override
  String starsGained(int count) {
    return 'Зірочки: +$count';
  }

  @override
  String get backToMap => 'Назад на мапу';

  @override
  String get winTitle => 'Готово!\nТи молодець!';

  @override
  String winStars(int count) {
    return 'Зароблено зірочок: $count!';
  }

  @override
  String get playAgain => 'Грати ще раз';

  @override
  String get builderBadge => 'РЕЧЕННЯ';

  @override
  String get who => 'ХТО';

  @override
  String get whatDoes => 'ЩО РОБИТЬ';

  @override
  String get whatWhere => 'ЩО / КУДИ';

  @override
  String get newLabel => 'НОВЕ';

  @override
  String get clear => 'Стерти';

  @override
  String get bookTitle => 'Моя книжечка';

  @override
  String get bookEmptyHint => 'Склади речення і збережи його в книжечку';

  @override
  String get zooTitle => 'Звіринець';

  @override
  String badgesTitle(int earned, int total) {
    return 'Відзнаки $earned/$total';
  }

  @override
  String get badgeFirstSwype => 'Перший свайп';

  @override
  String get badgeFirstSwypeHow => 'Перший правильний свайп';

  @override
  String get badgeNoMistake => 'Без помилок';

  @override
  String get badgeNoMistakeHow => 'Цілий розділ на три зірочки';

  @override
  String get badgeExplorer => 'Дослідник';

  @override
  String get badgeExplorerHow => 'Перша наліпка';

  @override
  String get badgeCollectorHalf => 'Колекціонер';

  @override
  String get badgeCollectorHalfHow => 'Половина Звіринця';

  @override
  String get badgeCollectorAll => 'Великий колекціонер';

  @override
  String get badgeCollectorAllHow => 'Увесь Звіринець';

  @override
  String get badgeNightOwl => 'Нічна сова';

  @override
  String get badgeNightOwlHow => 'Гра вночі';

  @override
  String get badgeEarlyBird => 'Рання пташка';

  @override
  String get badgeEarlyBirdHow => 'Гра вранці';

  @override
  String get badgeFourSeasons => 'Чотири пори року';

  @override
  String get badgeFourSeasonsHow => 'Гра в кожну пору року';

  @override
  String get badgeWordsmith10 => 'Словознавець';

  @override
  String get badgeWordsmith10How => '10 слів у рюкзаку';

  @override
  String get badgeWordsmith25 => 'Великий словознавець';

  @override
  String get badgeWordsmith25How => '25 слів у рюкзаку';

  @override
  String get badgeWordsmith50 => 'Майстер слів';

  @override
  String get badgeWordsmith50How => '50 слів у рюкзаку';

  @override
  String get badgePoet => 'Поет';

  @override
  String get badgePoetHow => '10 речень у Моїй книжечці';

  @override
  String get badgeListener => 'Слухач';

  @override
  String get badgeListenerHow => '10 раундів на слух на три зірочки';

  @override
  String get badgePersistent => 'Завзятець';

  @override
  String get badgePersistentHow => '7 днів гри';

  @override
  String get parentTitle => 'Для батьків';

  @override
  String gateQuestion(int a, int b) {
    return 'Скільки буде $a × $b?';
  }

  @override
  String get backToGame => 'Назад до гри';

  @override
  String get sectionOverview => 'Огляд';

  @override
  String get sectionLetters => 'Літери';

  @override
  String get sectionTips => 'Поради для дому';

  @override
  String get sectionMethod => 'Як застосунок навчає';

  @override
  String get sectionSettings => 'Налаштування';

  @override
  String get statProfile => 'профіль';

  @override
  String get statPlayDays => 'днів гри';

  @override
  String get statLessons => 'уроків';

  @override
  String get statStars => 'зірочок';

  @override
  String get statWords => 'слів у рюкзаку';

  @override
  String get statSentences => 'речень у Моїй книжечці';

  @override
  String get statBadges => 'відзнак';

  @override
  String get lettersLegend =>
      '🟢 засвоєно · 🟡 тренується · ⚪ ще не траплялося';

  @override
  String troubleWords(String letter, String words) {
    return 'Слова з $letter, які плутаються: $words';
  }

  @override
  String get tipNoData =>
      'Поки що нема чого тренувати — після кількох уроків тут будуть поради.';

  @override
  String tipWeakest(String words) {
    return 'Найслабші слова: $words. Спробуйте вдома проплескати їх по складах і пошукати речі, назви яких починаються так само.';
  }

  @override
  String tipLetter(String letter) {
    return 'Літера $letter ще засвоюється: пошукайте разом удома речі, назви яких починаються на $letter.';
  }

  @override
  String get tipLongPress =>
      'Довге натискання на урок на мапі покаже, що в ньому відпрацьовується і навіщо.';

  @override
  String methodLabel(String method) {
    return 'Метод: $method';
  }

  @override
  String get methodText =>
      'Дитина проводить пальцем по літерах у тому порядку, в якому чує склад або слово. Спершу відкриті склади (MA, TA), потім цілі слова, раунди на слух без тексту, завдання з пропущеною літерою та повторення найслабших слів. Помилка ніколи не зупиняє поступ — картка лише здригнеться й підкаже. Вивчені слова дитина одразу вживає в реченні (конструктор речень) і може зберегти їх у Моїй книжечці.';

  @override
  String get settingSounds => 'Звуки';

  @override
  String get settingAmbient => 'Звуки світу';

  @override
  String get settingMusic => 'Музика';

  @override
  String get settingLeftHanded => 'Для шульги (дзеркальна клавіатура)';

  @override
  String get settingDyslexiaFont =>
      'Шрифт для людей з дислексією (OpenDyslexic)';

  @override
  String get settingSeason => 'Пора року на мапі';

  @override
  String get seasonAuto => 'за календарем';

  @override
  String get seasonSpring => 'весна';

  @override
  String get seasonSummer => 'літо';

  @override
  String get seasonAutumn => 'осінь';

  @override
  String get seasonWinter => 'зима';

  @override
  String get settingTimeLimit => 'Денний ліміт часу гри';

  @override
  String get noLimit => 'без ліміту';

  @override
  String minutes(int n) {
    return '$n хв';
  }

  @override
  String playedToday(int played) {
    return 'Сьогодні зіграно: $played хв';
  }

  @override
  String playedTodayOf(int played, int limit) {
    return 'Сьогодні зіграно: $played з $limit хв';
  }

  @override
  String get guideAsleep => ' — провідник уже спить';

  @override
  String extendToday(int n) {
    return 'Продовжити сьогодні на $n хв';
  }

  @override
  String get profilesTitle => 'Профілі';

  @override
  String deleteProfileTitle(String name) {
    return 'Видалити профіль $name?';
  }

  @override
  String get deleteProfileBody =>
      'Буде видалено також увесь прогрес, наліпки та книжечку. Це неможливо скасувати.';

  @override
  String get cancel => 'Скасувати';

  @override
  String get delete => 'Видалити';

  @override
  String get statMinutesToday => 'хвилин сьогодні';

  @override
  String get statMinutesWeek => 'хвилин цього тижня';

  @override
  String get letterMastered => 'засвоєно';

  @override
  String get letterPracticing => 'тренується';

  @override
  String get letterUnseen => 'ще не траплялося';

  @override
  String get typeHunt => 'ЗВУК';

  @override
  String get typeJoin => 'СКЛАДИ';

  @override
  String get typeRhyme => 'РИМА';

  @override
  String get promptHunt => 'Яку літеру чуєш? Торкнися її';

  @override
  String get promptJoin => 'Поєднай склади — проведи по всьому слову';

  @override
  String get promptRhyme => 'Що римується? Торкнися картинки';

  @override
  String get expeditionTitle => 'Мандрівка за повторенням';

  @override
  String get badgeExpedition => 'Мандрівник';

  @override
  String get badgeExpeditionHow => 'Перша щотижнева мандрівка за повторенням';

  @override
  String get seasonStickersTitle => 'Наліпки пір року';

  @override
  String get mapLoadFailed => 'Не вдалося завантажити мапу';

  @override
  String get retry => 'Спробувати ще раз';

  @override
  String get vocativeLabel => 'Звертання чеською (кличний відмінок)';

  @override
  String get vocativeHint => 'напр. Lauro';

  @override
  String get guideTitle => 'Твій провідник';

  @override
  String get petPlay => 'Ходімо гратися';

  @override
  String get badgeHost => 'Гостинна душа';

  @override
  String get badgeHostHow => '10 подарунків тваринкам';

  @override
  String get badgeCuddler => 'Пестунчик';

  @override
  String get badgeCuddlerHow => 'Погладжено 5 тваринок';

  @override
  String get badgeWishMaker => 'Здійснене бажання';

  @override
  String get badgeWishMakerHow => '10 здійснених бажань';

  @override
  String get badgeFriendOfAll => 'Друг усім';

  @override
  String get badgeFriendOfAllHow => 'Кожна тваринка отримала подарунок';

  @override
  String get settingPetRounds => 'Подарунки тваринкам: спершу написати слово';

  @override
  String get petBowlFood => 'миска';

  @override
  String get petBowlWater => 'вода';

  @override
  String get storeIslandA => 'Острів літер';

  @override
  String get storeIslandB => 'Острів слів';

  @override
  String get storeIslandC => 'Острів речень';

  @override
  String storeProductIsland(String island, String language) {
    return '$island – $language';
  }

  @override
  String storeProductIslandDesc(String language) {
    return 'Нові розділи, наліпки та мешканці світу тваринок. Мова: $language.';
  }

  @override
  String storeProductLanguage(String language) {
    return 'Ще одна мова – $language';
  }

  @override
  String storeProductLanguageDesc(String island, String language) {
    return '$island ще однією мовою: $language.';
  }

  @override
  String get storeProductBundle => 'Усе назавжди';

  @override
  String get storeProductBundleDesc =>
      'Усі острови й мови, зокрема й ті, що з часом додадуться.';

  @override
  String get storeProductParent => 'Набір для батьків';

  @override
  String get storeProductParentDesc =>
      'Робочі аркуші, друк Моєї книжечки, щотижневий огляд і перенесення прогресу.';

  @override
  String get storeStateFree => 'безкоштовно';

  @override
  String get storeStateOwned => 'маєте';

  @override
  String storeBuy(String price) {
    return 'Купити за $price';
  }

  @override
  String get storeRestore => 'Відновити покупки';

  @override
  String get storeDebugTitle => 'Магазин (налагодження)';

  @override
  String get storeDebugEnable => 'Імітувати ввімкнений магазин';

  @override
  String get storeDebugForget => 'Забути покупки';

  @override
  String get homeLanguageLabel => 'Мова родини (меню та підказки)';

  @override
  String get homeLanguageSame => 'Така сама, як мова гри';
}
