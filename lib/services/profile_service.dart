import 'package:shared_preferences/shared_preferences.dart';

/// Profil dítěte: avatar (emoji zvířátka) a jméno, kterým ho průvodce
/// oslovuje. Zatím jeden profil; víc sourozenců (roadmap v3.0 „Profily")
/// přibude s prefixem klíčů `sk.p{n}.`.
class ProfileService {
  ProfileService._();
  static final ProfileService instance = ProfileService._();

  static const _kOnboarded = 'sk.profile.onboarded';
  static const _kName = 'sk.profile.name';
  static const _kAvatar = 'sk.profile.avatar';

  /// Zvířátka na výběr v onboardingu (emoji ≤ Unicode 12).
  static const avatars = ['🦊', '🐼', '🐰', '🐸', '🦁', '🐱', '🐶', '🦉'];
  static const defaultAvatar = '🦊';

  SharedPreferences? _prefs;
  bool _onboarded = false;
  String _name = '';
  String _avatar = defaultAvatar;

  bool get onboarded => _onboarded;
  String get name => _name;
  String get avatar => _avatar;

  static Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    final s = instance;
    s._prefs = prefs;
    s._onboarded = prefs.getBool(_kOnboarded) ?? false;
    s._name = prefs.getString(_kName) ?? '';
    s._avatar = prefs.getString(_kAvatar) ?? defaultAvatar;
  }

  void complete({required String avatar, required String name}) {
    _avatar = avatar;
    _name = name.trim();
    _onboarded = true;
    _prefs?.setString(_kAvatar, _avatar);
    _prefs?.setString(_kName, _name);
    _prefs?.setBool(_kOnboarded, true);
  }

  /// Vrátí onboarding (rodičovský koutek / testy).
  void reset() {
    _onboarded = false;
    _prefs?.setBool(_kOnboarded, false);
  }
}
