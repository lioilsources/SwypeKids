import 'package:flutter/foundation.dart';

/// Hlavní vypínač monetizace (`docs/MONETIZATION.md`, fáze 1).
///
/// Dokud je [enabled] `false`, appka se chová přesně jako bez obchodu: všechno
/// je odemčené a nikde se nerenderuje nic o nákupech. První vydání v App Store
/// jde s vypnutým obchodem (rozhodnutí §8.7); zamykání prověřují jen testy a
/// ladicí přepínač v rodičovském koutku (`kDebugMode`).
class StoreConfig {
  const StoreConfig._();

  /// Zapnout až s fází 2 (skutečný obchod) a prvním placeným obsahem.
  static const bool enabled = false;

  /// Platformy bez obchodu mají všechen obsah zdarma (Linux, §4).
  static bool isFreePlatform(TargetPlatform platform) =>
      platform == TargetPlatform.linux;

  /// Platí zámky? [flag] = [enabled] (parametr kvůli testům).
  static bool locksApply({
    bool flag = enabled,
    TargetPlatform? platform,
  }) =>
      flag && !isFreePlatform(platform ?? defaultTargetPlatform);
}
