import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../data/keyboard_layout.dart' show kEmoji;
import '../data/lessons.dart';
import '../data/models/content_pack.dart';
import '../world/world_clock.dart' show Season;

/// Ukládá postup dítěte (hvězdy za lekce, nálepky) per content pack a zvolený
/// jazyk. Každý profil (sourozenec) má vlastní prostor klíčů: profil 1
/// původní `sk.…`, další `sk.p{id}.…`. Čtení jde ze synchronní in-memory kopie (žádné async v build),
/// zápis je fire-and-forget do shared_preferences.
class ProgressService {
  ProgressService._();
  static final ProgressService instance = ProgressService._();

  static const _kLanguageKey = 'sk.selectedLanguage';
  static const _kProgressPrefix = 'sk.progress.';
  static const _kGlobalKey = 'sk.global'; // odznaky a statistiky napříč jazyky

  SharedPreferences? _prefs;
  int _profile = 1;
  final Map<String, _PackProgress> _byPack = {};
  _GlobalProgress _global = _GlobalProgress();
  Language? _selectedLanguage;

  /// Načte postup profilu [profile]; volá se při startu a při přepnutí dítěte.
  static Future<void> init({int profile = 1}) async {
    final prefs = await SharedPreferences.getInstance();
    instance._prefs = prefs;
    instance._profile = profile;
    instance._byPack.clear();
    instance._selectedLanguage = null;
    instance._global = _GlobalProgress();
    final rawGlobal = prefs.getString(instance._k(_kGlobalKey));
    if (rawGlobal != null) {
      try {
        instance._global = _GlobalProgress.fromJson(
            (jsonDecode(rawGlobal) as Map).cast<String, dynamic>());
      } catch (_) {
        // Poškozený záznam → odznaky od začátku, postup v packech zůstává.
      }
    }
    final langName = prefs.getString(instance._k(_kLanguageKey));
    instance._selectedLanguage =
        Language.values.asNameMap()[langName ?? ''];
    final progressPrefix = instance._k(_kProgressPrefix);
    for (final key in prefs.getKeys()) {
      if (!key.startsWith(progressPrefix)) continue;
      final raw = prefs.getString(key);
      if (raw == null) continue;
      try {
        instance._byPack[key.substring(progressPrefix.length)] =
            _PackProgress.fromJson(
                (jsonDecode(raw) as Map).cast<String, dynamic>());
      } catch (_) {
        // Poškozený záznam ignorujeme — dítě začne daný pack odznova.
      }
    }
  }

  int get profile => _profile;

  /// Klíč v prostoru aktivního profilu: profil 1 beze změny (starší
  /// instalace nepotřebují migraci), ostatní `sk.p{id}.…`.
  String _k(String key) =>
      _profile == 1 ? key : 'sk.p$_profile.${key.substring(3)}';

  /// Smaže uložený postup profilu [profile] (rodičovský koutek: odstranění
  /// sourozence). Aktivní profil se nemění.
  static Future<void> wipeProfile(int profile) async {
    final prefs = await SharedPreferences.getInstance();
    final prefix = profile == 1 ? 'sk.' : 'sk.p$profile.';
    for (final key in prefs.getKeys().toList()) {
      if (!key.startsWith(prefix)) continue;
      // Globální nastavení (zvuk, období, profily) nejsou postup.
      if (profile == 1 &&
          (key.startsWith('sk.settings.') ||
              key.startsWith('sk.profile') ||
              key.startsWith('sk.p') ||
              key == 'sk.activeProfile')) {
        continue;
      }
      await prefs.remove(key);
    }
  }

  // ── Jazyk ──────────────────────────────────────────────────────────────────

  /// Uložený jazyk; null = první start (použije se autodetekce).
  Language? get selectedLanguage => _selectedLanguage;

