import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swype_kids/characters/mascot.dart';
import 'package:swype_kids/data/lessons.dart';
import 'package:swype_kids/screens/lesson_map_screen.dart';
import 'package:swype_kids/services/progress_service.dart';
import 'package:swype_kids/services/session_service.dart';
import 'package:swype_kids/services/settings_service.dart';
import 'helpers.dart';

void main() {
  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    await ProgressService.init();
    await seedPack(Language.cs);
  });

  testWidgets('mapa načte český pack a zobrazí jednotky', (tester) async {
    await tester.pumpWidget(localizedApp(
      home: Scaffold(
        body: LessonMapScreen(
          language: Language.cs,
          onLanguageChanged: (_) {},
        ),
      ),
    ));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 400));

    // Hlavička packu a první jednotka
    expect(find.textContaining('Slabikář'), findsOneWidget);
    expect(find.text('M, A'), findsOneWidget);

    // Nic není dokončené → 0 hvězd, zamčené uzly existují
    expect(find.textContaining('⭐ 0'), findsOneWidget);
    expect(find.text('🔒'), findsWidgets);

    // Nezískané odměny jednotek jsou ❓
    expect(find.text('❓'), findsWidgets);

    // Otevření mapy se počítá jako hrací den; průvodce je v liště
    expect(ProgressService.instance.playDays.length, 1);
    expect(find.byType(Mascot), findsOneWidget);
  });

  testWidgets('dlouhý stisk na lekci ukáže poznámku pro rodiče',
      (tester) async {
    await tester.pumpWidget(localizedApp(
      home: Scaffold(
        body: LessonMapScreen(
          language: Language.cs,
          onLanguageChanged: (_) {},
        ),
      ),
    ));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 400));

    // První uzel první jednotky (hint 👩, odemčený)
    await tester.longPress(find.text('👩').at(1)); // [0] = ikona jednotky
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 400));
    expect(find.textContaining('První slabika'), findsOneWidget);
    expect(find.byKey(const ValueKey('read-note')), findsOneWidget);
    await tester.tap(find.byKey(const ValueKey('read-note'))); // TTS tiše
  });

  testWidgets('procvičování se nabídne až od 3 naučených slov', (tester) async {
    Future<void> pumpMap() async {
      await tester.pumpWidget(localizedApp(
        home: Scaffold(
          body: LessonMapScreen(
            key: UniqueKey(),
            language: Language.cs,
            onLanguageChanged: (_) {},
          ),
        ),
      ));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 400));
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

  testWidgets('zamčené jednotky jsou v mlze, odemčená se jednou rozplyne',
      (tester) async {
    await tester.pumpWidget(localizedApp(
      home: Scaffold(
        body: LessonMapScreen(
          language: Language.cs,
          onLanguageChanged: (_) {},
        ),
      ),
    ));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));

    // Mlha nad zamčenými jednotkami (viditelné jsou jen první dvě tři)
    expect(find.text('🌫️'), findsWidgets);
    expect(ProgressService.instance.isUnitRevealed('cs-CZ', 'cs-u1'), isFalse);

    // Po rozplynutí se první jednotka zapíše jako odhalená
    await tester.pump(const Duration(seconds: 2));
    expect(ProgressService.instance.isUnitRevealed('cs-CZ', 'cs-u1'), isTrue);
  });

  testWidgets('✨ v odemčené jednotce dá tajnou nálepku biotopu a zmizí',
      (tester) async {
    await tester.pumpWidget(localizedApp(
      home: Scaffold(
        body: LessonMapScreen(
          language: Language.cs,
          onLanguageChanged: (_) {},
        ),
      ),
    ));
    await tester.pump();
    await tester.pump(const Duration(seconds: 2)); // mlha první jednotky pryč

    expect(find.byKey(const ValueKey('secret-cs-u1')), findsOneWidget);
    await tester.tap(find.byKey(const ValueKey('secret-cs-u1')));
    await tester.pump();
    expect(ProgressService.instance.collectibles('cs-CZ'), contains('🐞'));
    expect(find.text('✨ 🐞'), findsOneWidget);
    expect(find.byKey(const ValueKey('secret-cs-u1')), findsNothing);
    await tester.pump(const Duration(seconds: 4));
  });

  testWidgets('po časovém limitu průvodce spí a lekce nejdou spustit',
      (tester) async {
    final t = DateTime.now();
    final day =
        '${t.year}-${t.month.toString().padLeft(2, '0')}-${t.day.toString().padLeft(2, '0')}';
    SharedPreferences.setMockInitialValues({
      'sk.settings.sessionLimitMin': 10,
      'sk.session.$day': 11 * 60,
    });
    await ProgressService.init();
    await SettingsService.instance.load();
    await SessionService.instance.load();
    expect(SessionService.instance.limitReached, isTrue);

    await tester.pumpWidget(localizedApp(
      home: Scaffold(
        body: LessonMapScreen(
          language: Language.cs,
          onLanguageChanged: (_) {},
        ),
      ),
    ));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 400));
    expect(find.byKey(const ValueKey('bedtime')), findsOneWidget);
    expect(find.text('💤'), findsWidgets);

    // Lekce pod kartou se nespustí
    await tester.tap(find.text('👩').at(1), warnIfMissed: false);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 400));
    expect(find.byKey(const ValueKey('bedtime')), findsOneWidget);
    expect(find.text('M, A'), findsOneWidget); // pořád mapa, ne hra

    // Rodič prodlouží → karta zmizí
    SessionService.instance.extendToday();
    await tester.pump();
    expect(find.byKey(const ValueKey('bedtime')), findsNothing);
    await tester.pump(const Duration(seconds: 3));
    SettingsService.instance.sessionLimitMin = 0;
  });
}
