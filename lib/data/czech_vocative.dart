/// 5. pád (vokativ) českých křestních jmen pro oslovení průvodcem
/// („Ahoj, Lauro!"). Pravidla pokrývají běžná jména; pohlaví z jména
/// nepoznají (Ester, Dagmar), proto má rodič v koutku ruční přepsání
/// (`ChildProfile.called`).
String czechVocative(String name) {
  final n = name.trim();
  if (n.length < 2) return n;
  final lower = n.toLowerCase();
  String keep(String suffix) => n.substring(0, n.length - suffix.length);

  // Ženská a hypokoristika na -a: Laura → Lauro, Ema → Emo, Kuba → Kubo.
  if (lower.endsWith('a')) return '${keep('a')}o';
  // Samohlásky na konci se nemění: Marie, Jiří, Zoe, Hugo, Nelly.
  if (RegExp(r'[eiyouáéíóúůýě]$').hasMatch(lower)) return n;

  // -ek → -ku (Marek → Marku, Radek → Radku), -něk → -ňku (Zdeněk → Zdeňku).
  if (lower.endsWith('něk')) return '${keep('něk')}ňku';
  if (lower.endsWith('ek')) return '${keep('ek')}ku';
  // -el → -le (Pavel → Pavle, Karel → Karle), ale -iel → -ieli (Daniel).
  if (lower.endsWith('iel')) return '${n}i';
  if (lower.endsWith('el')) return '${keep('el')}le';
  // Velár + -u: Dominik → Dominiku, Vojtěch → Vojtěchu, Oleg → Olegu.
  if (RegExp(r'(k|h|ch|g)$').hasMatch(lower)) return '${n}u';
  // -r po souhlásce → -ře (Petr → Petře), po samohlásce +e (Viktor → Viktore).
  if (lower.endsWith('r')) {
    final before = lower[lower.length - 2];
    return 'aeiouyáéíóúůýě'.contains(before) ? '${n}e' : '${keep('r')}ře';
  }
  // Měkké a sykavky + i: Tomáš → Tomáši, Ondřej → Ondřeji, Max → Maxi.
  if (RegExp(r'[šžčřjcďťňxsz]$').hasMatch(lower)) return '${n}i';
  // Ostatní tvrdé souhlásky + e: Adam → Adame, Jakub → Jakube, Martin → Martine.
  return '${n}e';
}
