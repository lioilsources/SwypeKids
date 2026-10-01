import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swype_kids/data/lessons.dart';
import 'package:swype_kids/services/settings_service.dart';
import 'package:swype_kids/ui/app_font.dart';
import 'package:swype_kids/widgets/key_widget.dart';
import 'package:swype_kids/widgets/keyboard_widget.dart';

void main() {
  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    await SettingsService.instance.load();
  });

  test('nastavení se ukládá, ohlašuje a přežije restart', () async {
    final s = SettingsService.instance;
    var n = 0;
    s.addListener(() => n++);
    s.leftHanded = true;
    s.leftHanded = true; // beze změny → bez notifikace
    s.sessionLimitMin = 15;
    s.dyslexiaFont = true;
    expect(n, 3);
    await SettingsService.instance.load();
    expect(SettingsService.instance.leftHanded, isTrue);
    expect(SettingsService.instance.sessionLimitMin, 15);
    expect(SettingsService.instance.dyslexiaFont, isTrue);
    expect(kFont, 'OpenDyslexic');
    SettingsService.instance.dyslexiaFont = false;
    expect(kFont, 'Nunito');
    s.removeListener(() => n++);
  });

  Finder key(String l) =>
      find.byWidgetPredicate((w) => w is KeyWidget && w.letter == l);

  testWidgets('levák: zrcadlená klávesnice má Q vpravo a M vlevo', (tester) async {
    tester.view.physicalSize = const Size(1000, 600);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);
    const lesson = Lesson(
        unlocked: ['Q', 'P', 'M', 'Z'], target: 'MA', display: 'MA', hint: '👩', label: 'MA');
    Widget board(bool mirrored) => MaterialApp(
          home: Scaffold(
            body: KeyboardWidget(
              lesson: lesson,
              newLetters: const [],
              emojiFor: (_) => '🙂',
              onSwypeEnd: (_) {},
              mirrored: mirrored,
            ),
          ),
        );
    await tester.pumpWidget(board(false));
    expect(tester.getCenter(key('Q')).dx, lessThan(tester.getCenter(key('P')).dx));
    expect(tester.getCenter(key('Z')).dx, lessThan(tester.getCenter(key('M')).dx));
    await tester.pumpWidget(board(true));
    expect(tester.getCenter(key('Q')).dx, greaterThan(tester.getCenter(key('P')).dx));
    expect(tester.getCenter(key('Z')).dx, greaterThan(tester.getCenter(key('M')).dx));
  });
}
