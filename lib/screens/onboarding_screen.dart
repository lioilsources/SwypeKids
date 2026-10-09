import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../audio/audio_service.dart';
import '../characters/mascot.dart';
import '../data/lessons.dart';
import '../services/entitlement_service.dart';
import '../services/profile_service.dart';
import '../services/progress_service.dart';
import '../services/tts_service.dart';
import '../widgets/language_picker.dart' show kLanguageFlag;
import '../ui/app_font.dart';
import '../ui/emoji_art.dart';
import '../ui/l10n.dart';

/// První minuta (roadmap v3.0): průvodce pozdraví hlasem, dítě vybere jazyk
/// podle vlajky a zvířátko, rodič může zadat jméno. Vše jde bez čtení —
/// každý krok má obrázek, hlas a jedno velké tlačítko ▶.
class OnboardingScreen extends StatefulWidget {
  final Language initialLanguage;
  final ValueChanged<Language> onDone;

  const OnboardingScreen({
    super.key,
    required this.initialLanguage,
    required this.onDone,
  });


  /// Fráze průvodce per jazyk: pozdrav, „vyber si zvířátko", „jak se jmenuješ".
  /// `{guide}` = jméno průvodce ([Mascot.name]).
  static const phrases = <Language, (String, String, String)>{
    Language.cs: ('Ahoj! Já jsem {guide}. Pojď si hrát s písmenky.', 'Vyber si zvířátko.', 'Jak se jmenuješ?'),
    Language.en: ("Hi! I'm {guide}. Let's play with letters.", 'Pick your animal.', "What's your name?"),
    Language.de: ('Hallo! Ich bin {guide}. Spielen wir mit Buchstaben.', 'Such dir ein Tier aus.', 'Wie heißt du?'),
    Language.es: ('¡Hola! Soy {guide}. Vamos a jugar con las letras.', 'Elige tu animal.', '¿Cómo te llamas?'),
    Language.it: ('Ciao! Sono {guide}. Giochiamo con le lettere.', 'Scegli il tuo animale.', 'Come ti chiami?'),
    Language.fr: ('Salut ! Je suis {guide}. Jouons avec les lettres.', 'Choisis ton animal.', 'Comment tu t\'appelles ?'),
    Language.pt: ('Oi! Eu sou {guide}. Vamos brincar com as letras.', 'Escolha seu bichinho.', 'Qual é o seu nome?'),
    Language.zh: ('你好！我是{guide}。我们一起玩字母吧。', '选一个小动物。', '你叫什么名字？'),
    Language.ja: ('こんにちは！わたしは{guide}。もじであそぼう。', 'どうぶつをえらんでね。', 'おなまえは？'),
  };

  /// Tytéž fráze v jazycích rodiny, ve kterých se v appce nečte
  /// ([kHomeOnlyLanguages]): dítě slyší průvodce řečí, které rozumí, a čte
  /// v jazyce zvolené vlajky.
  static const homePhrases = <String, (String, String, String)>{
    'uk': ('Привіт! Я {guide}. Пограймося з літерами.', 'Обери собі тваринку.', 'Як тебе звати?'),
    'ru': ('Привет! Я {guide}. Давай поиграем с буквами.', 'Выбери себе зверька.', 'Как тебя зовут?'),
    'vi': ('Xin chào! Mình là {guide}. Cùng chơi với chữ cái nhé.', 'Hãy chọn một con vật.', 'Bạn tên là gì?'),
  };

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late Language _lang =
      EntitlementService.instance.allowed(widget.initialLanguage);

  /// Jazyk rodiny (🗣 pod vlajkami); prázdné = stejný jako jazyk hry.
  /// Sourozenec dědí jazyk rodiny, první dítě jazyk zařízení.
  late String _home = _initialHome();
  int _step = 0; // 0 jazyk, 1 zvířátko, 2 jméno
  String _avatar = ProfileService.defaultAvatar;
  final _name = TextEditingController();
  MascotMood _mood = MascotMood.wave;
  int _taps = 0;

  static String _initialHome() {
    final family = ProfileService.instance.home.value;
    if (family.isNotEmpty) return family;
    final device =
        WidgetsBinding.instance.platformDispatcher.locale.languageCode;
    return kHomeOnlyLanguages.contains(device) ? device : '';
  }

