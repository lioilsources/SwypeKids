import 'package:cute_kid_fonts/cute_kid_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swype_kids/data/lessons.dart';
import 'package:swype_kids/main.dart';
import 'package:swype_kids/services/profile_service.dart';
import 'package:swype_kids/services/progress_service.dart';
import 'package:swype_kids/services/session_service.dart';
import 'package:swype_kids/services/settings_service.dart';
import 'package:swype_kids/world/world_clock.dart';

import 'helpers.dart';

void main() {
  setUp(() async {
    SharedPreferences.setMockInitialValues({
      'sk.profiles': '[{"id":1,"name":"Ema","avatar":"🐼"}]',
      'sk.activeProfile': 1,
      'sk.selectedLanguage': 'cs',
      'sk.settings.season': 'spring',
    });
    await ProfileService.init();
    await ProgressService.init(profile: 1);
    await WorldClockService.instance.loadSettings();
    await SettingsService.instance.load();
    await SessionService.instance.load();
    await seedPack(Language.cs);
    await seedPack(Language.en);
  });

  testWidgets('celá appka s existujícím profilem: mapa se načte (ne 🎹)',
      (tester) async {
    await tester.pumpWidget(const SwyperKidsApp());
    for (var i = 0; i < 20; i++) {
      await tester.pump(const Duration(milliseconds: 100));
    }
    expect(findText('🎹'), findsNothing, reason: 'mapa visí na placeholderu');
    expect(findText('M, A'), findsOneWidget);
    await tester.pump(const Duration(seconds: 5));
  }, timeout: const Timeout(Duration(seconds: 60)));

  /// Rodiny písma všech vykreslených textů s písmeny (i těch bez vlastního
  /// stylu). Ikony (MaterialIcons) a samotná emoji se nepočítají — ta
  /// kreslí systémové emoji písmo vždy.
  Set<String?> fontsOnScreen(WidgetTester tester) => {
        for (final e in find.byType(RichText).evaluate())
          if (RegExp(r'[\p{L}\p{N}]', unicode: true).hasMatch(
              (e.renderObject! as RenderParagraph).text.toPlainText()))
            (e.renderObject! as RenderParagraph).text.style?.fontFamily,
      }..remove('MaterialIcons');

  testWidgets('všechen text je v písmu appky, nikde systémové', (tester) async {
    await tester.pumpWidget(const SwyperKidsApp());
    for (var i = 0; i < 20; i++) {
      await tester.pump(const Duration(milliseconds: 100));
    }
    // I menu (tlačítka, popisky bez vlastního stylu).
    final scaffold = tester.firstState<ScaffoldState>(find.byType(Scaffold));
    scaffold.openDrawer();
    for (var i = 0; i < 10; i++) {
      await tester.pump(const Duration(milliseconds: 100));
    }
    expect(fontsOnScreen(tester),
        everyElement(isIn([KidFonts.baloo2, KidFonts.dynaPuff])));

    // Písmo pro dyslektiky přepne i text bez vlastního stylu.
    SettingsService.instance.dyslexiaFont = true;
    addTearDown(() => SettingsService.instance.dyslexiaFont = false);
    await tester.pump(const Duration(seconds: 1)); // AnimatedTheme
    expect(fontsOnScreen(tester), everyElement('OpenDyslexic'));
    await tester.pump(const Duration(seconds: 5));
  }, timeout: const Timeout(Duration(seconds: 60)));
}
