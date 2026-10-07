import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/lessons.dart';
import '../data/models/content_pack.dart';
import '../store/catalog.dart';
import '../store/store_config.dart';
import '../store/store_service.dart';
import 'progress_service.dart';

/// Co má rodina odemčené (`docs/MONETIZATION.md` §5–§6).
///
/// Dokud je obchod vypnutý ([enabled] == false, výchozí stav —
/// [StoreConfig.enabled]), je odemčené všechno a služba jen jednou zapíše
/// jazyk zdarma. Se zapnutým obchodem:
///
/// - zdarma je Ostrov písmenek (pásmo `a`) v [freeLanguage] a v jazycích,
///   které už některé dítě hrálo ([grandfathered]);
/// - všechno ostatní odemykají vlastněné produkty podle `unlocks` v katalogu.
///
/// Stav je globální pro zařízení (ne per profil) a drží se lokálně
/// (`sk.store.*`) — bez sítě platí poslední známý stav. Nic, co dítě už má
/// (postup, nálepky, batoh, knížka), se zamčením neztrácí; zámek jen brání
/// spustit jednotku.
class EntitlementService extends ChangeNotifier {
  EntitlementService._();
  static final EntitlementService instance = EntitlementService._();

  /// Samostatná instance pro testy logiky (bez singletonu).
  @visibleForTesting
  EntitlementService.forTest();

  static const _kOwned = 'sk.store.owned';
  static const _kFreeLang = 'sk.store.freeLang';
  static const _kGrandfathered = 'sk.store.grandfathered';
  static const _kGrandfatherDone = 'sk.store.grandfatherDone';
  static const _kDebugEnabled = 'sk.store.debugEnabled';

  static final _progressKey = RegExp(r'^sk\.(?:p\d+\.)?progress\.(.+)$');

  SharedPreferences? _prefs;
  StoreCatalog _catalog = StoreCatalog.empty;
  final Set<String> _owned = {};
  final Set<Language> _grandfathered = {};
  Language? _freeLanguage;
  bool _debugEnabled = false;

  /// Obchod, přes který se kupuje. Fáze 1 zná jen [FakeStore].
  StoreService store = FakeStore();

  StoreCatalog get catalog => _catalog;

