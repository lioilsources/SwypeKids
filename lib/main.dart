import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'data/lessons.dart';
import 'screens/home_shell.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
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
    return MaterialApp(
      title: 'Swype Kids',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF54A0FF),
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      home: HomeShell(initialLanguage: _detectLanguage()),
    );
  }
}
