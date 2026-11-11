import 'package:flutter/widgets.dart';

import '../data/lessons.dart';
import '../l10n/app_localizations.dart';
import '../services/achievement_service.dart';
import '../services/profile_service.dart';
import '../store/catalog.dart';
import '../widgets/language_picker.dart' show kLanguageFlag, kLanguageName;
import '../world/world_clock.dart';

export '../l10n/app_localizations.dart';

/// Jazyky rozhraní, ve kterých se v appce nečte — jen „jazyk rodiny“
/// (menu a nápověda) pro děti, které se učí číst v jiném jazyce, než jakým
/// mluví doma (ukrajinské dítě v české škole). Kód je BCP 47: `pt-PT`
/// a `zh-Hant` mají region / písmo, ostatní jen jazyk.
const kHomeOnlyLanguages = [
  'uk', 'ru', 'vi', //
  'ar', 'bn', 'ca', 'da', 'el', 'fi', 'gu', 'he', 'hi', 'hr', 'hu', 'id',
  'kn', 'ko', 'ml', 'mr', 'ms', 'nb', 'nl', 'or', 'pa', 'pl', 'pt-PT', 'ro',
  'sk', 'sl', 'sv', 'ta', 'te', 'th', 'tr', 'ur', 'zh-Hant',
];

/// Všechny jazyky rozhraní: jazyky packů + [kHomeOnlyLanguages].
final List<String> kHomeLanguages = [
  for (final l in Language.values) l.name,
  ...kHomeOnlyLanguages,
];

/// Jméno jazyka rozhraní v něm samém (nepřekládá se) a vlajka (zůstává emoji
/// jako ostatní vlajky; jazyky bez vlastního státu dostanou stát, kde se
/// mluví nejvíc — rozlišuje je jméno pod vlajkou).
const _homeOnly = <String, (String name, String flag)>{
  'uk': ('Українська', '🇺🇦'),
  'ru': ('Русский', '🇷🇺'),
  'vi': ('Tiếng Việt', '🇻🇳'),
  'ar': ('العربية', '🇸🇦'),
  'bn': ('বাংলা', '🇧🇩'),
  'ca': ('Català', '🇦🇩'),
  'da': ('Dansk', '🇩🇰'),
  'el': ('Ελληνικά', '🇬🇷'),
  'fi': ('Suomi', '🇫🇮'),
  'gu': ('ગુજરાતી', '🇮🇳'),
  'he': ('עברית', '🇮🇱'),
  'hi': ('हिन्दी', '🇮🇳'),
  'hr': ('Hrvatski', '🇭🇷'),
  'hu': ('Magyar', '🇭🇺'),
  'id': ('Bahasa Indonesia', '🇮🇩'),
  'kn': ('ಕನ್ನಡ', '🇮🇳'),
  'ko': ('한국어', '🇰🇷'),
  'ml': ('മലയാളം', '🇮🇳'),
  'mr': ('मराठी', '🇮🇳'),
  'ms': ('Bahasa Melayu', '🇲🇾'),
  'nb': ('Norsk bokmål', '🇳🇴'),
  'nl': ('Nederlands', '🇳🇱'),
  'or': ('ଓଡ଼ିଆ', '🇮🇳'),
  'pa': ('ਪੰਜਾਬੀ', '🇮🇳'),
  'pl': ('Polski', '🇵🇱'),
  'pt-PT': ('Português (Portugal)', '🇵🇹'),
  'ro': ('Română', '🇷🇴'),
  'sk': ('Slovenčina', '🇸🇰'),
  'sl': ('Slovenščina', '🇸🇮'),
  'sv': ('Svenska', '🇸🇪'),
  'ta': ('தமிழ்', '🇮🇳'),
  'te': ('తెలుగు', '🇮🇳'),
  'th': ('ไทย', '🇹🇭'),
  'tr': ('Türkçe', '🇹🇷'),
  'ur': ('اردو', '🇵🇰'),
  'zh-Hant': ('繁體中文', '🇹🇼'),
};

/// Jméno jazyka rozhraní v něm samém (nepřekládá se).
String homeLanguageName(String code) =>
    _homeOnly[code]?.$1 ??
    kLanguageName[Language.values.asNameMap()[code]] ??
    code;

/// Vlajka jazyka rozhraní.
String homeLanguageFlag(String code) =>
    _homeOnly[code]?.$2 ??
    kLanguageFlag[Language.values.asNameMap()[code]] ??
    '🏳️';

/// `Locale` z kódu jazyka rozhraní: `cs` → cs, `pt-PT` → pt_PT,
/// `zh-Hant` → zh s písmem Hant.
Locale localeOfCode(String code) {
  final parts = code.split('-');
  if (parts.length == 1) return Locale(parts[0]);
  return parts[1].length == 4
      ? Locale.fromSubtags(languageCode: parts[0], scriptCode: parts[1])
      : Locale(parts[0], parts[1]);
}

/// Přípona souboru ARB pro kód: `pt-PT` → `pt_PT`.
String arbSuffix(String code) => code.replaceAll('-', '_');

