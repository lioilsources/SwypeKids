import 'dart:convert';
import 'dart:io';

import 'package:cute_kid_fonts/cute_kid_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:swype_kids/data/lessons.dart';
import 'package:swype_kids/data/models/content_pack.dart';
import 'package:swype_kids/services/pack_service.dart';
import 'package:swype_kids/ui/emoji_art.dart';
import 'package:swype_kids/l10n/app_localizations.dart';

/// MaterialApp s lokalizací (UI česky) pro widget testy.
Widget localizedApp({required Widget home, Locale locale = const Locale('cs')}) =>
    MaterialApp(
      home: home,
      locale: locale,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
    );

/// Načte pack z disku a vloží ho do cache PackService (bez asset kanálu).
Future<ContentPack> seedPack(Language lang) async {
  final raw = await File('assets/packs/${lang.name}.json').readAsString();
  final pack =
      ContentPack.fromJson((jsonDecode(raw) as Map).cast<String, dynamic>());
  PackService.instance.seedCache(pack);
  return pack;
}

/// Jako `find.text`, ale najde i emoji nahrazené obrázkem ([EmojiArt])
/// a bublinkový text z CuteKidFonts ([BubbleText], štítek na kartě).
/// Záložní `Text` uvnitř [EmojiArt] se nepočítá dvakrát.
Finder findText(String text) => find.byElementPredicate((e) {
      final w = e.widget;
      if (w is EmojiArt) return w.emoji == text;
      if (w is BubbleText) return w.text == text;
      return w is Text &&
          w.data == text &&
          e.findAncestorWidgetOfExactType<EmojiArt>() == null;
    });

/// Náhrada `pumpAndSettle` pro obrazovky s nekonečnou animací (dýchající
/// nálepky [EmojiArt], průvodce): odpumpuje pevný čas po malých krocích.
Future<void> settle(WidgetTester tester,
    [Duration total = const Duration(seconds: 2)]) async {
  const step = Duration(milliseconds: 100);
  for (var t = Duration.zero; t < total; t += step) {
    await tester.pump(step);
  }
}
