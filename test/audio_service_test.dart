import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:swype_kids/audio/audio_service.dart';
import 'package:swype_kids/data/keyboard_layout.dart';

void main() {
  test('sfx manifest odkazuje na existující soubory pro každý Sfx', () {
    final manifest = (jsonDecode(
            File('assets/audio/manifest.json').readAsStringSync())
        as Map<String, dynamic>)['sfx'] as Map<String, dynamic>;
    for (final path in manifest.values) {
      expect(File(path as String).existsSync(), isTrue, reason: path);
    }
    for (final sfx in Sfx.values) {
      final ids = sfx == Sfx.success
          ? ['success_0', 'success_1', 'success_2']
          : [sfx.name];
      for (final id in ids) {
        expect(manifest, contains(id), reason: 'chybí sfx $id');
      }
    }
  });

  test('manifest má ambientní smyčky pro každou scénu světa', () {
    final manifest = (jsonDecode(
            File('assets/audio/manifest.json').readAsStringSync())
        as Map<String, dynamic>)['ambient'] as Map<String, dynamic>;
    for (final id in ['day', 'night', 'water']) {
      expect(manifest, contains(id));
      expect(File(manifest[id] as String).existsSync(), isTrue);
    }
  });

  test('manifest má titulní hudbu', () {
    final manifest = (jsonDecode(
            File('assets/audio/manifest.json').readAsStringSync())
        as Map<String, dynamic>)['music'] as Map<String, dynamic>;
    expect(File(manifest['title'] as String).existsSync(), isTrue);
  });

  test('hudba bez enginu je tichý no-op', () {
    final a = AudioService.instance;
    expect(() => a.setMusic(true, quiet: true), returnsNormally);
    expect(a.musicPlaying, isFalse);
    a.musicEnabled = false;
    a.musicEnabled = true;
    a.setMusic(false);
  });

  test('ambient bez enginu nic nehraje, ale pamatuje si přání', () {
    final a = AudioService.instance;
    expect(() => a.setAmbient('day'), returnsNormally);
    expect(a.ambientPlaying, isNull);
    a.ambientEnabled = false;
    a.ambientEnabled = true;
    expect(a.ambientPlaying, isNull);
    a.setAmbient(null);
  });

  test('tóny kláves stoupají zleva doprava', () {
    for (final row in kRows) {
      final pitches = row.map(AudioService.keyTonePitch).toList();
      for (var i = 1; i < pitches.length; i++) {
        expect(pitches[i], greaterThan(pitches[i - 1]),
            reason: '${row[i - 1]} → ${row[i]}');
      }
    }
    expect(AudioService.keyTonePitch('Q'), 1.0);
    expect(AudioService.keyTonePitch('?'), 1.0);
  });

  test('bez spuštěného enginu je přehrávání tiché no-op', () {
    expect(() {
      AudioService.instance.play(Sfx.success);
      AudioService.instance.playKeyTone('M');
      AudioService.instance.playStar(2);
    }, returnsNormally);
  });
}
