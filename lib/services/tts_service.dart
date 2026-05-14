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
