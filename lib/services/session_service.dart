import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'settings_service.dart';

/// Časový limit session (roadmap P6): počítá čas, kdy je appka v popředí,
/// per den (společně pro všechny profily — limit je rodiče). Po limitu
/// maskot „jde spát"; prodloužit jde jen z rodičovského koutku.
class SessionService extends ChangeNotifier {
  SessionService({DateTime Function()? now, SettingsService? settings})
      : _now = now ?? DateTime.now,
        _settings = settings ?? SettingsService.instance;

  static final SessionService instance = SessionService();

  static const _kPrefix = 'sk.session.'; // sk.session.YYYY-MM-DD → sekundy
  static const _kExtraPrefix = 'sk.sessionExtra.'; // prodloužení (minuty)
  static const extendMinutes = 10;
  static const _tick = Duration(seconds: 15);

  final DateTime Function() _now;
  final SettingsService _settings;
  SharedPreferences? _prefs;
  Timer? _timer;
  DateTime? _runningSince;
  String _day = '';
  int _playedSec = 0;
  int _extraMin = 0;
  bool _limitReached = false;

  String _dayKey(DateTime t) =>
      '${t.year}-${t.month.toString().padLeft(2, '0')}-${t.day.toString().padLeft(2, '0')}';

  Future<void> load() async {
    _prefs = await SharedPreferences.getInstance();
    _loadDay();
    _settings.addListener(_recheck);
  }

  void _loadDay() {
    _day = _dayKey(_now());
    _playedSec = _prefs?.getInt('$_kPrefix$_day') ?? 0;
    _extraMin = _prefs?.getInt('$_kExtraPrefix$_day') ?? 0;
    _recheck();
  }

  /// Odehrané sekundy dnes (včetně běžícího úseku).
  int get playedSecToday {
    final since = _runningSince;
    final running = since == null ? 0 : _now().difference(since).inSeconds;
    return _playedSec + running;
  }

  int get playedMinToday => playedSecToday ~/ 60;

  /// Limit v minutách pro dnešek (nastavení + prodloužení); 0 = bez limitu.
  int get limitMinToday =>
      _settings.sessionLimitMin == 0 ? 0 : _settings.sessionLimitMin + _extraMin;

  bool get limitReached => _limitReached;

  /// Appka přišla do popředí.
  void start() {
    if (_dayKey(_now()) != _day) {
      _runningSince = null;
      _loadDay();
    }
    _runningSince ??= _now();
    _timer?.cancel();
    _timer = Timer.periodic(_tick, (_) => tick());
  }

  /// Appka šla na pozadí / sezení skončilo.
  void stop() {
    _timer?.cancel();
    _timer = null;
    _flush();
  }

  void _flush() {
    final since = _runningSince;
    if (since == null) return;
    _playedSec += _now().difference(since).inSeconds;
    _runningSince = _timer == null ? null : _now();
    _prefs?.setInt('$_kPrefix$_day', _playedSec);
  }

  /// Uloží průběžný čas a zkontroluje limit (volá se každých 15 s).
  void tick() {
    if (_dayKey(_now()) != _day) {
      _runningSince = null;
      _loadDay();
      _runningSince = _now();
      return;
    }
    _flush();
    _recheck();
  }

  void _recheck() {
    final limit = limitMinToday;
    final reached = limit > 0 && playedSecToday >= limit * 60;
    if (reached != _limitReached) {
      _limitReached = reached;
      notifyListeners();
    }
  }

  /// Rodič prodloužil dnešek o [extendMinutes].
  void extendToday() {
    _extraMin += extendMinutes;
    _prefs?.setInt('$_kExtraPrefix$_day', _extraMin);
    _recheck();
    notifyListeners();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _settings.removeListener(_recheck);
    super.dispose();
  }
}
