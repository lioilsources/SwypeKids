import 'package:flutter/foundation.dart';
import 'package:flutter_tts/flutter_tts.dart';
import '../data/lessons.dart';

class TtsService {
  static final FlutterTts _tts = FlutterTts();

  static const Map<Language, String> _localeTags = {
    Language.cs: 'cs-CZ',
    Language.en: 'en-US',
    Language.de: 'de-DE',
    Language.es: 'es-ES',
    Language.it: 'it-IT',
    Language.fr: 'fr-FR',
    Language.zh: 'zh-CN',
    Language.ja: 'ja-JP',
    Language.pt: 'pt-BR',
  };

  /// iOS: appka si sama nastaví sdílenou AVAudioSession, než naběhne
  /// flutter_soloud (ten ve verzi 4 kategorii ani aktivaci neřeší a nechává
  /// to na appce). Bez toho iOS použije SoloAmbient → zvuky ztichnou
  /// přepínačem tichého režimu a po domluvení TTS může relace zhasnout.
  /// Playback + mixWithOthers: hra zní i v tichém režimu a nepřeruší
  /// hudbu jiných aplikací; TTS relaci po domluvení nevypíná.
  static Future<void> configureAudioSession() async {
    if (kIsWeb || defaultTargetPlatform != TargetPlatform.iOS) return;
    try {
      await _tts.setIosAudioCategory(
        IosTextToSpeechAudioCategory.playback,
        [IosTextToSpeechAudioCategoryOptions.mixWithOthers],
        IosTextToSpeechAudioMode.defaultMode,
      );
      await _tts.setSharedInstance(true); // setActive(true)
      await _tts.autoStopSharedSession(false);
    } catch (_) {
      // Bez nastavení relace hra běží dál (případně potichu).
    }
  }

  /// Ticho při snímání obrazovek a v integračních testech (na desktopu by
  /// jinak hlas opravdu mluvil).
  @visibleForTesting
  static bool muted = false;

  /// Hlasy jazyků rodiny, ve kterých se nečte (úvodní průvodce).
  static const Map<String, String> _homeTags = {
    'uk': 'uk-UA',
    'ru': 'ru-RU',
    'vi': 'vi-VN',
  };

  static Future<void> speak(String text, Language lang) =>
      _speak(text, _localeTags[lang] ?? 'en-US');

  /// Řekne [text] hlasem jazyka rozhraní [code] (`uk`, `cs`…).
  static Future<void> speakIn(String text, String code) => _speak(
      text,
      _homeTags[code] ??
          _localeTags[Language.values.asNameMap()[code]] ??
          'en-US');

  static Future<void> _speak(String text, String tag) async {
    if (muted || text.trim().isEmpty) return;
    try {
      await _tts.setLanguage(tag);
      await _tts.setSpeechRate(0.45);
      await _tts.setPitch(1.05);
      await _tts.stop();
      await _tts.speak(text);
    } catch (_) {
      // TTS engine může chybět (desktop, simulátor) — projeví se tichem.
    }
  }
}
