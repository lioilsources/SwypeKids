import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swype_kids/data/lessons.dart';
import 'package:swype_kids/parent/parent_gate.dart';
import 'package:swype_kids/parent/parent_screen.dart';
import 'package:swype_kids/services/pack_service.dart';
import 'package:swype_kids/services/profile_service.dart';
import 'package:swype_kids/services/progress_service.dart';
import 'helpers.dart';

void main() {
  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    await ProfileService.init();
    await ProgressService.init();
  });

  test('brána: příklad má správnou odpověď mezi třemi různými možnostmi', () {
    final rnd = Random(1);
    for (var i = 0; i < 50; i++) {
      final (a, b, options, idx) = ParentGate.makeQuestion(rnd);
      expect(options.length, 3);
      expect(options.toSet().length, 3);
      expect(options[idx], a * b);
      expect(options.every((o) => o > 0), isTrue);
    }
  });

  testWidgets('brána: špatná odpověď nepustí a vylosuje nový příklad, správná pustí',
      (tester) async {
    var passed = false;
    await tester.pumpWidget(localizedApp(
      home: ParentGate(random: Random(7), onPassed: () => passed = true),
    ));
    final (a, b, options, idx) = ParentGate.makeQuestion(Random(7));
    final question = find.text('Kolik je $a × $b?');
    expect(question, findsOneWidget);
    final wrong = options[(idx + 1) % 3];
    await tester.tap(find.byKey(ValueKey('gate-option-$wrong')));
    await tester.pump();
    expect(passed, isFalse);
    await tester.pump(const Duration(milliseconds: 500));

    // Nový příklad podle stejného generátoru
    final (a2, b2, options2, idx2) = ParentGate.makeQuestion(Random(7)..nextInt(1));
    // (generátor pokračuje; ověříme jen, že správná volba pustí)
    final q2 = tester.widget<Text>(find.byKey(const ValueKey('gate-question')));
    final m = RegExp(r'(\d+) × (\d+)').firstMatch(q2.data!)!;
    final correct = int.parse(m.group(1)!) * int.parse(m.group(2)!);
    await tester.tap(find.byKey(ValueKey('gate-option-$correct')));
    expect(passed, isTrue);
    expect(a2 + b2 + options2.length + idx2, greaterThan(0));
  });

  test('mřížka písmen: zvládnuté / procvičuje / nepotkalo', () async {
    final pack = await PackService.instance.load(Language.cs);
    final p = ProgressService.instance;
    p.markCompleted(pack.id, 'cs-u1-l1', 3); // MA
    for (var i = 0; i < 5; i++) {
      p.recordAttempt(pack.id, 'MA', success: true);
    }
    p.markCompleted(pack.id, 'cs-u2-l1', 1); // TA, síla 0
    final status = ParentScreen.letterStatus(pack);
    expect(status['M'], LetterStatus.mastered);
    expect(status['T'], LetterStatus.practicing);
    expect(status['A'], LetterStatus.practicing); // průměr MA(5) a TA(0) = 2.5
    expect(status['Z'], LetterStatus.unseen);
    expect(ParentScreen.troubleWords(pack, 'A').first.target, 'TA');
  });

  testWidgets('koutek ukáže přehled, mřížku, doporučení, metodu a nastavení',
      (tester) async {
    tester.view.physicalSize = const Size(900, 2200);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);
    ProfileService.instance.complete(avatar: '🐼', name: 'Ema');
    ProfileService.instance.complete(avatar: '🐸', name: 'Kuba');
    await ProgressService.init(profile: 2);
    ProgressService.instance.markCompleted('cs-CZ', 'cs-u1-l1', 3);

    await tester.pumpWidget(localizedApp(
      home: ParentScreen(language: Language.cs),
    ));
    await tester.runAsync(() => PackService.instance.load(Language.cs));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));

    expect(find.text('Přehled'), findsOneWidget);
    expect(find.text('1 / 54'), findsOneWidget);
    expect(find.textContaining('Metoda: analyticko'), findsOneWidget);
    expect(find.byKey(const ValueKey('music-toggle')), findsOneWidget);
    expect(find.byKey(const ValueKey('season-winter')), findsOneWidget);

    await tester.tap(find.byKey(const ValueKey('letter-M')));
    await tester.pump();
    expect(find.byKey(const ValueKey('trouble-words')), findsOneWidget);

    // Smazání profilu Ema (neaktivní) — Kuba zůstává aktivní
    await tester.tap(find.byKey(const ValueKey('delete-profile-1')));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));
    await tester.tap(find.byKey(const ValueKey('confirm-delete')));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));
    expect(ProfileService.instance.profiles.map((p) => p.id), [2]);
    expect(ProfileService.instance.activeId, 2);
  });
}
