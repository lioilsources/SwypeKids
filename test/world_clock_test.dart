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
    expect(clock.theme.phase, DayPhase.morning);
    expect(clock.theme.season, Season.summer);

    now = at(1, 22);
    expect(clock.phase, DayPhase.night);
    expect(clock.season, Season.winter);
    expect(clock.theme.celestial, '🌙');
  });

  test('ruční období přebije kalendář a ohlásí posluchače', () {
    final clock = WorldClockService(now: () => at(1, 12)); // zima
    var notified = 0;
    clock.addListener(() => notified++);
    expect(clock.season, Season.winter);
    clock.seasonOverride = Season.summer;
    expect(clock.season, Season.summer);
    expect(clock.calendarSeason, Season.winter);
    expect(notified, 1);
    clock.seasonOverride = Season.summer; // beze změny → bez notifikace
    expect(notified, 1);
    clock.seasonOverride = null;
    expect(clock.season, Season.winter);
    expect(notified, 2);
  });

  test('tick ohlásí jen změnu fáze dne', () {
    var now = at(1, 9);
    final clock = WorldClockService(now: () => now);
    var notified = 0;
    clock.addListener(() => notified++);
    clock.start();
    clock.tick();
    expect(notified, 0);
    now = at(1, 11);
    clock.tick();
    expect(notified, 1);
    clock.dispose();
  });

  test('částice podle období a denní doby', () {
    expect(WorldTheme.of(DayPhase.day, Season.winter).particles, ParticleKind.snow);
    expect(WorldTheme.of(DayPhase.day, Season.autumn).particles, ParticleKind.leaves);
    expect(WorldTheme.of(DayPhase.day, Season.spring).particles, ParticleKind.petals);
    expect(WorldTheme.of(DayPhase.day, Season.summer).particles, ParticleKind.none);
    expect(WorldTheme.of(DayPhase.night, Season.summer).particles,
        ParticleKind.fireflies);
  });

  test('obloha i země se liší podle období a jsou dost tmavé pro text', () {
    final winter = WorldTheme.of(DayPhase.day, Season.winter);
    final summer = WorldTheme.of(DayPhase.day, Season.summer);
    expect(winter.sky, isNot(equals(summer.sky)));
    for (final t in [winter, summer, WorldTheme.of(DayPhase.night, Season.autumn)]) {
      for (final c in t.sky) {
        expect(c.computeLuminance(), lessThan(0.2), reason: '${t.phase} ${t.season}');
      }
    }
    final night = WorldTheme.of(DayPhase.night, Season.summer);
    expect(night.groundOf(Biome.meadow).computeLuminance(),
        lessThan(summer.groundOf(Biome.meadow).computeLuminance()));
  });

  test('neznámý biotop padá na louku', () {
    expect(Biome.parse('forest'), Biome.forest);
    expect(Biome.parse('lava'), Biome.meadow);
    expect(Biome.parse(''), Biome.meadow);
    expect(Biome.isKnown('lava'), isFalse);
  });

  test('každá fáze má vlastní téma', () {
    final themes = DayPhase.values.map(WorldTheme.forPhase).toSet();
    expect(themes.length, DayPhase.values.length);
    for (final p in DayPhase.values) {
      expect(WorldTheme.forPhase(p).phase, p);
    }
  });
}
