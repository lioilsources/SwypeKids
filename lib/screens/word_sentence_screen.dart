import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../audio/audio_service.dart';
import '../data/models/content_pack.dart';
import '../data/models/sentence.dart';
import '../services/progress_service.dart';
import '../services/tts_service.dart';

/// Kolo „slovo do věty" (roadmap P5, wordToSentence): hned po naučení slova
/// ve hře se otevře malý builder s tím slovem předvyplněným. Dítě doplní
/// zbytek, trumpeta větu přečte. Vždy se dá přeskočit — nikdy neblokuje.
///
/// Vrací složenou větu, nebo null při přeskočení.
class WordSentenceScreen extends StatefulWidget {
  final ContentPack pack;
  final SentencePart word;

  const WordSentenceScreen({super.key, required this.pack, required this.word});

  /// Dlaždice builderu pro slovo z batohu, nebo null (slovo ve větách není).
  static SentencePart? tileFor(ContentPack pack, String vocab) {
    if (vocab.isEmpty) return null;
    for (final t in pack.sentence.all) {
      if (t.id == vocab && t.unlockedBy == TileUnlock.vocab) return t;
    }
    return null;
  }

  /// Kolik možností nabídnout v každé doplňované kategorii.
  static const choicesPerSlot = 4;

  @override
  State<WordSentenceScreen> createState() => _WordSentenceScreenState();
}

enum _Slot { subject, verb, object }

class _WordSentenceScreenState extends State<WordSentenceScreen> {
  late final SentenceCategories _data = widget.pack.sentence;
  late final _Slot _fixed = _data.subjects.contains(widget.word)
      ? _Slot.subject
      : _data.verbs.contains(widget.word)
          ? _Slot.verb
          : _Slot.object;
  late final Map<_Slot, SentencePart?> _picked = {
    for (final s in _Slot.values) s: s == _fixed ? widget.word : null,
  };
  bool _spoken = false;

  ComposedSentence get _sentence => ComposedSentence(
        subject: _picked[_Slot.subject],
        verb: _picked[_Slot.verb],
        object: _picked[_Slot.object],
        joiner: _data.joiner,
      );

  List<SentencePart> _category(_Slot slot) => switch (slot) {
        _Slot.subject => _data.subjects,
        _Slot.verb => _data.verbs,
        _Slot.object => _data.objects,
      };

  /// Nabídka pro doplnění: jen dostupné dlaždice, slova z batohu první.
  List<SentencePart> _choices(_Slot slot) {
    final progress = ProgressService.instance;
    final available = [
      for (final t in _category(slot))
        if (t.id != widget.word.id &&
            (t.unlockedBy == TileUnlock.always ||
                progress.hasWord(widget.pack.id, t.id)))
          t,
    ];
    final fromBag = available.where((t) => t.unlockedBy == TileUnlock.vocab);
    final basic = available.where((t) => t.unlockedBy == TileUnlock.always);
    return [...fromBag, ...basic].take(WordSentenceScreen.choicesPerSlot).toList();
  }

  void _pick(_Slot slot, SentencePart part) {
    AudioService.instance.play(Sfx.tap);
    setState(() {
      _picked[slot] = part;
      _spoken = false;
    });
  }

