import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swype_kids/data/lessons.dart';
import 'package:swype_kids/data/models/content_pack.dart';
import 'package:swype_kids/parent/parent_screen.dart';
import 'package:swype_kids/parent/store_debug_panel.dart';
import 'package:swype_kids/screens/collection_screen.dart';
import 'package:swype_kids/screens/game_screen.dart';
import 'package:swype_kids/screens/lesson_map_screen.dart';
import 'package:swype_kids/screens/onboarding_screen.dart';
import 'package:swype_kids/screens/win_screen.dart';
import 'package:swype_kids/services/entitlement_service.dart';
import 'package:swype_kids/services/pack_service.dart';
import 'package:swype_kids/services/profile_service.dart';
import 'package:swype_kids/services/progress_service.dart';
import 'package:swype_kids/widgets/key_widget.dart';
import 'package:swype_kids/widgets/keyboard_widget.dart';
import 'package:swype_kids/widgets/language_picker.dart';
import 'package:swype_kids/world/world_clock.dart';

import 'helpers.dart';
import 'store_fixture.dart';

/// Nic o nákupu v dětském UI: žádný text z obchodu, žádná cena.
void _expectNoStoreText(WidgetTester tester) {
  final words = RegExp(r'koupit|zdarma|obchod|nákup|0,99|Kč|\$|€',
      caseSensitive: false);
  for (final text in tester.widgetList<Text>(find.byType(Text))) {
    expect(words.hasMatch(text.data ?? ''), isFalse,
        reason: 'dítě vidí „${text.data}"');
  }
}

/// Jazyky, které picker dítěti nabízí. (Nabídka se v testu neotvírá —
/// s testovacím písmem položky přetékají.)
DropdownButton<Language> _picker(WidgetTester tester) =>
    tester.widget(find.byType(DropdownButton<Language>));

List<Language?> _offered(WidgetTester tester) =>
    [for (final item in _picker(tester).items!) item.value];

Finder _key(String letter) =>
    find.byWidgetPredicate((w) => w is KeyWidget && w.letter == letter);

Future<void> _swype(WidgetTester tester, List<String> letters) async {
  final gesture = await tester.startGesture(tester.getCenter(_key(letters[0])));
  await gesture.moveBy(const Offset(0, -2));
  await gesture.moveBy(const Offset(0, 2));
  await tester.pump();
  for (final l in letters.skip(1)) {
    await gesture.moveTo(tester.getCenter(_key(l)));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 150));
  }
  await gesture.up();
  await tester.pump();
}

