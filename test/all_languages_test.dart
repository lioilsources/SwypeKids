import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swype_kids/data/lessons.dart';
import 'package:swype_kids/data/models/content_pack.dart';
import 'package:swype_kids/parent/parent_screen.dart';
import 'package:swype_kids/screens/game_screen.dart';
import 'package:swype_kids/screens/onboarding_screen.dart';
import 'package:swype_kids/services/profile_service.dart';
import 'package:swype_kids/services/progress_service.dart';
import 'package:swype_kids/services/settings_service.dart';
import 'package:swype_kids/services/tts_service.dart';
import 'package:swype_kids/ui/l10n.dart';
import 'package:swype_kids/widgets/key_widget.dart';
import 'package:swype_kids/widgets/keyboard_widget.dart';
import 'helpers.dart';

/// All 45 interface languages (9 pack languages + 36 family-only ones):
/// every screen that shows interface text must lay out in each of them,
/// also right to left (ar, he, ur); the keyboard stays left to right.
const _pack = ContentPack(
  schemaVersion: 1,
  id: 'test-langs',
  language: Language.cs,
  units: [
    Unit(
      id: 'u1',
      title: 'M, A',
      icon: '👩',
      reward: CollectibleReward(emoji: '🐭'),
      lessons: [
        Lesson(id: 'u1-l1', unlocked: ['M', 'A'], target: 'MA',
            display: 'MA', hint: '👩', label: 'MA', vocab: 'ma'),
      ],
    ),
  ],
);

void main() {
  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    TtsService.muted = true;
    await ProgressService.init();
    await ProfileService.init();
    await SettingsService.instance.load();
    AppLanguage.instance.value = Language.cs;
    await seedPack(Language.cs);
  });

  test('every family-only language has a name, flag, voice and greeting', () {
    for (final code in kHomeOnlyLanguages) {
      expect(OnboardingScreen.homePhrases[code], isNotNull, reason: code);
      final (hello, pick, name) = OnboardingScreen.homePhrases[code]!;
      expect(hello, contains('{guide}'), reason: code);
      expect(pick, isNotEmpty);
      expect(name, isNotEmpty);
      expect(homeLanguageName(code), isNot(code));
      expect(homeLanguageFlag(code), isNot('🏳️'));
      expect(localeOfCode(code).languageCode, code.split('-').first);
    }
    expect(localeOfCode('pt-PT'), const Locale('pt', 'PT'));
    expect(localeOfCode('zh-Hant').scriptCode, 'Hant');
  });

  testWidgets('parent corner lays out in every interface language',
      (tester) async {
    tester.view.physicalSize = const Size(900, 2400);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);
    ProfileService.instance.complete(avatar: '🐼', name: 'Mia');
    for (final code in kHomeLanguages) {
      await tester.pumpWidget(localizedApp(
        locale: localeOfCode(code),
        home: ParentScreen(language: Language.cs),
      ));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300));
      expect(tester.takeException(), isNull, reason: code);
    }
  });

  testWidgets('onboarding offers all 45 languages without overflow',
      (tester) async {
    tester.view.physicalSize = const Size(780, 1688); // a small phone
    tester.view.devicePixelRatio = 2.0;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(localizedApp(
      home: OnboardingScreen(initialLanguage: Language.cs, onDone: (_) {}),
    ));
    await tester.pump();
    for (final code in kHomeLanguages) {
      expect(find.byKey(ValueKey('home-$code')), findsOneWidget, reason: code);
    }
    expect(tester.takeException(), isNull);
  });

  testWidgets('the keyboard keeps its left-to-right order in an RTL interface',
      (tester) async {
    tester.view.physicalSize = const Size(1200, 900);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);
    for (final code in ['ar', 'he', 'ur', 'th']) {
      await tester.pumpWidget(localizedApp(
        locale: localeOfCode(code),
        home: GameScreen(pack: _pack, unitIndex: 0),
      ));
      await tester.pump(const Duration(milliseconds: 600));
      final q = tester.getCenter(find.byWidgetPredicate((w) => w is KeyWidget && w.letter == 'Q'));
      final w = tester.getCenter(find.byWidgetPredicate((w) => w is KeyWidget && w.letter == 'W'));
      expect(q.dx, lessThan(w.dx), reason: '$code: QWERTY must not mirror');
      expect(Directionality.of(tester.element(find.byType(KeyboardWidget))), TextDirection.ltr);
      expect(tester.takeException(), isNull, reason: code);
    }
  });
}
