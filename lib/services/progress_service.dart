import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../data/lessons.dart';
import '../data/models/content_pack.dart';

/// Ukládá postup dítěte (hvězdy za lekce, nálepky) per content pack a zvolený
/// jazyk. Čtení jde ze synchronní in-memory kopie (žádné async v build),
/// zápis je fire-and-forget do shared_preferences.
class ProgressService {
  ProgressService._();
  static final ProgressService instance = ProgressService._();

  static const _kLanguageKey = 'sk.selectedLanguage';
  static const _kProgressPrefix = 'sk.progress.';

  SharedPreferences? _prefs;
  final Map<String, _PackProgress> _byPack = {};
  Language? _selectedLanguage;

  static Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    instance._prefs = prefs;
    instance._byPack.clear();
    instance._selectedLanguage = null;
    final langName = prefs.getString(_kLanguageKey);
    instance._selectedLanguage =
        Language.values.asNameMap()[langName ?? ''];
    for (final key in prefs.getKeys()) {
      if (!key.startsWith(_kProgressPrefix)) continue;
      final raw = prefs.getString(key);
      if (raw == null) continue;
      try {
        instance._byPack[key.substring(_kProgressPrefix.length)] =
            _PackProgress.fromJson(
                (jsonDecode(raw) as Map).cast<String, dynamic>());
      } catch (_) {
        // Poškozený záznam ignorujeme — dítě začne daný pack odznova.
      }
    }
  }

  // ── Jazyk ──────────────────────────────────────────────────────────────────

  /// Uložený jazyk; null = první start (použije se autodetekce).
  Language? get selectedLanguage => _selectedLanguage;

  set selectedLanguage(Language? lang) {
    _selectedLanguage = lang;
    if (lang != null) _prefs?.setString(_kLanguageKey, lang.name);
  }

  // ── Lekce a hvězdy ─────────────────────────────────────────────────────────

  int starsFor(String packId, String lessonId) =>
      _byPack[packId]?.completed[lessonId] ?? 0;

  bool isCompleted(String packId, String lessonId) =>
      starsFor(packId, lessonId) > 0;

  /// Uloží dokončení lekce; drží se maximum dosažených hvězd.
  void markCompleted(String packId, String lessonId, int stars) {
    final p = _byPack.putIfAbsent(packId, () => _PackProgress());
    final prev = p.completed[lessonId] ?? 0;
    if (stars > prev) p.completed[lessonId] = stars;
    _save(packId);
  }

  /// Celkový počet hvězd v packu.
  int totalStars(String packId) {
    final p = _byPack[packId];
    if (p == null) return 0;
    return p.completed.values.fold(0, (a, b) => a + b);
  }

  // ── Sbírka (Zvěřinec) ──────────────────────────────────────────────────────

  List<String> collectibles(String packId) =>
      List.unmodifiable(_byPack[packId]?.collectibles ?? const []);

  void addCollectible(String packId, String emoji) {
    final p = _byPack.putIfAbsent(packId, () => _PackProgress());
    if (!p.collectibles.contains(emoji)) {
      p.collectibles.add(emoji);
      _save(packId);
    }
  }

  // ── Navigace v packu ───────────────────────────────────────────────────────

  /// Index (unit, lesson) první nedokončené lekce; null = celý pack hotový.
  ({int unit, int lesson})? firstUncompletedIn(ContentPack pack) {
    for (var u = 0; u < pack.units.length; u++) {
      final lessons = pack.units[u].lessons;
      for (var l = 0; l < lessons.length; l++) {
        if (!isCompleted(pack.id, lessons[l].id)) return (unit: u, lesson: l);
      }
    }
    return null;
  }

  /// Jednotka je dokončená, když jsou dokončené všechny její lekce.
  bool isUnitCompleted(ContentPack pack, int unitIndex) => pack
      .units[unitIndex].lessons
      .every((l) => isCompleted(pack.id, l.id));

  /// Jednotka je odemčená, když je dokončená předchozí (první vždy).
  bool isUnitUnlocked(ContentPack pack, int unitIndex) =>
      unitIndex == 0 || isUnitCompleted(pack, unitIndex - 1);

  void _save(String packId) {
    final p = _byPack[packId];
    if (p == null) return;
    _prefs?.setString('$_kProgressPrefix$packId', jsonEncode(p.toJson()));
  }
}

class _PackProgress {
  final Map<String, int> completed; // lessonId → max hvězdy (1–3)
  final List<String> collectibles;  // emoji nálepek v pořadí získání

  _PackProgress({Map<String, int>? completed, List<String>? collectibles})
      : completed = completed ?? {},
        collectibles = collectibles ?? [];

  factory _PackProgress.fromJson(Map<String, dynamic> json) => _PackProgress(
        completed: ((json['completed'] as Map?) ?? const {})
            .map((k, v) => MapEntry(k as String, v as int)),
        collectibles:
            ((json['collectibles'] as List?) ?? const []).cast<String>(),
      );

  Map<String, dynamic> toJson() => {
        'v': 1,
        'completed': completed,
        'collectibles': collectibles,
      };
}
