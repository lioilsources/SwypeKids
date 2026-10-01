import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swype_kids/data/lessons.dart';
import 'package:swype_kids/screens/home_shell.dart';
import 'package:swype_kids/services/profile_service.dart';
import 'package:swype_kids/services/progress_service.dart';

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

    await tester.pumpWidget(const MaterialApp(
      home: HomeShell(initialLanguage: Language.cs),
    ));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 400));

    // Otevřít menu a profilový panel
    tester.state<ScaffoldState>(find.byType(Scaffold).first).openDrawer();
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 400));
    expect(find.text('Ema'), findsOneWidget);
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
}
