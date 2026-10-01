import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Denní doba světa hry.
enum DayPhase { morning, day, evening, night }

/// Roční období (severní polokoule; reálný kalendář je default — roadmap P1).
enum Season {
  spring('🌸'),
  summer('☀️'),
  autumn('🍂'),
  winter('❄️');

  const Season(this.emoji);
  final String emoji;
}

/// Částice ve světě podle období a denní doby.
enum ParticleKind { none, petals, fireflies, leaves, snow }

/// Biotop jednotky na mapě (`unit.scene.biome` v packu). Data, ne kód:
/// pack říká jen jméno, vzhled drží tahle tabulka.
enum Biome {
  meadow('🌼', Color(0xFF3E8E41), ['🌼', '🌷', '🦋', '🐝']),
  forest('🌲', Color(0xFF2E6B3A), ['🌲', '🌳', '🍄', '🦊']),
  pond('🐸', Color(0xFF2F7F8F), ['🐸', '🌿', '🦆', '🐟']),
  garden('🌻', Color(0xFF5A9E4B), ['🌻', '🌹', '🐌', '🍓']),
  farm('🐄', Color(0xFF8A7A3C), ['🐄', '🐓', '🌾', '🚜']),
  city('🏠', Color(0xFF6B6F80), ['🏠', '🏢', '🚗', '🚦']),
  mountains('⛰️', Color(0xFF6E7C8A), ['⛰️', '🏔️', '🦅', '🌲']),
  beach('🏖️', Color(0xFFC9B47A), ['🏖️', '🐚', '⛵', '🌴']),
  orchard('🍎', Color(0xFF5E9A4E), ['🍎', '🌳', '🍐', '🐝']),
  snow('⛄', Color(0xFFB9CCDF), ['⛄', '🎿', '🐧', '🌲']),
  jungle('🌴', Color(0xFF2F7A4F), ['🌴', '🐒', '🦜', '🌺']),
  sky('☁️', Color(0xFF5F9AD6), ['☁️', '🎈', '🪁', '🐦']);

  const Biome(this.emoji, this.ground, this.decor);

  final String emoji;
  final Color ground;
  final List<String> decor;

  /// Neznámé/prázdné jméno padá na louku (starší appka přežije novější pack).
  static Biome parse(String name) =>
      values.asNameMap()[name] ?? Biome.meadow;

  static bool isKnown(String name) => values.asNameMap().containsKey(name);
}

/// Zdroj času světa: roční období a denní doba podle reálných hodin.
/// Čas je injektovatelný kvůli testům; období může rodič přepnout ručně.
/// Jako [ChangeNotifier] hlásí změnu fáze dne (kontrola jednou za minutu)
/// i změnu ručního období.
class WorldClockService extends ChangeNotifier {
  final DateTime Function() _now;
  Season? _seasonOverride;
  SharedPreferences? _prefs;
  Timer? _timer;
  (DayPhase, Season)? _lastKey;

  WorldClockService({DateTime Function()? now}) : _now = now ?? DateTime.now;

  static final WorldClockService instance = WorldClockService();

  static const _kSeasonKey = 'sk.settings.season';

  DayPhase get phase => phaseAt(_now());
  Season get calendarSeason => seasonAt(_now());
  Season get season => _seasonOverride ?? calendarSeason;
  WorldTheme get theme => WorldTheme.of(phase, season);

  /// Ručně zvolené období; null = podle kalendáře.
  Season? get seasonOverride => _seasonOverride;

  set seasonOverride(Season? value) {
    if (value == _seasonOverride) return;
    _seasonOverride = value;
    if (value == null) {
      _prefs?.remove(_kSeasonKey);
    } else {
      _prefs?.setString(_kSeasonKey, value.name);
    }
    notifyListeners();
  }

  Future<void> loadSettings() async {
    _prefs = await SharedPreferences.getInstance();
    _seasonOverride =
        Season.values.asNameMap()[_prefs!.getString(_kSeasonKey) ?? ''];
  }

  /// Denní doba se mění pomalu — stačí kontrola jednou za minutu.
  void start() {
    _timer?.cancel();
    _lastKey = (phase, season);
    _timer = Timer.periodic(const Duration(minutes: 1), (_) => tick());
  }