  Future<void> _speak() async {
    if (!_sentence.isComplete) return;
    HapticFeedback.mediumImpact();
    AudioService.instance.play(Sfx.success);
    setState(() => _spoken = true);
    await TtsService.speak(_sentence.text, widget.pack.language);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF1A1A2E), Color(0xFF0F3460), Color(0xFF1B6B5A)],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // ── Přeskočit (vždy) ──────────────────────────────────────
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  key: const ValueKey('skip'),
                  icon: const Icon(Icons.close_rounded,
                      color: Color(0xFFA0C4FF), size: 26),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
              Text('🎒 ${widget.word.emoji}',
                  style: const TextStyle(fontSize: 40)),
              const SizedBox(height: 8),

              // ── Náhled věty + trumpeta ────────────────────────────────
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                        color: Colors.white.withValues(alpha: 0.13)),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Wrap(
                          spacing: 10,
                          runSpacing: 4,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            _preview(_Slot.subject, _sentence.subjectText, '👤'),
                            _preview(_Slot.verb, _sentence.verbText, '🎯'),
                            _preview(_Slot.object, _sentence.objectText, '🎁'),
                          ],
                        ),
                      ),
                      _RoundButton(
                        key: const ValueKey('trumpet'),
                        emoji: '🎺',
                        enabled: _sentence.isComplete,
                        onTap: _speak,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),

              // ── Nabídka pro chybějící části ───────────────────────────
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  children: [
                    for (final slot in _Slot.values)
                      if (slot != _fixed) _choiceRow(slot),
                  ],
                ),
              ),

              // ── Hotovo → zpět do hry ──────────────────────────────────
              AnimatedOpacity(
                duration: const Duration(milliseconds: 250),
                opacity: _spoken ? 1 : 0,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: _RoundButton(
                    key: const ValueKey('done'),
                    emoji: '➡️',
                    enabled: _spoken,
                    onTap: () {
                      // Složená věta se uloží do Mé knížky.
                      ProgressService.instance.addToBook(
                          widget.pack.id, _sentence.text, _sentence.emojis);
                      Navigator.of(context).pop(_sentence.text);
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _preview(_Slot slot, String? text, String placeholder) {
    final part = _picked[slot];
    if (part == null || text == null) {
      return Opacity(
        opacity: 0.35,
        child: Text(placeholder, style: const TextStyle(fontSize: 28)),
      );
    }
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(part.emoji, style: const TextStyle(fontSize: 26)),
        const SizedBox(width: 4),
        Text(
          text,
          style: TextStyle(
            fontFamily: 'Nunito',
            fontSize: 20,
            fontWeight: FontWeight.w900,
            color: slot == _fixed
                ? const Color(0xFF7BFFB2)
                : const Color(0xFFFFD200),
          ),
        ),
      ],
    );
  }

  Widget _choiceRow(_Slot slot) {
    final choices = _choices(slot);
    // Tvar podle kontextu: sloveso podle podmětu, předmět podle slovesa.
    String label(SentencePart p) => switch (slot) {
          _Slot.verb => ComposedSentence(subject: _picked[_Slot.subject], verb: p)
              .verbText!,
          _Slot.object => ComposedSentence(verb: _picked[_Slot.verb], object: p)
              .objectText!,
          _Slot.subject => p.text,
        };
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          for (final p in choices)
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: _ChoiceTile(
                  emoji: p.emoji,
                  text: label(p),
                  selected: identical(_picked[slot], p),
                  onTap: () => _pick(slot, p),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _ChoiceTile extends StatelessWidget {
  final String emoji;
  final String text;
  final bool selected;
  final VoidCallback onTap;

  const _ChoiceTile({
    required this.emoji,
    required this.text,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    const accent = Color(0xFFFFD200);
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 10),
        decoration: BoxDecoration(
          color: selected
              ? accent.withValues(alpha: 0.22)
              : Colors.white.withValues(alpha: 0.06),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: selected ? accent : Colors.white.withValues(alpha: 0.1),
            width: selected ? 2 : 1,
          ),
        ),
        child: Column(
          children: [
            Text(emoji, style: const TextStyle(fontSize: 30)),
            const SizedBox(height: 2),
            Text(
              text,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontFamily: 'Nunito',
                fontSize: 13,
                fontWeight: FontWeight.w800,
                color: selected ? accent : Colors.white.withValues(alpha: 0.85),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RoundButton extends StatelessWidget {
  final String emoji;
  final bool enabled;
  final VoidCallback onTap;

  const _RoundButton({
    super.key,
    required this.emoji,
    required this.enabled,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: enabled ? onTap : null,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: enabled
              ? const LinearGradient(
                  colors: [Color(0xFFFFD200), Color(0xFFFF8A00)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )
              : null,
          color: enabled ? null : Colors.white.withValues(alpha: 0.05),
        ),
        alignment: Alignment.center,
        child: Opacity(
          opacity: enabled ? 1 : 0.3,
          child: Text(emoji, style: const TextStyle(fontSize: 28)),
        ),
      ),
    );
  }
}
