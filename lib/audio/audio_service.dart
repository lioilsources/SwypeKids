import 'dart:convert';
import 'dart:math';

import 'package:flutter/services.dart';
import 'package:flutter_soloud/flutter_soloud.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/keyboard_layout.dart' show kRows;

/// Zvukové efekty ze sfx katalogu (`assets/audio/manifest.json`).
enum Sfx { key, success, error, star, sticker, tap }

/// Přehrává krátké zvuky hry přes flutter_soloud (nízká latence pro tóny
/// při swype). Hra musí fungovat i beze zvuku: pokud engine nejde spustit
/// (testy, chybějící audio zařízení), všechna volání jsou tichá no-op.
class AudioService {
  AudioService._();
  static final AudioService instance = AudioService._();

  static const _kSfxEnabledKey = 'sk.settings.sfx';
  static const _kAmbientEnabledKey = 'sk.settings.ambient';
  static const ambientVolume = 0.22;
  static const _ambientFade = Duration(milliseconds: 900);
  static const _manifestPath = 'assets/audio/manifest.json';
  static const _successVariants = 3;

  SharedPreferences? _prefs;
  bool _sfxEnabled = true;
  bool _ambientEnabled = true;
  bool _ready = false;
  final Map<String, AudioSource> _sources = {};
  final Map<String, AudioSource> _ambientSources = {};
  int _successIdx = 0;

  // Ambient: jedna smyčka naráz (scéna podle biotopu × denní doby).
  String? _ambientWanted; // co má hrát (i když je zrovna vypnuto / engine nejede)
  String? _ambientPlaying;
  SoundHandle? _ambientHandle;

  bool get sfxEnabled => _sfxEnabled;

  set sfxEnabled(bool value) {
    _sfxEnabled = value;
    _prefs?.setBool(_kSfxEnabledKey, value);
  }

  bool get ambientEnabled => _ambientEnabled;

  set ambientEnabled(bool value) {
    _ambientEnabled = value;
    _prefs?.setBool(_kAmbientEnabledKey, value);
    _syncAmbient();
  }

  /// Scéna, která právě hraje (null = ticho). Pro testy a ladění.
  String? get ambientPlaying => _ambientPlaying;

  /// Načte nastavení (rychlé) — volat před runApp.
  Future<void> loadSettings() async {
    _prefs = await SharedPreferences.getInstance();
    _sfxEnabled = _prefs!.getBool(_kSfxEnabledKey) ?? true;
    _ambientEnabled = _prefs!.getBool(_kAmbientEnabledKey) ?? true;
  }

  /// Spustí audio engine a načte sfx do paměti. Neblokuje start appky —
  /// volá se bez await; do dokončení jsou zvuky tiché.
  Future<void> init() async {
    try {
      await SoLoud.instance.init();
      final manifest = jsonDecode(await rootBundle.loadString(_manifestPath))
          as Map<String, dynamic>;
      final sfx = manifest['sfx'] as Map<String, dynamic>;
      for (final entry in sfx.entries) {
        _sources[entry.key] = await SoLoud.instance.loadAsset(entry.value);
      }
      final ambient =
          (manifest['ambient'] as Map<String, dynamic>?) ?? const {};
      for (final entry in ambient.entries) {
        _ambientSources[entry.key] =
            await SoLoud.instance.loadAsset(entry.value);
      }
      _ready = true;
      _syncAmbient(); // scéna vyžádaná před startem enginu
    } catch (_) {
      _ready = false; // bez zvuku, hra běží dál
    }
  }

  /// Přehraje efekt; [pitch] je relativní rychlost (1.0 = původní výška).
  void play(Sfx sfx, {double pitch = 1.0, double volume = 1.0}) {
    final id = switch (sfx) {
      Sfx.success => 'success_${_successIdx++ % _successVariants}',
      _ => sfx.name,
    };
    _playId(id, pitch: pitch, volume: volume);
  }

  // ── Ambient ───────────────────────────────────────────────────────────────

  /// Přepne ambientní scénu (id z manifestu, např. 'day'); null = ticho.
  /// Stejná scéna se nerestartuje, přechod je s krátkým prolnutím.
  void setAmbient(String? id) {
    _ambientWanted = id;
    _syncAmbient();
  }

  void _syncAmbient() {
    final target = (_ready && _ambientEnabled) ? _ambientWanted : null;
    if (target == _ambientPlaying) return;
    try {
      final old = _ambientHandle;
      if (old != null) {
        SoLoud.instance.fadeVolume(old, 0, _ambientFade);
        SoLoud.instance.scheduleStop(old, _ambientFade);
      }
      _ambientHandle = null;
      _ambientPlaying = null;
      final source = target == null ? null : _ambientSources[target];
      if (source != null) {
        final h = SoLoud.instance.play(source, volume: 0, looping: true);
        SoLoud.instance.fadeVolume(h, ambientVolume, _ambientFade);
        _ambientHandle = h;
        _ambientPlaying = target;
      }
    } catch (_) {
      _ambientHandle = null;
      _ambientPlaying = null;
    }
  }

  /// Tón xylofonu pro písmeno při swype — celý swype tak „zahraje melodii".
  void playKeyTone(String letter) =>
      _playId('key', pitch: keyTonePitch(letter), volume: 0.7);

  /// Cinknutí hvězdy; každá další hvězda o kvartu výš.
  void playStar(int index) =>
      _playId('star', pitch: _semis(const [0, 5, 10][index.clamp(0, 2)]));

  void _playId(String id, {double pitch = 1.0, double volume = 1.0}) {
    if (!_ready || !_sfxEnabled) return;
    final source = _sources[id];
    if (source == null) return;
    try {
      final handle = SoLoud.instance.play(source, volume: volume);
      if (pitch != 1.0) SoLoud.instance.setRelativePlaySpeed(handle, pitch);
    } catch (_) {
      // Přehrání jednoho zvuku nesmí shodit hru.
    }
  }

  // Durová pentatonika přes dvě oktávy: ať dítě swypne cokoli, zní to hezky.
  static const _pentatonic = [0, 2, 4, 7, 9, 12, 14, 16, 19, 21];

  /// Výška tónu klávesy podle sloupce: zleva doprava stoupá jako xylofon.
  /// Odsazené řady (A–L, Z–M) sedí mezi sloupci horní řady.
  static double keyTonePitch(String letter) {
    for (var r = 0; r < kRows.length; r++) {
      final c = kRows[r].indexOf(letter);
      if (c < 0) continue;
      final column = (c + r * 0.5).round().clamp(0, _pentatonic.length - 1);
      return _semis(_pentatonic[column]);
    }
    return 1.0;
  }

  static double _semis(int s) => pow(2, s / 12).toDouble();
}