  /// Zkontroluje změnu fáze/období a případně ohlásí posluchačům.
  void tick() {
    final key = (phase, season);
    if (key != _lastKey) {
      _lastKey = key;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

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

/// Vizuální podoba světa pro denní dobu × období. Barvy drží dost tmavé,
/// aby na nich zůstal čitelný bílý a žlutý text mapy.
class WorldTheme {
  final DayPhase phase;
  final Season season;
  final List<Color> sky;
  final String celestial; // slunce / měsíc

  const WorldTheme._(this.phase, this.season, this.sky, this.celestial);

  static const _skyByPhase = {
    DayPhase.morning: [Color(0xFF243B6B), Color(0xFF3E5F8A), Color(0xFF9A6A7E)],
    DayPhase.day: [Color(0xFF1E3C72), Color(0xFF2A5298), Color(0xFF2F74B5)],
    DayPhase.evening: [Color(0xFF2C1A4D), Color(0xFF4F2A68), Color(0xFF8E3F5E)],
    DayPhase.night: [Color(0xFF1A1A2E), Color(0xFF16213E), Color(0xFF0F3460)],
  };

  // Nádech období: zima bledší a modřejší, podzim do oranžova, jaro do růžova.
  static const _seasonTint = {
    Season.spring: (Color(0xFF7A5C8E), 0.15),
    Season.summer: (Color(0xFF2F74B5), 0.0),
    Season.autumn: (Color(0xFF8A4B2E), 0.2),
    Season.winter: (Color(0xFF4A6FA5), 0.25),
  };

  static WorldTheme of(DayPhase phase, Season season) {
    final (tint, amount) = _seasonTint[season]!;
    final sky = [
      for (final c in _skyByPhase[phase]!) Color.lerp(c, tint, amount)!,
    ];
    final celestial = switch (phase) {
      DayPhase.morning => '🌅',
      DayPhase.day => '☀️',
      DayPhase.evening => '🌇',
      DayPhase.night => '🌙',
    };
    return WorldTheme._(phase, season, sky, celestial);
  }

  static WorldTheme forPhase(DayPhase phase) => of(phase, Season.summer);

  static final morning = forPhase(DayPhase.morning);
  static final day = forPhase(DayPhase.day);
  static final evening = forPhase(DayPhase.evening);
  static final night = forPhase(DayPhase.night);

  bool get isNight => phase == DayPhase.night;
  bool get isDark => phase == DayPhase.night || phase == DayPhase.evening;

  /// Částice: zima sníh, podzim listí, jaro květy, léto světlušky po setmění.
  ParticleKind get particles => switch (season) {
        Season.winter => ParticleKind.snow,
        Season.autumn => ParticleKind.leaves,
        Season.spring => ParticleKind.petals,
        Season.summer => isDark ? ParticleKind.fireflies : ParticleKind.none,
      };

  LinearGradient get gradient => LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: sky,
      );

  /// Ambientní scéna (id v `assets/audio/manifest.json`): v noci cvrčci,
  /// u vody šplouchání, jinak ptáci a vítr.
  String ambientFor(Biome biome) {
    if (isNight) return 'night';
    if (biome == Biome.pond || biome == Biome.beach) return 'water';
    return 'day';
  }

  /// Barva země biotopu: v noci tmavší, v zimě zasněžená, na podzim teplejší.
  Color groundOf(Biome biome) {
    var c = biome.ground;
    c = switch (season) {
      Season.winter => Color.lerp(c, const Color(0xFFDDE8F3), 0.55)!,
      Season.autumn => Color.lerp(c, const Color(0xFFC77A2E), 0.3)!,
      Season.spring => Color.lerp(c, const Color(0xFF9ED08A), 0.15)!,
      Season.summer => c,
    };
    final darken = switch (phase) {
      DayPhase.day => 0.0,
      DayPhase.morning => 0.15,
      DayPhase.evening => 0.35,
      DayPhase.night => 0.6,
    };
    return Color.lerp(c, const Color(0xFF0B1020), darken)!;
  }
}
