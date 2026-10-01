import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swype_kids/data/lessons.dart';
import 'package:swype_kids/screens/onboarding_screen.dart';
import 'package:swype_kids/services/profile_service.dart';
import 'package:swype_kids/services/progress_service.dart';
import 'helpers.dart';

void main() {
  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    await ProgressService.init();
    await ProfileService.init();
  });

  test('profil se uloží a přežije restart', () async {
    expect(ProfileService.instance.onboarded, isFalse);
    final p = ProfileService.instance.complete(avatar: '🐼', name: '  Ema ');
    expect(p.id, 1);
    await ProfileService.init();
    expect(ProfileService.instance.onboarded, isTrue);
    expect(ProfileService.instance.name, 'Ema');
    expect(ProfileService.instance.avatar, '🐼');
  });

  test('sourozenci: každý má vlastní postup, jazyk a odznaky', () async {
    final s = ProfileService.instance;
    s.complete(avatar: '🐼', name: 'Ema');
    await ProgressService.init(profile: 1);
    final p = ProgressService.instance;
    p.markCompleted('cs-CZ', 'cs-u1-l1', 3);
    p.earnBadge('firstSwype');
    p.selectedLanguage = Language.cs;

    final second = s.complete(avatar: '🐸', name: 'Kuba');
    expect(second.id, 2);
    expect(s.activeId, 2);
    await ProgressService.init(profile: 2);
    expect(ProgressService.instance.isCompleted('cs-CZ', 'cs-u1-l1'), isFalse);
    expect(ProgressService.instance.hasBadge('firstSwype'), isFalse);
    expect(ProgressService.instance.selectedLanguage, isNull);
    ProgressService.instance.selectedLanguage = Language.en;
    ProgressService.instance.markCompleted('en-GB', 'en-u1-l1', 2);

    // Zpět k prvnímu: nic se neztratilo
    s.switchTo(1);
    await ProgressService.init(profile: 1);
    expect(ProgressService.instance.starsFor('cs-CZ', 'cs-u1-l1'), 3);
    expect(ProgressService.instance.hasBadge('firstSwype'), isTrue);
    expect(ProgressService.instance.selectedLanguage, Language.cs);

    // Smazání druhého maže jen jeho postup
    await ProgressService.wipeProfile(2);
    s.remove(2);
    await ProgressService.init(profile: 2);
    expect(ProgressService.instance.starsFor('en-GB', 'en-u1-l1'), 0);
    await ProgressService.init(profile: 1);
    expect(ProgressService.instance.starsFor('cs-CZ', 'cs-u1-l1'), 3);
    await ProfileService.init();
    expect(ProfileService.instance.profiles.map((p) => p.id), [1]);
  });

  test('starší jednoprofilová instalace (v2.4.1) se převede na profil 1',
      () async {
    SharedPreferences.setMockInitialValues({
      'sk.profile.onboarded': true,
      'sk.profile.name': 'Ema',
      'sk.profile.avatar': '🐰',
      'sk.progress.cs-CZ': '{"v":1,"completed":{"cs-u1-l1":3},"collectibles":[]}',
    });
    await ProfileService.init();
    final s = ProfileService.instance;
    expect(s.onboarded, isTrue);
    expect(s.activeId, 1);
    expect(s.active!.name, 'Ema');
    await ProgressService.init(profile: s.activeId);
    expect(ProgressService.instance.starsFor('cs-CZ', 'cs-u1-l1'), 3);
  });

  test('každý jazyk má fráze průvodce', () {
    for (final l in Language.values) {
      expect(OnboardingScreen.phrases[l], isNotNull, reason: l.name);
    }
  });

  testWidgets('tři kroky bez čtení: vlajka → zvířátko → jméno → hotovo',
      (tester) async {
    Language? done;
    await tester.pumpWidget(localizedApp(
      home: OnboardingScreen(
        initialLanguage: Language.en,
        onDone: (l) => done = l,
      ),
    ));
    await tester.pump();

    // Krok 1: jazyk podle vlajky
    expect(find.textContaining("I'm Pipi"), findsOneWidget);
    await tester.tap(find.byKey(const ValueKey('lang-cs')));
    await tester.pump();
    expect(find.textContaining('Já jsem Pipi'), findsOneWidget);
    await tester.tap(find.byKey(const ValueKey('next')));
    await tester.pump();

    // Krok 2: zvířátko
    expect(find.text('Vyber si zvířátko.'), findsOneWidget);
    await tester.tap(find.byKey(const ValueKey('avatar-🐼')));
    await tester.pump();
    await tester.tap(find.byKey(const ValueKey('next')));
    await tester.pump();

    // Krok 3: jméno (může zůstat prázdné)
    expect(find.text('Jak se jmenuješ?'), findsOneWidget);
    await tester.enterText(find.byKey(const ValueKey('name')), 'Ema');
    await tester.tap(find.byKey(const ValueKey('next')));
    await tester.pump();

    expect(done, Language.cs);
    expect(ProfileService.instance.onboarded, isTrue);
    expect(ProfileService.instance.avatar, '🐼');
    expect(ProfileService.instance.name, 'Ema');
    expect(ProgressService.instance.selectedLanguage, Language.cs);
  });
}
