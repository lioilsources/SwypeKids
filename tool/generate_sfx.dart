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

// ── Ambient smyčky (roadmap P2): dočasná syntéza, později nahrávky ─────────

/// Bílý šum přes jednoduchý dolní propust (one-pole), [cutoff] 0–1.
List<double> noise(double seconds, {double cutoff = 0.05, int seed = 1}) {
  final rnd = Random(seed);
  final n = (seconds * sampleRate).round();
  var y = 0.0;
  return List.generate(n, (_) {
    y += cutoff * ((rnd.nextDouble() * 2 - 1) - y);
    return y;
  });
}

/// Ptačí cvrlikání: krátký sinus s klouzavou výškou, 2–4 tóny ve skupince.
List<double> chirp(Random rnd) {
  final notes = 2 + rnd.nextInt(3);
  var out = <double>[];
  for (var k = 0; k < notes; k++) {
    final f0 = 2400 + rnd.nextDouble() * 1200;
    final f1 = f0 + (rnd.nextDouble() - 0.3) * 900;
    final len = 0.05 + rnd.nextDouble() * 0.06;
    final n = (len * sampleRate).round();
    var phase = 0.0;
    final tone = List.generate(n, (i) {
      final t = i / n;
      phase += 2 * pi * (f0 + (f1 - f0) * t) / sampleRate;
      final env = sin(pi * t); // měkký nástup i konec
      return 0.35 * env * sin(phase);
    });
    out = mix(out, tone, out.length / sampleRate + 0.02 + rnd.nextDouble() * 0.05);
  }
  return out;
}

/// Cvrček: vysoký tón modulovaný ~40 Hz v krátkých dávkách.
List<double> cricketBurst(double seconds, double freq) {
  final n = (seconds * sampleRate).round();
  return List.generate(n, (i) {
    final t = i / sampleRate;
    final env = sin(pi * i / n);
    final am = 0.5 + 0.5 * sin(2 * pi * 42 * t);
    return 0.22 * env * am * sin(2 * pi * freq * t);
  });
}

/// „Plip" kapky: krátký klesající sinus.
List<double> plip(Random rnd) {
  final n = (0.09 * sampleRate).round();
  final f0 = 700 + rnd.nextDouble() * 500;
  var phase = 0.0;
  return List.generate(n, (i) {
    final t = i / sampleRate;
    phase += 2 * pi * (f0 - 350 * (i / n)) / sampleRate;
    return 0.3 * exp(-t * 40) * sin(phase);
  });
}

/// Pomalé vlnění hlasitosti (vítr, voda).
List<double> lfo(List<double> src, double hz, double depth, {double phase = 0}) =>
    [for (var i = 0; i < src.length; i++)
      src[i] * (1 - depth + depth * (0.5 + 0.5 * sin(2 * pi * hz * i / sampleRate + phase)))];

/// Bezešvá smyčka: posledních [fade] s se prolne do začátku.
List<double> seamless(List<double> src, {double fade = 0.6}) {
  final f = (fade * sampleRate).round();
  final n = src.length - f;
  final out = List<double>.generate(n, (i) => src[i]);
  for (var i = 0; i < f; i++) {
    final w = i / f;
    out[i] = out[i] * w + src[n + i] * (1 - w);
  }
  return out;
}

const double ambientSeconds = 10;

/// Den v přírodě: vítr + ptáci.
List<double> ambientDay() {
  final rnd = Random(11);
  var out = lfo(noise(ambientSeconds + 0.6, cutoff: 0.03, seed: 3), 0.17, 0.6);
  out = [for (final s in out) s * 0.5];
  for (var i = 0; i < 9; i++) {
    out = mix(out, chirp(rnd), rnd.nextDouble() * ambientSeconds);
  }
  return seamless(out);
}

/// Noc: cvrčci + slabý vítr.
List<double> ambientNight() {
  final rnd = Random(23);
  var out = lfo(noise(ambientSeconds + 0.6, cutoff: 0.02, seed: 5), 0.11, 0.5);
  out = [for (final s in out) s * 0.25];
  var t = 0.0;
  while (t < ambientSeconds) {
    out = mix(out, cricketBurst(0.25 + rnd.nextDouble() * 0.1, 4100 + rnd.nextDouble() * 300), t);
    t += 0.45 + rnd.nextDouble() * 0.2;
  }
  // druhý cvrček dál, jiná výška
  t = 0.2;
  while (t < ambientSeconds) {
    out = mix(out, [for (final s in cricketBurst(0.3, 3600)) s * 0.5], t);
    t += 0.7 + rnd.nextDouble() * 0.3;
  }
  return seamless(out);
}

/// Voda: šplouchání (vlněný šum) + kapky.
List<double> ambientWater() {
  final rnd = Random(37);
  var out = lfo(noise(ambientSeconds + 0.6, cutoff: 0.12, seed: 7), 0.35, 0.8);
  out = lfo(out, 0.9, 0.4, phase: 1.3);
  out = [for (final s in out) s * 0.55];
  for (var i = 0; i < 7; i++) {
    out = mix(out, plip(rnd), rnd.nextDouble() * ambientSeconds);
  }
  return seamless(out);
}

// ── Žvatlání postav (Animal Crossing style): krátké „slabiky" bez jazyka ──

