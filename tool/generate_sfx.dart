// Generátor dočasných zvukových efektů (roadmap v2.2, sfx katalog v1).
//
// Zvuky jsou syntetizované (vlastní dílo, žádná licence třetích stran) a slouží
// jako placeholder, dokud je nenahradí zvukař. Výstup: 16-bit mono WAV do
// assets/audio/sfx/ + assets/audio/manifest.json.
//
//   dart run tool/generate_sfx.dart

import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

const int sampleRate = 22050;
const String outDir = 'assets/audio/sfx';

/// C5 — základní tón xylofonu. Výšky jednotlivých písmen se odvozují
/// změnou rychlosti přehrávání v AudioService.
const double baseFreq = 523.25;

double semis(int s) => pow(2, s / 12).toDouble();

List<double> silence(double seconds) =>
    List.filled((seconds * sampleRate).round(), 0.0);

/// Úder do dřevěné destičky: základ + nealikvotní alikvoty s rychlým
/// doznívaním, krátký „klepnutí" na začátku.
List<double> xylo(double freq, {double seconds = 0.45, double gain = 0.8}) {
  final n = (seconds * sampleRate).round();
  return List.generate(n, (i) {
    final t = i / sampleRate;
    final attack = min(1.0, t / 0.002);
    final body = sin(2 * pi * freq * t) * exp(-t * 9) +
        0.35 * sin(2 * pi * freq * 3.93 * t) * exp(-t * 26) +
        0.12 * sin(2 * pi * freq * 9.54 * t) * exp(-t * 60);
    return gain * attack * body;
  });
}

/// Zvoneček: čistší, delší doznívání, vyšší alikvoty.
List<double> bell(double freq, {double seconds = 0.7, double gain = 0.6}) {
  final n = (seconds * sampleRate).round();
  return List.generate(n, (i) {
    final t = i / sampleRate;
    final attack = min(1.0, t / 0.003);
    final body = sin(2 * pi * freq * t) * exp(-t * 5) +
        0.5 * sin(2 * pi * freq * 2.76 * t) * exp(-t * 9) +
        0.25 * sin(2 * pi * freq * 5.4 * t) * exp(-t * 16);
    return gain * attack * body;
  });
}

/// Smíchá [layer] do [base] od času [at] (sekundy); prodlouží base, je-li třeba.
List<double> mix(List<double> base, List<double> layer, double at) {
  final offset = (at * sampleRate).round();
  final out = List<double>.from(base);
  if (out.length < offset + layer.length) {
    out.addAll(List.filled(offset + layer.length - out.length, 0.0));
  }
  for (var i = 0; i < layer.length; i++) {
    out[offset + i] += layer[i];
  }
  return out;
}

/// Arpeggio z xylofonových tónů (půltóny nad C5) s danými rozestupy.
List<double> arpeggio(List<int> steps, double gap, {double lastLen = 0.6}) {
  var out = <double>[];
  for (var i = 0; i < steps.length; i++) {
    final last = i == steps.length - 1;
    out = mix(
      out,
      xylo(baseFreq * semis(steps[i]),
          seconds: last ? lastLen : 0.4, gain: last ? 0.75 : 0.6),
      i * gap,
    );
  }
  return out;
}

/// Měkké „bump" — nízký sinus s poklesem výšky, žádný bzučák.
List<double> bump() {
  final n = (0.28 * sampleRate).round();
  var phase = 0.0;
  return List.generate(n, (i) {
    final t = i / sampleRate;
    final f = 220 - 110 * (t / 0.28);
    phase += 2 * pi * f / sampleRate;
    final env = min(1.0, t / 0.012) * exp(-t * 11);
    return 0.7 * env * sin(phase);
  });
}

/// Krátké „pop" pro UI.
List<double> pop() {
  final n = (0.07 * sampleRate).round();
  var phase = 0.0;
  return List.generate(n, (i) {
    final t = i / sampleRate;
    final f = 900 - 500 * (t / 0.07);
    phase += 2 * pi * f / sampleRate;
    final env = min(1.0, t / 0.002) * exp(-t * 55);
    return 0.45 * env * sin(phase);
  });
}

/// Nálepka: rychlé stoupající třpytky + závěrečný akord zvonků.
List<double> sticker() {
  var out = <double>[];
  const run = [0, 4, 7, 12, 16, 19, 24];
  for (var i = 0; i < run.length; i++) {
    out = mix(out, bell(baseFreq * semis(run[i]), seconds: 0.3, gain: 0.25),
        i * 0.05);
  }
  for (final s in [12, 16, 19]) {
    out = mix(out, bell(baseFreq * semis(s), seconds: 1.0, gain: 0.3), 0.4);
  }
  return out;
}

Uint8List wav(List<double> samples) {
  // Normalizace na -1 dBFS, ať se vrstvy nepřebudí.
  final peak = samples.fold<double>(0, (m, s) => max(m, s.abs()));
  final norm = peak > 0 ? 0.89 / peak : 1.0;
  final data = ByteData(samples.length * 2);
  for (var i = 0; i < samples.length; i++) {
    final v = (samples[i] * norm).clamp(-1.0, 1.0);
    data.setInt16(i * 2, (v * 32767).round(), Endian.little);
  }
  final header = ByteData(44);
  void ascii(int off, String s) {
    for (var i = 0; i < s.length; i++) {
      header.setUint8(off + i, s.codeUnitAt(i));
    }
  }

  ascii(0, 'RIFF');
  header.setUint32(4, 36 + data.lengthInBytes, Endian.little);
  ascii(8, 'WAVE');
  ascii(12, 'fmt ');
  header.setUint32(16, 16, Endian.little);
  header.setUint16(20, 1, Endian.little); // PCM
  header.setUint16(22, 1, Endian.little); // mono
  header.setUint32(24, sampleRate, Endian.little);
  header.setUint32(28, sampleRate * 2, Endian.little);
  header.setUint16(32, 2, Endian.little);
  header.setUint16(34, 16, Endian.little);
  ascii(36, 'data');
  header.setUint32(40, data.lengthInBytes, Endian.little);
  return Uint8List.fromList([
    ...header.buffer.asUint8List(),
    ...data.buffer.asUint8List(),
  ]);
}

void main() {
  final sounds = <String, List<double>>{
    'key': xylo(baseFreq),
    'success_0': arpeggio([0, 4, 7, 12], 0.09),
    'success_1': arpeggio([7, 4, 7, 12], 0.08),
    'success_2': arpeggio([0, 7, 12, 16], 0.1),
    'error': bump(),
    'star': [...silence(0.005), ...bell(baseFreq * semis(19))],
    'sticker': sticker(),
    'tap': pop(),
  };

  Directory(outDir).createSync(recursive: true);
  final manifest = <String, String>{};
  sounds.forEach((id, samples) {
    final path = '$outDir/$id.wav';
    File(path).writeAsBytesSync(wav(samples));
    manifest[id] = path;
    stdout.writeln('✓ $path (${(samples.length / sampleRate).toStringAsFixed(2)} s)');
  });

  File('assets/audio/manifest.json').writeAsStringSync(
      '${const JsonEncoder.withIndent('  ').convert({'sfx': manifest})}\n');
  stdout.writeln('✓ assets/audio/manifest.json');
}
