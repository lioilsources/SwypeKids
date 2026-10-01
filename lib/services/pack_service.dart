import 'dart:convert';
import 'dart:ui' show Color;

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart' show rootBundle;

import '../data/keyboard_data.dart';
import '../data/lessons.dart';
import '../data/models/content_pack.dart';

/// Načítá content packy z assets/packs/{lang}.json s in-memory cache.
/// JSON packy jsou jediný zdroj pravdy obsahu.
class PackService {
  PackService._();
  static final PackService instance = PackService._();

  final Map<Language, ContentPack> _cache = {};
  final Map<Language, Future<ContentPack>> _inFlight = {};

  ContentPack? cached(Language lang) => _cache[lang];

  /// Testy: vloží pack načtený z disku, ať widget testy nečekají na asset
  /// kanál (velký JSON se tam dekóduje v izolátu a zasekne se).
  @visibleForTesting
  void seedCache(ContentPack pack) => _cache[pack.language] = pack;

  /// Souběžná volání (mapa + builder + Zvěřinec při startu) sdílejí jedno
  /// načtení.
  Future<ContentPack> load(Language lang) {
    final hit = _cache[lang];
    if (hit != null) return Future.value(hit);
    return _inFlight[lang] ??=
        _load(lang).whenComplete(() => _inFlight.remove(lang));
  }

  Future<ContentPack> _load(Language lang) async {
    ContentPack pack;
    try {
      // Bajty + utf8.decode místo loadString: ten assety nad 50 KB dekóduje
      // v samostatném izolátu, který na iOS (i ve widget testech) nedoběhl —
      // mapa pak zůstala na 🎹. 70 KB se na hlavním izolátu dekóduje za ~1 ms.
      final bytes = await rootBundle.load('assets/packs/${lang.name}.json');
      final raw = utf8.decode(
          bytes.buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes));
      pack = ContentPack.fromJson(
          (jsonDecode(raw) as Map).cast<String, dynamic>());
    } catch (e) {
      // Rozbitý pack by neprošel testem; kdyby přesto chyběl, dítě dostane
      // anglický pack místo prázdné obrazovky.
      if (lang == Language.en) rethrow;
      debugPrint('PackService: pack ${lang.name} nejde načíst ($e), fallback en');
      pack = await load(Language.en);
    }
    _cache[lang] = pack;
    return pack;
  }

  /// Emoji klávesy s ohledem na per-pack override.
  String keyEmojiFor(ContentPack pack, String letter) =>
      pack.keyboardEmoji[letter] ?? keyEmoji(letter);

  /// Barva klávesy s ohledem na per-pack override.
  Color keyColorFor(ContentPack pack, String letter) =>
      pack.keyboardColors[letter] ?? keyColor(letter);
}
