import 'package:flutter/material.dart';
import 'package:swype_kids/l10n/app_localizations.dart';

/// MaterialApp s lokalizací (UI česky) pro widget testy.
Widget localizedApp({required Widget home, Locale locale = const Locale('cs')}) =>
    MaterialApp(
      home: home,
      locale: locale,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
    );
