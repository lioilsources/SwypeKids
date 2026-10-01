import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

/// Profil dítěte: avatar (emoji zvířátka) a jméno, kterým ho průvodce
/// oslovuje. Sourozenci na jednom tabletu mají každý svůj profil; postup
/// každého profilu drží [ProgressService] pod vlastním prefixem klíčů
/// (`sk.p{id}.…`; profil 1 používá původní klíče, takže starší instalace
/// nepotřebují migraci).
class ChildProfile {
  final int id;
  final String name;
  final String avatar;

  const ChildProfile({required this.id, required this.name, required this.avatar});

  factory ChildProfile.fromJson(Map<String, dynamic> json) => ChildProfile(
        id: json['id'] as int,
        name: json['name'] as String? ?? '',
        avatar: json['avatar'] as String? ?? ProfileService.defaultAvatar,
      );

  Map<String, dynamic> toJson() => {'id': id, 'name': name, 'avatar': avatar};

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
  }

  /// Založí nový profil a přepne na něj. Vrací ho (id pro ProgressService).
  ChildProfile complete({required String avatar, required String name}) {
    final id = _profiles.isEmpty
        ? 1
        : _profiles.map((p) => p.id).reduce((a, b) => a > b ? a : b) + 1;
    final profile = ChildProfile(id: id, name: name.trim(), avatar: avatar);
    _profiles = [..._profiles, profile];
    _activeId = id;
    _persist();
    return profile;
  }

  void switchTo(int id) {
    if (!_profiles.any((p) => p.id == id)) return;
    _activeId = id;
    _prefs?.setInt(_kActive, id);
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
  }

  /// Vrátí onboarding (rodičovský koutek / testy): smaže všechny profily.
  void reset() {
    _profiles = [];
    _activeId = 1;
    _prefs?.remove(_kProfiles);
    _prefs?.remove(_kActive);
  }
}
