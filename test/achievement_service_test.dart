import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swype_kids/data/lessons.dart';
import 'package:swype_kids/data/models/content_pack.dart';
import 'package:swype_kids/services/achievement_service.dart';
import 'package:swype_kids/services/progress_service.dart';
import 'package:swype_kids/world/world_clock.dart';

ContentPack _pack() => ContentPack(
      schemaVersion: 2,
      id: 'test-B',
      language: Language.cs,
      units: [
        for (var u = 1; u <= 4; u++)
          Unit(
            id: 'u$u',
            title: 'U$u',
            icon: '⭐',
            reward: CollectibleReward(emoji: '${u}️⃣'),
            lessons: [
              Lesson(id: 'u$u-l1', unlocked: const ['M', 'A'], target: 'MA',
                  display: 'MA', hint: '👩', label: 'MA'),
            ],
          ),
      ],
    );

void main() {
  late AchievementService a;
  late ProgressService p;

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    await ProgressService.init();
    a = AchievementService.instance;
    p = ProgressService.instance;
  });

  WorldClockService clockAt(int month, int hour) =>
      WorldClockService(now: () => DateTime(2026, month, 15, hour));

  test('první tah jen jednou, bez chyby jen za samé tři hvězdy', () {
    final pack = _pack();
    expect(a.check(const LessonDone(type: LessonType.swype, stars: 2), pack),
        [GameBadge.firstSwype]);
    expect(a.check(const LessonDone(type: LessonType.swype, stars: 3), pack), isEmpty);
    expect(a.check(const UnitDone(allThreeStars: false), pack), isEmpty);
    expect(a.check(const UnitDone(allThreeStars: true), pack), [GameBadge.noMistake]);
    expect(p.hasBadge('noMistake'), isTrue);
  });

  test('sběratelské odznaky podle nálepek', () {
    final pack = _pack();
    p.addCollectible(pack.id, '1️⃣');
    expect(a.check(const ProgressChanged(), pack), [GameBadge.explorer]);
    p.addCollectible(pack.id, '2️⃣');
    expect(a.check(const ProgressChanged(), pack), [GameBadge.collectorHalf]);
    p.addCollectible(pack.id, '3️⃣');
    p.addCollectible(pack.id, '4️⃣');
    expect(a.check(const ProgressChanged(), pack), [GameBadge.collectorAll]);
  });

  test('slovíčkář, básník a posluchač podle počtů', () {
    final pack = _pack();
    for (var i = 0; i < 10; i++) {
      p.addWord(pack.id, 'w$i');
      p.addToBook(pack.id, 'věta $i', '');
    }
    expect(a.check(const ProgressChanged(), pack),
        containsAll([GameBadge.wordsmith10, GameBadge.poet]));
    expect(a.check(const ProgressChanged(), pack), isEmpty);
    for (var i = 0; i < 10; i++) {
      a.check(const LessonDone(type: LessonType.listen, stars: 3), pack);
    }
    expect(p.listenPerfectCount, 10);
    expect(p.hasBadge('listener'), isTrue);
    expect(p.hasBadge('wordsmith25'), isFalse);
  });

  test('sova, ptáče, čtyři období a vytrvalec podle světových hodin', () async {
    final pack = _pack();
    expect(a.check(const SessionStart(), pack, clock: clockAt(1, 22)),
        [GameBadge.nightOwl]);
    expect(a.check(const SessionStart(), pack, clock: clockAt(4, 7)),
        [GameBadge.earlyBird]);
    a.check(const SessionStart(), pack, clock: clockAt(7, 12));
    expect(a.check(const SessionStart(), pack, clock: clockAt(10, 12)),
        [GameBadge.fourSeasons]);
    expect(p.playDays.length, 4);
    for (var d = 1; d <= 3; d++) {
      a.check(const SessionStart(), pack,
          clock: WorldClockService(now: () => DateTime(2026, 11, d, 12)));
    }
    expect(a.check(const SessionStart(), pack,
            clock: WorldClockService(now: () => DateTime(2026, 11, 4, 12))),
        isEmpty); // 8. den, odznak už byl v 7.
    expect(p.hasBadge('persistent'), isTrue);

    await ProgressService.init(); // přežije restart
    expect(ProgressService.instance.badges.keys,
        containsAll(['nightOwl', 'earlyBird', 'fourSeasons', 'persistent']));
    expect(ProgressService.instance.playDays.length, 8);
  });
}
