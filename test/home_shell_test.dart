import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swype_kids/characters/guide.dart';
import 'package:swype_kids/characters/mascot.dart';
import 'package:swype_kids/data/lessons.dart';
import 'package:swype_kids/screens/home_shell.dart';
import 'package:swype_kids/services/profile_service.dart';
import 'package:swype_kids/services/progress_service.dart';
import 'helpers.dart';

void main() {
  testWidgets('menu ukáže sourozence, přepnutí načte jeho postup',
      (tester) async {
    SharedPreferences.setMockInitialValues({});
    await ProfileService.init();
    final s = ProfileService.instance;
    s.complete(avatar: '🐼', name: 'Ema');
    await ProgressService.init(profile: 1);
    ProgressService.instance.selectedLanguage = Language.cs;
    s.complete(avatar: '🐸', name: 'Kuba');
    await ProgressService.init(profile: 2);
    ProgressService.instance.selectedLanguage = Language.en;
    s.switchTo(1);
    await ProgressService.init(profile: 1);

    await tester.pumpWidget(localizedApp(
      home: HomeShell(initialLanguage: Language.cs),
    ));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 400));

    // Otevřít menu a profilový panel
    tester.state<ScaffoldState>(find.byType(Scaffold).first).openDrawer();
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 400));
    expect(findText('Ema'), findsOneWidget);
    await tester.tap(find.byKey(const ValueKey('profile-header')));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 400));
    expect(find.byKey(const ValueKey('profile-2')), findsOneWidget);
    expect(find.byKey(const ValueKey('profile-add')), findsOneWidget);

    // Přepnout na Kubu → aktivní profil 2 a jeho jazyk (en)
    await tester.tap(find.byKey(const ValueKey('profile-2')));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 600));
    expect(ProfileService.instance.activeId, 2);
    expect(ProgressService.instance.profile, 2);
    expect(ProgressService.instance.selectedLanguage, Language.en);
    await tester.pump(const Duration(seconds: 1));
  });

  testWidgets('dítě si v profilu vybere průvodce; každý sourozenec svého',
      (tester) async {
    SharedPreferences.setMockInitialValues({});
    await ProfileService.init();
    final s = ProfileService.instance;
    s.complete(avatar: '🐼', name: 'Ema');
    s.complete(avatar: '🐸', name: 'Kuba');
    s.switchTo(1);
    await ProgressService.init(profile: 1);
    ProgressService.instance.selectedLanguage = Language.cs;

    tester.view.physicalSize = const Size(390, 844) * 3;
    tester.view.devicePixelRatio = 3;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(localizedApp(
      home: HomeShell(initialLanguage: Language.cs),
    ));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 400));
    expect(s.guide.value, Guide.panda);

    tester.state<ScaffoldState>(find.byType(Scaffold).first).openDrawer();
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 400));
    await tester.tap(find.byKey(const ValueKey('profile-header')));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 400));
    expect(findText('Tvůj průvodce'), findsOneWidget);
    expect(findText('Gepardíček'), findsOneWidget);

    await tester.tap(find.byKey(const ValueKey('guide-cheetah')));
    await tester.pump();
    expect(s.guide.value, Guide.cheetah);
    expect(s.active!.guide, Guide.cheetah);
    // Jméno průvodce v textech appky se změní s ním.
    expect(Mascot.name(Language.cs), 'Gepardíček');
    expect(Mascot.imageFor(MascotMood.wave, guide: s.guide.value),
        'assets/characters/cheetah/wave.png');

    // Sourozenec má pořád Pandičku; po návratu je zpátky gepard.
    s.switchTo(2);
    expect(s.guide.value, Guide.panda);
    s.switchTo(1);
    expect(s.guide.value, Guide.cheetah);

    // Volba přežije restart.
    await ProfileService.init();
    expect(ProfileService.instance.guide.value, Guide.cheetah);
    await tester.pump(const Duration(seconds: 1));
  });
}
