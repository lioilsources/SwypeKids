import '../data/lessons.dart';
import '../data/models/content_pack.dart';
import '../data/models/sentence.dart';
import '../services/progress_service.dart';
import '../ui/sticker_kind.dart';

/// Dárek pro zvířátko = slovo, které dítě zná: nálepka ze slova v batohu
/// (lekce s `vocab`), nebo základní předmět z builderu vět (🍎 🥛 🧸…).
class Gift {
  /// Stabilní id: `vocab` slova, nebo id dlaždice builderu.
  final String id;
  final String emoji;

  /// Lekce slova (mini-kolo, síla slova); `null` u základních předmětů.
  final Lesson? lesson;

  /// Dlaždice předmětu z builderu (pády: „jí jablko", „hraje si s autem").
  final SentencePart? object;

  const Gift({required this.id, required this.emoji, this.lesson, this.object});

  StickerKind get kind => StickerKind.of(emoji);

  /// Dárky na tácku: naučená slova (nejnovější první), pak základní
  /// předměty builderu, bez duplicit podle obrázku.
  static List<Gift> trayFor(ContentPack pack) {
    final progress = ProgressService.instance;
    final bag = progress.wordBag(pack.id);
    final objects = {for (final o in pack.sentence.objects) o.id: o};
    final seen = <String>{};
    final gifts = <Gift>[];
    for (final l in pack.allLessons) {
      if (l.vocab.isEmpty || !bag.contains(l.vocab)) continue;
      // Dárek je jen jídlo, pití nebo hračka — ne máma, les nebo dveře.
      if (!StickerKind.of(l.hint).giftable) continue;
      if (!seen.add(l.hint)) continue;
      gifts.add(Gift(id: l.vocab, emoji: l.hint, lesson: l, object: objects[l.vocab]));
    }
    for (final o in pack.sentence.objects) {
      if (o.unlockedBy != TileUnlock.always) continue;
      if (!StickerKind.of(o.emoji).giftable) continue;
      if (!seen.add(o.emoji)) continue;
      gifts.add(Gift(id: o.id, emoji: o.emoji, object: o));
    }
    return gifts;
  }
}

/// Věta po dárku: „Myš jí jablko." / „ねこはりんごをたべます".
/// Podmět = nálepka jednotky (`reward.subject`), sloveso podle druhu dárku
/// (jí / pije / hraje si — id v2/v3/v6 jsou stejná ve všech packech),
/// předmět jen když ho builder zná i s pády; jinak věta bez předmětu
/// („Myš jí."), aby nikdy nebyla gramaticky špatně.
class PetSentence {
  static const eatVerb = 'v2';
  static const drinkVerb = 'v3';
  static const playVerb = 'v6';

  /// Sloveso pro dárek; `null` = věta nebude (věc nejí ani nepije —
  /// jídlo jen zajiskří).
  static String? verbIdFor({required Gift gift, required bool residentEats}) {
    return switch (gift.kind) {
      StickerKind.food => residentEats ? eatVerb : null,
      StickerKind.drink => residentEats ? drinkVerb : null,
      _ => playVerb,
    };
  }

  /// Věta po dárku, nebo `null`, když k dárku věta nepatří.
  static ComposedSentence? compose(
      ContentPack pack, CollectibleReward resident, Gift gift) {
    final data = pack.sentence;
    final verbId = verbIdFor(
        gift: gift, residentEats: StickerKind.of(resident.emoji).eats);
    if (verbId == null) return null;
    final verb = data.verbs.where((v) => v.id == verbId).firstOrNull;
    final text = resident.subject.isNotEmpty
        ? resident.subject
        : resident.label.isEmpty
            ? resident.emoji
            : resident.label[0].toUpperCase() + resident.label.substring(1);
    final subject = SentencePart(
      id: 'pet',
      emoji: resident.emoji,
      text: text,
      // Japonština/čínština nemají tvary slovesa podle osoby.
      person: verb?.forms == null ? null : '3sg',
    );
    // Hraje si „s autem" jen s hračkou z builderu; jinak věta bez předmětu.
    return ComposedSentence(
      subject: subject,
      verb: verb,
      object: gift.object,
      joiner: data.joiner,
      verbLast: data.order == 'sov',
    );
  }

  /// Text s tečkou na konci (čínština/japonština „。").
  static String sentenceText(ComposedSentence s, Language lang) {
    final end =
        lang == Language.zh || lang == Language.ja ? '。' : '.';
    return '${s.text}$end';
  }
}
