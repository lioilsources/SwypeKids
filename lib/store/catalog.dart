import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;

import '../data/lessons.dart';

/// Druh produktu v katalogu (`docs/MONETIZATION.md` §3).
enum ProductType { island, language, theme, voice, parent, bundle }

/// Co produkt odemyká — výslovně, aby šlo přidat balíček bez změny kódu:
/// buď všechno ([all]), nebo pásma ([bands]) / štítky jednotek ([tags],
/// `unit.product`) ve vyjmenovaných jazycích ([languages]; prázdné = ve
/// všech), případně funkce mimo obsah ([features], např. `parent.plus`).
class ProductUnlocks {
  final bool all;
  final Set<Language> languages;
  final Set<String> bands;
  final Set<String> tags;
  final Set<String> features;

  const ProductUnlocks({
    this.all = false,
    this.languages = const {},
    this.bands = const {},
    this.tags = const {},
    this.features = const {},
  });

  factory ProductUnlocks.fromJson(Map<String, dynamic> json) => ProductUnlocks(
        all: json['all'] as bool? ?? false,
        languages: {
          for (final l in (json['languages'] as List?) ?? const [])
            Language.values.byName(l as String),
        },
        bands: ((json['bands'] as List?) ?? const []).cast<String>().toSet(),
        tags: ((json['tags'] as List?) ?? const []).cast<String>().toSet(),
        features:
            ((json['features'] as List?) ?? const []).cast<String>().toSet(),
      );

  bool get isEmpty =>
      !all && bands.isEmpty && tags.isEmpty && features.isEmpty;

  bool _inLanguage(Language lang) =>
      languages.isEmpty || languages.contains(lang);

  /// Odemyká pásmo [band] jazyka [lang]?
  bool coversBand(Language lang, String band) =>
      all || (bands.contains(band) && _inLanguage(lang));

  /// Odemyká jednotky se štítkem [tag] (`unit.product`) v jazyce [lang]?
  bool coversTag(Language lang, String tag) =>
      all || (tags.contains(tag) && _inLanguage(lang));

  bool coversFeature(String feature) => all || features.contains(feature);
}

/// Jedna položka katalogu. Název a popis se skládají z ARB klíčů podle
/// [type] (`CatalogProductL10n` v `ui/l10n.dart`), cena přichází z obchodu.
class CatalogProduct {
  /// Stabilní id shodné s id v App Store Connect / Play Console.
  final String id;
  final ProductType type;

  /// Pořadí v rodičovském koutku (menší výš).
  final int order;
  final ProductUnlocks unlocks;

  const CatalogProduct({
    required this.id,
    required this.type,
    this.order = 0,
    this.unlocks = const ProductUnlocks(),
  });

  factory CatalogProduct.fromJson(Map<String, dynamic> json) => CatalogProduct(
        id: json['id'] as String,
        type: ProductType.values.byName(json['type'] as String),
        order: json['order'] as int? ?? 0,
        unlocks: ProductUnlocks.fromJson(
            ((json['unlocks'] as Map?) ?? const {}).cast<String, dynamic>()),
      );

  /// Jazyk produktu, když odemyká právě jeden (ostrov, jazyk).
  Language? get language =>
      unlocks.languages.length == 1 ? unlocks.languages.single : null;

  /// Pásmo produktu, když odemyká právě jedno (ostrov, jazyk).
  String? get band => unlocks.bands.length == 1 ? unlocks.bands.single : null;
}

/// Katalog produktů z `assets/store/catalog.json`.
class StoreCatalog {
  final int schemaVersion;
  final List<CatalogProduct> products;

  const StoreCatalog({this.schemaVersion = 1, this.products = const []});

  static const empty = StoreCatalog();
  static const assetPath = 'assets/store/catalog.json';

  /// Produkt, který odemyká Ostrov písmenek jazyka — odvozuje se z jazyka,
  /// do packu se nepíše.
  static String languageProductId(Language lang) => 'lang.${lang.name}';

  /// Produkt ostrova (pásma `b`, `c`) jazyka.
  static String islandProductId(Language lang, String band) =>
      'island.${lang.name}.$band';

  factory StoreCatalog.fromJson(Map<String, dynamic> json) => StoreCatalog(
        schemaVersion: json['schemaVersion'] as int? ?? 1,
        products: [
          for (final p in (json['products'] as List?) ?? const [])
            CatalogProduct.fromJson((p as Map).cast<String, dynamic>()),
        ]..sort((a, b) => a.order.compareTo(b.order)),
      );

  factory StoreCatalog.parse(String raw) =>
      StoreCatalog.fromJson((jsonDecode(raw) as Map).cast<String, dynamic>());

  /// Načte katalog z assetů; rozbitý katalog = prázdný (nic se neprodává,
  /// zdarma a už koupené podle uloženého stavu platí dál).
  static Future<StoreCatalog> load() async {
    try {
      final bytes = await rootBundle.load(assetPath);
      return StoreCatalog.parse(utf8.decode(
          bytes.buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes)));
    } catch (e) {
      // ignore: avoid_print
      print('StoreCatalog: load failed: $e');
      return empty;
    }
  }

  CatalogProduct? byId(String id) {
    for (final p in products) {
      if (p.id == id) return p;
    }
    return null;
  }

  /// Je štítek jednotky (`unit.product`) v katalogu — jako id produktu nebo
  /// jako štítek, který některý produkt odemyká?
  bool knowsTag(String tag) => products
      .any((p) => p.id == tag || p.unlocks.tags.contains(tag));
}
