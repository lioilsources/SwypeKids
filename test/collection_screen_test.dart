import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swype_kids/data/lessons.dart';
import 'package:swype_kids/screens/collection_screen.dart';
import 'package:swype_kids/services/pack_service.dart';
import 'package:swype_kids/services/progress_service.dart';
import 'helpers.dart';

void main() {
  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    await ProgressService.init();
  });

  testWidgets('ostrov: získané zvířátko má jméno, tajná nálepka se ukáže až po nalezení',
      (tester) async {
    tester.view.physicalSize = const Size(800, 1400);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);
    final p = ProgressService.instance;
    p.addCollectible('cs-CZ', '🐭');

    await tester.pumpWidget(localizedApp(
      home: Scaffold(body: CollectionScreen(language: Language.cs)),
    ));
    await tester.runAsync(() => PackService.instance.load(Language.cs));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));

    expect(find.text('myš'), findsOneWidget);
    expect(find.byKey(const ValueKey('secret-cs-u1')), findsNothing);
    expect(find.text('❓'), findsWidgets); // ostatní jednotky
    expect(find.text('1/13'), findsOneWidget);

    await tester.tap(find.byKey(const ValueKey('sticker-cs-u1')));
    await tester.pump(const Duration(milliseconds: 400));

    p.addCollectible('cs-CZ', '🐞');
    await tester.pumpWidget(localizedApp(
      home: Scaffold(body: CollectionScreen(language: Language.cs, key: ValueKey(2))),
    ));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));
    expect(find.byKey(const ValueKey('secret-cs-u1')), findsOneWidget);
    await tester.pump(const Duration(seconds: 3));
  });
}
