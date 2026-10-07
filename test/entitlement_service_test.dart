import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swype_kids/data/lessons.dart';
import 'package:swype_kids/services/achievement_service.dart';
import 'package:swype_kids/services/entitlement_service.dart';
import 'package:swype_kids/services/progress_service.dart';
import 'package:swype_kids/store/catalog.dart';
import 'package:swype_kids/store/store_config.dart';
import 'package:swype_kids/store/store_service.dart';

import 'store_fixture.dart';

String _stars(Map<String, int> completed) =>
    jsonEncode({'v': 1, 'completed': completed});

void main() {
  final service = EntitlementService.instance;
  final cs = storePack(Language.cs);
  final en = storePack(Language.en);

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    await ProgressService.init();
  });
  tearDown(storeOff);

  test('obchod je ve výchozím stavu vypnutý a Linux je vždy zdarma', () {
    expect(StoreConfig.enabled, isFalse,
        reason: 'první vydání jde bez obchodu (MONETIZATION.md §8.7)');
    expect(StoreConfig.locksApply(), isFalse);
    expect(
        StoreConfig.locksApply(flag: true, platform: TargetPlatform.iOS), isTrue);
    expect(StoreConfig.locksApply(flag: true, platform: TargetPlatform.linux),
        isFalse);
  });

  test('vypnutý obchod: všechno odemčené, jako dnes', () async {
    await service.load(catalog: testCatalog(), deviceLanguage: 'cs');
    expect(service.enabled, isFalse);
    for (final pack in [cs, en]) {
      expect(pack.units.every((u) => service.unlocked(pack, u)), isTrue);
      expect(service.playableUnits(pack), [0, 1, 2, 3, 4]);
    }
    expect(service.childLanguages, Language.values);
    expect(Language.values.every(service.languageUnlocked), isTrue);
    expect(service.allowed(Language.ja), Language.ja);
    expect(service.hasFeature('parent.plus'), isTrue);
    // Postup jednotek je beze změny lineární.
    expect(service.unitOpen(cs, 0), isTrue);
    expect(service.unitOpen(cs, 1), isFalse);
    ProgressService.instance.markCompleted(cs.id, 'cs-u1-l1', 3);
    expect(service.unitOpen(cs, 1), isTrue);
    expect(service.unitOpen(cs, 2), isFalse);
    // Služba funguje i bez načtení (testy obrazovek ji neinicializují).
    expect(EntitlementService.forTest().unlocked(cs, cs.units[4]), isTrue);
  });

  test('zapnutý obchod: zdarma je jen Ostrov písmenek jazyka zařízení',
      () async {
    await storeOn(deviceLanguage: 'cs');
    expect(service.freeLanguage, Language.cs);
    expect(service.playableUnits(cs), [0, 1]);
    expect(service.unlocked(cs, cs.units[2]), isFalse); // tematický balíček
    expect(service.unlocked(cs, cs.units[3]), isFalse); // Ostrov slov
    expect(service.playableUnits(en), isEmpty);
    expect(service.childLanguages, [Language.cs]);
    expect(service.languageUnlocked(Language.en), isFalse);
    expect(service.allowed(Language.en), Language.cs);
    expect(service.hasFeature('parent.plus'), isFalse);
  });

  test('jazyk zdarma se zapíše jednou provždy', () async {
    await service.load(catalog: testCatalog(), deviceLanguage: 'cs');
    expect(service.freeLanguage, Language.cs);
    // Rodič přepne telefon do němčiny → další jazyk se neodemkne.
    await service.load(catalog: testCatalog(), deviceLanguage: 'de');
    expect(service.freeLanguage, Language.cs);
    service.claimFreeLanguage(Language.en);
    expect(service.freeLanguage, Language.cs);
    final prefs = await SharedPreferences.getInstance();
    expect(prefs.getString('sk.store.freeLang'), 'cs');
  });

  test('jazyk zařízení, který appka neumí: zdarma je jazyk z onboardingu',
      () async {
    await storeOn(deviceLanguage: 'sk');
    expect(service.freeLanguage, isNull);
    // Než je rozhodnuto, onboarding nabídne všechny jazyky.
    expect(service.childLanguages, Language.values);
    service.claimFreeLanguage(Language.de);
    expect(service.freeLanguage, Language.de);
    expect(service.childLanguages, [Language.de]);
    service.claimFreeLanguage(Language.en);
    await service.load(catalog: testCatalog(), deviceLanguage: 'sk');
    expect(service.freeLanguage, Language.de);
  });

  test('starší instalace bez jazyka zařízení: zdarma je hraný jazyk',
      () async {
    await storeOn(deviceLanguage: 'sk', onboardedLanguage: Language.it);
    expect(service.freeLanguage, Language.it);
  });

  test('koupě přes FakeStore odemkne ostrov a přežije restart', () async {
    final store = await storeOn();
    expect(service.unlocked(cs, cs.units[3]), isFalse);

    // Zrušená koupě nic neodemkne.
    store.nextResult = PurchaseResult.cancelled;
    expect(await service.buy('island.cs.b'), PurchaseResult.cancelled);
    expect(service.owns('island.cs.b'), isFalse);

    var notified = 0;
    void listener() => notified++;
    service.addListener(listener);
    expect(await service.buy('island.cs.b'), PurchaseResult.purchased);
    service.removeListener(listener);
    expect(notified, 1);
    expect(service.owns('island.cs.b'), isTrue);
    expect(service.playableUnits(cs), [0, 1, 3]);
    // Ostrov je po jazycích: anglický Ostrov slov zůstává zamčený.
    expect(service.bandUnlocked(Language.en, 'b'), isFalse);

    // Restart: stav se načte z úložiště (jiný obchod, žádná síť).
    await storeOn(store: FakeStore(isAvailable: false));
    expect(service.owns('island.cs.b'), isTrue);
    expect(service.playableUnits(cs), [0, 1, 3]);
  });

  test('další jazyk odemkne jen svůj Ostrov písmenek', () async {
    await storeOn();
    await service.buy(StoreCatalog.languageProductId(Language.en));
    expect(service.playableUnits(en), [0, 1]);
    expect(service.childLanguages, [Language.cs, Language.en]);
    expect(service.allowed(Language.en), Language.en);
  });

  test('tematický balíček je jedna položka pro všechny jazyky', () async {
    await storeOn();
    await service.buy(kThemeTag);
    // Jednotky se štítkem balíčku se odemknou v každém packu, i v jazyce,
    // jehož Ostrov písmenek rodina nemá; pásma se tím nemění.
    expect(service.playableUnits(cs), [0, 1, 2]);
    expect(service.playableUnits(en), [2]);
    expect(service.unlocked(en, en.units[2]), isTrue);
    expect(service.bandUnlocked(Language.cs, 'b'), isFalse);
    // Jazyk se dítěti nabídne, až když má Ostrov písmenek.
    expect(service.childLanguages, [Language.cs]);
  });

  test('„Vše napořád" odemkne všechno ve všech jazycích', () async {
    await storeOn();
    await service.buy('all.forever');
    for (final pack in [cs, en]) {
      expect(service.playableUnits(pack), [0, 1, 2, 3, 4]);
    }
    expect(service.childLanguages, Language.values);
    expect(service.hasFeature('parent.plus'), isTrue);
    expect(
        service.catalog.products.every(service.redundant), isTrue);
  });

  test('obnovení nákupů přidává z účtu a offline nic neodebere', () async {
    final store = await storeOn(store: FakeStore(purchased: {'island.cs.c'}));
    expect(service.owns('island.cs.c'), isFalse);
    await service.restore();
    expect(service.owns('island.cs.c'), isTrue);
    store.isAvailable = false;
    await service.restore();
    expect(service.owns('island.cs.c'), isTrue);
    expect(await service.buy('island.cs.b'), PurchaseResult.failed);
    expect(service.owns('island.cs.b'), isFalse);
  });

  test('grandfathering: hrané jazyky mají Ostrov písmenek navždy', () async {
    SharedPreferences.setMockInitialValues({
      // profil 1 hrál anglicky, profil 2 německy; ve španělštině jen otevřel mapu
      'sk.progress.en-US': _stars({'en-u1-l1': 2}),
      'sk.p2.progress.de-DE': _stars({'de-u1-l1': 3}),
      'sk.progress.es-ES': _stars({}),
      'sk.progress.rozbity': 'není json',
    });
    await ProgressService.init();
    // Verze bez obchodu nic nezapisuje…
    await service.load(catalog: testCatalog(), deviceLanguage: 'cs');
    expect(service.grandfathered, isEmpty);
    // …první start s obchodem ano.
    await storeOn();
    expect(service.grandfathered, {Language.en, Language.de});
    expect(service.childLanguages,
        [Language.cs, Language.en, Language.de]);
    expect(service.playableUnits(en), [0, 1]);
    // Nové ostrovy jsou placené pro všechny stejně.
    expect(service.bandUnlocked(Language.en, 'b'), isFalse);
    expect(service.languageUnlocked(Language.es), isFalse);

    // Jen jednou: hvězda ve francouzštině po zavedení plateb už jazyk
    // neodemkne, a zapsané jazyky přežijí restart.
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('sk.progress.fr-FR', _stars({'fr-u1-l1': 3}));
    await storeOn();
    expect(service.grandfathered, {Language.en, Language.de});
    expect(prefs.getStringList('sk.store.grandfathered'), ['en', 'de']);
  });

  test('zamčená jednotka uprostřed packu nezavře cestu za sebou', () async {
    await storeOn();
    await service.buy('island.cs.b');
    final p = ProgressService.instance;
    expect(service.unitOpen(cs, 0), isTrue);
    expect(service.unitOpen(cs, 3), isFalse);
    p.markCompleted(cs.id, 'cs-u1-l1', 3);
    p.markCompleted(cs.id, 'cs-u2-l1', 3);
    expect(service.unitOpen(cs, 2), isFalse); // tematický balíček rodina nemá
    expect(service.unitOpen(cs, 3), isTrue); // Ostrov slov navazuje na u2
    expect(service.unitOpen(cs, 4), isFalse);
  });

  test('naučená lekce se smí opakovat, i když je její jednotka zamčená',
      () async {
    await storeOn();
    final locked = cs.units[3].lessons.single;
    expect(service.lessonPlayable(cs, cs.units[0].lessons.single), isTrue);
    expect(service.lessonPlayable(cs, locked), isFalse);
    ProgressService.instance.markCompleted(cs.id, locked.id, 2);
    expect(service.lessonPlayable(cs, locked), isTrue);
    // Složené kolo mimo pack (dárek zvířátku) projde vždy.
    expect(
        service.lessonPlayable(
            cs,
            const Lesson(
                id: 'jinde', unlocked: ['M', 'A'], target: 'MA',
                display: 'MA', hint: '👩', label: 'MA')),
        isTrue);
  });

  test('„všechny nálepky" počítá jen jednotky, ke kterým se dítě dostane',
      () async {
    await storeOn();
    final p = ProgressService.instance;
    p.addCollectible(cs.id, '🐭');
    expect(
        AchievementService.instance
            .check(const ProgressChanged(), cs)
            .map((b) => b.name),
        containsAll(['explorer', 'collectorHalf']));
    expect(p.hasBadge('collectorAll'), isFalse);
    p.addCollectible(cs.id, '🐯');
    AchievementService.instance.check(const ProgressChanged(), cs);
    expect(p.hasBadge('collectorAll'), isTrue);
  });

  test('smazání profilu 1 nesmaže nákupy ani jazyk zdarma', () async {
    await storeOn();
    await service.buy('island.cs.b');
    await ProgressService.wipeProfile(1);
    await storeOn();
    expect(service.freeLanguage, Language.cs);
    expect(service.owns('island.cs.b'), isTrue);
  });
}