void main() {
  final service = EntitlementService.instance;
  late ContentPack cs;

  setUpAll(() {
    cs = storePack(Language.cs);
    PackService.instance.seedCache(cs);
    PackService.instance.seedCache(storePack(Language.en));
  });

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    await ProfileService.init();
    await ProgressService.init();
    // Poledne: v noci by mapa spala a nálepky měly jiné pózy.
    WorldClockService.instance.debugNowOverride =
        () => DateTime(2026, 6, 15, 12);
  });
  tearDown(() {
    storeOff();
    WorldClockService.instance.debugNowOverride = null;
  });

  void bigScreen(WidgetTester tester) {
    tester.view.physicalSize = const Size(900, 2400);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);
  }

  Future<void> pumpMap(WidgetTester tester,
      {ValueChanged<Language>? onLanguage}) async {
    bigScreen(tester);
    await tester.pumpWidget(localizedApp(
      home: Scaffold(
        body: LessonMapScreen(
          language: Language.cs,
          onLanguageChanged: onLanguage ?? (_) {},
        ),
      ),
    ));
    await settle(tester, const Duration(milliseconds: 600));
  }

  Finder node(int unit) => find.byKey(ValueKey('lesson-cs-u$unit-l1'));
  final fog = find.byKey(const ValueKey('island-in-fog'));

  testWidgets('vypnutý obchod: mapa ukáže celý pack a žádný ostrov v mlze',
      (tester) async {
    await service.load(catalog: testCatalog(), deviceLanguage: 'cs');
    await pumpMap(tester);
    for (var u = 1; u <= 5; u++) {
      expect(node(u), findsOneWidget);
    }
    expect(fog, findsNothing);
    // Picker nabízí všech devět jazyků.
    expect(find.byType(LanguagePicker), findsOneWidget);
    expect(_offered(tester), Language.values);
  });

  testWidgets('zapnutý obchod: zamčené jednotky na mapě nejsou, další ostrov '
      'je v mlze a nejde na něj ťuknout', (tester) async {
    await storeOn();
    final p = ProgressService.instance;
    p.markCompleted(cs.id, 'cs-u1-l1', 3);
    p.markCompleted(cs.id, 'cs-u2-l1', 3);
    await pumpMap(tester);

    expect(node(1), findsOneWidget);
    expect(node(2), findsOneWidget);
    for (var u = 3; u <= 5; u++) {
      expect(node(u), findsNothing);
      expect(findText('Jednotka $u'), findsNothing);
    }
    // Tři zamčené jednotky = jeden ostrov v mlze, bez textu a bez akce.
    expect(fog, findsOneWidget);
    expect(
        tester
            .widgetList<Text>(
                find.descendant(of: fog, matching: find.byType(Text)))
            .map((t) => t.data),
        everyElement('🌫️'));
    expect(find.descendant(of: fog, matching: find.byType(GestureDetector)),
        findsNothing);
    _expectNoStoreText(tester);

    await tester.tap(fog, warnIfMissed: false);
    await settle(tester, const Duration(milliseconds: 600));
    expect(find.byType(GameScreen), findsNothing);

    // Odemčená jednotka jde spustit jako dřív.
    await tester.tap(node(2));
    await settle(tester, const Duration(milliseconds: 600));
    expect(find.byType(GameScreen), findsOneWidget);
    expect(find.byType(KeyboardWidget), findsOneWidget);
  });

  testWidgets('koupě v koutku se na mapě projeví hned', (tester) async {
    await storeOn();
    final p = ProgressService.instance;
    p.markCompleted(cs.id, 'cs-u1-l1', 3);
    p.markCompleted(cs.id, 'cs-u2-l1', 3);
    await pumpMap(tester);
    expect(node(4), findsNothing);

    await service.buy('island.cs.b');
    await settle(tester, const Duration(milliseconds: 400));
    expect(node(4), findsOneWidget);
    expect(fog, findsOneWidget); // tematický balíček a Ostrov vět zůstávají

    await service.buy('all.forever');
    await settle(tester, const Duration(milliseconds: 400));
    expect(node(5), findsOneWidget);
    expect(fog, findsNothing);
  });

  testWidgets('GameScreen zamčenou jednotku odmítne spustit', (tester) async {
    await storeOn();
    await tester.pumpWidget(localizedApp(
      home: Builder(
        builder: (context) => TextButton(
          onPressed: () => Navigator.of(context).push(MaterialPageRoute<void>(
            builder: (_) => GameScreen(pack: cs, unitIndex: 3),
          )),
          child: const Text('▶'),
        ),
      ),
    ));
    await tester.tap(findText('▶'));
    await tester.pump();
    expect(find.byType(KeyboardWidget), findsNothing);
    _expectNoStoreText(tester);
    await settle(tester, const Duration(milliseconds: 800));
    // Obrazovka se beze slova zavřela a nic nezapsala.
    expect(find.byType(GameScreen), findsNothing);
    expect(findText('▶'), findsOneWidget);
    expect(ProgressService.instance.totalStars(cs.id), 0);

    // Po koupi se táž jednotka spustí.
    await service.buy('island.cs.b');
    await tester.tap(findText('▶'));
    await settle(tester, const Duration(milliseconds: 800));
    expect(find.byType(KeyboardWidget), findsOneWidget);
  });

  testWidgets('procvičování: lekce ze zamčené jednotky ne, naučená ano',
      (tester) async {
    await storeOn();
    final locked = cs.units[3].lessons.single;
    Widget practice() => localizedApp(
          home: GameScreen(
            key: UniqueKey(),
            pack: cs,
            unitIndex: 0,
            practice: Unit(
              id: 'practice',
              title: 'Procvičování',
              icon: '🔁',
              reward: const CollectibleReward(emoji: '🔁'),
              lessons: [locked],
            ),
          ),
        );
    await tester.pumpWidget(practice());
    await settle(tester, const Duration(milliseconds: 400));
    expect(find.byType(KeyboardWidget), findsNothing);
    expect(find.byKey(const ValueKey('game-refused')), findsOneWidget);

    // Co dítě už umí, to mu zámek nevezme.
    ProgressService.instance.markCompleted(cs.id, locked.id, 3);
    await tester.pumpWidget(practice());
    await settle(tester, const Duration(milliseconds: 400));
    expect(find.byType(KeyboardWidget), findsOneWidget);
  });

  testWidgets('poslední odemčená jednotka zakončí ostrov oslavou',
      (tester) async {
    await storeOn();
    tester.view.physicalSize = const Size(1200, 900);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);
    ProgressService.instance.markCompleted(cs.id, 'cs-u1-l1', 3);

    await tester.pumpWidget(localizedApp(
      home: GameScreen(pack: cs, unitIndex: 1),
    ));
    await tester.pump(const Duration(milliseconds: 1000));
    await _swype(tester, ['T', 'A']);
    await settle(tester, const Duration(milliseconds: 2400));
    expect(find.byType(WinScreen), findsOneWidget);
    _expectNoStoreText(tester);
  });

  testWidgets('dětský picker nabízí jen odemčené jazyky', (tester) async {
    await storeOn();
    Language? picked;
    await pumpMap(tester, onLanguage: (l) => picked = l);
    expect(_offered(tester), [Language.cs]);
    _expectNoStoreText(tester);

    // Rodič přidá angličtinu → dítěti se objeví vlajka.
    await service.buy('lang.en');
    await settle(tester, const Duration(milliseconds: 400));
    expect(_offered(tester), [Language.cs, Language.en]);
    _picker(tester).onChanged!(Language.en);
    expect(picked, Language.en);
  });

  testWidgets('onboarding dalšího dítěte nabízí jen odemčené jazyky',
      (tester) async {
    await storeOn();
    await tester.pumpWidget(localizedApp(
      home: OnboardingScreen(initialLanguage: Language.en, onDone: (_) {}),
    ));
    await settle(tester, const Duration(milliseconds: 400));
    expect(find.byKey(const ValueKey('lang-cs')), findsOneWidget);
    expect(find.byKey(const ValueKey('lang-en')), findsNothing);
    expect(find.byKey(const ValueKey('lang-de')), findsNothing);
  });

  testWidgets('první start na zařízení s neznámým jazykem: onboarding nabídne '
      'všechny jazyky a zvolený je zdarma', (tester) async {
    await storeOn(deviceLanguage: 'sk');
    expect(service.freeLanguage, isNull);
    Language? done;
    await tester.pumpWidget(localizedApp(
      home: OnboardingScreen(
          initialLanguage: Language.en, onDone: (l) => done = l),
    ));
    await settle(tester, const Duration(milliseconds: 400));
    for (final l in Language.values) {
      expect(find.byKey(ValueKey('lang-${l.name}')), findsOneWidget);
    }
    await tester.tap(find.byKey(const ValueKey('lang-de')));
    for (var step = 0; step < 3; step++) {
      await tester.tap(find.byKey(const ValueKey('next')));
      await settle(tester, const Duration(milliseconds: 400));
    }
    expect(done, Language.de);
    expect(service.freeLanguage, Language.de);
    expect(service.childLanguages, [Language.de]);
  });

  testWidgets('Zvěřinec neukazuje zamčené ostrovy, získané nálepky ano',
      (tester) async {
    await storeOn();
    bigScreen(tester);
    final p = ProgressService.instance;
    p.addCollectible(cs.id, '🐭');
    p.addCollectible(cs.id, '🐻'); // nálepka z jednotky, která je teď zamčená
    await tester.pumpWidget(localizedApp(
      home: const Scaffold(body: CollectionScreen(language: Language.cs)),
    ));
    await settle(tester, const Duration(milliseconds: 600));
    expect(findText('Jednotka 1'), findsOneWidget);
    expect(findText('Jednotka 2'), findsOneWidget);
    expect(findText('Jednotka 3'), findsNothing);
    expect(findText('Jednotka 4'), findsOneWidget);
    expect(findText('Jednotka 5'), findsNothing);
    expect(findText('2/3'), findsOneWidget);
    _expectNoStoreText(tester);
  });

  testWidgets('rodičovský koutek: ladicí přepínač zapne zámky a koupě odemkne',
      (tester) async {
    bigScreen(tester);
    ProfileService.instance.complete(avatar: '🐼', name: 'Ema');
    await service.load(catalog: testCatalog(), deviceLanguage: 'cs');
    await tester.pumpWidget(localizedApp(
      home: const ParentScreen(language: Language.cs),
    ));
    await settle(tester, const Duration(milliseconds: 600));
    expect(find.byType(StoreDebugPanel), findsOneWidget);
    // Vypnutý obchod: žádná nabídka, jen přepínač.
    expect(find.byKey(const ValueKey('store-buy-island.cs.b')), findsNothing);
    expect(service.enabled, isFalse);

    await tester.ensureVisible(find.byKey(const ValueKey('store-debug-toggle')));
    await tester.tap(find.byKey(const ValueKey('store-debug-toggle')));
    await settle(tester, const Duration(milliseconds: 600));
    expect(service.enabled, isTrue);
    expect(service.unlocked(cs, cs.units[3]), isFalse);
    // Jazyk zařízení je zdarma, ostrov se dá koupit; název je lokalizovaný.
    expect(find.byKey(const ValueKey('store-free-lang.cs')), findsOneWidget);
    expect(findText('Ostrov slov – Čeština'), findsOneWidget);
    expect(findText('Vše napořád'), findsOneWidget);

    final buy = find.byKey(const ValueKey('store-buy-island.cs.b'));
    await tester.ensureVisible(buy);
    await tester.tap(buy);
    await settle(tester, const Duration(milliseconds: 400));
    expect(service.owns('island.cs.b'), isTrue);
    expect(service.unlocked(cs, cs.units[3]), isTrue);
    expect(find.byKey(const ValueKey('store-owned-island.cs.b')),
        findsOneWidget);
  });
}
