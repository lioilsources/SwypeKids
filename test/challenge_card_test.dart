import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:swype_kids/data/lessons.dart';
import 'package:swype_kids/widgets/challenge_card.dart';

const _baba = Lesson(
  id: 'x',
  type: LessonType.missingLetter,
  unlocked: ['B', 'A'],
  target: 'BABA',
  display: 'BÁBA',
  hint: '👵',
  label: 'BÁ-BA',
  gap: 2,
);

Future<void> _pump(WidgetTester tester, CardMode mode,
    {List<String> path = const []}) {
  return tester.pumpWidget(MaterialApp(
    home: Scaffold(
      body: ChallengeCard(
        lesson: _baba,
        path: path,
        status: GameStatus.idle,
        shake: false,
        emojiFor: (l) => '🙂',
        mode: mode,
      ),
    ),
  ));
}

void main() {
  testWidgets('doplňovačka skryje jen písmeno v díře, s diakritikou',
      (tester) async {
    await _pump(tester, CardMode.gap);
    expect(find.text('BÁ?A'), findsOneWidget);
    expect(find.text('?'), findsOneWidget); // jen jedno skryté políčko
    expect(find.text('B'), findsOneWidget); // první B zůstává vidět
    expect(find.text('A'), findsNWidgets(2));
  });

  testWidgets('trefené písmeno v díře se odkryje', (tester) async {
    await _pump(tester, CardMode.gap, path: ['B', 'A', 'B']);
    expect(find.text('?'), findsNothing);
    expect(find.text('B'), findsNWidgets(2));
  });

  testWidgets('jen obrázek: žádný text ani písmena', (tester) async {
    await _pump(tester, CardMode.picture);
    expect(find.text('👵'), findsOneWidget);
    expect(find.text('• • •'), findsOneWidget);
    expect(find.text('?'), findsNWidgets(4));
    expect(find.textContaining('Co je na obrázku'), findsOneWidget);
  });

  testWidgets('plný režim ukáže label a písmena', (tester) async {
    await _pump(tester, CardMode.full);
    expect(find.text('BÁ-BA'), findsOneWidget);
    expect(find.text('?'), findsNothing);
  });
}
