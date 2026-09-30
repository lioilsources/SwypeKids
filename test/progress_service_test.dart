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

  group('batoh slov', () {
    test('addWord přidá jen jednou a přežije restart', () async {
      final p = ProgressService.instance;
      expect(p.addWord('test-XX', 'mama'), isTrue);
      expect(p.addWord('test-XX', 'mama'), isFalse);
      expect(p.addWord('test-XX', ''), isFalse);
      expect(p.wordBag('test-XX'), {'mama'});

      await ProgressService.init(); // znovu načíst z SharedPreferences
      expect(ProgressService.instance.hasWord('test-XX', 'mama'), isTrue);
      expect(ProgressService.instance.hasWord('test-YY', 'mama'), isFalse);
    });

    test('„nové" slovo platí 24 h', () {
      final p = ProgressService.instance;
      final t0 = DateTime(2026, 9, 30, 8);
      p.addWord('test-XX', 'kolo', now: t0);
      expect(p.isNewWord('test-XX', 'kolo', now: t0.add(const Duration(hours: 23))),
          isTrue);
      expect(p.isNewWord('test-XX', 'kolo', now: t0.add(const Duration(hours: 24))),
          isFalse);
      expect(p.isNewWord('test-XX', 'les', now: t0), isFalse);
    });
  });

  group('síla slov', () {
    test('úspěch +1, chyba −1, v mezích 0–5', () {
      final p = ProgressService.instance;
      p.recordAttempt('test-XX', 'MA', success: false);
      expect(p.strengthOf('test-XX', 'MA'), 0);
      for (var i = 0; i < 7; i++) {
        p.recordAttempt('test-XX', 'MA', success: true);
      }
      expect(p.strengthOf('test-XX', 'MA'), 5);
      p.recordAttempt('test-XX', 'MA', success: false);
      expect(p.strengthOf('test-XX', 'MA'), 4);
    });

    test('weakestLearned: jen dokončené, unikátní target, od nejslabší', () {
      final p = ProgressService.instance;
      final pack = _testPack();
      p.markCompleted(pack.id, 'u1-l1', 3); // MA
      p.markCompleted(pack.id, 'u1-l2', 3); // MA znovu → jen jednou
      p.markCompleted(pack.id, 'u2-l1', 3); // TA
      p.recordAttempt(pack.id, 'MA', success: true);
      expect(p.weakestLearned(pack).map((l) => l.target), ['TA', 'MA']);
      expect(p.weakestLearned(pack, limit: 1).single.target, 'TA');
    });
  });
}
