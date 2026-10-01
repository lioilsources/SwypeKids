import '../data/models/content_pack.dart';
import '../world/world_clock.dart';
import 'progress_service.dart';

/// Odznaky (roadmap P4): jednorázové, bez streaku s tlakem. Podmínky jsou
/// čistá pravidla nad postupem a světovými hodinami.
enum GameBadge {
  firstSwype('🎯', 'První tah', 'První správný swype'),
  noMistake('💎', 'Bez chyby', 'Celá jednotka na samé tři hvězdy'),
  explorer('🧭', 'Objevitel', 'První nálepka'),
  collectorHalf('🎒', 'Sběratel', 'Polovina Zvěřince'),
  collectorAll('🏆', 'Velký sběratel', 'Celý Zvěřinec'),
  nightOwl('🦉', 'Noční sova', 'Hrálo v noci'),
  earlyBird('🐦', 'Ranní ptáče', 'Hrálo ráno'),
  fourSeasons('🍀', 'Čtyři roční období', 'Hrálo v každém období'),
  wordsmith10('📚', 'Slovíčkář', '10 slov v batohu'),
  wordsmith25('📚', 'Velký slovíčkář', '25 slov v batohu'),
  wordsmith50('📚', 'Mistr slov', '50 slov v batohu'),
  poet('✍️', 'Básník', '10 vět v Mé knížce'),
  listener('👂', 'Posluchač', '10 poslechových kol na tři hvězdy'),
  persistent('🌱', 'Vytrvalec', '7 hracích dnů');

  const GameBadge(this.emoji, this.title, this.condition);

  final String emoji;
  final String title;
  final String condition;
}

/// Co se ve hře právě stalo — vstup pro vyhodnocení odznaků.
sealed class Trigger {
  const Trigger();
}

/// Správně dohrané kolo.
class LessonDone extends Trigger {
  final bool listen;
  final int stars;
  const LessonDone({required this.listen, required this.stars});
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
      case LessonDone(:final listen, :final stars):
        award(GameBadge.firstSwype, true);
        if (listen && stars == 3) {
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
