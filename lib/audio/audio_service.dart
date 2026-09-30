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
  static const _manifestPath = 'assets/audio/manifest.json';
  static const _successVariants = 3;

  SharedPreferences? _prefs;
  bool _sfxEnabled = true;
  bool _ready = false;
  final Map<String, AudioSource> _sources = {};
  int _successIdx = 0;

  bool get sfxEnabled => _sfxEnabled;

  set sfxEnabled(bool value) {
    _sfxEnabled = value;
    _prefs?.setBool(_kSfxEnabledKey, value);
  }

  /// Načte nastavení (rychlé) — volat před runApp.
  Future<void> loadSettings() async {
    _prefs = await SharedPreferences.getInstance();
    _sfxEnabled = _prefs!.getBool(_kSfxEnabledKey) ?? true;
  }

  /// Spustí audio engine a načte sfx do paměti. Neblokuje start appky —
  /// volá se bez await; do dokončení jsou zvuky tiché.
  Future<void> init() async {
    try {
      await SoLoud.instance.init();
      final manifest = (jsonDecode(await rootBundle.loadString(_manifestPath))
          as Map<String, dynamic>)['sfx'] as Map<String, dynamic>;
      for (final entry in manifest.entries) {
        _sources[entry.key] = await SoLoud.instance.loadAsset(entry.value);
      }
      _ready = true;
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
