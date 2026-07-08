import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swype_kids/data/lessons.dart';
import 'package:swype_kids/data/models/content_pack.dart';
import 'package:swype_kids/services/progress_service.dart';

ContentPack _testPack() => const ContentPack(
      schemaVersion: 1,
      id: 'test-XX',
      language: Language.cs,
      units: [
        Unit(
          id: 'u1',
          title: 'M, A',
          icon: '👩',
          reward: CollectibleReward(emoji: '🐭'),
          lessons: [
            Lesson(id: 'u1-l1', unlocked: ['M', 'A'], target: 'MA',
                display: 'MA', hint: '👩', label: 'MÁ-MA'),
            Lesson(id: 'u1-l2', unlocked: ['M', 'A'], target: 'MA',
                display: 'MA', hint: '👩', label: 'MÁ-MA'),
          ],
        ),
        Unit(
          id: 'u2',
          title: 'T',
          icon: '👨',
          reward: CollectibleReward(emoji: '🐯'),
          lessons: [
            Lesson(id: 'u2-l1', unlocked: ['M', 'A', 'T'], target: 'TA',
                display: 'TA', hint: '👨', label: 'TÁ-TA'),
          ],
        ),
      ],
    );

void main() {
  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    await ProgressService.init();
  });

  test('markCompleted ukládá maximum hvězd', () {
    final p = ProgressService.instance;
    expect(p.starsFor('test-XX', 'u1-l1'), 0);
    expect(p.isCompleted('test-XX', 'u1-l1'), isFalse);

    p.markCompleted('test-XX', 'u1-l1', 2);
    expect(p.starsFor('test-XX', 'u1-l1'), 2);
    expect(p.isCompleted('test-XX', 'u1-l1'), isTrue);

    p.markCompleted('test-XX', 'u1-l1', 1); // horší pokus nesnižuje
    expect(p.starsFor('test-XX', 'u1-l1'), 2);

    p.markCompleted('test-XX', 'u1-l1', 3); // lepší přepíše
    expect(p.starsFor('test-XX', 'u1-l1'), 3);
    expect(p.totalStars('test-XX'), 3);
  });

  test('progres přežije restart (re-init ze shared_preferences)', () async {
    ProgressService.instance.markCompleted('test-XX', 'u1-l1', 3);
    ProgressService.instance.addCollectible('test-XX', '🐭');

    await ProgressService.init(); // simulace restartu appky
    expect(ProgressService.instance.starsFor('test-XX', 'u1-l1'), 3);
    expect(ProgressService.instance.collectibles('test-XX'), ['🐭']);
  });

  test('collectibles nedubluje', () {
    final p = ProgressService.instance;
    p.addCollectible('test-XX', '🐭');
    p.addCollectible('test-XX', '🐭');
    p.addCollectible('test-XX', '🐯');
    expect(p.collectibles('test-XX'), ['🐭', '🐯']);
  });

  test('odemykání jednotek a první nedokončená lekce', () {
    final p = ProgressService.instance;
    final pack = _testPack();

    expect(p.isUnitUnlocked(pack, 0), isTrue);
    expect(p.isUnitUnlocked(pack, 1), isFalse);
    expect(p.firstUncompletedIn(pack), (unit: 0, lesson: 0));

    p.markCompleted(pack.id, 'u1-l1', 3);
    expect(p.firstUncompletedIn(pack), (unit: 0, lesson: 1));
    expect(p.isUnitCompleted(pack, 0), isFalse);

    p.markCompleted(pack.id, 'u1-l2', 1);
    expect(p.isUnitCompleted(pack, 0), isTrue);
    expect(p.isUnitUnlocked(pack, 1), isTrue);
    expect(p.firstUncompletedIn(pack), (unit: 1, lesson: 0));

    p.markCompleted(pack.id, 'u2-l1', 2);
    expect(p.firstUncompletedIn(pack), isNull);
  });

  test('volba jazyka se ukládá', () async {
    expect(ProgressService.instance.selectedLanguage, isNull);
    ProgressService.instance.selectedLanguage = Language.cs;
    await ProgressService.init();
    expect(ProgressService.instance.selectedLanguage, Language.cs);
  });
}
