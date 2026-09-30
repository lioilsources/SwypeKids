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

  ContentPack? cached(Language lang) => _cache[lang];

  Future<ContentPack> load(Language lang) async {
    final hit = _cache[lang];
    if (hit != null) return hit;
    ContentPack pack;
    try {
      final raw = await rootBundle.loadString('assets/packs/${lang.name}.json');
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