  set selectedLanguage(Language? lang) {
    _selectedLanguage = lang;
    if (lang != null) _prefs?.setString(_k(_kLanguageKey), lang.name);
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

  /// Má dítě nálepku dané jednotky? Stará uložení drží emoji z globální
  /// kEmoji mapy (před lokalizací) — počítá se i legacy hodnota podle písmene.
  bool hasCollectible(String packId, CollectibleReward reward) {
    final owned = _byPack[packId]?.collectibles ?? const [];
    if (owned.contains(reward.emoji)) return true;
    final legacy = kEmoji[reward.name];
    return legacy != null && owned.contains(legacy);
  }

  void addCollectible(String packId, String emoji) {
    final p = _byPack.putIfAbsent(packId, () => _PackProgress());
    if (!p.collectibles.contains(emoji)) {
      p.collectibles.add(emoji);
      _save(packId);
    }
  }

  // ── Batoh slov ─────────────────────────────────────────────────────────────

  /// Jak dlouho má slovo v builderu štítek „nové".
  static const newWordWindow = Duration(hours: 24);

  /// Slova (lesson.vocab), která dítě správně swyplo.
  Set<String> wordBag(String packId) =>
      Set.unmodifiable(_byPack[packId]?.words.keys ?? const <String>{});

  bool hasWord(String packId, String vocabId) =>
      _byPack[packId]?.words.containsKey(vocabId) ?? false;

  /// Přidá slovo do batohu; vrací true, pokud tam ještě nebylo.
  bool addWord(String packId, String vocabId, {DateTime? now}) {
    if (vocabId.isEmpty) return false;
    final p = _byPack.putIfAbsent(packId, () => _PackProgress());
    if (p.words.containsKey(vocabId)) return false;
    p.words[vocabId] = (now ?? DateTime.now()).millisecondsSinceEpoch;
    _save(packId);
    return true;
  }

  /// Slovo přibylo do batohu během posledních 24 h.
  bool isNewWord(String packId, String vocabId, {DateTime? now}) {
    final at = _byPack[packId]?.words[vocabId];
    if (at == null) return false;
    final age = (now ?? DateTime.now())
        .difference(DateTime.fromMillisecondsSinceEpoch(at));
    return age < newWordWindow;
  }

  // ── Odznaky a statistiky (napříč jazyky) ───────────────────────────────────

  /// Získané odznaky (id → kdy, ms epoch).
  Map<String, int> get badges => Map.unmodifiable(_global.badges);

  bool hasBadge(String id) => _global.badges.containsKey(id);

  /// Zapíše odznak; true = byl nový.
  bool earnBadge(String id, {DateTime? now}) {
    if (_global.badges.containsKey(id)) return false;
    _global.badges[id] = (now ?? DateTime.now()).millisecondsSinceEpoch;
    _saveGlobal();
    return true;
  }

  /// Hrací dny (YYYY-MM-DD) a období, ve kterých dítě hrálo.
  Set<String> get playDays => Set.unmodifiable(_global.playDays);
  Set<String> get seasonsPlayed => Set.unmodifiable(_global.seasons);
  int get listenPerfectCount => _global.listenPerfect;

  void recordPlayDay(DateTime at, Season season) {
    final day =
        '${at.year}-${at.month.toString().padLeft(2, '0')}-${at.day.toString().padLeft(2, '0')}';
    var changed = _global.playDays.add(day);
    changed = _global.seasons.add(season.name) || changed;
    if (changed) _saveGlobal();
  }

  void bumpListenPerfect() {
    _global.listenPerfect++;
    _saveGlobal();
  }

  void _saveGlobal() =>
      _prefs?.setString(_k(_kGlobalKey), jsonEncode(_global.toJson()));

  // ── Odhalené kousky světa ──────────────────────────────────────────────────

  /// Jednotka už byla na mapě odhalená (mlha se rozplynula) — animace
  /// rozplynutí hraje jen jednou.
  bool isUnitRevealed(String packId, String unitId) =>
      _byPack[packId]?.revealed.contains(unitId) ?? false;

  void markUnitRevealed(String packId, String unitId) {
    final p = _byPack.putIfAbsent(packId, () => _PackProgress());
    if (p.revealed.add(unitId)) _save(packId);
  }

  // ── Má knížka ──────────────────────────────────────────────────────────────

  static const maxBookPages = 100;

  /// Uložené věty, nejnovější první.
  List<BookPage> book(String packId) =>
      List.unmodifiable((_byPack[packId]?.book ?? const []).reversed);

  /// Uloží větu do knížky; stejná věta se neukládá dvakrát. Vrací true,
  /// pokud přibyla nová stránka.
  bool addToBook(String packId, String text, String emojis, {DateTime? now}) {
    if (text.trim().isEmpty) return false;
    final p = _byPack.putIfAbsent(packId, () => _PackProgress());
    if (p.book.any((page) => page.text == text)) return false;
    p.book.add(BookPage(
        text: text,
        emojis: emojis,
        at: (now ?? DateTime.now()).millisecondsSinceEpoch));
    if (p.book.length > maxBookPages) p.book.removeAt(0);
    _save(packId);
    return true;
  }

  // ── Síla slov (spaced repetition lite) ─────────────────────────────────────

  static const maxStrength = 5;

  /// Síla slova/slabiky (podle target) 0–5; nepotkané = 0.
  int strengthOf(String packId, String target) =>
      _byPack[packId]?.strength[target] ?? 0;

  /// Úspěch +1, chyba −1 (v mezích 0–5).
  void recordAttempt(String packId, String target, {required bool success}) {
    if (target.isEmpty) return;
    final p = _byPack.putIfAbsent(packId, () => _PackProgress());
    final next = (strengthOf(packId, target) + (success ? 1 : -1))
        .clamp(0, maxStrength);
    p.strength[target] = next;
    _save(packId);
  }

  /// Dokončené lekce (bez reviewMix), jedna na target, od nejslabší.
  /// Při shodě síly dřívější lekce první (déle neviděná).
  List<Lesson> weakestLearned(ContentPack pack, {int? limit}) {
    final seen = <String>{};
    final learned = [
      for (final l in pack.allLessons)
        if (l.type != LessonType.reviewMix &&
            isCompleted(pack.id, l.id) &&
            seen.add(l.target))
          l,
    ];
    final order = {for (final (i, l) in learned.indexed) l.target: i};
    learned.sort((a, b) {
      final byStrength =
          strengthOf(pack.id, a.target).compareTo(strengthOf(pack.id, b.target));
      return byStrength != 0
          ? byStrength
          : order[a.target]!.compareTo(order[b.target]!);
    });
    return limit == null ? learned : learned.take(limit).toList();
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
    _prefs?.setString(_k('$_kProgressPrefix$packId'), jsonEncode(p.toJson()));
  }
}

class _PackProgress {
  final Map<String, int> completed; // lessonId → max hvězdy (1–3)
  final List<String> collectibles;  // emoji nálepek v pořadí získání
  final Map<String, int> words;     // batoh: vocab id → kdy poprvé (ms epoch)
  final Map<String, int> strength;  // target → síla 0–5
  final List<BookPage> book;        // Má knížka, nejstarší první
  final Set<String> revealed;       // jednotky, u kterých už hrálo rozplynutí mlhy

