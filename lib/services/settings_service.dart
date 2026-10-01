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

  /// Povolené limity session v minutách; 0 = bez limitu.
  static const sessionLimits = [0, 10, 15, 20];

  SharedPreferences? _prefs;
  bool _leftHanded = false;
  int _sessionLimitMin = 0;

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
  }
}
