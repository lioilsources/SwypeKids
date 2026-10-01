import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swype_kids/data/lessons.dart';
import 'package:swype_kids/screens/sentence_builder_screen.dart';
import 'package:swype_kids/services/pack_service.dart';
import 'package:swype_kids/services/progress_service.dart';
import 'helpers.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    await ProgressService.init();
    await seedPack(Language.cs);
  });

  Future<void> pumpBuilder(WidgetTester tester) async {
    tester.view.physicalSize = const Size(1200, 1600);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(localizedApp(
      home: Scaffold(
        body: SentenceBuilderScreen(
          language: Language.cs,
          onLanguageChanged: (_) {},
        ),
      ),
    ));
    await tester.pump();
    await tester.pump();
  }

  testWidgets('slova mimo batoh jsou siluetky, z batohu se odemknou jako nová',
      (tester) async {
    await pumpBuilder(tester);

    // Základní dlaždice jsou hned, slova ze hry zatím „?"
    expect(find.text('Já'), findsOneWidget);
    expect(find.text('Máma'), findsNothing);
    expect(find.text('?'), findsWidgets);
    expect(find.text('NOVÉ'), findsNothing);

    final packId = PackService.instance.cached(Language.cs)!.id;
    ProgressService.instance.addWord(packId, 'mama');
    await pumpBuilder(tester);

    expect(find.text('Máma'), findsOneWidget);
    expect(find.text('NOVÉ'), findsOneWidget);

    // Vybraná Máma se promítne do věty se správným tvarem slovesa
    await tester.tap(find.text('Máma'));
    await tester.pump();
    await tester.tap(find.text('jí'));
    await tester.pump();
    expect(find.text('jí'), findsWidgets);
  });

  testWidgets('hotovou větu jde uložit do Mé knížky, 🎹 vezme slovo do hry',
      (tester) async {
    ProgressService.instance.addWord('cs-CZ', 'kolo');
    await pumpBuilder(tester);

    // Bez celé věty není co uložit
    expect(find.byKey(const ValueKey('save-book')), findsNothing);
    await tester.tap(find.text('Já'));
    await tester.pump();
    await tester.tap(find.text('chci'));
    await tester.pump();
    await tester.tap(find.text('kolo'));
    await tester.pump();

    await tester.tap(find.byKey(const ValueKey('save-book')));
    await tester.pump();
    expect(ProgressService.instance.book('cs-CZ').single.text, 'Já chci kolo');
    expect(find.text('✅'), findsOneWidget);

    // Naučené slovo má 🎹, nenaučené ne
    expect(find.byKey(const ValueKey('play-kolo')), findsOneWidget);
    expect(find.byKey(const ValueKey('play-mama')), findsNothing);
  });
}
