// Snímky obrazovek pro web a obchody — skutečná appka, skutečné písmo
// a obrázky, rozehraný postup. Hlas i zvuky jsou vypnuté.
//
//   flutter test integration_test/store_screenshots_test.dart -d macos
//
// PNG se uloží do dočasné složky appky (cesta se vypíše na konci:
// `SHOTS_DIR=…`); odtud je `tool/store_screenshots.sh` zkopíruje.
//
// Jazyk: `--dart-define=SHOT_LANG=en` (výchozí cs). `SHOT_LANG` je jazyk
// rozhraní; uk, ru a vi nemají vlastní pack, takže se v nich čte česky
// (jazyk rodiny — ukrajinské dítě v české škole). Jiný jazyk než cs dělá
// jen sady pro App Store; scény (slova, rýmy, věty) se vybírají z packu.
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
import 'package:swype_kids/data/models/sentence.dart';
import 'package:swype_kids/data/sentence_corpus.dart';
import 'package:swype_kids/parent/parent_screen.dart';
import 'package:swype_kids/pet/gift.dart';
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

/// Kam snímky uložit (`--dart-define=SHOT_OUT=…`). Na iOS simulátoru
/// zapisuje appka rovnou na disk Macu — jeho kontejner po testu zmizí.
/// Na macOS je appka v sandboxu, tam zůstane dočasná složka.
const _outPath = String.fromEnvironment('SHOT_OUT');

/// Jazyk rozhraní snímků (`--dart-define=SHOT_LANG=…`).
const _ui = String.fromEnvironment('SHOT_LANG', defaultValue: 'cs');

/// Jazyk, ve kterém se čte: uk/ru/vi nemají pack → čeština.
final Language _lang =
    Language.values.asNameMap()[_ui] ?? Language.cs;

/// Jména sourozenců na snímcích, ať nejsou všude česká.
const _names = {
  'cs': ('Ema', 'Kuba'),
  'en': ('Emma', 'Jack'),
  'de': ('Emma', 'Ben'),
  'es': ('Lucía', 'Mateo'),
  'fr': ('Léa', 'Hugo'),
  'it': ('Sofia', 'Leo'),
  'pt': ('Alice', 'Miguel'),
  'uk': ('Соня', 'Марко'),
  'ru': ('Маша', 'Миша'),
  'vi': ('An', 'Minh'),
};

AppLocalizations get _l => lookupAppLocalizations(Locale(_ui));

/// Rozehraný profil: 13 hotových jednotek, slova v batohu, věty v knížce,
/// pár odznaků a tajných nálepek — ať je na snímcích co vidět.
Future<ContentPack> _seed() async {
  SharedPreferences.setMockInitialValues({});
  await ProfileService.init();
  final profiles = ProfileService.instance;
  final (first, second) = _names[_ui] ?? _names['cs']!;
  profiles.complete(avatar: '🦊', name: first);
  profiles.complete(avatar: '🐸', name: second);
  profiles.switchTo(1);
  profiles.setGuide(1, Guide.panda);
  if (_ui != _lang.name) profiles.setHome(1, _ui);
  await ProgressService.init(profile: 1);
  await SettingsService.instance.load();
  await SessionService.instance.load();
  await WorldClockService.instance.loadSettings();
  final p = ProgressService.instance;
  p.selectedLanguage = _lang;
  final pack = await PackService.instance.load(_lang);
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
  // Pár slov z batohu odemkne předměty v builderu, zbytek zůstane „?“.
  final locked = [
    for (final o in pack.sentence.objects)
      if (o.unlockedBy == TileUnlock.vocab) o.id,
  ];
  for (final w in locked.take(6)) {
    p.addWord(pack.id, w);
  }
  for (final secret in ['🐞', '🍄', '🐢', '🐌']) {
    p.addCollectible(pack.id, secret);
  }
  for (final s in _bookSentences(pack)) {
    p.addToBook(pack.id, s.text, s.emojis);
  }
  for (final b in ['firstSwype', 'explorer', 'noMistake', 'wordsmith10', 'host']) {
    p.earnBadge(b);
  }
  for (var i = 0; i < 12; i++) {
    p.recordGift(pack.id, '🐭');
  }
  return pack;
}

/// Čtyři věty do Mé knížky: tři z builderu (pokaždé jiný podmět, sloveso
/// i předmět), čtvrtá ze světa zvířátka.
List<CorpusSentence> _bookSentences(ContentPack pack) {
  final corpus = SentenceCorpus.of(pack);
  final used = <String>{};
  final out = <CorpusSentence>[];
  for (final s in corpus.where((s) => s.source == 'builder')) {
    final parts = s.parts.split('|');
    final ids = ['s:${parts[0]}', 'v:${parts[1].split(':').first}',
        'o:${parts[2].split(':').first}'];
    if (ids.any(used.contains)) continue;
    used.addAll(ids);
    out.add(s);
    if (out.length == 3) break;
  }
  out.addAll(corpus.where((s) => s.source == 'pet' && !s.parts.endsWith('.-')).take(1));
  return out;
}

/// Věta pro Skládej větu: podmět, sloveso a předmět, které jsou v
/// seznamech co nejvýš (ať jsou dlaždice vidět bez posouvání).
List<String> _builderTiles(ContentPack pack) {
  final d = pack.sentence;
  int at(List<SentencePart> list, String id) =>
      list.indexWhere((x) => x.id == id);
  List<String>? best;
  var bestScore = 1 << 30;
  for (final s in SentenceCorpus.of(pack).where((s) => s.source == 'builder')) {
    final parts = s.parts.split('|');
    final subject = parts[0];
    final verb = parts[1].split(':').first;
    final object = parts[2].split(':').first;
    final i = at(d.subjects, subject), j = at(d.verbs, verb), k = at(d.objects, object);
    if (i < 0 || j < 0 || k < 0) continue;
    final o = d.objects[k];
    if (o.unlockedBy != TileUnlock.always) continue;
    final score = i + j + k;
    if (score < bestScore) {
      bestScore = score;
      best = [subject, verb, object];
    }
  }
  return best!;
}

