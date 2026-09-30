import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swype_kids/data/lessons.dart';
import 'package:swype_kids/screens/sentence_builder_screen.dart';
import 'package:swype_kids/services/pack_service.dart';
import 'package:swype_kids/services/progress_service.dart';

void main() {
  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    await ProgressService.init();
  });

  Future<void> pumpBuilder(WidgetTester tester) async {
    tester.view.physicalSize = const Size(1200, 1600);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: SentenceBuilderScreen(
          language: Language.cs,
          onLanguageChanged: (_) {},
        ),
      ),
    ));
    await tester.runAsync(() => PackService.instance.load(Language.cs));
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
}
