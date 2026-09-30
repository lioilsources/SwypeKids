import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swype_kids/data/lessons.dart';
import 'package:swype_kids/screens/book_screen.dart';
import 'package:swype_kids/services/pack_service.dart';
import 'package:swype_kids/services/progress_service.dart';

void main() {
  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    await ProgressService.init();
  });

  Future<void> pumpBook(WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: Scaffold(body: BookScreen(language: Language.cs)),
    ));
    await tester.runAsync(() => PackService.instance.load(Language.cs));
    await tester.pump();
    await tester.pump();
  }

  testWidgets('prázdná knížka ukáže obrázkový návod', (tester) async {
    await pumpBook(tester);
    expect(find.text('🗣️ ➡️ 📖'), findsOneWidget);
  });

  testWidgets('uložené věty jsou v knížce, nejnovější nahoře', (tester) async {
    ProgressService.instance.addToBook('cs-CZ', 'Máma jí kolo', '👩 🍽️ 🚲');
    ProgressService.instance.addToBook('cs-CZ', 'Já chci les', '👶 ✋ 🌲');
    await pumpBook(tester);

    expect(find.text('Máma jí kolo'), findsOneWidget);
    expect(find.text('👩 🍽️ 🚲'), findsOneWidget);
    final newest = tester.getTopLeft(find.text('Já chci les')).dy;
    final older = tester.getTopLeft(find.text('Máma jí kolo')).dy;
    expect(newest, lessThan(older));
    await tester.tap(find.text('Máma jí kolo')); // přečte nahlas (TTS tiše v testu)
  });
}
