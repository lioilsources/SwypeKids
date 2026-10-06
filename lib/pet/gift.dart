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

  /// Sloveso pro dárek; `null` = věta nebude. Věc (oko, banán) nejí,
  /// nepije a „nehraje si" — dárek jí jen zajiskří (vlastní slovesa věcí
  /// přijdou s pravidly, `docs/PLAN_VETY_KVALITA.md` §3.2).
  static String? verbIdFor({required Gift gift, required bool residentEats}) {
    if (!residentEats) return null;
    return switch (gift.kind) {
      StickerKind.food => eatVerb,
      StickerKind.drink => drinkVerb,
      _ => playVerb,
    };
  }

  /// Věta po dárku, nebo `null`, když k dárku věta nepatří.
  /// Podmět ze nálepky jednotky („Myš", „Die Maus", „ねこは").
  static SentencePart subjectFor(ContentPack pack, CollectibleReward r) {
    final text = r.subject.isNotEmpty
        ? r.subject
        : r.label.isEmpty
            ? r.emoji
            : r.label[0].toUpperCase() + r.label.substring(1);
    // Japonština/čínština nemají tvary slovesa podle osoby.
    final hasForms = pack.sentence.verbs.any((v) => v.forms != null);
    return SentencePart(
      id: 'pet-${r.emoji}',
      emoji: r.emoji,
      text: text,
      person: hasForms ? '3sg' : null,
      unlockedBy: TileUnlock.sticker,
    );
  }

  /// Podměty builderu vět ze zvířátek (a lidí) Zvěřince — odemknou se
  /// nálepkou. Věci (🍌, ☀️) podmětem nejsou: nejedí, nepijí.
  static List<SentencePart> stickerSubjects(ContentPack pack) => [
        for (final u in pack.units)
          if (StickerKind.of(u.reward.emoji).eats)
            subjectFor(pack, u.reward),
      ];

  static ComposedSentence? compose(
      ContentPack pack, CollectibleReward resident, Gift gift) {
    final data = pack.sentence;
    final verbId = verbIdFor(
        gift: gift, residentEats: StickerKind.of(resident.emoji).eats);
    if (verbId == null) return null;
    final verb = data.verbs.where((v) => v.id == verbId).firstOrNull;
    final subject = subjectFor(pack, resident);
    // Předmět jen s výslovným tvarem pro rámec slovesa („s autem");
    // 4. pád smí chybět, když je stejný jako základní tvar. Jinak věta
    // bez předmětu — nikdy tichý základní tvar („spí mléko").
    final o = gift.object;
    final frame = verb?.frame;
    final fits = o != null &&
        (frame == null ||
            frame == Frame.acc ||
            (o.forms?.containsKey(frame) ?? false));
    return ComposedSentence(
      subject: subject,
      verb: verb,
      object: fits ? o : null,
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
