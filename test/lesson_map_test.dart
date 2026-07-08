import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swype_kids/data/lessons.dart';
import 'package:swype_kids/screens/lesson_map_screen.dart';
import 'package:swype_kids/services/progress_service.dart';

void main() {
  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    await ProgressService.init();
  });

  testWidgets('mapa načte český pack a zobrazí jednotky', (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: LessonMapScreen(
          language: Language.cs,
          onLanguageChanged: (_) {},
        ),
      ),
    ));
    await tester.pumpAndSettle();

    // Hlavička packu a první jednotka
    expect(find.textContaining('Slabikář'), findsOneWidget);
    expect(find.text('M, A'), findsOneWidget);

    // Nic není dokončené → 0 hvězd, zamčené uzly existují
    expect(find.textContaining('⭐ 0'), findsOneWidget);
    expect(find.text('🔒'), findsWidgets);

    // Nezískané odměny jednotek jsou ❓
    expect(find.text('❓'), findsWidgets);
  });
}
