import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swype_kids/characters/mascot.dart';
import 'package:swype_kids/data/lessons.dart';
import 'package:swype_kids/data/models/content_pack.dart';
import 'package:swype_kids/data/models/sentence.dart';
import 'package:swype_kids/screens/game_screen.dart';
import 'package:swype_kids/screens/word_sentence_screen.dart';
import 'package:swype_kids/services/progress_service.dart';
import 'package:swype_kids/services/settings_service.dart';
import 'package:swype_kids/widgets/challenge_card.dart';
import 'package:swype_kids/widgets/key_widget.dart';
import 'package:swype_kids/widgets/keyboard_widget.dart';
import 'package:swype_kids/widgets/star_celebration.dart';
import 'helpers.dart';

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

    await tester.pumpWidget(localizedApp(
      home: GameScreen(pack: _pack, unitIndex: 0),
    ));
    expect(findText('👩 1/2'), findsOneWidget);

    // Průvodce zamává při příchodu, pak jásá po správném swype
    expect(find.byType(Mascot), findsOneWidget);
    expect(find.byKey(const ValueKey('mascot-wave')), findsOneWidget);
    await tester.pump(const Duration(milliseconds: 1000));
    expect(find.byKey(const ValueKey('mascot-wave')), findsNothing);

    // Lekce 1: první pokus = 3 hvězdy + oslava s padajícími hvězdami
    await _swype(tester, ['M', 'A']);
    expect(find.byKey(const ValueKey('mascot-cheer')), findsOneWidget);
    expect(ProgressService.instance.starsFor(_pack.id, 'u1-l1'), 3);
    expect(findText('⭐ 3'), findsOneWidget);
    expect(find.byType(StarCelebration), findsOneWidget);

    // Slovo s vocab přistane do batohu; první tah dá odznak
    expect(ProgressService.instance.wordBag(_pack.id), {'ma'});
    expect(ProgressService.instance.hasBadge('firstSwype'), isTrue);
    await tester.pump(const Duration(milliseconds: 700));
    expect(findText('První tah'), findsOneWidget);
    await tester.pump(const Duration(milliseconds: 300));
    expect(findText('🎒 MA'), findsOneWidget);

    // Po oslavě se automaticky přejde na další lekci
    await tester.pump(const Duration(milliseconds: 1400));
    expect(findText('👩 2/2'), findsOneWidget);
    expect(findText('🎒 MA'), findsNothing);
    expect(find.byType(StarCelebration), findsNothing);

    // Lekce 2: chyba nic neuloží a neblokuje, druhý pokus = 2 hvězdy
    await _swype(tester, ['M', 'A']);
    // průvodce: „ups, zkus to znovu“
    expect(find.byKey(const ValueKey('mascot-oops')), findsOneWidget);
    expect(ProgressService.instance.starsFor(_pack.id, 'u1-l2'), 0);
    expect(find.byType(StarCelebration), findsNothing);
    await tester.pump(const Duration(milliseconds: 1000));
    await _swype(tester, ['A', 'M']);
    expect(ProgressService.instance.starsFor(_pack.id, 'u1-l2'), 2);

    // Konec jednotky → nálepka do Zvěřince a oslava jednotky
    await tester.pump(const Duration(milliseconds: 1700));
    await tester.pump(const Duration(milliseconds: 500));
    expect(ProgressService.instance.collectibles(_pack.id), ['🐭']);
    expect(findText('Máš novou nálepku!'), findsOneWidget);
    // Druhá lekce byla na 2⭐ → bez „Bez chyby“; první nálepka → Objevitel
    expect(ProgressService.instance.hasBadge('noMistake'), isFalse);
    expect(findText('Objevitel'), findsOneWidget);

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

    await tester.pumpWidget(localizedApp(
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
    await tester.tap(findText('mapa'));
    // GameScreen má nekonečnou animaci (blikání nových písmen) → bez settle.
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 400));
    expect(findText('🔁 1/1'), findsOneWidget);

    await _swype(tester, ['M', 'A']);
    expect(ProgressService.instance.strengthOf(_pack.id, 'MA'), 1);
    expect(ProgressService.instance.isCompleted(_pack.id, 'u1-l1'), isFalse);

    await tester.pump(const Duration(milliseconds: 1700));
    await tester.pump(const Duration(milliseconds: 500));
    expect(findText('mapa'), findsOneWidget); // zpět na mapě
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
              id: 'ma',
              emoji: '🐭',
              text: 'ma',
              unlockedBy: TileUnlock.vocab,
              forms: {'acc': 'ma'}), // výslovný tvar — bez něj věta není
        ],
      ),
    );

    await tester.pumpWidget(localizedApp(
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
    expect(findText('👩 2/2'), findsOneWidget);
    await tester.pump(const Duration(seconds: 3));
  });

  testWidgets('na šířku je karta vlevo a klávesnice vpravo', (tester) async {
    tester.view.physicalSize = const Size(1200, 600);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(localizedApp(
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
    await tester.pumpWidget(localizedApp(
      home: GameScreen(pack: _pack, unitIndex: 0),
    ));
    await tester.pump();
    expect(tester.getCenter(find.byType(ChallengeCard)).dy,
        lessThan(tester.getTopLeft(find.byType(KeyboardWidget)).dy));
    await tester.pump(const Duration(seconds: 4));
  });

  group('nové typy kol (v4.0)', () {
    const hunt = Lesson(id: 'h1', type: LessonType.letterHunt,
        unlocked: ['M', 'A', 'S'], target: 'S', display: 'S', hint: '☀️', label: 'S');
    const join = Lesson(id: 'j1', type: LessonType.syllableJoin,
        unlocked: ['M', 'A'], target: 'MAMA', display: 'MÁMA', hint: '👩',
        label: 'MÁ-MA', parts: ['MÁ', 'MA']);
    const rhyme = Lesson(id: 'r1', type: LessonType.rhymePick,
        unlocked: ['M', 'A'], target: 'PES', display: 'PES', hint: '🐶', label: 'PES',
        options: [RhymeOption(emoji: '🌲', display: 'LES'),
          RhymeOption(emoji: '🚲', display: 'KOLO'), RhymeOption(emoji: '👃', display: 'NOS')],
        answer: 0);
    final pack = ContentPack(schemaVersion: 2, id: 'test-v4', language: Language.cs, units: const [
      Unit(id: 'u', title: 'U', icon: '👂', reward: CollectibleReward(emoji: '🦁'),
          lessons: [hunt, join, rhyme]),
    ]);

    Future<void> pump(WidgetTester tester) async {
      tester.view.physicalSize = const Size(1200, 900);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.reset);
      await tester.pumpWidget(localizedApp(home: GameScreen(pack: pack, unitIndex: 0)));
      await tester.pump();
    }

    testWidgets('lov hlásky: text skrytý, ťuknutí na správnou klávesu = 3⭐', (tester) async {
      await pump(tester);
      expect(findText('• • •'), findsOneWidget);
      expect(find.textContaining('Které písmenko slyšíš'), findsOneWidget);
      await _swype(tester, ['S']);
      expect(ProgressService.instance.starsFor(pack.id, 'h1'), 3);
      await tester.pump(const Duration(milliseconds: 1700));
      await tester.pump(const Duration(milliseconds: 400));

      // spojování slabik: karta ukazuje MÁ + MA
      expect(findText('MÁ + MA'), findsOneWidget);
      await _swype(tester, ['M', 'A', 'M', 'A']);
      expect(ProgressService.instance.starsFor(pack.id, 'j1'), 3);
      await tester.pump(const Duration(milliseconds: 1700));
      await tester.pump(const Duration(milliseconds: 400));

      // rým: tři obrázky místo klávesnice, chyba odhalí správnou, pak 2⭐
      expect(find.byType(KeyboardWidget), findsNothing);
      expect(find.byKey(const ValueKey('rhyme-option-1')), findsOneWidget);
      await tester.tap(find.byKey(const ValueKey('rhyme-option-1')));
      await tester.pump();
      expect(ProgressService.instance.starsFor(pack.id, 'r1'), 0);
      await tester.pump(const Duration(milliseconds: 1000));
      await tester.tap(find.byKey(const ValueKey('rhyme-option-0')));
      await tester.pump();
      expect(ProgressService.instance.starsFor(pack.id, 'r1'), 2);
      await tester.pump(const Duration(seconds: 4));
    });
  });

  testWidgets('průvodce jde přetáhnout; puštěný na klávesy pomalu uhne',
      (tester) async {
    tester.view.physicalSize = const Size(390, 844) * 3;
    tester.view.devicePixelRatio = 3;
    addTearDown(tester.view.reset);
    await SettingsService.instance.load();

    await tester.pumpWidget(localizedApp(
      home: GameScreen(pack: _pack, unitIndex: 0),
    ));
    await tester.pump(const Duration(seconds: 2));

    final guide = find.byKey(const ValueKey('guide-drag'));
    Rect keys() => [
          for (final l in ['M', 'A', 'Q', 'P', 'Z', 'L'])
            if (_key(l).evaluate().isNotEmpty) tester.getRect(_key(l))
        ].reduce((a, b) => a.expandToInclude(b));
    final card = tester.getRect(find.byType(ChallengeCard));

    // Výchozí místo nepřekáží ani kartě, ani klávesám.
    expect(tester.getRect(guide).overlaps(keys()), isFalse);
    expect(tester.getRect(guide).overlaps(card), isFalse);

    // Dítě ho šoupne doprostřed klávesnice…
    final g = await tester.startGesture(tester.getCenter(guide));
    for (var i = 0; i < 10; i++) {
      await g.moveBy((keys().center - tester.getCenter(guide)) / 4);
      await tester.pump(const Duration(milliseconds: 16));
    }
    expect(tester.getRect(guide).overlaps(keys()), isTrue);
    await g.up();
    await tester.pump();
    // …a on pomalu odejde na volné místo (ne skokem).
    await tester.pump(const Duration(milliseconds: 300));
    expect(tester.getRect(guide).overlaps(keys()), isTrue);
    await tester.pump(const Duration(seconds: 2));
    expect(tester.getRect(guide).overlaps(keys()), isFalse);
    expect(tester.getRect(guide).overlaps(card), isFalse);
    expect(SettingsService.instance.guidePositionFor('game'), isNotNull);

    // Swype přes klávesy pořád funguje.
    await _swype(tester, ['M', 'A']);
    expect(ProgressService.instance.starsFor(_pack.id, 'u1-l1'), 3);
    await tester.pump(const Duration(seconds: 4));
  });

  testWidgets('ťuknutí na Pandičku ve hře = zamává, i opakovaně',
      (tester) async {
    tester.view.physicalSize = const Size(390, 844) * 3;
    tester.view.devicePixelRatio = 3;
    addTearDown(tester.view.reset);
    await SettingsService.instance.load();
    await tester.pumpWidget(localizedApp(
      home: GameScreen(pack: _pack, unitIndex: 0),
    ));
    await tester.pump(const Duration(seconds: 2)); // úvodní zamávání dohraje
    final guide = find.byKey(const ValueKey('guide-drag'));
    expect(find.byKey(const ValueKey('mascot-wave')), findsNothing);

    await tester.tap(guide);
    await tester.pump();
    expect(find.byKey(const ValueKey('mascot-wave')), findsOneWidget);
    // Druhé ťuknutí uprostřed mávání začne mávat znovu (neskončí po 1. ťuknutí).
    await tester.pump(const Duration(milliseconds: 600));
    await tester.tap(guide);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 600));
    expect(find.byKey(const ValueKey('mascot-wave')), findsOneWidget);
    await tester.pump(const Duration(seconds: 1));
    expect(find.byKey(const ValueKey('mascot-wave')), findsNothing);
    await tester.pump(const Duration(seconds: 3));
  });
}
