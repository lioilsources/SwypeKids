import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../audio/audio_service.dart';
import '../data/lessons.dart';
import '../data/models/content_pack.dart';
import '../data/models/sentence.dart';
import '../services/pack_service.dart';
import '../services/progress_service.dart';
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
  ContentPack? _pack;

  SentenceCategories get _data => _pack?.sentence ?? SentenceCategories.empty;

  @override
  void initState() {
    super.initState();
    _loadPack();
  }

  @override
  void didUpdateWidget(covariant SentenceBuilderScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.language != widget.language) {
      setState(() {
        _subject = null;
        _verb = null;
        _object = null;
        _pack = null;
      });
      _loadPack();
    }
  }

  Future<void> _loadPack() async {
    final pack = await PackService.instance.load(widget.language);
    if (mounted && pack.language == widget.language) {
      setState(() => _pack = pack);
    }
  }

  /// Dlaždice je k dispozici: základní, nebo už je slovo v batohu.
  bool _isUnlocked(SentencePart p) =>
      p.unlockedBy == TileUnlock.always ||
      (_pack != null && ProgressService.instance.hasWord(_pack!.id, p.id));

  bool _isNew(SentencePart p) =>
      p.unlockedBy == TileUnlock.vocab &&
      _pack != null &&
      ProgressService.instance.isNewWord(_pack!.id, p.id);

  void _pick(SentencePart p, void Function() select) {
    if (!_isUnlocked(p)) {
      // Siluetka: slovo se teprve naučí ve hře.
      HapticFeedback.selectionClick();
      return;
    }
    AudioService.instance.play(Sfx.tap);
    setState(select);
  }

  String _composeSentence() {
    final subj = _subject;
    final verb = _verb;
    final obj = _object;

    // Verb agrees with subject person (defaults to 1sg = base text).
    String? verbText = verb?.text;
    if (verb != null && subj?.person != null) {
      verbText = verb.formFor(subj!.person!);
    }

    // Object form is chosen by the verb's frame (acc / dir / loc / instr).
    String? objText = obj?.text;
    if (obj != null && verb?.frame != null) {
      objText = obj.formFor(verb!.frame!);
    }

    final parts = <String>[
      if (subj != null) subj.text,
      if (verbText != null) verbText,
      if (objText != null) objText,
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
                          _previewSlot(_verb, '🎯',
                              resolvedText: _subject?.person != null
                                  ? _verb?.formFor(_subject!.person!)
                                  : null),
                          _previewSlot(_object, '🎁',
                              resolvedText: _verb?.frame != null
                                  ? _object?.formFor(_verb!.frame!)
                                  : null),
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

            // ── Tři sloupce kategorií ────────────────────────────────
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: _CategoryColumn(
                      label: 'KDO',
                      items: _data.subjects,
                      selected: _subject,
                      accent: const Color(0xFFFFD200),
                      isUnlocked: _isUnlocked,
                      isNew: _isNew,
                      onPick: (p) => _pick(p, () => _subject = p),
                    )),
                    const SizedBox(width: 8),
                    Expanded(child: _CategoryColumn(
                      label: 'CO DĚLÁ',
                      items: _data.verbs,
                      selected: _verb,
                      accent: const Color(0xFF7BFFB2),
                      contextKey: _subject?.person,
                      isUnlocked: _isUnlocked,
                      isNew: _isNew,
                      onPick: (p) => _pick(p, () => _verb = p),
                    )),
                    const SizedBox(width: 8),
                    Expanded(child: _CategoryColumn(
                      label: 'CO / KAM',
                      items: _data.objects,
                      selected: _object,
                      accent: const Color(0xFFA0C4FF),
                      contextKey: _verb?.frame,
                      isUnlocked: _isUnlocked,
                      isNew: _isNew,
                      onPick: (p) => _pick(p, () => _object = p),
                    )),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _previewSlot(SentencePart? part, String placeholder,
      {String? resolvedText}) {
    if (part == null) {
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
          resolvedText ?? part.text,
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

class _CategoryColumn extends StatelessWidget {
  final String label;
  final List<SentencePart> items;
  final SentencePart? selected;
  final Color accent;
  final String? contextKey;
  final bool Function(SentencePart) isUnlocked;
  final bool Function(SentencePart) isNew;
  final ValueChanged<SentencePart> onPick;

  const _CategoryColumn({
    required this.label,
    required this.items,
    required this.selected,
    required this.accent,
    required this.isUnlocked,
    required this.isNew,
    required this.onPick,
    this.contextKey,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 6),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Nunito',
              fontSize: 11,
              fontWeight: FontWeight.w900,
              color: accent,
              letterSpacing: 1.2,
            ),
          ),
        ),
        Expanded(
          child: ListView.separated(
            itemCount: items.length,
            separatorBuilder: (_, __) => const SizedBox(height: 8),
            itemBuilder: (_, i) {
              final p = items[i];
              return _PartTile(
                part: p,
                isSelected: identical(p, selected),
                locked: !isUnlocked(p),
                isNew: isNew(p),
                accent: accent,
                contextKey: contextKey,
                onTap: () => onPick(p),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _PartTile extends StatelessWidget {
  final SentencePart part;
  final bool isSelected;
  final bool locked; // slovo ještě není v batohu → siluetka „?"
  final bool isNew; // slovo přibylo do batohu za posledních 24 h
  final Color accent;
  final String? contextKey;
  final VoidCallback onTap;

  const _PartTile({
    required this.part,
    required this.isSelected,
    required this.accent,
    required this.onTap,
    this.locked = false,
    this.isNew = false,
    this.contextKey,
  });

  @override
  Widget build(BuildContext context) {
    if (locked) return _buildLocked();
    final tile = _buildTile();
    if (!isNew) return tile;
    return Stack(
      clipBehavior: Clip.none,
      children: [
        tile,
        const Positioned(top: -6, right: -4, child: _NewBadge()),
      ],
    );
  }

  Widget _buildLocked() {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.03),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.white.withOpacity(0.08)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Tmavá siluetka emoji — dítě tuší, co ho ve hře čeká.
            ColorFiltered(
              colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.55), BlendMode.srcIn),
              child: Text(part.emoji, style: const TextStyle(fontSize: 28)),
            ),
            const SizedBox(height: 2),
            Text(
              '?',
              style: TextStyle(
                fontFamily: 'Nunito',
                fontSize: 12,
                fontWeight: FontWeight.w900,
                color: Colors.white.withOpacity(0.35),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTile() {
    final displayText =
        contextKey != null ? part.formFor(contextKey!) : part.text;
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
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
              displayText,
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

/// Štítek „NOVÉ" s jemným poskakováním (slovo čerstvě z batohu).
class _NewBadge extends StatefulWidget {
  const _NewBadge();

  @override
  State<_NewBadge> createState() => _NewBadgeState();
}

class _NewBadgeState extends State<_NewBadge>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 900),
  );

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (MediaQuery.of(context).disableAnimations) {
      _ctrl.stop();
    } else if (!_ctrl.isAnimating) {
      _ctrl.repeat(reverse: true);
    }
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _ctrl,
      builder: (context, child) => Transform.translate(
        offset: Offset(0, -3 * Curves.easeInOut.transform(_ctrl.value)),
        child: child,
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
        decoration: BoxDecoration(
          color: const Color(0xFF1DD1A1),
          borderRadius: BorderRadius.circular(99),
        ),
        child: const Text(
          'NOVÉ',
          style: TextStyle(
            fontFamily: 'Nunito',
            fontSize: 9,
            fontWeight: FontWeight.w900,
            color: Colors.white,
            letterSpacing: 0.5,
          ),
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
