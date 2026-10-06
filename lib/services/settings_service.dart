import 'dart:ui' show Offset;

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Nastavení rodiče mimo zvuk (ten drží AudioService) a období
/// (WorldClockService): levák, časový limit session. Společné pro všechny
/// profily — patří rodiči, ne dítěti.
class SettingsService extends ChangeNotifier {
  SettingsService._();
  static final SettingsService instance = SettingsService._();

  static const _kLeftHanded = 'sk.settings.leftHanded';
  static const _kSessionLimit = 'sk.settings.sessionLimitMin';
  static const _kDyslexiaFont = 'sk.settings.dyslexiaFont';
  static const _kGuidePos = 'sk.settings.guidePos';
  static const _kPetRounds = 'sk.settings.petRounds';

  /// Povolené limity session v minutách; 0 = bez limitu.
  static const sessionLimits = [0, 10, 15, 20];

  SharedPreferences? _prefs;
  bool _leftHanded = false;
  int _sessionLimitMin = 0;
  bool _dyslexiaFont = false;

  final Map<String, Offset> _guidePositions = {};

  /// Kam dítě naposledy posunulo průvodce na obrazovce [place] (`game`,
  /// `map`) — podíl volné šířky a výšky (0–1); `null` = výchozí vpravo dole.
  Offset? guidePositionFor(String place) => _guidePositions[place];

  void setGuidePosition(String place, Offset v) {
    _guidePositions[place] = v;
    _prefs?.setString(_guideKey(place), '${v.dx},${v.dy}');
  }

  // Hra používá původní klíč (v2.8), ať se pozice po aktualizaci neztratí.
  static String _guideKey(String place) =>
      place == 'game' ? _kGuidePos : '$_kGuidePos.$place';

  static Offset? _parseOffset(String? raw) {
    final g = raw?.split(',');
    final gx = g == null || g.length != 2 ? null : double.tryParse(g[0]);
    final gy = g == null || g.length != 2 ? null : double.tryParse(g[1]);
    return gx == null || gy == null
        ? null
        : Offset(gx.clamp(0.0, 1.0), gy.clamp(0.0, 1.0));
  }

  bool _petRounds = true;

  /// Svět zvířátka: ťuknutí na dárek nejdřív nabídne slovo napsat (trénink).
  /// Vypnuto = dárky se jen dávají.
  bool get petRounds => _petRounds;

  set petRounds(bool v) {
    if (v == _petRounds) return;
    _petRounds = v;
    _prefs?.setBool(_kPetRounds, v);
    notifyListeners();
  }

  /// Písmo OpenDyslexic místo DynaPuff v celé appce.
  bool get dyslexiaFont => _dyslexiaFont;

  set dyslexiaFont(bool v) {
    if (v == _dyslexiaFont) return;
    _dyslexiaFont = v;
    _prefs?.setBool(_kDyslexiaFont, v);
    notifyListeners();
  }

  /// Zrcadlená klávesnice (řady zprava doleva) — kratší cesta pro levou ruku.
  bool get leftHanded => _leftHanded;

  set leftHanded(bool v) {
    if (v == _leftHanded) return;
    _leftHanded = v;
    _prefs?.setBool(_kLeftHanded, v);
    notifyListeners();
  }

  int get sessionLimitMin => _sessionLimitMin;

  set sessionLimitMin(int v) {
    if (v == _sessionLimitMin) return;
    _sessionLimitMin = v;
    _prefs?.setInt(_kSessionLimit, v);
    notifyListeners();
  }

  Future<void> load() async {
    _prefs = await SharedPreferences.getInstance();
    _leftHanded = _prefs!.getBool(_kLeftHanded) ?? false;
    _sessionLimitMin = _prefs!.getInt(_kSessionLimit) ?? 0;
    _dyslexiaFont = _prefs!.getBool(_kDyslexiaFont) ?? false;
    _petRounds = _prefs!.getBool(_kPetRounds) ?? true;
    _guidePositions.clear();
    for (final place in const ['game', 'map', 'pet']) {
      final o = _parseOffset(_prefs!.getString(_guideKey(place)));
      if (o != null) _guidePositions[place] = o;
    }
  }
}
