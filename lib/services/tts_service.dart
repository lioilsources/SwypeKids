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

  static Future<void> speak(String text, Language lang) async {
    if (text.trim().isEmpty) return;
    try {
      await _tts.setLanguage(_localeTags[lang] ?? 'en-US');
      await _tts.setSpeechRate(0.45);
      await _tts.setPitch(1.05);
      await _tts.stop();
      await _tts.speak(text);
    } catch (_) {
      // TTS engine může chybět (desktop, simulátor) — projeví se tichem.
    }
  }
}
