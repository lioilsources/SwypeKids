import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../characters/guide.dart';
import '../data/czech_vocative.dart';
import '../data/lessons.dart';

/// Profil dítěte: avatar (emoji zvířátka) a jméno, kterým ho průvodce
/// oslovuje. Sourozenci na jednom tabletu mají každý svůj profil; postup
/// každého profilu drží [ProgressService] pod vlastním prefixem klíčů
/// (`sk.p{id}.…`; profil 1 používá původní klíče, takže starší instalace
/// nepotřebují migraci).
class ChildProfile {
  final int id;
  final String name;
  final String avatar;

  /// Ruční oslovení v češtině (5. pád), když pravidla netrefí (Ester).
  final String called;

  /// Průvodce, kterého si dítě vybralo.
  final Guide guide;

  /// Jazyk rodiny: kód jazyka rozhraní (`uk`, `vi`…), když se liší od
  /// jazyka, ve kterém se dítě učí číst. Prázdné = rozhraní v jazyce hry.
  final String home;

  const ChildProfile({
    required this.id,
    required this.name,
    required this.avatar,
    this.called = '',
    this.guide = Guide.panda,
    this.home = '',
  });

  ChildProfile copyWith({String? called, Guide? guide, String? home}) =>
      ChildProfile(
        id: id,
        name: name,
        avatar: avatar,
        called: called ?? this.called,
        guide: guide ?? this.guide,
        home: home ?? this.home,
      );

  factory ChildProfile.fromJson(Map<String, dynamic> json) => ChildProfile(
        id: json['id'] as int,
        name: json['name'] as String? ?? '',
        avatar: json['avatar'] as String? ?? ProfileService.defaultAvatar,
        called: json['called'] as String? ?? '',
        guide: Guide.fromName(json['guide'] as String?),
        home: json['home'] as String? ?? '',
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'avatar': avatar,
        if (called.isNotEmpty) 'called': called,
        if (guide != Guide.panda) 'guide': guide.name,
        if (home.isNotEmpty) 'home': home,
      };

  /// Jak dítě oslovit v daném jazyce: čeština 5. pádem (ruční tvar má
  /// přednost), ostatní jazyky appky oslovují 1. pádem.
  String addressIn(Language lang) {
    if (name.trim().isEmpty) return '';
    if (lang != Language.cs) return name.trim();
    return called.trim().isNotEmpty ? called.trim() : czechVocative(name);
  }

  /// Jak profil oslovit: jméno, nebo jen avatar.
  String get label => name.isNotEmpty ? name : avatar;
}

class ProfileService {
  ProfileService._();
  static final ProfileService instance = ProfileService._();

  static const _kProfiles = 'sk.profiles';
  static const _kActive = 'sk.activeProfile';
  // Starší jednoprofilové klíče (v2.4.1) — převedou se na profil 1.
  static const _kLegacyOnboarded = 'sk.profile.onboarded';
  static const _kLegacyName = 'sk.profile.name';
  static const _kLegacyAvatar = 'sk.profile.avatar';

  /// Zvířátka na výběr v onboardingu (emoji ≤ Unicode 12).
  static const avatars = ['🦊', '🐼', '🐰', '🐸', '🦁', '🐱', '🐶', '🦉'];
  static const defaultAvatar = '🦊';
  static const maxProfiles = 6;

  SharedPreferences? _prefs;
  List<ChildProfile> _profiles = [];
  int _activeId = 1;

  List<ChildProfile> get profiles => List.unmodifiable(_profiles);
  int get activeId => _activeId;
  ChildProfile? get active =>
      _profiles.where((p) => p.id == _activeId).firstOrNull;

  /// První start = žádný profil.
  bool get onboarded => _profiles.isNotEmpty;
  String get name => active?.name ?? '';
  String get avatar => active?.avatar ?? defaultAvatar;
  bool get canAdd => _profiles.length < maxProfiles;

  /// Průvodce aktivního dítěte; mění se při přepnutí profilu i výběru.
  final ValueNotifier<Guide> guide = ValueNotifier(Guide.panda);

