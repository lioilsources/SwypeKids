import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swype_kids/data/lessons.dart';
import 'package:swype_kids/data/models/content_pack.dart';
import 'package:swype_kids/screens/word_sentence_screen.dart';
import 'package:swype_kids/services/pack_service.dart';
import 'package:swype_kids/services/progress_service.dart';

void main() {
  late ContentPack cs;

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    await ProgressService.init();
  });

  Future<String?> runScreen(WidgetTester tester, String vocab,
      Future<void> Function() interact) async {
    tester.view.physicalSize = const Size(1000, 1400);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);
    cs = (await tester.runAsync(() => PackService.instance.load(Language.cs)))!;
    String? result = 'nevráceno';
    await tester.pumpWidget(MaterialApp(
      home: Builder(
        builder: (context) => TextButton(
          onPressed: () async {
            result = await Navigator.of(context).push(MaterialPageRoute<String>(
              builder: (_) => WordSentenceScreen(
                pack: cs,
                word: WordSentenceScreen.tileFor(cs, vocab)!,
              ),
            ));
          },
          child: const Text('hra'),
        ),
      ),
    ));
    await tester.tap(find.text('hra'));
    await tester.pumpAndSettle();
    await interact();
    await tester.pumpAndSettle();
    return result;
  }

  testWidgets('slovo je předvyplněné, dítě doplní zbytek a větu uslyší',
      (tester) async {
    ProgressService.instance.addWord('cs-CZ', 'mama');
    final result = await runScreen(tester, 'kolo', () async {
      // Slovo z batohu je v nabídce první
      await tester.tap(find.text('Máma'));
      await tester.pump();
      // Sloveso už v nabídce časované podle podmětu
      await tester.tap(find.text('jí'));
      await tester.pump();
      expect(find.text('kolo'), findsOneWidget); // předvyplněný předmět
      await tester.tap(find.byKey(const ValueKey('trumpet')));
      await tester.pump();
      await tester.tap(find.byKey(const ValueKey('done')));
    });
    expect(result, 'Máma jí kolo');
  });

  testWidgets('trumpeta čeká na celou větu, přeskočit jde vždy',
      (tester) async {
    final result = await runScreen(tester, 'mama', () async {
      await tester.tap(find.byKey(const ValueKey('trumpet')));
      await tester.pump();
      // Bez celé věty se „hotovo" neukáže
      await tester.tap(find.byKey(const ValueKey('done')),
          warnIfMissed: false);
      await tester.pump();
      expect(find.byType(WordSentenceScreen), findsOneWidget);
      await tester.tap(find.byKey(const ValueKey('skip')));
    });
    expect(result, isNull);
  });

  test('tileFor najde jen vocab dlaždice', () async {
    TestWidgetsFlutterBinding.ensureInitialized();
    final pack = await PackService.instance.load(Language.cs);
    expect(WordSentenceScreen.tileFor(pack, 'kolo')?.text, 'kolo');
    expect(WordSentenceScreen.tileFor(pack, ''), isNull);
    expect(WordSentenceScreen.tileFor(pack, 's1'), isNull); // „Já" je always
  });
}
