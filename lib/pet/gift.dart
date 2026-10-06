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

/// Řádek, který se po dárku objeví v bublině: text věty, obrázky nad ní
/// a stabilní klíč pro korpus (`<sloveso>.<předmět>`).
class PetLine {
  final String text;
  final List<String> emojis;
  final String key;

  const PetLine({required this.text, required this.emojis, required this.key});

  /// Obrázková řádka (pro Mou knížku).
  String get emojiRow => emojis.join(' ');
}

/// Věta po dárku: „Myš jí jablko." / „ねこはりんごをたべます".
/// Všechno prochází [SentenceRules] — stejná pravidla jako Skládej větu:
/// - zvíře / člověk: jí (v2) / pije (v3) / hraje si (v6) podle druhu dárku;
///   předmět jen když ho sloveso bere a má pro něj výslovný tvar, jinak
///   věta bez předmětu („Myš jí.");
/// - věc s vlastním slovesem (`reward.verb`): „Oko se dívá na kolo.";
/// - jiná věc: pojmenovací věta dárku („To je jablko.");
/// - jinak nic (dárek jen zajiskří).
class PetSentence {
  static const eatVerb = 'v2';
  static const drinkVerb = 'v3';
  static const playVerb = 'v6';

  /// Druh nálepky jako podmětu: z packu (`reward.kind`), jinak z emoji.
  static String kindOf(CollectibleReward r) {
    if (r.kind.isNotEmpty) return r.kind;
    return switch (StickerKind.of(r.emoji)) {
      StickerKind.animal => 'animal',
      StickerKind.person => 'person',
      _ => 'thing',
    };
  }

  static bool eats(CollectibleReward r) => kindOf(r) != 'thing';

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
      kind: kindOf(r),
      unlockedBy: TileUnlock.sticker,
    );
  }

  /// Podměty builderu vět ze zvířátek (a lidí) Zvěřince — odemknou se
  /// nálepkou. Věci (🍌, ☀️) podmětem nejsou: nejedí, nepijí.
  static List<SentencePart> stickerSubjects(ContentPack pack) => [
        for (final u in pack.units)
          if (eats(u.reward)) subjectFor(pack, u.reward),
      ];

  static String _stop(Language lang) =>
      lang == Language.zh || lang == Language.ja ? '。' : '.';

  /// Co se po dárku řekne, nebo `null`, když k dárku věta nepatří.
  static PetLine? line(
      ContentPack pack, CollectibleReward resident, Gift gift) {
    final data = pack.sentence;
    final subject = subjectFor(pack, resident);
    final o = gift.object;

    if (eats(resident)) {
      final verbId = switch (gift.kind) {
        StickerKind.food => eatVerb,
        StickerKind.drink => drinkVerb,
        _ => playVerb,
      };
      final verb = data.verbs.where((v) => v.id == verbId).firstOrNull;
      if (verb == null || !SentenceRules.subjectFits(subject, verb)) {
        return null;
      }
      final object = o != null && SentenceRules.objectFits(verb, o) ? o : null;
      final c = ComposedSentence(
        subject: subject,
        verb: verb,
        object: object,
        joiner: data.joiner,
        verbLast: data.order == 'sov',
      );
      return PetLine(
        text: '${c.text}${_stop(pack.language)}',
        emojis: [resident.emoji, verb.emoji, if (object != null) object.emoji],
        key: '${verb.id}.${object?.id ?? '-'}',
      );
    }

    // Věc s vlastním slovesem: „Oko se dívá na kolo."
    final own = resident.verb;
    if (own != null && o != null && SentenceRules.objectFits(own, o)) {
      final c = ComposedSentence(
        subject: subject,
        verb: own,
        object: o,
        joiner: data.joiner,
        verbLast: data.order == 'sov',
      );
      return PetLine(
        text: '${c.text}${_stop(pack.language)}',
        emojis: [resident.emoji, own.emoji, o.emoji],
        key: 'verb.${o.id}',
      );
    }

    // Jinak aspoň pojmenovat dárek: „To je jablko."
    final naming = o == null ? null : SentenceRules.naming(data, o);
    if (naming == null) return null;
    return PetLine(text: naming, emojis: [o!.emoji], key: 'naming.${o.id}');
  }
}
