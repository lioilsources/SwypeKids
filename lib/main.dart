import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'audio/audio_service.dart';
import 'data/lessons.dart';
import 'screens/home_shell.dart';
import 'screens/onboarding_screen.dart';
import 'services/profile_service.dart';
import 'services/progress_service.dart';
import 'services/session_service.dart';
import 'services/settings_service.dart';
import 'world/world_clock.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ProfileService.init();
  await ProgressService.init(profile: ProfileService.instance.activeId);
  await AudioService.instance.loadSettings();
  await WorldClockService.instance.loadSettings();
  await SettingsService.instance.load();
  await SessionService.instance.load();
  SessionService.instance.start();
  WorldClockService.instance.start();
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
  runApp(const SwyperKidsApp());
}

Language _detectLanguage() {
  // Uložená volba má přednost; autodetekce jen při prvním startu.
  final saved = ProgressService.instance.selectedLanguage;
  if (saved != null) return saved;
  final code = WidgetsBinding.instance.platformDispatcher.locale.languageCode;
  return Language.values.firstWhere(
    (l) => l.name == code,
    orElse: () => Language.en,
  );
}

class SwyperKidsApp extends StatelessWidget {
  const SwyperKidsApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Změna písma (rodičovský koutek) překreslí celou appku.
    return ListenableBuilder(
      listenable: SettingsService.instance,
      builder: (context, _) => MaterialApp(
      title: 'Swype Kids',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
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
