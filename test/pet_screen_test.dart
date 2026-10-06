import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swype_kids/data/lessons.dart';
import 'package:swype_kids/data/models/content_pack.dart';
import 'package:swype_kids/pet/gift.dart';
import 'package:swype_kids/pet/pet_screen.dart';
import 'package:swype_kids/screens/collection_screen.dart';
import 'package:swype_kids/services/progress_service.dart';
import 'package:swype_kids/services/session_service.dart';
import 'package:swype_kids/services/settings_service.dart';
import 'package:swype_kids/ui/emoji_art.dart';
import 'package:swype_kids/world/world_clock.dart';
import 'helpers.dart';

void main() {
  late ContentPack pack;

  // Soubor packu číst mimo fake-async widget testu (jinak visí).
  setUpAll(() async => pack = await seedPack(Language.cs));
  setUp(() => WorldClockService.instance.debugNowOverride =
      () => DateTime(2026, 6, 1, 10));
  tearDown(() => WorldClockService.instance.debugNowOverride = null);

  Future<void> setUpProfile({Map<String, Object> prefs = const {}}) async {
    SharedPreferences.setMockInitialValues(prefs);
    await ProgressService.init();
    await SettingsService.instance.load();
    await SessionService.instance.load();
    // Myš z první jednotky je v Zvěřinci, mléko v batohu.
    ProgressService.instance.addCollectible(pack.id, pack.units.first.reward.emoji);
    ProgressService.instance.addWord(pack.id, 'mleko');
  }

  Future<void> pumpPet(WidgetTester tester) async {
    tester.view.physicalSize = const Size(390, 844) * 3;
    tester.view.devicePixelRatio = 3;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(
        localizedApp(home: PetScreen(pack: pack, unitIndex: 0)));
    await settle(tester, const Duration(milliseconds: 600));
  }

  test('tácek: naučené jídlo/pití/hračky + základní předměty, žádné dveře',
      () async {
    await setUpProfile();
    final tray = Gift.trayFor(pack).map((g) => g.emoji).toList();
    expect(tray, contains('🥛')); // slovo z batohu
    expect(tray, contains('🍎')); // základní předmět builderu
    expect(tray, isNot(contains('🚪')));
    expect(tray, isNot(contains('👩'))); // máma není dárek
  });

  testWidgets('ze Zvěřince ťuknutím na řádek do světa zvířátka',
      (tester) async {
    await setUpProfile();
    tester.view.physicalSize = const Size(390, 844) * 3;
    tester.view.devicePixelRatio = 3;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(localizedApp(
        home: const Scaffold(body: CollectionScreen(language: Language.cs))));
    await settle(tester);
    // Nezískaná jednotka svět nemá.
    expect(find.byKey(ValueKey('island-${pack.units[1].id}')), findsNothing);
    await tester.tap(find.byKey(ValueKey('island-${pack.units.first.id}')));
    await settle(tester);
    expect(find.byType(PetScreen), findsOneWidget);
    expect(find.byKey(const ValueKey('pet-resident')), findsOneWidget);
    await tester.tap(find.byKey(const ValueKey('pet-back')));
    await settle(tester);
    expect(find.byType(PetScreen), findsNothing);
  });

  testWidgets(
      'dárek přetažený na myš: jí, věta „Myš jí jablko.", ⭐ do knížky',
      (tester) async {
    await setUpProfile();
    await pumpPet(tester);
    final resident = find.byKey(const ValueKey('pet-resident'));

    final g = await tester.startGesture(
        tester.getCenter(find.byKey(const ValueKey('gift-o2'))));
    await tester.pump(const Duration(milliseconds: 50));
    await g.moveTo(tester.getCenter(resident));
    await tester.pump(const Duration(milliseconds: 50));
    await g.up();
    await tester.pump();

    // Jí (póza eat, když obrázek existuje) a objeví se věta.
    final art = tester.widget<EmojiArt>(resident);
    expect(art.action, StickerAction.eat);
    expect(art.pose, 'eat');
    expect(findText('Myš jí jablko.'), findsOneWidget);

    // Průvodce před ⭐ pomalu uhne (bublina věty je GuideAvoid).
    await settle(tester, const Duration(seconds: 2));
    await tester.tap(find.byKey(const ValueKey('pet-save')));
    await tester.pump();
    expect(ProgressService.instance.book(pack.id).single.text, 'Myš jí jablko.');
    // Uložit jde jen jednou.
    await tester.tap(find.byKey(const ValueKey('pet-save')));
    expect(ProgressService.instance.book(pack.id), hasLength(1));

    // Pití z batohu → pije.
    final g2 = await tester.startGesture(
        tester.getCenter(find.byKey(const ValueKey('gift-mleko'))));
    await tester.pump(const Duration(milliseconds: 50));
    await g2.moveTo(tester.getCenter(resident));
    await tester.pump(const Duration(milliseconds: 50));
    await g2.up();
    await tester.pump();
    expect(tester.widget<EmojiArt>(resident).action, StickerAction.drink);
    expect(findText('Myš pije mléko.'), findsOneWidget);
    await settle(tester, const Duration(seconds: 3));
    expect(tester.widget<EmojiArt>(resident).action, isNull);
  });

  testWidgets('hlazení = raduje se; po vypršení času spí', (tester) async {
    await setUpProfile();
    await pumpPet(tester);
    final resident = find.byKey(const ValueKey('pet-resident'));
    final g = await tester.startGesture(tester.getCenter(resident));
    for (var i = 0; i < 10; i++) {
      await g.moveBy(Offset(i.isEven ? 14 : -14, 2));
      await tester.pump(const Duration(milliseconds: 60));
    }
    await g.up();
    await tester.pump();
    expect(tester.widget<EmojiArt>(resident).action, StickerAction.happy);
    expect(ProgressService.instance.petStats(pack.id).petted, {'🐭'});
    await settle(tester, const Duration(seconds: 2));

    // Limit session → spí.
    final t = DateTime.now();
    final day =
        '${t.year}-${t.month.toString().padLeft(2, '0')}-${t.day.toString().padLeft(2, '0')}';
    await setUpProfile(prefs: {
      'sk.settings.sessionLimitMin': 10,
      'sk.session.$day': 11 * 60,
    });
    expect(SessionService.instance.limitReached, isTrue);
    await tester.pumpWidget(const SizedBox());
    await pumpPet(tester);
    final art = tester.widget<EmojiArt>(resident);
    expect(art.action, StickerAction.sleep);
    expect(art.pose, 'sleep');
    await settle(tester, const Duration(seconds: 2));
  });

  testWidgets('v noci spí a dárek odloží („pšt"), věta není', (tester) async {
    WorldClockService.instance.debugNowOverride =
        () => DateTime(2026, 6, 1, 23);
    await setUpProfile();
    await pumpPet(tester);
    final resident = find.byKey(const ValueKey('pet-resident'));
    expect(tester.widget<EmojiArt>(resident).action, StickerAction.sleep);
    final g = await tester.startGesture(
        tester.getCenter(find.byKey(const ValueKey('gift-o2'))));
    await tester.pump(const Duration(milliseconds: 50));
    await g.moveTo(tester.getCenter(resident));
    await tester.pump(const Duration(milliseconds: 50));
    await g.up();
    await tester.pump();
    expect(find.byKey(const ValueKey('pet-shh')), findsOneWidget);
    expect(find.byKey(const ValueKey('pet-sentence')), findsNothing);
    expect(ProgressService.instance.petStats(pack.id).gifts, 0);
    await settle(tester, const Duration(seconds: 3));
  });
}