  /// Jazyk rodiny aktivního dítěte (prázdné = rozhraní v jazyce hry).
  final ValueNotifier<String> home = ValueNotifier('');

  void _syncGuide() {
    guide.value = active?.guide ?? Guide.panda;
    home.value = active?.home ?? '';
  }

  /// Rodič nastavil profilu [id] jazyk rodiny; prázdné = jazyk hry.
  void setHome(int id, String code) {
    _profiles = [
      for (final p in _profiles) p.id == id ? p.copyWith(home: code) : p,
    ];
    _persist();
    _syncGuide();
  }

  /// Dítě si v profilu vybralo jiného průvodce.
  void setGuide(int id, Guide g) {
    _profiles = [
      for (final p in _profiles) p.id == id ? p.copyWith(guide: g) : p,
    ];
    _persist();
    _syncGuide();
  }

  /// Oslovení aktivního dítěte v jazyce [lang] (prázdné bez jména).
  String addressIn(Language lang) => active?.addressIn(lang) ?? '';

  /// Rodič opravil oslovení (5. pád) profilu [id]; prázdné = podle pravidel.
  void setCalled(int id, String called) {
    _profiles = [
      for (final p in _profiles)
        p.id == id
            ? p.copyWith(called: called.trim())
            : p,
    ];
    _persist();
  }

  static Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    final s = instance;
    s._prefs = prefs;
    s._profiles = [];
    s._activeId = 1;
    final raw = prefs.getString(_kProfiles);
    if (raw != null) {
      try {
        s._profiles = [
          for (final p in jsonDecode(raw) as List)
            ChildProfile.fromJson((p as Map).cast<String, dynamic>()),
        ];
      } catch (_) {
        s._profiles = [];
      }
    } else if (prefs.getBool(_kLegacyOnboarded) ?? false) {
      // v2.4.1 → profil 1 s původním postupem
      s._profiles = [
        ChildProfile(
          id: 1,
          name: prefs.getString(_kLegacyName) ?? '',
          avatar: prefs.getString(_kLegacyAvatar) ?? defaultAvatar,
        ),
      ];
      s._persist();
    }
    s._activeId = prefs.getInt(_kActive) ?? (s._profiles.firstOrNull?.id ?? 1);
    if (!s._profiles.any((p) => p.id == s._activeId) && s._profiles.isNotEmpty) {
      s._activeId = s._profiles.first.id;
    }
    s._syncGuide();
  }

  /// Založí nový profil a přepne na něj. Vrací ho (id pro ProgressService).
  ChildProfile complete({
    required String avatar,
    required String name,
    String home = '',
  }) {
    final id = _profiles.isEmpty
        ? 1
        : _profiles.map((p) => p.id).reduce((a, b) => a > b ? a : b) + 1;
    final profile =
        ChildProfile(id: id, name: name.trim(), avatar: avatar, home: home);
    _profiles = [..._profiles, profile];
    _activeId = id;
    _persist();
    _syncGuide();
    return profile;
  }

  void switchTo(int id) {
    if (!_profiles.any((p) => p.id == id)) return;
    _activeId = id;
    _prefs?.setInt(_kActive, id);
    _syncGuide();
  }

  /// Smaže profil (postup v ProgressService maže volající). Aktivní se
  /// přepne na první zbývající.
  void remove(int id) {
    _profiles = [for (final p in _profiles) if (p.id != id) p];
    if (_activeId == id) _activeId = _profiles.firstOrNull?.id ?? 1;
    _persist();
  }

  void _persist() {
    _prefs?.setString(
        _kProfiles, jsonEncode([for (final p in _profiles) p.toJson()]));
    _prefs?.setInt(_kActive, _activeId);
    _syncGuide();
  }

  /// Vrátí onboarding (rodičovský koutek / testy): smaže všechny profily.
  void reset() {
    _profiles = [];
    _activeId = 1;
    _prefs?.remove(_kProfiles);
    _prefs?.remove(_kActive);
    _syncGuide();
  }
}
