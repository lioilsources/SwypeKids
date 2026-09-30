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

  testWidgets('dlouhý stisk na lekci ukáže poznámku pro rodiče',
      (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: LessonMapScreen(
          language: Language.cs,
          onLanguageChanged: (_) {},
        ),
      ),
    ));
    await tester.pumpAndSettle();

    // První uzel první jednotky (hint 👩, odemčený)
    await tester.longPress(find.text('👩').at(1)); // [0] = ikona jednotky
    await tester.pumpAndSettle();
    expect(find.textContaining('První slabika'), findsOneWidget);
  });

  testWidgets('procvičování se nabídne až od 3 naučených slov', (tester) async {
    Future<void> pumpMap() async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: LessonMapScreen(
            key: UniqueKey(),
            language: Language.cs,
            onLanguageChanged: (_) {},
          ),
        ),
      ));
      await tester.pumpAndSettle();
    }

    await pumpMap();
    expect(find.text('Procvičování'), findsNothing);

    final p = ProgressService.instance;
    // MA, TA, BA (u1-l1, u2-l1, u3-l1)
    for (final id in ['cs-u1-l1', 'cs-u2-l1', 'cs-u3-l1']) {
      p.markCompleted('cs-CZ', id, 3);
    }
    await pumpMap();
    expect(find.text('Procvičování'), findsOneWidget);
  });
}