/// Jazyk UI = jazyk packu, který dítě hraje (německé dítě vidí německé
/// menu), pokud profil nemá vlastní jazyk rodiny ([ProfileService.home]).
/// HomeShell ho mění spolu s jazykem; MaterialApp poslouchá obojí.
class AppLanguage extends ValueNotifier<Language> {
  AppLanguage._() : super(Language.en);
  static final AppLanguage instance = AppLanguage._();

  /// Kód jazyka rozhraní (`cs`, `uk`…).
  String get code {
    final home = ProfileService.instance.home.value;
    return kHomeLanguages.contains(home) ? home : value.name;
  }

  Locale get locale => localeOfCode(code);
}

extension L10nContext on BuildContext {
  AppLocalizations get l => AppLocalizations.of(this);
}

/// Název a podmínka odznaku v jazyce UI.
extension GameBadgeL10n on GameBadge {
  String title(AppLocalizations l) => switch (this) {
        GameBadge.firstSwype => l.badgeFirstSwype,
        GameBadge.noMistake => l.badgeNoMistake,
        GameBadge.explorer => l.badgeExplorer,
        GameBadge.collectorHalf => l.badgeCollectorHalf,
        GameBadge.collectorAll => l.badgeCollectorAll,
        GameBadge.nightOwl => l.badgeNightOwl,
        GameBadge.earlyBird => l.badgeEarlyBird,
        GameBadge.fourSeasons => l.badgeFourSeasons,
        GameBadge.wordsmith10 => l.badgeWordsmith10,
        GameBadge.wordsmith25 => l.badgeWordsmith25,
        GameBadge.wordsmith50 => l.badgeWordsmith50,
        GameBadge.poet => l.badgePoet,
        GameBadge.listener => l.badgeListener,
        GameBadge.persistent => l.badgePersistent,
        GameBadge.expedition => l.badgeExpedition,
        GameBadge.host => l.badgeHost,
        GameBadge.cuddler => l.badgeCuddler,
        GameBadge.wishMaker => l.badgeWishMaker,
        GameBadge.friendOfAll => l.badgeFriendOfAll,
      };

  String condition(AppLocalizations l) => switch (this) {
        GameBadge.firstSwype => l.badgeFirstSwypeHow,
        GameBadge.noMistake => l.badgeNoMistakeHow,
        GameBadge.explorer => l.badgeExplorerHow,
        GameBadge.collectorHalf => l.badgeCollectorHalfHow,
        GameBadge.collectorAll => l.badgeCollectorAllHow,
        GameBadge.nightOwl => l.badgeNightOwlHow,
        GameBadge.earlyBird => l.badgeEarlyBirdHow,
        GameBadge.fourSeasons => l.badgeFourSeasonsHow,
        GameBadge.wordsmith10 => l.badgeWordsmith10How,
        GameBadge.wordsmith25 => l.badgeWordsmith25How,
        GameBadge.wordsmith50 => l.badgeWordsmith50How,
        GameBadge.poet => l.badgePoetHow,
        GameBadge.listener => l.badgeListenerHow,
        GameBadge.persistent => l.badgePersistentHow,
        GameBadge.expedition => l.badgeExpeditionHow,
        GameBadge.host => l.badgeHostHow,
        GameBadge.cuddler => l.badgeCuddlerHow,
        GameBadge.wishMaker => l.badgeWishMakerHow,
        GameBadge.friendOfAll => l.badgeFriendOfAllHow,
      };
}

/// Název ostrova (pásma) v jazyce UI.
String islandName(AppLocalizations l, String band) => switch (band) {
      'b' => l.storeIslandB,
      'c' => l.storeIslandC,
      _ => l.storeIslandA,
    };

/// Název a popis produktu z katalogu v jazyce UI (jen rodičovský koutek).
/// Jazyk produktu se píše svým vlastním jménem ([kLanguageName]).
extension CatalogProductL10n on CatalogProduct {
  String get _languageName => kLanguageName[language] ?? '';

  String title(AppLocalizations l) => switch (type) {
        ProductType.island =>
          l.storeProductIsland(islandName(l, band ?? 'b'), _languageName),
        ProductType.language => l.storeProductLanguage(_languageName),
        ProductType.bundle => l.storeProductBundle,
        ProductType.parent => l.storeProductParent,
        // Tematické balíčky a hlas zatím v katalogu nejsou (§8).
        ProductType.theme || ProductType.voice => id,
      };

  String description(AppLocalizations l) => switch (type) {
        ProductType.island => l.storeProductIslandDesc(_languageName),
        ProductType.language =>
          l.storeProductLanguageDesc(islandName(l, band ?? 'a'), _languageName),
        ProductType.bundle => l.storeProductBundleDesc,
        ProductType.parent => l.storeProductParentDesc,
        ProductType.theme || ProductType.voice => '',
      };
}

extension SeasonL10n on Season {
  String label(AppLocalizations l) => switch (this) {
        Season.spring => l.seasonSpring,
        Season.summer => l.seasonSummer,
        Season.autumn => l.seasonAutumn,
        Season.winter => l.seasonWinter,
      };
}
