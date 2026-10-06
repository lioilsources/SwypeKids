import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swype_kids/data/lessons.dart';
import 'package:swype_kids/data/models/content_pack.dart';
import 'package:swype_kids/pet/gift.dart';
import 'package:swype_kids/pet/pet_screen.dart';
import 'package:swype_kids/pet/wish.dart';
import 'package:swype_kids/screens/game_screen.dart';
import 'package:swype_kids/services/achievement_service.dart';
import 'package:swype_kids/services/progress_service.dart';
import 'package:swype_kids/services/session_service.dart';
import 'package:swype_kids/services/settings_service.dart';
import 'package:swype_kids/world/world_clock.dart';
import 'helpers.dart';

void main() {
  late ContentPack pack;
  setUpAll(() async => pack = await seedPack(Language.cs));
  // Den (10:00), ať test nezávisí na tom, kdy běží; noc má vlastní test.
  setUp(() => WorldClockService.instance.debugNowOverride =
      () => DateTime(2026, 6, 1, 10));
  tearDown(() => WorldClockService.instance.debugNowOverride = null);

  Future<void> fresh({Map<String, Object> prefs = const {}}) async {
    SharedPreferences.setMockInitialValues(prefs);
    await ProgressService.init();
    await SettingsService.instance.load();
    await SessionService.instance.load();
    ProgressService.instance.addCollectible(pack.id, pack.units.first.reward.emoji);
  }

  Lesson lessonOf(String vocab) =>
      pack.allLessons.firstWhere((l) => l.vocab == vocab);

  test('přání: slabé slovo, nikdy dvakrát za sebou totéž', () async {
    await fresh();
    final p = ProgressService.instance;
    for (final w in ['mleko', 'banan', 'hracka', 'auto', 'fotbal']) {
      p.addWord(pack.id, w);
    }
    // Mléko a banán umí skvěle, ostatní slabě.
    for (var i = 0; i < 5; i++) {
      p.recordAttempt(pack.id, lessonOf('mleko').target, success: true);
      p.recordAttempt(pack.id, lessonOf('banan').target, success: true);
    }
    final tray = Gift.trayFor(pack);
    final rng = Random(1);
    for (var i = 0; i < 30; i++) {
      final w = PetLearning.pickWish(pack, tray, last: 'auto', rng: rng)!;
      expect(w.id, isNot('auto'));
      expect(w.id, isNot(anyOf('mleko', 'banan')), reason: 'silná slova ne');
      expect(w.lesson, isNotNull, reason: 'přání = naučené slovo');
    }
  });

  test('kolo podle síly: celé slovo → chybí písmeno → jen obrázek', () async {
    await fresh();
    final p = ProgressService.instance;
    final milk = lessonOf('mleko');
    LessonType type() => PetLearning.roundFor(pack, milk).type;
    expect(type(), LessonType.swype);
    for (var i = 0; i < 2; i++) {
      p.recordAttempt(pack.id, milk.target, success: true);
    }
    expect(type(), LessonType.missingLetter);
    for (var i = 0; i < 2; i++) {
      p.recordAttempt(pack.id, milk.target, success: true);
    }
    expect(type(), LessonType.pictureOnly);
    // Id i target zůstávají → síla se zapisuje k témuž slovu.
    expect(PetLearning.roundFor(pack, milk).target, milk.target);
  });

  test('odznaky světa zvířátka: hostitel, mazlík, přání, kamarád všech',
      () async {
    await fresh();
    final p = ProgressService.instance;
    final a = AchievementService.instance;
    for (var i = 0; i < 9; i++) {
      p.recordGift(pack.id, '🐭');
    }
    expect(a.check(const PetAction(), pack), isNot(contains(GameBadge.host)));
    p.recordGift(pack.id, '🐭', wish: true);
    expect(a.check(const PetAction(), pack), contains(GameBadge.host));
    for (final e in ['🐭', '🐯', '🐟', '🐱']) {
      p.recordPetting(pack.id, e);
    }
    p.recordPetting(pack.id, '🐭'); // stejné se nepočítá dvakrát
    expect(a.check(const PetAction(), pack), isNot(contains(GameBadge.cuddler)));
    p.recordPetting(pack.id, '🦁');
    expect(a.check(const PetAction(), pack), contains(GameBadge.cuddler));
    expect(p.petStats(pack.id).wishes, 1);
    // Kamarád všech: aspoň 5 zvířátek a každé dostalo dárek.
    for (final u in pack.units.take(5)) {
      p.addCollectible(pack.id, u.reward.emoji);
    }
    expect(a.check(const PetAction(), pack),
        isNot(contains(GameBadge.friendOfAll)));
    for (final u in pack.units.take(5)) {
      p.recordGift(pack.id, u.reward.emoji);
    }
    expect(a.check(const PetAction(), pack), contains(GameBadge.friendOfAll));
    // Statistiky přežijí restart.
    await ProgressService.init();
    expect(ProgressService.instance.petStats(pack.id).gifts, 15);
  });

  Future<void> pumpPet(WidgetTester tester) async {
    tester.view.physicalSize = const Size(390, 844) * 3;
    tester.view.devicePixelRatio = 3;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(
        localizedApp(home: PetScreen(pack: pack, unitIndex: 0)));
    await settle(tester, const Duration(seconds: 2));
  }

  testWidgets(
      'ťuknutí na naučený dárek → kolo (napsat slovo) → dárek doletí, '
      'přání se splní', (tester) async {
    await fresh();
    ProgressService.instance.addWord(pack.id, 'mleko');
    await pumpPet(tester);
    // Jediné naučené slovo v tácku = mléko → to si přeje.
    expect(find.byKey(const ValueKey('pet-wish')), findsOneWidget);

    await tester.tap(find.byKey(const ValueKey('gift-mleko')));
    await settle(tester);
    final round = tester.widget<GameScreen>(find.byType(GameScreen));
    expect(round.practice!.lessons.single.vocab, 'mleko');
    expect(round.practice!.lessons.single.type, LessonType.swype);
    // Dítě kolo dohraje (GameScreen vrátí hvězdy).
    tester.state<NavigatorState>(find.byType(Navigator)).pop(3);
    await settle(tester, const Duration(milliseconds: 600));
    expect(findText('Myš pije mléko.'), findsOneWidget);
    expect(find.byKey(const ValueKey('pet-wish')), findsNothing);
    final stats = ProgressService.instance.petStats(pack.id);
    expect(stats.gifts, 1);
    expect(stats.wishes, 1);
    expect(stats.fed, contains('🐭'));
    await settle(tester, const Duration(seconds: 6));
  });

  testWidgets('rodič vypnul psaní: ťuknutí jen řekne slovo, kolo není',
      (tester) async {
    await fresh(prefs: {'sk.settings.petRounds': false});
    expect(SettingsService.instance.petRounds, isFalse);
    ProgressService.instance.addWord(pack.id, 'mleko');
    await pumpPet(tester);
    await tester.tap(find.byKey(const ValueKey('gift-mleko')));
    await settle(tester);
    expect(find.byType(GameScreen), findsNothing);
    await settle(tester, const Duration(seconds: 3));
  });

  testWidgets('v noci spí: žádné přání, ťuknutí na dárek kolo neotevře',
      (tester) async {
    WorldClockService.instance.debugNowOverride =
        () => DateTime(2026, 6, 1, 23);
    await fresh();
    ProgressService.instance.addWord(pack.id, 'mleko');
    await pumpPet(tester);
    expect(find.byKey(const ValueKey('pet-wish')), findsNothing);
    await tester.tap(find.byKey(const ValueKey('gift-mleko')));
    await settle(tester);
    expect(find.byType(GameScreen), findsNothing);
    await settle(tester, const Duration(seconds: 3));
  });
}
