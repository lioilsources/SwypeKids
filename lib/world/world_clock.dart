import 'package:flutter/material.dart';

/// Denní doba světa hry.
enum DayPhase { morning, day, evening, night }

/// Roční období (severní polokoule; reálný kalendář je default — roadmap P1).
enum Season { spring, summer, autumn, winter }

/// Zdroj času světa: roční období a denní doba podle reálných hodin.
/// Čas je injektovatelný kvůli testům a budoucímu override z rodičovského
/// koutku.
class WorldClockService {
  final DateTime Function() _now;

  WorldClockService({DateTime Function()? now}) : _now = now ?? DateTime.now;

  static final WorldClockService instance = WorldClockService();

  DayPhase get phase => phaseAt(_now());
  Season get season => seasonAt(_now());
  WorldTheme get theme => WorldTheme.forPhase(phase);

  /// 6–10 ráno, 10–18 den, 18–21 večer, jinak noc.
  static DayPhase phaseAt(DateTime t) {
    final h = t.hour;
    if (h >= 6 && h < 10) return DayPhase.morning;
    if (h >= 10 && h < 18) return DayPhase.day;
    if (h >= 18 && h < 21) return DayPhase.evening;
    return DayPhase.night;
  }

  /// Meteorologická období: jaro 3–5, léto 6–8, podzim 9–11, zima 12–2.
  static Season seasonAt(DateTime t) => switch (t.month) {
        3 || 4 || 5 => Season.spring,
        6 || 7 || 8 => Season.summer,
        9 || 10 || 11 => Season.autumn,
        _ => Season.winter,
      };
}

/// Vizuální podoba světa pro danou denní dobu. Barvy drží dost tmavé, aby
/// na nich zůstal čitelný bílý a žlutý text mapy.
class WorldTheme {
  final DayPhase phase;
  final List<Color> sky;
  final String celestial; // slunce / měsíc v rohu mapy

  const WorldTheme._(this.phase, this.sky, this.celestial);

  static const morning = WorldTheme._(
    DayPhase.morning,
    [Color(0xFF243B6B), Color(0xFF3E5F8A), Color(0xFF9A6A7E)],
    '🌅',
  );
  static const day = WorldTheme._(
    DayPhase.day,
    [Color(0xFF1E3C72), Color(0xFF2A5298), Color(0xFF2F74B5)],
    '☀️',
  );
  static const evening = WorldTheme._(
    DayPhase.evening,
    [Color(0xFF2C1A4D), Color(0xFF4F2A68), Color(0xFF8E3F5E)],
    '🌇',
  );
  static const night = WorldTheme._(
    DayPhase.night,
    [Color(0xFF1A1A2E), Color(0xFF16213E), Color(0xFF0F3460)],
    '🌙',
  );

  static WorldTheme forPhase(DayPhase phase) => switch (phase) {
        DayPhase.morning => morning,
        DayPhase.day => day,
        DayPhase.evening => evening,
        DayPhase.night => night,
      };

  LinearGradient get gradient => LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: sky,
      );
}
