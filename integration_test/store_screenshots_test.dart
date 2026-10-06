// Snímky obrazovek pro web a obchody — skutečná appka, skutečné písmo
// a obrázky, rozehraný postup. Hlas i zvuky jsou vypnuté.
//
//   flutter test integration_test/store_screenshots_test.dart -d macos
//
// PNG se uloží do dočasné složky appky (cesta se vypíše na konci:
// `SHOTS_DIR=…`); odtud je `tool/store_screenshots.sh` zkopíruje.
import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swype_kids/characters/guide.dart';
import 'package:swype_kids/data/lessons.dart';
import 'package:swype_kids/data/models/content_pack.dart';
import 'package:swype_kids/parent/parent_screen.dart';
import 'package:swype_kids/pet/pet_screen.dart';
import 'package:swype_kids/screens/game_screen.dart';
import 'package:swype_kids/screens/home_shell.dart';
import 'package:swype_kids/screens/onboarding_screen.dart';
import 'package:swype_kids/screens/unit_complete_screen.dart';
import 'package:swype_kids/services/pack_service.dart';
import 'package:swype_kids/services/profile_service.dart';
import 'package:swype_kids/services/progress_service.dart';
import 'package:swype_kids/services/session_service.dart';
import 'package:swype_kids/services/settings_service.dart';
import 'package:swype_kids/services/tts_service.dart';
import 'package:swype_kids/ui/app_font.dart';
import 'package:swype_kids/ui/l10n.dart';
import 'package:swype_kids/world/world_clock.dart';

final _root = GlobalKey();
late Directory _out;

/// Rozehraný profil: 13 hotových jednotek, slova v batohu, věty v knížce,
/// pár odznaků a tajných nálepek — ať je na snímcích co vidět.
Future<ContentPack> _seed() async {
  SharedPreferences.setMockInitialValues({});
  await ProfileService.init();
  final profiles = ProfileService.instance;
  profiles.complete(avatar: '🦊', name: 'Ema');
  profiles.complete(avatar: '🐸', name: 'Kuba');
  profiles.switchTo(1);
  profiles.setGuide(1, Guide.panda);
  await ProgressService.init(profile: 1);
  await SettingsService.instance.load();
  await SessionService.instance.load();
  await WorldClockService.instance.loadSettings();
  final p = ProgressService.instance;
  p.selectedLanguage = Language.cs;
  final pack = await PackService.instance.load(Language.cs);
  for (var u = 0; u < 13; u++) {
    final unit = pack.units[u];
    for (final (i, l) in unit.lessons.indexed) {
      p.markCompleted(pack.id, l.id, i % 3 == 1 ? 2 : 3);
      p.recordAttempt(pack.id, l.target, success: true);
      if (i.isEven) p.recordAttempt(pack.id, l.target, success: true);
      if (l.vocab.isNotEmpty) p.addWord(pack.id, l.vocab);
    }
    p.addCollectible(pack.id, unit.reward.emoji);
    p.markUnitRevealed(pack.id, unit.id);
  }
  for (final w in ['mleko', 'hracka', 'auto', 'banan', 'voda', 'kniha']) {
    p.addWord(pack.id, w);
  }
  for (final secret in ['🐞', '🍄', '🐢', '🐌']) {
    p.addCollectible(pack.id, secret);
  }
  p.addToBook(pack.id, 'Máma jí jablko.', '👩 🍽️ 🍎');
  p.addToBook(pack.id, 'Já si hraju s autem.', '👶 🎲 🚗');
  p.addToBook(pack.id, 'Myš pije mléko.', '🐭 🥛 🥛');
  p.addToBook(pack.id, 'Oko se dívá na kolo.', '👁️ 👀 🚲');
  for (final b in ['firstSwype', 'explorer', 'noMistake', 'wordsmith10', 'host']) {
    p.earnBadge(b);
  }
  for (var i = 0; i < 12; i++) {
    p.recordGift(pack.id, '🐭');
  }
  return pack;
}

Widget _app(Widget home, {Locale locale = const Locale('cs')}) => RepaintBoundary(
      key: _root,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        locale: locale,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        theme: ThemeData(
          fontFamily: kFont,
          fontFamilyFallback: kFontFallback,
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFF54A0FF),
            brightness: Brightness.dark,
          ),
          useMaterial3: true,
        ),
        home: home,
      ),
    );

Future<void> _wait(WidgetTester t, [int ms = 1600]) async {
  for (var i = 0; i < ms ~/ 100; i++) {
    await t.pump(const Duration(milliseconds: 100));
  }
}

Future<void> _shot(WidgetTester t, String name, double ratio) async {
  await _wait(t, 400);
  final boundary = _root.currentContext!.findRenderObject()! as RenderRepaintBoundary;
  final image = await boundary.toImage(pixelRatio: ratio);
  final bytes = await image.toByteData(format: ui.ImageByteFormat.png);
  File('${_out.path}/$name.png').writeAsBytesSync(bytes!.buffer.asUint8List());
  image.dispose();
}

Future<void> _show(WidgetTester t, Widget home,
    {Locale locale = const Locale('cs')}) async {
  // Nový strom pro každý snímek: žádný stav z předchozí obrazovky.
  await t.pumpWidget(const SizedBox());
  await t.pump(const Duration(milliseconds: 100));
  await t.pumpWidget(_app(home, locale: locale));
  await _wait(t, 2600);
}

Future<void> _menu(WidgetTester t, String label) async {
  t.firstState<ScaffoldState>(find.byType(Scaffold)).openDrawer();
  await _wait(t, 700);
  await t.tap(find.text(label).last);
  await _wait(t, 1800);
}

