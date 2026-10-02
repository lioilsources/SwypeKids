import 'dart:math';

import 'package:flutter/material.dart';

import '../audio/audio_service.dart';
import '../data/lessons.dart';

/// Stavy průvodce (roadmap P1). Názvy odpovídají vstupům Rive state machine
/// z `docs/ILLUSTRATOR_BRIEF.md`, aby se emoji verze dala vyměnit za `.riv`
/// beze změny volajících.
enum MascotMood { idle, wave, wink, cheer, oops, sleep, read }

/// Průvodce Pandička — obrázek na stav s jednoduchými animacemi; po dodání
/// postavy se tělo widgetu nahradí Rive, API zůstane.
///
/// Reakce jsou krátké (≤ 1,2 s) a po nich se vrací do [MascotMood.idle]
/// přes [onSettled]; při redukci pohybu se jen vymění emoji.
class Mascot extends StatefulWidget {
  final MascotMood mood;
  final double size;

  /// Zavolá se, když dočasná reakce (wave/wink/cheer/oops) dohrála.
  final VoidCallback? onSettled;

  /// Ťuknutí prstem — volající obvykle nastaví [MascotMood.wave].
  final VoidCallback? onTickle;

  /// Změna hodnoty přehraje reakci znovu, i když se [mood] nezměnil
  /// (dítě ťukne podruhé, zatímco ještě mává).
  final int replay;

  const Mascot({
    super.key,
    this.mood = MascotMood.idle,
    this.size = 48,
    this.onSettled,
    this.onTickle,
    this.replay = 0,
  });

  static const emoji = '🐼';

  /// Jméno průvodce = zdrobnělina jména zvířete v jazyce packu. Další
  /// zvířata (Gepardíček, Kapybárka, Žirafka…) přibudou s jejich obrázky.
  static const _names = <Language, String>{
    Language.cs: 'Pandička',
    Language.en: 'Pandy',
    Language.de: 'Pandi',
    Language.es: 'Pandita',
    Language.it: 'Pandina',
    Language.fr: 'Pandou',
    Language.pt: 'Pandinha',
    Language.zh: '熊猫宝宝',
    Language.ja: 'パンダちゃん',
  };

  static String name(Language lang) => _names[lang] ?? _names[Language.en]!;

  /// Varianty jásotu — každá oslava si náhodně vybere jednu.
  static const cheerVariants = ['clap', 'dance', 'hug', 'jump', 'star'];

  /// Pracovní postava Pandička (tier‑0 draft z `drafts/stickers/round2`),
  /// než ilustrátor dodá `.riv`. Jeden obrázek na stav; wink sdílí klid.
  static String imageFor(MascotMood mood, {int variant = 0}) => switch (mood) {
        MascotMood.wave => 'assets/characters/panda/wave.png',
        MascotMood.cheer => 'assets/characters/panda/cheer-'
            '${cheerVariants[variant % cheerVariants.length]}.png',
        MascotMood.oops => 'assets/characters/panda/oops.png',
        MascotMood.read => 'assets/characters/panda/read.png',
        MascotMood.sleep => 'assets/characters/panda/sleep.png',
        MascotMood.idle ||
        MascotMood.wink =>
          'assets/characters/panda/idle.png',
      };

  /// Pozdrav průvodce při příchodu na mapu (TTS). `{name}` = jméno dítěte;
  /// bez jména se oslovení vynechá. V noci místo pozdravu „dobrou noc".
  static const _hello = <Language, (String, String)>{
    Language.cs: ('Ahoj{name}!', 'Dobrou noc{name}, zítra zase.'),
    Language.en: ('Hi{name}!', 'Good night{name}, see you tomorrow.'),
    Language.de: ('Hallo{name}!', 'Gute Nacht{name}, bis morgen.'),
    Language.es: ('¡Hola{name}!', 'Buenas noches{name}, hasta mañana.'),
    Language.it: ('Ciao{name}!', 'Buonanotte{name}, a domani.'),
    Language.fr: ('Salut{name} !', 'Bonne nuit{name}, à demain.'),
    Language.pt: ('Oi{name}!', 'Boa noite{name}, até amanhã.'),
    Language.zh: ('你好{name}！', '晚安{name}，明天见。'),
    Language.ja: ('{name}こんにちは！', '{name}おやすみ、またあした。'),
  };

  static String greeting(Language lang, String name, {bool night = false}) {
    final (day, nightText) = _hello[lang] ?? _hello[Language.en]!;
    final template = night ? nightText : day;
    final n = name.trim();
    if (n.isEmpty) return template.replaceAll('{name}', '');
    final sep = switch (lang) {
      Language.zh => '，',
      Language.ja => '',
      _ => ', ',
    };
    return lang == Language.ja
        ? template.replaceAll('{name}', '$n、')
        : template.replaceAll('{name}', '$sep$n');
  }

