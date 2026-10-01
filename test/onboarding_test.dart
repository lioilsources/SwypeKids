import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swype_kids/data/lessons.dart';
import 'package:swype_kids/screens/onboarding_screen.dart';
import 'package:swype_kids/services/profile_service.dart';
import 'package:swype_kids/services/progress_service.dart';

void main() {
  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    await ProgressService.init();
    await ProfileService.init();
  });

  test('profil se uloží a přežije restart', () async {
    expect(ProfileService.instance.onboarded, isFalse);
    ProfileService.instance.complete(avatar: '🐼', name: '  Ema ');
    await ProfileService.init();
    expect(ProfileService.instance.onboarded, isTrue);
    expect(ProfileService.instance.name, 'Ema');
    expect(ProfileService.instance.avatar, '🐼');
  });

  test('každý jazyk má fráze průvodce', () {
    for (final l in Language.values) {
      expect(OnboardingScreen.phrases[l], isNotNull, reason: l.name);
    }
  });

  testWidgets('tři kroky bez čtení: vlajka → zvířátko → jméno → hotovo',
      (tester) async {
    Language? done;
    await tester.pumpWidget(MaterialApp(
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