  (String, String, String) get _say {
    // Jazyk rodiny má přednost: buď jazyk, ve kterém se jen mluví (uk…),
    // nebo některý z jazyků hry (anglická rodina, dítě čte česky).
    final (hello, pick, name) = OnboardingScreen.homePhrases[_home] ??
        OnboardingScreen.phrases[Language.values.asNameMap()[_home]] ??
        OnboardingScreen.phrases[_lang] ??
        OnboardingScreen.phrases[Language.en]!;
    return (hello.replaceAll('{guide}', Mascot.name(_lang)), pick, name);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _speakStep());
  }

  @override
  void dispose() {
    _name.dispose();
    super.dispose();
  }

  void _speakStep() {
    final (hello, pick, name) = _say;
    final text = switch (_step) { 0 => hello, 1 => pick, _ => name };
    if (kHomeLanguages.contains(_home)) {
      TtsService.speakIn(text, _home);
    } else {
      TtsService.speak(text, _lang);
    }
  }

  void _pickHome(String code) {
    AudioService.instance.play(Sfx.tap);
    setState(() {
      _home = _home == code ? '' : code; // druhé ťuknutí volbu zruší
      _mood = MascotMood.wave;
    });
    _speakStep();
  }

  void _pickLanguage(Language l) {
    AudioService.instance.play(Sfx.tap);
    setState(() {
      _lang = l;
      _mood = MascotMood.wave; // pozdraví znovu v novém jazyce
    });
    _speakStep();
  }

  Future<void> _next() async {
    AudioService.instance.play(Sfx.success);
    HapticFeedback.mediumImpact();
    if (_step < 2) {
      setState(() {
        _step++;
        _mood = MascotMood.wink;
      });
      _speakStep();
      return;
    }
    // Nový profil (první dítě nebo další sourozenec) → vlastní postup.
    final profile = ProfileService.instance
        .complete(avatar: _avatar, name: _name.text, home: _home);
    await ProgressService.init(profile: profile.id);
    ProgressService.instance.selectedLanguage = _lang;
    // Zařízení s jazykem, který appka neumí: zdarma je první zvolený jazyk.
    EntitlementService.instance.claimFreeLanguage(_lang);
    if (mounted) widget.onDone(_lang);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF1E3C72), Color(0xFF2A5298), Color(0xFF1B6B5A)],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 560),
              child: Column(
                children: [
                  const SizedBox(height: 16),
                  // Průvodce + bublina; ťuknutí zamává (jako všude) a
                  // zopakuje hlas.
                  GestureDetector(
                    key: const ValueKey('mascot'),
                    onTap: () {
                      setState(() {
                        _mood = MascotMood.wave;
                        _taps++;
                      });
                      _speakStep();
                    },
                    child: Column(
                      children: [
                        Mascot(
                          mood: _mood,
                          replay: _taps,
                          size: 80,
                          onSettled: () {
                            if (mounted) {
                              setState(() => _mood = MascotMood.idle);
                            }
                          },
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 24),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 10),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: Text(
                            switch (_step) {
                              0 => _say.$1,
                              1 => _say.$2,
                              _ => _say.$3,
                            },
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: kFont,
                              fontFamilyFallback: kFontFallback,
                              fontSize: 17,
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: switch (_step) {
                      0 => _languageStep(),
                      1 => _avatarStep(),
                      _ => _nameStep(),
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: _BigButton(
                      key: const ValueKey('next'),
                      label: _step == 2 ? '🎹' : '▶',
                      onTap: _next,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _languageStep() => Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Wrap(
                spacing: 12,
                runSpacing: 12,
                alignment: WrapAlignment.center,
                children: [
                  for (final l in EntitlementService.instance.childLanguages)
                    _Choice(
                      key: ValueKey('lang-${l.name}'),
                      emoji: kLanguageFlag[l] ?? '🏳️',
                      selected: l == _lang,
                      onTap: () => _pickLanguage(l),
                    ),
                ],
              ),
              const SizedBox(height: 18),
              // Jazyk rodiny: čím se mluví doma, když se dítě učí číst
              // jinou řečí. Bez textu — 🗣 a vlajky všech jazyků rozhraní.
              const Text('🗣️', style: TextStyle(fontSize: 26)),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  alignment: WrapAlignment.center,
                  children: [
                    for (final code in kHomeLanguages)
                      _Choice(
                        key: ValueKey('home-$code'),
                        emoji: homeLanguageFlag(code),
                        selected: code == _home,
                        size: 46,
                        onTap: () => _pickHome(code),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );

  Widget _avatarStep() => Center(
        child: Wrap(
          spacing: 12,
          runSpacing: 12,
          alignment: WrapAlignment.center,
          children: [
            for (final a in ProfileService.avatars)
              _Choice(
                key: ValueKey('avatar-$a'),
                emoji: a,
                selected: a == _avatar,
                onTap: () {
                  AudioService.instance.play(Sfx.tap);
                  setState(() => _avatar = a);
                },
              ),
          ],
        ),
      );

  // Jméno píše rodič; prázdné je v pořádku (průvodce řekne jen „ahoj").
  Widget _nameStep() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          children: [
            Text(_avatar, style: const TextStyle(fontSize: 64)),
            const SizedBox(height: 12),
            TextField(
              key: const ValueKey('name'),
              controller: _name,
              textAlign: TextAlign.center,
              textCapitalization: TextCapitalization.words,
              maxLength: 20,
              style: TextStyle(
                fontFamily: kDisplayFont,
                fontFamilyFallback: kFontFallback,
                fontSize: 24,
                fontWeight: FontWeight.w900,
                color: Colors.white,
              ),
              decoration: InputDecoration(
                counterText: '',
                filled: true,
                fillColor: Colors.white.withValues(alpha: 0.1),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: BorderSide.none,
                ),
              ),
              onSubmitted: (_) => _next(),
            ),
          ],
        ),
      );
}

class _Choice extends StatelessWidget {
  final String emoji;
  final bool selected;
  final VoidCallback onTap;
  final double size;

  const _Choice({
    super.key,
    required this.emoji,
    required this.selected,
    required this.onTap,
    this.size = 76,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        width: size,
        height: size,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: selected
              ? const Color(0xFFFFD200).withValues(alpha: 0.25)
              : Colors.white.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(size * 0.26),
          border: Border.all(
            color: selected
                ? const Color(0xFFFFD200)
                : Colors.white.withValues(alpha: 0.12),
            width: selected ? 3 : 1,
          ),
        ),
        child: EmojiArt(emoji, size: size * 0.53),
      ),
    );
  }
}

class _BigButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  const _BigButton({super.key, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 96,
        height: 96,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: const LinearGradient(
            colors: [Color(0xFFFFD200), Color(0xFFFF8A00)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFFFFD200).withValues(alpha: 0.5),
              blurRadius: 24,
            ),
          ],
        ),
        child: Text(label,
            style: const TextStyle(fontSize: 40, color: Color(0xFF3A2E1F))),
      ),
    );
  }
}
