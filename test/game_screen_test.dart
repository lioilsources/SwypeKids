import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swype_kids/data/lessons.dart';
import 'package:swype_kids/data/models/content_pack.dart';
import 'package:swype_kids/data/models/sentence.dart';
import 'package:swype_kids/screens/game_screen.dart';
import 'package:swype_kids/screens/word_sentence_screen.dart';
import 'package:swype_kids/services/progress_service.dart';
import 'package:swype_kids/widgets/challenge_card.dart';
import 'package:swype_kids/widgets/key_widget.dart';
import 'package:swype_kids/widgets/keyboard_widget.dart';
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
            display: 'MA', hint: '👩', label: 'MA', vocab: 'ma'),
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

    // Slovo s vocab přistane do batohu; první tah dá odznak
    expect(ProgressService.instance.wordBag(_pack.id), {'ma'});
    expect(ProgressService.instance.hasBadge('firstSwype'), isTrue);
    await tester.pump(const Duration(milliseconds: 700));
    expect(find.text('🎯 První tah'), findsOneWidget);
    await tester.pump(const Duration(milliseconds: 300));
    expect(find.text('🎒 MA'), findsOneWidget);

    // Po oslavě se automaticky přejde na další lekci
    await tester.pump(const Duration(milliseconds: 1400));
    expect(find.text('👩 2/2'), findsOneWidget);
    expect(find.text('🎒 MA'), findsNothing);
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
    // Druhá lekce byla na 2⭐ → bez „Bez chyby“; první nálepka → Objevitel
    expect(ProgressService.instance.hasBadge('noMistake'), isFalse);
    expect(find.text('🧭 Objevitel'), findsOneWidget);

    // Doběhnout zbývající časovače (fade stopy klávesnice)
    await tester.pump(const Duration(seconds: 3));
  });

  test('reviewMix vybere nejslabší naučené slovo z odemčených písmen', () {
    const mix = Lesson(
        id: 'mix',
        type: LessonType.reviewMix,
        unlocked: ['M', 'A'],
        target: 'MA',
        display: 'MA',
        hint: '🔁',
        label: 'MA',
        parentNote: 'opakování');
    final p = ProgressService.instance;

    // Nic naučeného → hraje se vlastní target jako obyčejný swype
    final fallback = resolveReviewMix(_pack, mix);
    expect(fallback.type, LessonType.swype);
    expect(fallback.target, 'MA');

    p.markCompleted(_pack.id, 'u1-l1', 3); // MA
    p.markCompleted(_pack.id, 'u1-l2', 3); // AM
    p.markCompleted(_pack.id, 'u2-l1', 3); // TA — T není odemčené
    p.recordAttempt(_pack.id, 'MA', success: true);
    p.recordAttempt(_pack.id, 'TA', success: false);

    final picked = resolveReviewMix(_pack, mix);
    expect(picked.target, 'AM'); // slabší než MA, TA nejde swypnout
    expect(picked.id, 'mix'); // postup se píše k reviewMix uzlu
    expect(picked.unlocked, ['M', 'A']);
    expect(picked.parentNote, 'opakování');
  });

  testWidgets('procvičování: hvězdy a síla ano, dokončení lekce ne, pak zpět',
      (tester) async {
    tester.view.physicalSize = const Size(1200, 900);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(MaterialApp(
      home: Builder(
        builder: (context) => TextButton(
          onPressed: () => Navigator.of(context).push(MaterialPageRoute(
            builder: (_) => GameScreen(
              pack: _pack,
              unitIndex: 0,
              practice: Unit(
                id: 'practice',
                title: 'Procvičování',
                icon: '🔁',
                reward: const CollectibleReward(emoji: '🔁'),
                lessons: [_pack.units[0].lessons[0]],
              ),
            ),
          )),
          child: const Text('mapa'),
        ),
      ),
    ));
    await tester.tap(find.text('mapa'));
    // GameScreen má nekonečnou animaci (blikání nových písmen) → bez settle.
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 400));
    expect(find.text('🔁 1/1'), findsOneWidget);

    await _swype(tester, ['M', 'A']);
    expect(ProgressService.instance.strengthOf(_pack.id, 'MA'), 1);
    expect(ProgressService.instance.isCompleted(_pack.id, 'u1-l1'), isFalse);

    await tester.pump(const Duration(milliseconds: 1700));
    await tester.pump(const Duration(milliseconds: 500));
    expect(find.text('mapa'), findsOneWidget); // zpět na mapě
    expect(ProgressService.instance.collectibles(_pack.id), isEmpty);
    await tester.pump(const Duration(seconds: 3));
  });

  testWidgets('nové slovo s dlaždicí → po oslavě slovo do věty, přeskočit → další lekce',
      (tester) async {
    tester.view.physicalSize = const Size(1200, 900);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);
    final pack = ContentPack(
      schemaVersion: 2,
      id: 'test-sentence',
      language: Language.cs,
      units: _pack.units,
      sentence: const SentenceCategories(
        subjects: [
          SentencePart(id: 's1', emoji: '👶', text: 'Já', person: '1sg'),
        ],
        verbs: [SentencePart(id: 'v1', emoji: '🍽️', text: 'jím', frame: 'acc')],
        objects: [
          SentencePart(
              id: 'ma', emoji: '🐭', text: 'ma', unlockedBy: TileUnlock.vocab),
        ],
      ),
    );

    await tester.pumpWidget(MaterialApp(
      home: GameScreen(pack: pack, unitIndex: 0),
    ));
    await _swype(tester, ['M', 'A']);
    await tester.pump(const Duration(milliseconds: 1700));
    await tester.pump(const Duration(milliseconds: 400));
    expect(find.byType(WordSentenceScreen), findsOneWidget);

    expect(find.byKey(const ValueKey('skip')), findsOneWidget);
    await tester.tap(find.byKey(const ValueKey('skip')));
    await tester.pump();
    await tester.pump(const Duration(seconds: 1)); // animace zavření routy
    expect(find.byType(WordSentenceScreen), findsNothing);
    expect(find.text('👩 2/2'), findsOneWidget);
    await tester.pump(const Duration(seconds: 3));
  });

  testWidgets('na šířku je karta vlevo a klávesnice vpravo', (tester) async {
    tester.view.physicalSize = const Size(1200, 600);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(const MaterialApp(
      home: GameScreen(pack: _pack, unitIndex: 0),
    ));
    await tester.pump();
    final card = tester.getCenter(find.byType(ChallengeCard));
    final keyboard = tester.getCenter(find.byType(KeyboardWidget));
    expect(card.dx, lessThan(600));
    expect(keyboard.dx, greaterThan(600));
    expect((card.dy - keyboard.dy).abs(), lessThan(120)); // vedle sebe

    // Swype funguje i v tomhle rozložení
    await _swype(tester, ['M', 'A']);
    expect(ProgressService.instance.starsFor(_pack.id, 'u1-l1'), 3);
    await tester.pump(const Duration(seconds: 4));
  });

  testWidgets('na výšku zůstává karta nad klávesnicí', (tester) async {
    tester.view.physicalSize = const Size(600, 1000);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(const MaterialApp(
      home: GameScreen(pack: _pack, unitIndex: 0),
    ));
    await tester.pump();
    expect(tester.getCenter(find.byType(ChallengeCard)).dy,
        lessThan(tester.getTopLeft(find.byType(KeyboardWidget)).dy));
    await tester.pump(const Duration(seconds: 4));
  });
}