/// Jedna slabika: tón s klouzavou výškou a formantovým brumem, 60–110 ms.
List<double> babbleSyllable(Random rnd, double base) {
  final len = 0.06 + rnd.nextDouble() * 0.05;
  final n = (len * sampleRate).round();
  final f0 = base * (0.85 + rnd.nextDouble() * 0.5);
  final f1 = f0 * (0.8 + rnd.nextDouble() * 0.5);
  var phase = 0.0;
  return List.generate(n, (i) {
    final t = i / n;
    phase += 2 * pi * (f0 + (f1 - f0) * t) / sampleRate;
    final env = sin(pi * t);
    // dva „formanty" nad základem dávají hlasový charakter
    return 0.4 * env * (sin(phase) + 0.35 * sin(phase * 2.01) + 0.15 * sin(phase * 3.02));
  });
}

/// Žvatlání: 4–7 slabik s pauzami; [base] = základní výška (vyšší = menší
/// postava). Tři varianty se střídají.
List<double> babble(int seed, {double base = 330}) {
  final rnd = Random(seed);
  var out = <double>[];
  final count = 4 + rnd.nextInt(4);
  var t = 0.0;
  for (var i = 0; i < count; i++) {
    out = mix(out, babbleSyllable(rnd, base), t);
    t += 0.09 + rnd.nextDouble() * 0.08;
  }
  return out;
}

// ── Hudba: titulní smyčka (roadmap P2, „první hudební smyčka") ──────────────

/// Měkký basový tón (sinus + oktáva), doznívá přes dobu.
List<double> bass(double freq, double seconds) {
  final n = (seconds * sampleRate).round();
  return List.generate(n, (i) {
    final t = i / sampleRate;
    final env = min(1.0, t / 0.01) * exp(-t * 2.2);
    return 0.35 * env * (sin(2 * pi * freq * t) + 0.3 * sin(2 * pi * freq * 2 * t));
  });
}

/// Hravá melodie v C dur pentatonice nad akordy C–Am–F–G, 100 bpm, 8 taktů.
/// Xylofon hraje melodii, bas drží kořen; konec se prolne do začátku.
List<double> musicTitle() {
  const beat = 0.6; // 100 bpm
  const bars = 8;
  // Kořeny akordů (půltóny nad C3 = 130.81 Hz)
  const roots = [0, 9, 5, 7, 0, 9, 5, 7];
  // Melodie: (půltón nad C5, doba v osminách), 0 = pauza
  const melody = [
    [0, 2, 4, 2, 7, 2, 4, 2], [9, 2, 7, 2, 4, 4], [5, 2, 4, 2, 2, 2, 4, 2], [7, 4, 4, 2, 2, 2],
    [0, 2, 4, 2, 7, 2, 12, 2], [9, 2, 12, 2, 7, 4], [5, 2, 7, 2, 9, 2, 7, 2], [4, 2, 2, 2, 0, 4],
  ];
  var out = silence(bars * 4 * beat + 1.0);
  for (var bar = 0; bar < bars; bar++) {
    final barStart = bar * 4 * beat;
    final rootHz = 130.81 * semis(roots[bar]);
    for (var b = 0; b < 4; b++) {
      out = mix(out, bass(b.isEven ? rootHz : rootHz * 1.5, beat * 0.9), barStart + b * beat);
    }
    var t = barStart;
    final notes = melody[bar];
    for (var i = 0; i < notes.length; i += 2) {
      final len = notes[i + 1] * beat / 2;
      out = mix(out, xylo(baseFreq * semis(notes[i]), seconds: min(0.5, len + 0.15), gain: 0.5), t);
      t += len;
    }
  }
  return seamless(out.sublist(0, (bars * 4 * beat * sampleRate).round() + (0.6 * sampleRate).round()));
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

  // Ambient smyčky (hlasitost drží AudioService, soubory jsou normalizované)
  const ambientDir = 'assets/audio/ambient';
  Directory(ambientDir).createSync(recursive: true);
  final ambient = <String, String>{};
  for (final (id, samples) in [
    ('day', ambientDay()),
    ('night', ambientNight()),
    ('water', ambientWater()),
  ]) {
    final path = '$ambientDir/$id.wav';
    File(path).writeAsBytesSync(wav(samples));
    ambient[id] = path;
    stdout.writeln('✓ $path (${(samples.length / sampleRate).toStringAsFixed(2)} s loop)');
  }

  for (var i = 0; i < 3; i++) {
    final path = '$outDir/babble_$i.wav';
    final samples = babble(100 + i);
    File(path).writeAsBytesSync(wav(samples));
    manifest['babble_$i'] = path;
    stdout.writeln('✓ $path (${(samples.length / sampleRate).toStringAsFixed(2)} s)');
  }

  const musicDir = 'assets/audio/music';
  Directory(musicDir).createSync(recursive: true);
  final music = musicTitle();
  File('$musicDir/title.wav').writeAsBytesSync(wav(music));
  stdout.writeln('✓ $musicDir/title.wav (${(music.length / sampleRate).toStringAsFixed(2)} s loop)');

  File('assets/audio/manifest.json').writeAsStringSync(
      '${const JsonEncoder.withIndent('  ').convert({
        'sfx': manifest,
        'ambient': ambient,
        'music': {'title': '$musicDir/title.wav'},
      })}\n');
  stdout.writeln('✓ assets/audio/manifest.json');
}