/// Dárek z tácku ve světě zvířátka (tácek se posouvá — nejdřív doscrollovat).
Future<void> _give(WidgetTester t, String gift) async {
  final from = find.byKey(ValueKey('gift-$gift'));
  await t.scrollUntilVisible(
    from,
    120,
    scrollable: find.descendant(
        of: find.byKey(const ValueKey('pet-tray')),
        matching: find.byType(Scrollable)),
  );
  await _wait(t, 400);
  await _drag(t, from, find.byKey(const ValueKey('pet-resident')));
}

Future<void> _drag(WidgetTester t, Finder from, Finder to) async {
  final g = await t.startGesture(t.getCenter(from));
  await t.pump(const Duration(milliseconds: 80));
  await g.moveTo(t.getCenter(to), timeStamp: const Duration(milliseconds: 200));
  await t.pump(const Duration(milliseconds: 80));
  await g.up();
  await t.pump();
}

/// Jedna sada snímků ve velikosti [size]; [only] omezí výběr (desktop).
Future<void> _run(WidgetTester t, ContentPack pack, Size size, double ratio,
    String prefix, {Set<String>? only}) async {
  await t.binding.setSurfaceSize(size);
  bool want(String name) => only == null || only.contains(name);
  Future<void> shot(String name) => _shot(t, '$prefix$name', ratio);
  final home = HomeShell(initialLanguage: Language.cs);

  if (want('01-mapa')) {
    await _show(t, home);
    await shot('01-mapa');
  }
  if (want('02-hra')) {
    await _show(t, GameScreen(pack: pack, unitIndex: 5));
    await shot('02-hra');
  }
  if (want('03-doplnovacka')) {
    await _show(t, GameScreen(pack: pack, unitIndex: 5, startLessonIndex: 2));
    await shot('03-doplnovacka');
  }
  if (want('04-rymy')) {
    await _show(t, GameScreen(pack: pack, unitIndex: 12, startLessonIndex: 4));
    await shot('04-rymy');
  }
  if (want('05-nalepka')) {
    await _show(
        t,
        UnitCompleteScreen(
          reward: pack.units[1].reward,
          stars: 9,
          playWith: () => PetScreen(pack: pack, unitIndex: 1),
        ));
    await shot('05-nalepka');
  }
  if (want('06-zverinec')) {
    await _show(t, home);
    await _menu(t, 'Zvěřinec');
    await shot('06-zverinec');
  }
  if (want('07-svet-zviratka')) {
    await _show(t, PetScreen(pack: pack, unitIndex: 0));
    await _give(t, 'o2');
    await _wait(t, 2600); // průvodce uhne z věty
    await shot('07-svet-zviratka');
  }
  if (want('08-svet-oko')) {
    await _show(t, PetScreen(pack: pack, unitIndex: 4));
    await _give(t, 'kolo');
    await _wait(t, 2600);
    await shot('08-svet-oko');
  }
  if (want('09-skladej-vetu')) {
    await _show(t, home);
    await _menu(t, 'Skládej větu');
    for (final key in ['tile-mama', 'tile-v2', 'tile-o2']) {
      await t.tap(find.byKey(ValueKey(key)));
      await _wait(t, 400);
    }
    await shot('09-skladej-vetu');
  }
  if (want('10-ma-knizka')) {
    await _show(t, home);
    await _menu(t, 'Má knížka');
    await shot('10-ma-knizka');
  }
  if (want('11-pruvodci')) {
    await _show(t, home);
    t.firstState<ScaffoldState>(find.byType(Scaffold)).openDrawer();
    await _wait(t, 700);
    await t.tap(find.byKey(const ValueKey('profile-header')));
    await _wait(t, 1500);
    await shot('11-pruvodci');
  }
  if (want('12-rodice')) {
    await _show(t, const ParentScreen(language: Language.cs));
    await shot('12-rodice');
  }
  if (want('13-uvod')) {
    await _show(t, OnboardingScreen(initialLanguage: Language.cs, onDone: (_) {}));
    await shot('13-uvod');
  }
  if (want('14-japonstina')) {
    final ja = await PackService.instance.load(Language.ja);
    AppLanguage.instance.value = Language.ja;
    await _show(t, GameScreen(pack: ja, unitIndex: 1),
        locale: const Locale('ja'));
    await shot('14-japonstina');
    AppLanguage.instance.value = Language.cs;
  }
}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('snímky obrazovek', (t) async {
    TtsService.muted = true; // zvuky zůstanou tiché: AudioService se nespouští
    // Dopoledne v červnu — ať na snímcích není noc a nikdo nespí.
    WorldClockService.instance.debugNowOverride = () => DateTime(2026, 6, 3, 10);
    AppLanguage.instance.value = Language.cs;
    _out = Directory('${Directory.systemTemp.path}/swypekids-shots')
      ..createSync(recursive: true);
    for (final f in _out.listSync()) {
      f.deleteSync();
    }
    final pack = await _seed();

    // Telefon na výšku (iPhone 390×844 @3x) — všechny sekce.
    await _run(t, pack, const Size(390, 844), 3, 'phone-');
    // Počítač (1280×800 @2x) — výběr.
    await _run(t, pack, const Size(1280, 800), 2, 'desktop-', only: {
      '01-mapa',
      '02-hra',
      '06-zverinec',
      '07-svet-zviratka',
      '09-skladej-vetu',
    });

    await t.pumpWidget(const SizedBox());
    await _wait(t, 500);
    // ignore: avoid_print
    print('SHOTS_DIR=${_out.path}');
  }, timeout: const Timeout(Duration(minutes: 15)));
}