  /// Načte stav z úložiště. [deviceLanguage] = kód jazyka zařízení,
  /// [onboardedLanguage] = jazyk, který dítě už hraje (starší instalace).
  /// Opakované volání = „restart appky" (testy).
  Future<void> load({
    StoreCatalog? catalog,
    String? deviceLanguage,
    Language? onboardedLanguage,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    _prefs = prefs;
    _catalog = catalog ?? await StoreCatalog.load();
    _owned
      ..clear()
      ..addAll(prefs.getStringList(_kOwned) ?? const []);
    _grandfathered
      ..clear()
      ..addAll(_languages(prefs.getStringList(_kGrandfathered) ?? const []));
    _freeLanguage = Language.values.asNameMap()[prefs.getString(_kFreeLang)];
    _debugEnabled = kDebugMode && (prefs.getBool(_kDebugEnabled) ?? false);

    // Jazyk zdarma: jazyk zařízení, když ho appka umí; jinak jazyk, který
    // dítě už hraje. Jinak počká na onboarding ([claimFreeLanguage]).
    if (_freeLanguage == null) {
      final device = Language.values.asNameMap()[deviceLanguage ?? ''];
      final free = device ?? onboardedLanguage;
      if (free != null) _writeFreeLanguage(free);
    }
    if (enabled) _grandfatherOnce();
    notifyListeners();
  }

  static Iterable<Language> _languages(Iterable<String> names) sync* {
    final byName = Language.values.asNameMap();
    for (final n in names) {
      final l = byName[n];
      if (l != null) yield l;
    }
  }

  // ── Vypínač ────────────────────────────────────────────────────────────────

  /// Platí zámky? Bez obchodu (výchozí) je všechno odemčené.
  bool get enabled => _debugEnabled || StoreConfig.locksApply();

  /// Ladicí simulace zapnutého obchodu (rodičovský koutek v debug buildu,
  /// testy). V release buildu nejde zapnout.
  bool get debugEnabled => _debugEnabled;

  set debugEnabled(bool value) {
    if (!kDebugMode || value == _debugEnabled) return;
    _debugEnabled = value;
    _prefs?.setBool(_kDebugEnabled, value);
    if (enabled) _grandfatherOnce();
    notifyListeners();
  }

  /// Ladění: zapomene lokální nákupy (ne jazyk zdarma ani grandfathering).
  void debugForgetPurchases() {
    if (!kDebugMode) return;
    _owned.clear();
    _prefs?.remove(_kOwned);
    notifyListeners();
  }

  // ── Zdarma ─────────────────────────────────────────────────────────────────

  /// Jazyk, jehož Ostrov písmenek je zdarma. Zapisuje se jednou provždy,
  /// aby změna jazyka telefonu neodemykala další jazyk.
  Language? get freeLanguage => _freeLanguage;

  /// Jazyky hrané před zavedením plateb — pásmo `a` jim zůstává navždy.
  Set<Language> get grandfathered => Set.unmodifiable(_grandfathered);

  /// Onboarding: zařízení má jazyk, který appka neumí → zdarma je jazyk,
  /// který si dítě vybralo. Když už jazyk zdarma je, nedělá nic.
  void claimFreeLanguage(Language lang) {
    if (_freeLanguage != null) return;
    _writeFreeLanguage(lang);
    notifyListeners();
  }

  void _writeFreeLanguage(Language lang) {
    _freeLanguage = lang;
    _prefs?.setString(_kFreeLang, lang.name);
  }

  /// První start s obchodem: každý jazyk, ve kterém má kterýkoli profil
  /// aspoň jednu hvězdu, zůstane odemčený (§6). Běží právě jednou.
  void _grandfatherOnce() {
    final prefs = _prefs;
    if (prefs == null || (prefs.getBool(_kGrandfatherDone) ?? false)) return;
    final byName = Language.values.asNameMap();
    for (final key in prefs.getKeys()) {
      final packId = _progressKey.firstMatch(key)?.group(1);
      if (packId == null) continue;
      final lang = byName[packId.split('-').first];
      if (lang == null) continue;
      try {
        final completed =
            (jsonDecode(prefs.getString(key) ?? '{}') as Map)['completed'];
        if (completed is Map && completed.values.any((s) => s is int && s > 0)) {
          _grandfathered.add(lang);
        }
      } catch (_) {
        // Poškozený záznam postupu → žádné hvězdy.
      }
    }
    prefs.setStringList(
        _kGrandfathered, [for (final l in _grandfathered) l.name]);
    prefs.setBool(_kGrandfatherDone, true);
  }

  // ── Co je odemčené ─────────────────────────────────────────────────────────

  /// Vlastněné produkty (id z katalogu).
  Set<String> get owned => Set.unmodifiable(_owned);

  bool owns(String productId) => _owned.contains(productId);

  Iterable<ProductUnlocks> get _ownedUnlocks sync* {
    for (final id in _owned) {
      final product = _catalog.byId(id);
      if (product != null) yield product.unlocks;
    }
  }

  /// Je pásmo [band] jazyka [lang] zdarma (bez nákupu)?
  bool isFree(Language lang, String band) =>
      band == kDefaultBand &&
      (lang == _freeLanguage || _grandfathered.contains(lang));

  /// Je odemčené pásmo [band] jazyka [lang]?
  bool bandUnlocked(Language lang, String band) =>
      !enabled ||
      isFree(lang, band) ||
      _ownedUnlocks.any((u) => u.coversBand(lang, band));

  /// Je odemčený Ostrov písmenek jazyka — smí se jazyk nabídnout dítěti?
  bool languageUnlocked(Language lang) => bandUnlocked(lang, kDefaultBand);

  /// Je odemčená jednotka [unit] packu [pack]? Jednotka se štítkem
  /// `product` se řídí jen jím (tematický balíček), jinak svým pásmem.
  bool unlocked(ContentPack pack, Unit unit) {
    if (!enabled) return true;
    if (unit.product.isNotEmpty) {
      return _ownedUnlocks.any((u) => u.coversTag(pack.language, unit.product));
    }
    return bandUnlocked(pack.language, unit.band);
  }

  /// Funkce mimo obsah (např. `parent.plus`).
  bool hasFeature(String feature) =>
      !enabled || _ownedUnlocks.any((u) => u.coversFeature(feature));

  /// Už produkt nic nepřidá — všechno, co odemyká, rodina má?
  bool redundant(CatalogProduct product) {
    if (!enabled || owns(product.id)) return true;
    if (_ownedUnlocks.any((u) => u.all)) return true;
    final u = product.unlocks;
    if (u.all || u.isEmpty) return false;
    final langs = u.languages.isEmpty ? Language.values.toSet() : u.languages;
    return langs.every((l) =>
            u.bands.every((b) => bandUnlocked(l, b)) &&
            u.tags.every((t) => _ownedUnlocks.any((o) => o.coversTag(l, t)))) &&
        u.features.every(hasFeature);
  }

  /// Indexy jednotek packu, které dítě smí hrát (v pořadí packu).
  List<int> playableUnits(ContentPack pack) => [
        for (var u = 0; u < pack.units.length; u++)
          if (unlocked(pack, pack.units[u])) u,
      ];

  /// Jednotka je otevřená ke hře: je odemčená a předchozí hratelná jednotka
  /// je dokončená (první vždy). Zamčené jednotky uprostřed packu se
  /// přeskakují, aby za nimi cesta nezůstala zavřená.
  bool unitOpen(ContentPack pack, int unitIndex) {
    final progress = ProgressService.instance;
    if (!enabled) return progress.isUnitUnlocked(pack, unitIndex);
    final playable = playableUnits(pack);
    final at = playable.indexOf(unitIndex);
    if (at < 0) return false;
    return at == 0 || progress.isUnitCompleted(pack, playable[at - 1]);
  }

  /// Smí dítě hrát lekci [lesson]? Ano, když je z odemčené jednotky, když ji
  /// už má dohranou (opakování toho, co umí, zůstává), nebo když v packu
  /// vůbec není (složené kolo).
  bool lessonPlayable(ContentPack pack, Lesson lesson) {
    if (!enabled) return true;
    for (final unit in pack.units) {
      if (!unit.lessons.any((l) => l.id == lesson.id)) continue;
      return unlocked(pack, unit) ||
          ProgressService.instance.isCompleted(pack.id, lesson.id);
    }
    return true;
  }

  // ── Jazyky pro dítě ────────────────────────────────────────────────────────

  /// Jazyky, které smí vidět dítě (vlajky v pickeru a v onboardingu): jen ty
  /// s odemčeným Ostrovem písmenek. Než je známý jazyk zdarma (první start
  /// na zařízení s jazykem, který appka neumí), nabízí se všechny — vybraný
  /// se stane jazykem zdarma.
  List<Language> get childLanguages {
    if (!enabled || _freeLanguage == null) return Language.values;
    return [
      for (final l in Language.values)
        if (languageUnlocked(l)) l,
    ];
  }

  /// [wanted], když ho dítě smí hrát; jinak jazyk zdarma (nebo první
  /// odemčený).
  Language allowed(Language wanted) {
    final langs = childLanguages;
    if (langs.contains(wanted) || langs.isEmpty) return wanted;
    final free = _freeLanguage;
    return free != null && langs.contains(free) ? free : langs.first;
  }

  // ── Nákupy ─────────────────────────────────────────────────────────────────

  /// Koupí produkt přes [store]; úspěch se uloží a platí hned.
  Future<PurchaseResult> buy(String productId) async {
    final result = await store.buy(productId);
    if (result == PurchaseResult.purchased) _grant({productId});
    return result;
  }

  /// Obnoví nákupy z účtu. Jen přidává — nedostupný obchod nic neodebere
  /// (offline platí poslední známý stav).
  Future<void> restore() async => _grant(await store.restore());

  void _grant(Set<String> ids) {
    final before = _owned.length;
    _owned.addAll(ids);
    if (_owned.length == before) return;
    _prefs?.setStringList(_kOwned, _owned.toList()..sort());
    notifyListeners();
  }
}
