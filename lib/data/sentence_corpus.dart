import 'models/content_pack.dart';
import 'models/sentence.dart';
import '../pet/gift.dart';
import '../ui/sticker_kind.dart';

/// Jedna věta, kterou appka může dítěti nabídnout, se stabilním id.
class CorpusSentence {
  /// `<lang>:<zdroj>:<části>` — nemění se, i když se změní text.
  final String id;

  /// `builder` (Skládej větu + věta po novém slově), `pet` (svět
  /// zvířátka), `naming` (pojmenovací věta).
  final String source;
  final String emojis;
  final String text;

  /// Z čeho je složená (`mama|v2:3sg|o2:acc`) — pro korektora a ladění.
  final String parts;

  /// Chybějící výslovné tvary (tichý základní tvar) — prázdné = v pořádku.
  final List<String> fallbacks;

  const CorpusSentence({
    required this.id,
    required this.source,
    required this.emojis,
    required this.text,
    required this.parts,
    this.fallbacks = const [],
  });

  /// Otisk textu: změna věty vrátí řádek kontroly na „čeká".
  String get hash {
    var h = 0x811c9dc5;
    for (final c in text.codeUnits) {
      h = ((h ^ c) * 0x01000193) & 0xffffffff;
    }
    return h.toRadixString(16).padLeft(8, '0');
  }
}

/// Všechno, co appka umí říct ve větách — jeden zdroj pro testy, export
/// korektorům a strojovou korekturu (`docs/PLAN_VETY_KVALITA.md` §3.4).
/// Používá stejné skládání jako obrazovky ([ComposedSentence],
/// [PetSentence], [SentenceRules]) — žádná druhá implementace.
class SentenceCorpus {
  static List<CorpusSentence> of(ContentPack pack) {
    final lang = pack.language.name;
    final d = pack.sentence;
    final out = <CorpusSentence>[];
    final verbLast = d.order == 'sov';

    // ── Skládej větu: podměty packu + zvířátka Zvěřince ────────────────
    final subjects = [...d.subjects, ...PetSentence.stickerSubjects(pack)];
    for (final s in subjects) {
      for (final v in d.verbs) {
        for (final o in d.objects) {
          if (!SentenceRules.allows(d, subject: s, verb: v, object: o)) {
            continue;
          }
          final c = ComposedSentence(
              subject: s, verb: v, object: o, joiner: d.joiner, verbLast: verbLast);
          out.add(CorpusSentence(
            id: '$lang:b:${s.id}.${v.id}.${o.id}',
            source: 'builder',
            emojis: c.emojis,
            text: '${c.text}${_stop(pack)}',
            parts: '${s.id}|${v.id}:${s.person ?? '-'}|${o.id}:${v.frame ?? '-'}',
            fallbacks: SentenceRules.fallbacks(s, v, o),
          ));
        }
      }
    }

    // ── Svět zvířátka: nálepka jednotky + dárek ────────────────────────
    final gifts = <Gift>[
      for (final o in d.objects)
        if (StickerKind.of(o.emoji).giftable)
          Gift(id: o.id, emoji: o.emoji, object: o),
      // dárky z batohu, které builder nezná → věta bez předmětu
      const Gift(id: '-food', emoji: '🍌'),
      const Gift(id: '-drink', emoji: '💧'),
      const Gift(id: '-toy', emoji: '🧸'),
    ];
    final seen = <String>{};
    for (final u in pack.units) {
      for (final g in gifts) {
        final c = PetSentence.compose(pack, u.reward, g);
        if (c == null) continue;
        final id = '$lang:p:${u.reward.emoji}.${c.verb?.id}.'
            '${c.object?.id ?? '-'}';
        if (!seen.add(id)) continue;
        out.add(CorpusSentence(
          id: id,
          source: 'pet',
          emojis: c.emojis,
          text: PetSentence.sentenceText(c, pack.language),
          parts: 'reward:${u.reward.emoji}|${c.verb?.id}:'
              '${c.subject?.person ?? '-'}|${c.object?.id ?? '-'}:'
              '${c.object == null ? '-' : c.verb?.frame ?? '-'}',
          fallbacks: c.subject == null || c.verb == null
              ? const []
              : SentenceRules.fallbacks(c.subject!, c.verb!, c.object),
        ));
      }
    }
    return out;
  }

  static String _stop(ContentPack pack) =>
      pack.language.name == 'zh' || pack.language.name == 'ja' ? '。' : '.';
}
