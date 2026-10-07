import 'dart:io';

import 'package:swype_kids/data/lessons.dart';
import 'package:swype_kids/data/models/content_pack.dart';
import 'package:swype_kids/services/entitlement_service.dart';
import 'package:swype_kids/store/catalog.dart';
import 'package:swype_kids/store/store_service.dart';

/// Štítek tematického balíčku v testech (v katalogu appky zatím žádný není).
const kThemeTag = 'theme.zima';

/// Malý pack se všemi druhy zamykání — skutečné packy zatím pásmo `b`
/// nemají: u1, u2 = Ostrov písmenek (`a`), u3 = tematický balíček uprostřed,
/// u4 = Ostrov slov (`b`), u5 = Ostrov vět (`c`).
ContentPack storePack(Language lang) {
  final id = lang.name;
  Unit unit(int n, String emoji, {String band = 'a', String product = ''}) =>
      Unit(
        id: '$id-u$n',
        title: 'Jednotka $n',
        icon: '⭐',
        reward: CollectibleReward(emoji: emoji, label: 'nálepka $n'),
        band: band,
        product: product,
        lessons: [
          Lesson(
              id: '$id-u$n-l1',
              unlocked: const ['M', 'A', 'T'],
              target: n.isEven ? 'TA' : 'MA',
              display: n.isEven ? 'TA' : 'MA',
              hint: '👩',
              label: 'slovo $n'),
        ],
      );
  return ContentPack(
    schemaVersion: 2,
    id: '$id-TEST',
    language: lang,
    title: 'Testovací ostrovy',
    units: [
      unit(1, '🐭'),
      unit(2, '🐯'),
      unit(3, '⛄', product: kThemeTag),
      unit(4, '🐻', band: 'b'),
      unit(5, '🦊', band: 'c'),
    ],
  );
}

/// Katalog appky z disku + jeden tematický balíček pro všechny jazyky.
StoreCatalog testCatalog() {
  final disk =
      StoreCatalog.parse(File(StoreCatalog.assetPath).readAsStringSync());
  return StoreCatalog(products: [
    ...disk.products,
    const CatalogProduct(
      id: kThemeTag,
      type: ProductType.theme,
      order: 500,
      unlocks: ProductUnlocks(tags: {kThemeTag}),
    ),
  ]);
}

/// „Start appky" se zapnutým obchodem: načte stav z prefs, zapne zámky a
/// dá službě čistý [FakeStore]. Vypnutí patří do tearDown ([storeOff]).
Future<FakeStore> storeOn({
  String? deviceLanguage = 'cs',
  Language? onboardedLanguage,
  FakeStore? store,
}) async {
  final service = EntitlementService.instance;
  await service.load(
    catalog: testCatalog(),
    deviceLanguage: deviceLanguage,
    onboardedLanguage: onboardedLanguage,
  );
  service.debugEnabled = true;
  return service.store = store ?? FakeStore();
}

void storeOff() => EntitlementService.instance.debugEnabled = false;
