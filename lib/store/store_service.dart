/// Produkt tak, jak ho vrátil obchod: id a cena v měně účtu (už zformátovaná
/// obchodem — appka cenu nikdy neskládá ani nemá natvrdo).
class StoreOffer {
  final String id;
  final String price;

  const StoreOffer({required this.id, required this.price});
}

enum PurchaseResult { purchased, cancelled, failed }

/// Rozhraní obchodu. Fáze 2 ho naplní nad `in_app_purchase` (StoreKit 2 /
/// Play Billing); do té doby existuje jen [FakeStore].
abstract class StoreService {
  /// Je obchod na zařízení dostupný (síť, účet, platforma)?
  Future<bool> get available;

  /// Ceny pro produkty [ids]; které obchod nezná, ty ve výsledku chybí.
  Future<List<StoreOffer>> loadProducts(Set<String> ids);

  /// Spustí koupi; `purchased` = produkt patří účtu.
  Future<PurchaseResult> buy(String productId);

  /// Produkty, které účet už vlastní (obnovení nákupů, ověření při startu).
  Future<Set<String>> restore();
}

/// Obchod bez sítě a bez peněz: testy, Linux a ladicí přepínač v rodičovském
/// koutku. „Účet" žije jen v paměti; skriptem jde nasimulovat zrušenou nebo
/// neúspěšnou koupi a nedostupný obchod.
class FakeStore implements StoreService {
  FakeStore({
    Set<String> purchased = const {},
    this.price = '0,99',
    this.isAvailable = true,
  }) : account = {...purchased};

  /// Co „účet" vlastní (přežije smazání lokálního stavu appky → restore).
  final Set<String> account;

  /// Cena, kterou obchod hlásí u každého produktu.
  String price;
  bool isAvailable;

  /// Výsledek příští koupě (pak se vrací k `purchased`).
  PurchaseResult nextResult = PurchaseResult.purchased;

  /// Všechny pokusy o koupi v pořadí (pro testy).
  final List<String> attempts = [];

  @override
  Future<bool> get available async => isAvailable;

  @override
  Future<List<StoreOffer>> loadProducts(Set<String> ids) async => isAvailable
      ? [for (final id in ids) StoreOffer(id: id, price: price)]
      : const [];

  @override
  Future<PurchaseResult> buy(String productId) async {
    attempts.add(productId);
    if (!isAvailable) return PurchaseResult.failed;
    final result = nextResult;
    nextResult = PurchaseResult.purchased;
    if (result == PurchaseResult.purchased) account.add(productId);
    return result;
  }

  @override
  Future<Set<String>> restore() async =>
      isAvailable ? {...account} : const {};
}