/// První obyvatel Zvěřince, který jí (zvíře, ne věc), od [from].
int _animalUnit(ContentPack pack, {int from = 0}) {
  for (var i = from; i < pack.units.length; i++) {
    if (PetSentence.eats(pack.units[i].reward)) return i;
  }
  return from;
}

/// Dárek pro obyvatele jednotky [unit], po kterém vznikne věta s předmětem.
String _giftFor(ContentPack pack, int unit) {
  final resident = pack.units[unit].reward;
  final tray = Gift.trayFor(pack);
  for (final g in tray) {
    if (g.object == null) continue;
    final line = PetSentence.line(pack, resident, g);
    // Věta s předmětem („Myš jí jablko.“), ne jen „Myš jí.“
    if (line != null && line.key.endsWith('.${g.id}') &&
        !line.key.startsWith('naming.')) {
      return g.id;
    }
  }
  return tray.first.id;
}

/// Lekce s rýmy (výběr obrázku): (jednotka, lekce).
(int, int) _rhyme(ContentPack pack) {
  for (final (u, unit) in pack.units.indexed) {
    for (final (i, l) in unit.lessons.indexed) {
      if (l.type == LessonType.rhymePick) return (u, i);
    }
  }
  return (5, 0);
}

Widget _app(Widget home, {Locale locale = const Locale(_ui)}) => RepaintBoundary(
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
    {Locale locale = const Locale(_ui)}) async {
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
  final home = HomeShell(initialLanguage: _lang);
  final (rhymeUnit, rhymeLesson) = _rhyme(pack);
  final sticker = _animalUnit(pack, from: 1);
  final pet = _animalUnit(pack);

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
    await _show(t, GameScreen(
        pack: pack, unitIndex: rhymeUnit, startLessonIndex: rhymeLesson));
    await shot('04-rymy');
  }
  if (want('05-nalepka')) {
    await _show(
        t,
        UnitCompleteScreen(
          reward: pack.units[sticker].reward,
          stars: 9,
          playWith: () => PetScreen(pack: pack, unitIndex: sticker),
        ));
    await shot('05-nalepka');
  }
  if (want('06-zverinec')) {
    await _show(t, home);
    await _menu(t, _l.menuZoo);
    await shot('06-zverinec');
  }
  if (want('07-svet-zviratka')) {
    await _show(t, PetScreen(pack: pack, unitIndex: pet));
    await _give(t, _giftFor(pack, pet));
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
    await _menu(t, _l.menuSentence);
    for (final id in _builderTiles(pack)) {
      await t.tap(find.byKey(ValueKey('tile-$id')));
      await _wait(t, 400);
    }
    await shot('09-skladej-vetu');
  }
  if (want('10-ma-knizka')) {
    await _show(t, home);
    await _menu(t, _l.menuBook);
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
    await _show(t, ParentScreen(language: _lang));
    await shot('12-rodice');
  }
  if (want('13-uvod')) {
    await _show(t, OnboardingScreen(initialLanguage: _lang, onDone: (_) {}));
    await shot('13-uvod');
  }
  if (want('14-japonstina')) {
    final ja = await PackService.instance.load(Language.ja);
    AppLanguage.instance.value = Language.ja;
    await _show(t, GameScreen(pack: ja, unitIndex: 1),
        locale: const Locale('ja'));
    await shot('14-japonstina');
    AppLanguage.instance.value = _lang;
  }
}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('snímky obrazovek', (t) async {
    TtsService.muted = true; // zvuky zůstanou tiché: AudioService se nespouští
    // Dopoledne v červnu — ať na snímcích není noc a nikdo nespí.
    WorldClockService.instance.debugNowOverride = () => DateTime(2026, 6, 3, 10);
    AppLanguage.instance.value = _lang;
    _out = Directory(_outPath.isNotEmpty
        ? _outPath
        : '${Directory.systemTemp.path}/swypekids-shots')
      ..createSync(recursive: true);
    for (final f in _out.listSync()) {
      f.deleteSync();
    }
    final pack = await _seed();

    if (_ui == 'cs') {
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
    }

    // App Store: iPhone 6,9" (1320×2868), iPhone 6,3" (1206×2622) a iPad 13"
    // (2064×2752), nejvýš 10 snímků na zařízení. Google Play má vlastní sady
    // (tool/play_screenshots.py).
    const store = {
      '01-mapa',
      '02-hra',
      '04-rymy',
      '05-nalepka',
      '06-zverinec',
      '07-svet-zviratka',
      '09-skladej-vetu',
      '10-ma-knizka',
      '11-pruvodci',
      '12-rodice',
    };
    await _run(t, pack, const Size(440, 956), 3, 'appstore-iphone-', only: store);
    // Slot „iPhone 6,3\"“ v App Store Connect bere jen 1206×2622 (nebo
    // 1179×2556); bez vlastní sady ukáže vybledlé převzaté snímky.
    // Snímky s titulky (tool/store_captions.py) dělají 6,3" z 6,9".
    if (_ui == 'cs') {
      await _run(t, pack, const Size(402, 874), 3, 'appstore-iphone63-', only: store);
    }
    await _run(t, pack, const Size(1032, 1376), 2, 'appstore-ipad-', only: store);

    await t.pumpWidget(const SizedBox());
    await _wait(t, 500);
    // ignore: avoid_print
    print('SHOTS_DIR=${_out.path}');
  }, timeout: const Timeout(Duration(minutes: 15)));
}
