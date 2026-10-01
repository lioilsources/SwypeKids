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
    expect(find.text('🎹'), findsNothing, reason: 'mapa visí na placeholderu');
    expect(find.text('M, A'), findsOneWidget);
    await tester.pump(const Duration(seconds: 5));
  }, timeout: const Timeout(Duration(seconds: 60)));
}
