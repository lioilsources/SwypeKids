import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swype_kids/characters/mascot.dart';
import 'package:swype_kids/data/lessons.dart';
import 'package:swype_kids/screens/lesson_map_screen.dart';
import 'package:swype_kids/services/progress_service.dart';
import 'package:swype_kids/services/session_service.dart';
import 'package:swype_kids/services/settings_service.dart';
import 'package:swype_kids/world/world_clock.dart';
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
    expect(findText('M, A'), findsOneWidget);

    // Nic není dokončené → 0 hvězd, zamčené uzly existují
    expect(find.textContaining('⭐ 0'), findsOneWidget);
    expect(findText('🔒'), findsWidgets);

    // Nezískané odměny jednotek jsou ❓
    expect(findText('❓'), findsWidgets);

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
    await tester.longPress(findText('👩').at(1)); // [0] = ikona jednotky
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
    expect(findText('Procvičování'), findsNothing);

    final p = ProgressService.instance;
    // MA, TA, BA (u1-l1, u2-l1, u3-l1)
    for (final id in ['cs-u1-l1', 'cs-u2-l1', 'cs-u3-l1']) {
      p.markCompleted('cs-CZ', id, 3);
    }
    await pumpMap();
    expect(findText('Procvičování'), findsOneWidget);
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
    expect(findText('🌫️'), findsWidgets);
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
    expect(findText('🐞'), findsWidgets); // čip ✨ + nálepka
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
    expect(findText('💤'), findsWidgets);

    // Lekce pod kartou se nespustí
    await tester.tap(findText('👩').at(1), warnIfMissed: false);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 400));
    expect(find.byKey(const ValueKey('bedtime')), findsOneWidget);
    expect(findText('M, A'), findsOneWidget); // pořád mapa, ne hra

    // Rodič prodlouží → karta zmizí
    SessionService.instance.extendToday();
    await tester.pump();
    expect(find.byKey(const ValueKey('bedtime')), findsNothing);
    await tester.pump(const Duration(seconds: 3));
    SettingsService.instance.sessionLimitMin = 0;
  });

  testWidgets('od 10 naučených slov se jednou týdně nabídne výprava místo procvičování',
      (tester) async {
    final p = ProgressService.instance;
    const ids = ['cs-u1-l1', 'cs-u2-l1', 'cs-u3-l1', 'cs-u4-l1', 'cs-u4-l2',
      'cs-u5-l1', 'cs-u5-l2', 'cs-u6-l1', 'cs-u6-l2', 'cs-u6-l3'];
    for (final id in ids) {
      p.markCompleted('cs-CZ', id, 3);
    }
    await tester.pumpWidget(localizedApp(
      home: Scaffold(
        body: LessonMapScreen(language: Language.cs, onLanguageChanged: (_) {}),
      ),
    ));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 400));
    expect(find.byKey(const ValueKey('expedition')), findsOneWidget);
    expect(findText('Výprava za opakováním'), findsOneWidget);
    expect(findText('Procvičování'), findsNothing);

    // Po dnešní výpravě se zase ukáže obyčejné procvičování
    p.markExpedition(DateTime.now());
    await tester.pumpWidget(localizedApp(
      home: Scaffold(
        body: LessonMapScreen(
            key: UniqueKey(), language: Language.cs, onLanguageChanged: (_) {}),
      ),
    ));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 400));
    expect(find.byKey(const ValueKey('expedition')), findsNothing);
    expect(findText('Procvičování'), findsOneWidget);
    await tester.pump(const Duration(seconds: 3));
  });

  testWidgets('sezónní překvapení je jen na rozehrané jednotce a dá nálepku období',
      (tester) async {
    await tester.pumpWidget(localizedApp(
      home: Scaffold(
        body: LessonMapScreen(language: Language.cs, onLanguageChanged: (_) {}),
      ),
    ));
    await tester.pump();
    await tester.pump(const Duration(seconds: 2));
    final season = WorldClockService.instance.season;
    expect(find.byKey(const ValueKey('seasonal-cs-u1')), findsOneWidget);
    expect(find.byKey(const ValueKey('seasonal-cs-u2')), findsNothing);
    await tester.tap(find.byKey(const ValueKey('seasonal-cs-u1')));
    await tester.pump();
    expect(ProgressService.instance.collectibles('cs-CZ'), contains(season.secret));
    expect(find.byKey(const ValueKey('seasonal-cs-u1')), findsNothing);
    await tester.pump(const Duration(seconds: 4));
  });

  testWidgets('Pandička stojí dole na mapě a po chvíli přejde do druhého rohu',
      (tester) async {
    tester.view.physicalSize = const Size(800, 1400);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(localizedApp(
      home: Scaffold(
        body: LessonMapScreen(language: Language.cs, onLanguageChanged: (_) {}),
      ),
    ));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 400));
    final mascot = find.byKey(const ValueKey('map-mascot'));
    expect(mascot, findsOneWidget);
    final start = tester.getCenter(mascot);
    expect(start.dy, greaterThan(1100)); // dole na ploše, ne v liště
    expect(start.dx, greaterThan(400)); // začíná vpravo

    await tester.pump(const Duration(seconds: 25));
    await tester.pump(const Duration(seconds: 3)); // dojde
    // V noci Pandička spí a nechodí (test podle reálných hodin).
    if (!WorldClockService.instance.theme.isNight) {
      expect(tester.getCenter(mascot).dx, lessThan(400));
    }
    await tester.pump(const Duration(seconds: 3));
  });

  testWidgets('ťuknutí na Pandičku na mapě = zamává', (tester) async {
    tester.view.physicalSize = const Size(800, 1400);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(localizedApp(
      home: Scaffold(
        body: LessonMapScreen(language: Language.cs, onLanguageChanged: (_) {}),
      ),
    ));
    await tester.pump();
    await tester.pump(const Duration(seconds: 2)); // úvodní zamávání dohraje
    expect(find.byKey(const ValueKey('mascot-wave')), findsNothing);
    await tester.tap(find.byKey(const ValueKey('map-mascot')));
    await tester.pump();
    expect(find.byKey(const ValueKey('mascot-wave')), findsOneWidget);
    await tester.pump(const Duration(seconds: 3));
  });
}
