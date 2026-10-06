import 'dart:math';

import '../data/lessons.dart';
import '../data/models/content_pack.dart';
import '../services/progress_service.dart';
import 'gift.dart';

/// Přání zvířátka a mini-kolo před dárkem — tady se ve světě zvířátka
/// opakují naučená slova (plán: `docs/PLAN_ZVERINEC_HRA.md` §2.4).
class PetLearning {
  /// Co si zvířátko přeje: slovo z tácku, přednostně slabé (síla ≤ 3),
  /// nikdy dvakrát za sebou totéž. `null` = tácek nemá naučená slova.
  static Gift? pickWish(ContentPack pack, List<Gift> tray,
      {String? last, Random? rng}) {
    final progress = ProgressService.instance;
    int strength(Gift g) => progress.strengthOf(pack.id, g.lesson!.target);
    final words = [
      for (final g in tray)
        if (g.lesson != null && g.id != last) g,
    ]..sort((a, b) => strength(a).compareTo(strength(b)));
    if (words.isEmpty) return null;
    final weak = words.where((g) => strength(g) <= 3).toList();
    final pool = (weak.isNotEmpty ? weak : words).take(3).toList();
    return pool[(rng ?? Random()).nextInt(pool.length)];
  }

  /// Kolo na napsání slova podle síly: 0–1 celé slovo vidět, 2–3 jedno
  /// písmeno chybí, 4–5 jen obrázek.
  static Lesson roundFor(ContentPack pack, Lesson lesson) {
    final s = ProgressService.instance.strengthOf(pack.id, lesson.target);
    final type = s <= 1
        ? LessonType.swype
        : s <= 3 && lesson.target.length >= 2
            ? LessonType.missingLetter
            : s <= 3
                ? LessonType.swype
                : LessonType.pictureOnly;
    return lesson.withType(type);
  }

  /// Jednotka s jedním kolem pro `GameScreen(practice:)`.
  static Unit roundUnit(ContentPack pack, Gift gift) => Unit(
        id: 'pet-${gift.id}',
        title: gift.lesson!.label,
        icon: gift.emoji,
        reward: const CollectibleReward(emoji: ''),
        lessons: [roundFor(pack, gift.lesson!)],
      );
}
