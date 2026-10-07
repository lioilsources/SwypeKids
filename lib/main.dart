import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'audio/audio_service.dart';
import 'data/lessons.dart';
import 'screens/home_shell.dart';
import 'screens/onboarding_screen.dart';
import 'services/entitlement_service.dart';
import 'services/profile_service.dart';
import 'services/progress_service.dart';
import 'services/session_service.dart';
import 'services/settings_service.dart';
import 'services/tts_service.dart';
import 'ui/app_font.dart';
import 'ui/l10n.dart';
import 'world/world_clock.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ProfileService.init();
  await ProgressService.init(profile: ProfileService.instance.activeId);
  await EntitlementService.instance.load(
    deviceLanguage:
        WidgetsBinding.instance.platformDispatcher.locale.languageCode,
    onboardedLanguage: ProgressService.instance.selectedLanguage,
  );
  await AudioService.instance.loadSettings();
  await WorldClockService.instance.loadSettings();
  await SettingsService.instance.load();
  await SessionService.instance.load();
  SessionService.instance.start();
  WorldClockService.instance.start();
  // Zvuková relace iOS musí být nastavená dřív, než naběhne audio engine.
  await TtsService.configureAudioSession();
  // Audio engine startuje na pozadí; do té doby je hra tichá.
  AudioService.instance.init();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.light,
  ));
  // Jazyk UI se nastaví jednou před startem — nikdy ne během buildu
  // (notifikace během buildu přestaví MaterialApp a ta zas HomeShell → smyčka).
  AppLanguage.instance.value = _detectLanguage();
  runApp(const SwyperKidsApp());
}

Language _detectLanguage() {
  // Uložená volba má přednost; autodetekce jen při prvním startu.
  final saved = ProgressService.instance.selectedLanguage;
  final code = WidgetsBinding.instance.platformDispatcher.locale.languageCode;
  // Se zapnutým obchodem jen jazyk, který má dítě odemčený.
  return EntitlementService.instance.allowed(saved ??
      Language.values.firstWhere(
        (l) => l.name == code,
        orElse: () => Language.en,
      ));
}

class SwyperKidsApp extends StatelessWidget {
  const SwyperKidsApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Změna písma (rodičovský koutek) překreslí celou appku.
    return ListenableBuilder(
      listenable:
          Listenable.merge([SettingsService.instance, AppLanguage.instance]),
      builder: (context, _) => MaterialApp(
      title: 'Swype Kids',
      locale: AppLanguage.instance.locale,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // Výchozí písmo pro všechen text bez vlastního stylu (tlačítka,
        // dialogy, popisky, pole) — jinak by zůstalo systémové.
        fontFamily: kFont,
        fontFamilyFallback: kFontFallback,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF54A0FF),
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      home: ProfileService.instance.onboarded
          ? HomeShell(initialLanguage: _detectLanguage())
          : const _FirstStart(),
      ),
    );
  }
}

/// První start: onboarding, po něm rovnou mapa (bez návratu zpět).
class _FirstStart extends StatelessWidget {
  const _FirstStart();

  @override
  Widget build(BuildContext context) {
    return OnboardingScreen(
      initialLanguage: _detectLanguage(),
      onDone: (lang) => Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => HomeShell(initialLanguage: lang)),
      ),
    );
  }
}
