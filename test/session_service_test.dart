import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swype_kids/services/session_service.dart';
import 'package:swype_kids/services/settings_service.dart';

void main() {
  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    await SettingsService.instance.load();
    SettingsService.instance.sessionLimitMin = 0;
  });

  test('limit: po 10 min průvodce spí, prodloužení o 10 min ho probudí', () async {
    var now = DateTime(2026, 10, 1, 15, 0);
    final s = SessionService(now: () => now);
    await s.load();
    var notified = 0;
    s.addListener(() => notified++);
    SettingsService.instance.sessionLimitMin = 10;
    expect(s.limitMinToday, 10);

    s.start();
    now = now.add(const Duration(minutes: 9));
    s.tick();
    expect(s.limitReached, isFalse);
    expect(s.playedMinToday, 9);

    now = now.add(const Duration(minutes: 1));
    s.tick();
    expect(s.limitReached, isTrue);
    expect(notified, 1);

    s.extendToday();
    expect(s.limitMinToday, 20);
    expect(s.limitReached, isFalse);

    now = now.add(const Duration(minutes: 10));
    s.tick();
    expect(s.limitReached, isTrue);
    s.stop();

    // Přežije restart (čas i prodloužení dne)
    final s2 = SessionService(now: () => now);
    await s2.load();
    expect(s2.playedMinToday, 20);
    expect(s2.limitMinToday, 20);
    expect(s2.limitReached, isTrue);
    s.dispose();
    s2.dispose();
  });

  test('nový den začíná od nuly, bez limitu nikdy nespí', () async {
    var now = DateTime(2026, 10, 1, 23, 55);
    final s = SessionService(now: () => now);
    await s.load();
    SettingsService.instance.sessionLimitMin = 10;
    s.start();
    now = now.add(const Duration(minutes: 20));
    s.tick(); // už je 2. 10. → nový den
    expect(s.playedMinToday, 0);
    expect(s.limitReached, isFalse);

    SettingsService.instance.sessionLimitMin = 0;
    now = now.add(const Duration(hours: 3));
    s.tick();
    expect(s.limitReached, isFalse);
    s.dispose();
  });
}
