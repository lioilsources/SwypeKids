import 'dart:convert';
import 'dart:io';

import 'package:cute_kid_fonts/cute_kid_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swype_kids/data/lessons.dart';
import 'package:swype_kids/main.dart' show languageOfCountry;
import 'package:swype_kids/parent/parent_screen.dart';
import 'package:swype_kids/screens/onboarding_screen.dart';
import 'package:swype_kids/services/profile_service.dart';
import 'package:swype_kids/services/progress_service.dart';
import 'package:swype_kids/services/settings_service.dart';
import 'package:swype_kids/ui/app_font.dart';
import 'package:swype_kids/ui/l10n.dart';
import 'helpers.dart';

/// Jazyk rodiny: rozhraní v řeči, které doma rozumějí (uk, ru, vi…),
/// zatímco se dítě učí číst v jazyce packu.
void main() {
  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    await ProgressService.init();
    await ProfileService.init();
    await SettingsService.instance.load();
    AppLanguage.instance.value = Language.cs;
    await seedPack(Language.cs);
  });

  test('jazyk rodiny patří profilu, přežije restart a řídí jazyk rozhraní',
      () async {
    final s = ProfileService.instance;
    s.complete(avatar: '🐼', name: 'Olena', home: 'uk');
    expect(AppLanguage.instance.locale, const Locale('uk'));

    // Sourozenec bez jazyka rodiny: rozhraní v jazyce hry.
    s.complete(avatar: '🐸', name: 'Kuba');
    expect(AppLanguage.instance.locale, const Locale('cs'));

    await ProfileService.init();
    s.switchTo(1);
    expect(s.home.value, 'uk');
    expect(AppLanguage.instance.locale, const Locale('uk'));

    // Rodič ho v koutku změní nebo zruší.
    s.setHome(1, 'vi');
    expect(AppLanguage.instance.locale, const Locale('vi'));
    s.setHome(1, '');
    expect(AppLanguage.instance.locale, const Locale('cs'));
  });

  test('neznámý kód v uloženém profilu rozhraní nerozbije', () {
    ProfileService.instance.complete(avatar: '🐼', name: 'X', home: 'xx');
    expect(AppLanguage.instance.locale, const Locale('cs'));
  });

  test('každý jazyk rozhraní má překlad, jméno, vlajku a všechny klíče', () {
    Map<String, dynamic> arb(String code) =>
        (jsonDecode(File('lib/l10n/app_$code.arb').readAsStringSync()) as Map)
            .cast<String, dynamic>();
    Set<String> keys(Map<String, dynamic> m) =>
        m.keys.where((k) => !k.startsWith('@')).toSet();
    final template = keys(arb('cs'));
    expect(kHomeLanguages.length, Language.values.length + 3);
    for (final code in kHomeLanguages) {
      expect(AppLocalizations.supportedLocales, contains(Locale(code)),
          reason: code);
      expect(keys(arb(code)), template, reason: code);
      expect(homeLanguageName(code), isNot(code));
      expect(homeLanguageFlag(code), isNot('🏳️'));
    }
    for (final code in kHomeOnlyLanguages) {
      expect(OnboardingScreen.homePhrases[code], isNotNull, reason: code);
    }
  });

  test('vietnamské rozhraní sází písmo, které umí všechna znaménka', () {
    expect(kFont, KidFonts.dynaPuff);
    ProfileService.instance.complete(avatar: '🐼', name: 'An', home: 'vi');
    expect(kFont, KidFonts.baloo2);
  });

  test('zařízení v jazyce, ve kterém se nečte: nabídne se jazyk země', () {
    expect(languageOfCountry('CZ'), Language.cs);
    expect(languageOfCountry('AT'), Language.de);
    expect(languageOfCountry('UA'), Language.en);
    expect(languageOfCountry(null), Language.en);
  });

  testWidgets('úvod: 🗣 vlajka přepne průvodce do jazyka rodiny, čte se česky',
      (tester) async {
    Language? done;
    await tester.pumpWidget(localizedApp(
      home: OnboardingScreen(
        initialLanguage: Language.cs,
        onDone: (l) => done = l,
      ),
    ));
    await tester.pump();
    expect(find.textContaining('Já jsem Pandička'), findsOneWidget);

    await tester.tap(find.byKey(const ValueKey('home-uk')));
    await tester.pump();
    expect(find.textContaining('Я Pandička'), findsOneWidget);

    // Druhé ťuknutí volbu zruší, třetí ji vrátí.
    await tester.tap(find.byKey(const ValueKey('home-uk')));
    await tester.pump();
    expect(find.textContaining('Já jsem Pandička'), findsOneWidget);
    await tester.tap(find.byKey(const ValueKey('home-uk')));
    await tester.pump();

    for (var i = 0; i < 3; i++) {
      await tester.tap(find.byKey(const ValueKey('next')));
      await tester.pump();
    }
    expect(done, Language.cs);
    expect(ProgressService.instance.selectedLanguage, Language.cs);
    expect(ProfileService.instance.active!.home, 'uk');
    expect(AppLanguage.instance.locale, const Locale('uk'));
  });

  testWidgets('koutek v ukrajinštině: rodič změní jazyk rodiny profilu',
      (tester) async {
    tester.view.physicalSize = const Size(900, 2400);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);
    ProfileService.instance.complete(avatar: '🐼', name: 'Olena', home: 'uk');

    await tester.pumpWidget(localizedApp(
      locale: AppLanguage.instance.locale,
      home: ParentScreen(language: Language.cs),
    ));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));
    expect(tester.takeException(), isNull);
    expect(find.textContaining('Українська'), findsOneWidget);

    await tester.tap(find.byKey(const ValueKey('home-1')));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));
    await tester.tap(find.textContaining('Tiếng Việt').last);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));
    expect(ProfileService.instance.active!.home, 'vi');
    expect(tester.takeException(), isNull);
  });
}
