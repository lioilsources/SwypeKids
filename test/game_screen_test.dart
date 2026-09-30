import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swype_kids/data/lessons.dart';
import 'package:swype_kids/data/models/content_pack.dart';
import 'package:swype_kids/screens/game_screen.dart';
import 'package:swype_kids/services/progress_service.dart';
import 'package:swype_kids/widgets/key_widget.dart';
import 'package:swype_kids/widgets/star_celebration.dart';

const _pack = ContentPack(
  schemaVersion: 1,
  id: 'test-game',
  language: Language.cs,
  units: [
    Unit(
      id: 'u1',
      title: 'M, A',
      icon: '👩',
      reward: CollectibleReward(emoji: '🐭'),
      lessons: [
        Lesson(id: 'u1-l1', unlocked: ['M', 'A'], target: 'MA',
            display: 'MA', hint: '👩', label: 'MA'),
        Lesson(id: 'u1-l2', unlocked: ['M', 'A'], target: 'AM',
            display: 'AM', hint: '👩', label: 'AM'),
      ],
    ),
    Unit(
      id: 'u2',
      title: 'T',
      icon: '👨',
      reward: CollectibleReward(emoji: '🐯'),
      lessons: [
        Lesson(id: 'u2-l1', unlocked: ['M', 'A', 'T'], target: 'TA',
            display: 'TA', hint: '👨', label: 'TA'),
      ],
    ),
  ],
);

Finder _key(String letter) =>
    find.byWidgetPredicate((w) => w is KeyWidget && w.letter == letter);

/// Swype přes klávesy [letters]; na každé další klávese prst chvíli
/// setrvá (dwell), jako by to udělalo dítě.
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
  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    await ProgressService.init();
  });

  testWidgets('správný swype → hvězdy, oslava, další lekce, nálepka',
      (tester) async {
    tester.view.physicalSize = const Size(1200, 900);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(const MaterialApp(
      home: GameScreen(pack: _pack, unitIndex: 0),
    ));
    expect(find.text('👩 1/2'), findsOneWidget);

    // Lekce 1: první pokus = 3 hvězdy + oslava s padajícími hvězdami
    await _swype(tester, ['M', 'A']);
    expect(ProgressService.instance.starsFor(_pack.id, 'u1-l1'), 3);
    expect(find.text('⭐ 3'), findsOneWidget);
    expect(find.byType(StarCelebration), findsOneWidget);

    // Po oslavě se automaticky přejde na další lekci
    await tester.pump(const Duration(milliseconds: 1700));
    expect(find.text('👩 2/2'), findsOneWidget);
    expect(find.byType(StarCelebration), findsNothing);

    // Lekce 2: chyba nic neuloží a neblokuje, druhý pokus = 2 hvězdy
    await _swype(tester, ['M', 'A']);
    expect(ProgressService.instance.starsFor(_pack.id, 'u1-l2'), 0);
    expect(find.byType(StarCelebration), findsNothing);
    await tester.pump(const Duration(milliseconds: 1000));
    await _swype(tester, ['A', 'M']);
    expect(ProgressService.instance.starsFor(_pack.id, 'u1-l2'), 2);

    // Konec jednotky → nálepka do Zvěřince a oslava jednotky
    await tester.pump(const Duration(milliseconds: 1700));
    await tester.pump(const Duration(milliseconds: 500));
    expect(ProgressService.instance.collectibles(_pack.id), ['🐭']);
    expect(find.text('Máš novou nálepku!'), findsOneWidget);

    // Doběhnout zbývající časovače (fade stopy klávesnice)
    await tester.pump(const Duration(seconds: 3));
  });
}
