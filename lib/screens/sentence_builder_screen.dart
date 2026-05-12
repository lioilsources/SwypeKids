import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../data/lessons.dart';
import '../data/sentence_builder.dart';
import '../services/tts_service.dart';
import '../widgets/language_picker.dart';

class SentenceBuilderScreen extends StatefulWidget {
  final Language language;
  final ValueChanged<Language> onLanguageChanged;

  const SentenceBuilderScreen({
    super.key,
    required this.language,
    required this.onLanguageChanged,
  });

  @override
  State<SentenceBuilderScreen> createState() => _SentenceBuilderScreenState();
}

class _SentenceBuilderScreenState extends State<SentenceBuilderScreen> {
  SentencePart? _subject;
  SentencePart? _verb;
  SentencePart? _object;

  SentenceCategories get _data => kSentenceData[widget.language]!;

  @override
  void didUpdateWidget(covariant SentenceBuilderScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.language != widget.language) {
      setState(() {
        _subject = null;
        _verb = null;
        _object = null;
      });
    }
  }

  String _composeSentence() {
    final parts = <String>[
      if (_subject != null) _subject!.text,
      if (_verb != null) _verb!.text,
      if (_object != null) _object!.text,
    ];
    return parts.join(_data.joiner);
  }

  bool get _hasAny => _subject != null || _verb != null || _object != null;

  Future<void> _speak() async {
    final s = _composeSentence();
    if (s.isEmpty) return;
    HapticFeedback.mediumImpact();
    await TtsService.speak(s, widget.language);
  }

  void _clear() {
    setState(() {
      _subject = null;
      _verb = null;
      _object = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF1A1A2E),
            Color(0xFF16213E),
            Color(0xFF0F3460),
          ],
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            // ── Top bar ──────────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 8, vertical: 4),
              child: Row(
                children: [
                  Builder(
                    builder: (ctx) => IconButton(
                      icon: const Icon(Icons.menu,
                          color: Color(0xFFA0C4FF), size: 22),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      onPressed: () => Scaffold.of(ctx).openDrawer(),
                    ),
                  ),
                  const SizedBox(width: 8),
                  _badge('🗣️ VĚTA'),
                  const Spacer(),
                  LanguagePicker(
                    value: widget.language,
                    onChanged: widget.onLanguageChanged,
                  ),
                ],
              ),
            ),

            // ── Sentence preview + trumpet ───────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 4, 12, 8),
              child: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 14, vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.white.withOpacity(0.13)),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Wrap(
                        spacing: 8,
                        runSpacing: 4,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          _previewSlot(_subject, '👤'),
                          _previewSlot(_verb, '🎯'),
                          _previewSlot(_object, '🎁'),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    if (_hasAny)
                      IconButton(
                        icon: const Icon(Icons.backspace_outlined,
                            color: Color(0xFFA0C4FF), size: 20),
                        onPressed: _clear,
                        tooltip: 'Smazat',
                      ),
                    _TrumpetButton(
                      enabled: _hasAny,
                      onTap: _speak,
                    ),
                  ],
                ),
              ),
            ),

            // ── Tři řady kategorií ───────────────────────────────────
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                children: [
                  _CategoryRow(
                    label: 'KDO',
                    items: _data.subjects,
                    selected: _subject,
                    accent: const Color(0xFFFFD200),
                    onPick: (p) => setState(() => _subject = p),
                  ),
                  _CategoryRow(
                    label: 'CO DĚLÁ',
                    items: _data.verbs,
                    selected: _verb,
                    accent: const Color(0xFF7BFFB2),
                    onPick: (p) => setState(() => _verb = p),
                  ),
                  _CategoryRow(
                    label: 'CO / KAM',
                    items: _data.objects,
                    selected: _object,
                    accent: const Color(0xFFA0C4FF),
                    onPick: (p) => setState(() => _object = p),
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _previewSlot(SentencePart? part, String placeholder) {
    if (part == null) {
      return Opacity(
        opacity: 0.35,
        child: Text(placeholder,
            style: const TextStyle(fontSize: 28)),
      );
    }
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(part.emoji, style: const TextStyle(fontSize: 26)),
        const SizedBox(width: 4),
        Text(
          part.text,
          style: const TextStyle(
            fontFamily: 'Nunito',
            fontSize: 20,
            fontWeight: FontWeight.w900,
            color: Color(0xFFFFD200),
          ),
        ),
      ],
    );
  }

  Widget _badge(String text) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.08),
          borderRadius: BorderRadius.circular(99),
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontFamily: 'Nunito',
            fontSize: 11,
            fontWeight: FontWeight.w800,
            color: Color(0xFFA0C4FF),
            letterSpacing: 0.5,
          ),
        ),
      );
}

class _CategoryRow extends StatelessWidget {
  final String label;
  final List<SentencePart> items;
  final SentencePart? selected;
  final Color accent;
  final ValueChanged<SentencePart> onPick;

  const _CategoryRow({
    required this.label,
    required this.items,
    required this.selected,
    required this.accent,
    required this.onPick,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8, bottom: 4),
            child: Text(
              label,
              style: TextStyle(
                fontFamily: 'Nunito',
                fontSize: 11,
                fontWeight: FontWeight.w900,
                color: accent,
                letterSpacing: 1.2,
              ),
            ),
          ),
          SizedBox(
            height: 84,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 4),
              itemCount: items.length,
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemBuilder: (_, i) {
                final p = items[i];
                final isSelected = identical(p, selected);
                return _PartTile(
                  part: p,
                  isSelected: isSelected,
                  accent: accent,
                  onTap: () => onPick(p),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _PartTile extends StatelessWidget {
  final SentencePart part;
  final bool isSelected;
  final Color accent;
  final VoidCallback onTap;

  const _PartTile({
    required this.part,
    required this.isSelected,
    required this.accent,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        width: 86,
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected
              ? accent.withOpacity(0.22)
              : Colors.white.withOpacity(0.06),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? accent : Colors.white.withOpacity(0.1),
            width: isSelected ? 2 : 1,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: accent.withOpacity(0.4),
                    blurRadius: 12,
                    spreadRadius: 1,
                  ),
                ]
              : null,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(part.emoji, style: const TextStyle(fontSize: 28)),
            const SizedBox(height: 2),
            Text(
              part.text,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Nunito',
                fontSize: 12,
                fontWeight: FontWeight.w800,
                color: isSelected ? accent : Colors.white.withOpacity(0.85),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TrumpetButton extends StatelessWidget {
  final bool enabled;
  final VoidCallback onTap;
  const _TrumpetButton({required this.enabled, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: enabled ? onTap : null,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        width: 56,
        height: 56,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: enabled
              ? const LinearGradient(
                  colors: [Color(0xFFFFD200), Color(0xFFFF8A00)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )
              : null,
          color: enabled ? null : Colors.white.withOpacity(0.05),
          boxShadow: enabled
              ? [
                  BoxShadow(
                    color: const Color(0xFFFFD200).withOpacity(0.6),
                    blurRadius: 18,
                    spreadRadius: 1,
                  ),
                ]
              : null,
        ),
        child: Center(
          child: Text(
            '🎺',
            style: TextStyle(
              fontSize: 28,
              color: enabled ? null : Colors.white.withOpacity(0.3),
            ),
          ),
        ),
      ),
    );
  }
}
