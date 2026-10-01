import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:swype_kids/data/lessons.dart';
import 'package:swype_kids/data/models/content_pack.dart';
import 'package:swype_kids/services/pack_service.dart';
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
