import '../data/lessons.dart';
import '../data/models/content_pack.dart';
import '../world/world_clock.dart';
import 'progress_service.dart';

/// Odznaky (roadmap P4): jednorázové, bez streaku s tlakem. Podmínky jsou
/// čistá pravidla nad postupem a světovými hodinami.
enum GameBadge {
  firstSwype('🎯'),
  noMistake('💎'),
  explorer('🧭'),
  collectorHalf('🎒'),
  collectorAll('🏆'),
  nightOwl('🦉'),
  earlyBird('🐦'),
  fourSeasons('🍀'),
  wordsmith10('📚'),
  wordsmith25('📚'),
  wordsmith50('📚'),
  poet('✍️'),
  listener('👂'),
  persistent('🌱');

  const GameBadge(this.emoji);

  /// Název a podmínka jsou v ARB (`GameBadgeL10n` v lib/ui/l10n.dart).
  final String emoji;
}

/// Co se ve hře právě stalo — vstup pro vyhodnocení odznaků.
sealed class Trigger {
  const Trigger();
}

/// Správně dohrané kolo.
class LessonDone extends Trigger {
  final LessonType type;
  final int stars;
  const LessonDone({required this.type, required this.stars});
}

/// Dokončená jednotka; [allThreeStars] = každá lekce na 3⭐ v tomto běhu.
class UnitDone extends Trigger {
  final bool allThreeStars;
  const UnitDone({required this.allThreeStars});
}

/// Otevření mapy / začátek hraní (den, denní doba, období).
class SessionStart extends Trigger {
  const SessionStart();
}

/// Změna batohu, knížky nebo nálepek — přepočítat počty.
class ProgressChanged extends Trigger {
  const ProgressChanged();
}

class AchievementService {
  AchievementService._();
  static final AchievementService instance = AchievementService._();

  static const wordsmithSteps = {
    GameBadge.wordsmith10: 10,
    GameBadge.wordsmith25: 25,
    GameBadge.wordsmith50: 50,
  };
  static const poetSentences = 10;
  static const listenerRounds = 10;
  static const persistentDays = 7;

  /// Vyhodnotí [trigger] pro [pack] a vrátí nově získané odznaky (v pořadí
  /// podle enum). Už získané se nevracejí.
  List<GameBadge> check(Trigger trigger, ContentPack pack,
      {WorldClockService? clock}) {
    final p = ProgressService.instance;
    final world = clock ?? WorldClockService.instance;
    final earned = <GameBadge>[];
    void award(GameBadge b, bool condition) {
      if (condition && p.earnBadge(b.name)) earned.add(b);
    }

    switch (trigger) {
      case LessonDone(:final type, :final stars):
        award(GameBadge.firstSwype, true);
        if (type == LessonType.listen && stars == 3) {
          p.bumpListenPerfect();
        }
        award(GameBadge.listener, p.listenPerfectCount >= listenerRounds);
      case UnitDone(:final allThreeStars):
        award(GameBadge.noMistake, allThreeStars);
      case SessionStart():
        p.recordPlayDay(world.now(), world.season);
        award(GameBadge.nightOwl, world.phase == DayPhase.night);
        award(GameBadge.earlyBird, world.phase == DayPhase.morning);
        award(GameBadge.fourSeasons, p.seasonsPlayed.length == Season.values.length);
        award(GameBadge.persistent, p.playDays.length >= persistentDays);
      case ProgressChanged():
        break;
    }

    // Počty platí po každém spouštěči — nálepky, slova i věty se mohly změnit.
    final stickers = pack.units
        .where((u) => p.hasCollectible(pack.id, u.reward))
        .length;
    award(GameBadge.explorer, stickers >= 1);
    award(GameBadge.collectorHalf, stickers * 2 >= pack.units.length);
    award(GameBadge.collectorAll, stickers >= pack.units.length);
    final words = p.wordBag(pack.id).length;
    for (final e in wordsmithSteps.entries) {
      award(e.key, words >= e.value);
    }
    award(GameBadge.poet, p.book(pack.id).length >= poetSentences);
    return earned;
  }
}