  /// Doplněk ke stavu — jen tam, kde ho nevyjádří samotný obrázek.
  static String? accessoryFor(MascotMood mood) => switch (mood) {
        MascotMood.wink => '😉',
        MascotMood.sleep => '💤',
        MascotMood.idle ||
        MascotMood.wave ||
        MascotMood.cheer ||
        MascotMood.oops ||
        MascotMood.read =>
          null,
      };

  static bool isTransient(MascotMood mood) =>
      mood == MascotMood.wave ||
      mood == MascotMood.wink ||
      mood == MascotMood.cheer ||
      mood == MascotMood.oops;

  @override
  State<Mascot> createState() => _MascotState();
}

class _MascotState extends State<Mascot> with TickerProviderStateMixin {
  // Dýchání v idle (pomalé), reakce (rychlé).
  late final AnimationController _breath = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 2600),
  );
  late final AnimationController _react = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 900),
  );

  @override
  void initState() {
    super.initState();
    _react.addStatusListener((s) {
      if (s == AnimationStatus.completed) widget.onSettled?.call();
    });
  }

  bool _started = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _syncBreath();
    // Počáteční reakce (např. wave při příchodu) musí také dohrát.
    if (!_started) {
      _started = true;
      _play();
    }
  }

  @override
  void didUpdateWidget(covariant Mascot old) {
    super.didUpdateWidget(old);
    if (old.mood != widget.mood || old.replay != widget.replay) _play();
    _syncBreath();
  }

  void _syncBreath() {
    final reduce = MediaQuery.of(context).disableAnimations;
    if (!reduce && widget.mood != MascotMood.sleep) {
      if (!_breath.isAnimating) _breath.repeat(reverse: true);
    } else {
      _breath.stop();
    }
  }

  /// Varianta jásotu pro právě hrající oslavu.
  int _variant = 0;
  static final _rng = Random();

  void _play() {
    if (!Mascot.isTransient(widget.mood)) return;
    if (widget.mood == MascotMood.cheer) {
      _variant = _rng.nextInt(Mascot.cheerVariants.length);
    }
    // Postava „žvatlá" bez jazyka (roadmap P2) — při mávání a jásotu.
    if (widget.mood == MascotMood.wave || widget.mood == MascotMood.cheer) {
      AudioService.instance.play(Sfx.babble, volume: 0.6);
    }
    if (MediaQuery.of(context).disableAnimations) {
      // Bez pohybu: jen chvíli ukázat doplněk, pak uklidit.
      Future.delayed(const Duration(milliseconds: 700), () {
        if (mounted) widget.onSettled?.call();
      });
      return;
    }
    _react.forward(from: 0);
  }

  @override
  void dispose() {
    _breath.dispose();
    _react.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final accessory = Mascot.accessoryFor(widget.mood);
    return GestureDetector(
      onTap: widget.onTickle,
      child: AnimatedBuilder(
        animation: Listenable.merge([_breath, _react]),
        builder: (context, _) {
          final t = _react.value;
          double scale = 1 + 0.04 * sin(_breath.value * pi); // dýchání
          double dx = 0, dy = 0, angle = 0;
          switch (widget.mood) {
            case MascotMood.cheer:
              // Výskok s pružným dopadem.
              dy = -widget.size * 0.45 * sin(pi * min(1.0, t * 1.2));
              scale *= 1 + 0.15 * sin(pi * t);
            case MascotMood.oops:
              // Krátké zavrtění hlavou, žádný smutek.
              dx = widget.size * 0.08 * sin(t * pi * 6) * (1 - t);
            case MascotMood.wave:
              angle = 0.12 * sin(t * pi * 4) * (1 - t);
            case MascotMood.wink:
              scale *= 1 + 0.08 * sin(pi * t);
            case MascotMood.sleep:
              scale = 0.96;
            case MascotMood.idle || MascotMood.read:
              break;
          }
          return Transform.translate(
            offset: Offset(dx, dy),
            child: Transform.rotate(
              angle: angle,
              child: Transform.scale(
                scale: scale,
                child: SizedBox(
                  width: widget.size * 1.5,
                  height: widget.size * 1.2,
                  child: Stack(
                    clipBehavior: Clip.none,
                    alignment: Alignment.bottomLeft,
                    children: [
                      Image.asset(
                        Mascot.imageFor(widget.mood, variant: _variant),
                        key: ValueKey('mascot-${widget.mood.name}'),
                        width: widget.size * 1.2,
                        height: widget.size * 1.2,
                        filterQuality: FilterQuality.medium,
                        // Bez assetu (testy, rozbitý build) zůstane emoji.
                        errorBuilder: (_, __, ___) => Text(Mascot.emoji,
                            style: TextStyle(fontSize: widget.size)),
                      ),
                      if (accessory != null)
                        Positioned(
                          right: 0,
                          top: 0,
                          child: Text(
                            accessory,
                            style: TextStyle(fontSize: widget.size * 0.5),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