  _PackProgress({
    Map<String, int>? completed,
    List<String>? collectibles,
    Map<String, int>? words,
    Map<String, int>? strength,
    List<BookPage>? book,
    Set<String>? revealed,
  })  : completed = completed ?? {},
        collectibles = collectibles ?? [],
        words = words ?? {},
        strength = strength ?? {},
        book = book ?? [],
        revealed = revealed ?? {};

  factory _PackProgress.fromJson(Map<String, dynamic> json) => _PackProgress(
        completed: ((json['completed'] as Map?) ?? const {})
            .map((k, v) => MapEntry(k as String, v as int)),
        collectibles:
            ((json['collectibles'] as List?) ?? const []).cast<String>(),
        words: ((json['words'] as Map?) ?? const {})
            .map((k, v) => MapEntry(k as String, v as int)),
        strength: ((json['strength'] as Map?) ?? const {})
            .map((k, v) => MapEntry(k as String, v as int)),
        book: [
          for (final page in (json['book'] as List?) ?? const [])
            BookPage.fromJson((page as Map).cast<String, dynamic>()),
        ],
        revealed: ((json['revealed'] as List?) ?? const []).cast<String>().toSet(),
      );

  Map<String, dynamic> toJson() => {
        'v': 1,
        'completed': completed,
        'collectibles': collectibles,
        'words': words,
        'strength': strength,
        'book': [for (final page in book) page.toJson()],
        'revealed': revealed.toList(),
      };
}

/// Odznaky a statistiky společné pro všechny jazyky.
class _GlobalProgress {
  final Map<String, int> badges;
  final Set<String> playDays;
  final Set<String> seasons;
  int listenPerfect;

  _GlobalProgress({
    Map<String, int>? badges,
    Set<String>? playDays,
    Set<String>? seasons,
    this.listenPerfect = 0,
  })  : badges = badges ?? {},
        playDays = playDays ?? {},
        seasons = seasons ?? {};

  factory _GlobalProgress.fromJson(Map<String, dynamic> json) =>
      _GlobalProgress(
        badges: ((json['badges'] as Map?) ?? const {})
            .map((k, v) => MapEntry(k as String, v as int)),
        playDays: ((json['playDays'] as List?) ?? const []).cast<String>().toSet(),
        seasons: ((json['seasons'] as List?) ?? const []).cast<String>().toSet(),
        listenPerfect: json['listenPerfect'] as int? ?? 0,
      );

  Map<String, dynamic> toJson() => {
        'v': 1,
        'badges': badges,
        'playDays': playDays.toList(),
        'seasons': seasons.toList(),
        'listenPerfect': listenPerfect,
      };
}

/// Jedna stránka Mé knížky: složená věta + obrázková řádka.
class BookPage {
  final String text;
  final String emojis;
  final int at; // ms epoch

  const BookPage({required this.text, required this.emojis, required this.at});

  factory BookPage.fromJson(Map<String, dynamic> json) => BookPage(
        text: json['text'] as String,
        emojis: json['emojis'] as String? ?? '',
        at: json['at'] as int? ?? 0,
      );

  Map<String, dynamic> toJson() => {'text': text, 'emojis': emojis, 'at': at};
}
