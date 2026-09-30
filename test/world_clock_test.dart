import 'package:flutter_test/flutter_test.dart';
import 'package:swype_kids/world/world_clock.dart';

void main() {
  DateTime at(int month, int hour) => DateTime(2026, month, 15, hour, 30);

  test('denní doba podle hodin včetně hranic', () {
    expect(WorldClockService.phaseAt(at(1, 5)), DayPhase.night);
    expect(WorldClockService.phaseAt(at(1, 6)), DayPhase.morning);
    expect(WorldClockService.phaseAt(at(1, 9)), DayPhase.morning);
    expect(WorldClockService.phaseAt(at(1, 10)), DayPhase.day);
    expect(WorldClockService.phaseAt(at(1, 17)), DayPhase.day);
    expect(WorldClockService.phaseAt(at(1, 18)), DayPhase.evening);
    expect(WorldClockService.phaseAt(at(1, 20)), DayPhase.evening);
    expect(WorldClockService.phaseAt(at(1, 21)), DayPhase.night);
    expect(WorldClockService.phaseAt(at(1, 0)), DayPhase.night);
  });

  test('roční období podle měsíce', () {
    expect(WorldClockService.seasonAt(at(12, 12)), Season.winter);
    expect(WorldClockService.seasonAt(at(2, 12)), Season.winter);
    expect(WorldClockService.seasonAt(at(3, 12)), Season.spring);
    expect(WorldClockService.seasonAt(at(6, 12)), Season.summer);
    expect(WorldClockService.seasonAt(at(9, 12)), Season.autumn);
    expect(WorldClockService.seasonAt(at(11, 12)), Season.autumn);
  });

  test('injektovaný čas řídí fázi, období i téma', () {
    var now = at(7, 8);
    final clock = WorldClockService(now: () => now);
    expect(clock.phase, DayPhase.morning);
    expect(clock.season, Season.summer);
    expect(clock.theme, same(WorldTheme.morning));

    now = at(1, 22);
    expect(clock.phase, DayPhase.night);
    expect(clock.season, Season.winter);
    expect(clock.theme.celestial, '🌙');
  });

  test('každá fáze má vlastní téma', () {
    final themes = DayPhase.values.map(WorldTheme.forPhase).toSet();
    expect(themes.length, DayPhase.values.length);
    for (final p in DayPhase.values) {
      expect(WorldTheme.forPhase(p).phase, p);
    }
  });
}
