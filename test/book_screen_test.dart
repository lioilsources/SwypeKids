import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swype_kids/data/lessons.dart';
import 'package:swype_kids/screens/book_screen.dart';
import 'package:swype_kids/services/progress_service.dart';
import 'helpers.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    await ProgressService.init();
    await seedPack(Language.cs);
  });

  Future<void> pumpBook(WidgetTester tester) async {
    await tester.pumpWidget(localizedApp(
      home: Scaffold(body: BookScreen(language: Language.cs)),
    ));
    await tester.pump();
    await tester.pump();
  }

  testWidgets('prázdná knížka ukáže obrázkový návod', (tester) async {
    await pumpBook(tester);
    expect(findText('🗣️ ➡️ 📖'), findsOneWidget);
  });

  testWidgets('uložené věty jsou v knížce, nejnovější nahoře', (tester) async {
    ProgressService.instance.addToBook('cs-CZ', 'Máma jí kolo', '👩 🍽️ 🚲');
    ProgressService.instance.addToBook('cs-CZ', 'Já chci les', '👶 ✋ 🌲');
    await pumpBook(tester);

    expect(findText('Máma jí kolo'), findsOneWidget);
    // Řádek obrázků = nálepky, každá zvlášť.
    for (final e in ['👩', '🍽️', '🚲']) {
      expect(findText(e), findsWidgets);
    }
    final newest = tester.getTopLeft(findText('Já chci les')).dy;
    final older = tester.getTopLeft(findText('Máma jí kolo')).dy;
    expect(newest, lessThan(older));
    await tester.tap(findText('Máma jí kolo')); // přečte nahlas (TTS tiše v testu)
  });
}
