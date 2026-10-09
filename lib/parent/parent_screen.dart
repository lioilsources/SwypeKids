import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../audio/audio_service.dart';
import '../data/czech_vocative.dart';
import '../data/keyboard_layout.dart' show kRows;
import '../data/lessons.dart';
import '../data/models/content_pack.dart';
import '../services/achievement_service.dart';
import '../services/pack_service.dart';
import '../services/profile_service.dart';
import '../services/progress_service.dart';
import '../services/session_service.dart';
import '../services/settings_service.dart';
import '../world/world_clock.dart';
import '../ui/app_font.dart';
import '../ui/l10n.dart';
import '../ui/emoji_art.dart';
import 'store_debug_panel.dart';

/// Stav písmene pro mřížku abecedy (roadmap P6).
enum LetterStatus { unseen, practicing, mastered }

/// Rodičovský koutek: přehled, mřížka písmen, doporučení pro doma, metoda,
/// nastavení. Vše čte lokální postup — žádná síť, žádný tracking.
class ParentScreen extends StatefulWidget {
  final Language language;

  const ParentScreen({super.key, required this.language});

  /// Práh „zvládnuto": průměrná síla slov s písmenem ≥ 4 (z 5).
  static const masteredStrength = 4.0;

  /// Stav každého písmene klávesnice: zelená = zvládnuté, žlutá =
  /// procvičuje (potkalo, ale slabé), šedá = ještě nepotkalo.
  static Map<String, LetterStatus> letterStatus(ContentPack pack) {
    final p = ProgressService.instance;
    final sums = <String, (double, int)>{};
    for (final l in pack.allLessons) {
      if (!p.isCompleted(pack.id, l.id)) continue;
      final s = p.strengthOf(pack.id, l.target).toDouble();
      for (final ch in l.target.split('').toSet()) {
        final (sum, n) = sums[ch] ?? (0.0, 0);
        sums[ch] = (sum + s, n + 1);
      }
    }
    return {
      for (final ch in kRows.expand((r) => r))
        ch: switch (sums[ch]) {
          null => LetterStatus.unseen,
          (final sum, final n) when sum / n >= masteredStrength =>
            LetterStatus.mastered,
          _ => LetterStatus.practicing,
        },
    };
  }

  /// Slova, ve kterých se písmeno plete (nejslabší s tím písmenem).
  static List<Lesson> troubleWords(ContentPack pack, String letter) =>
      ProgressService.instance
          .weakestLearned(pack)
          .where((l) => l.target.contains(letter))
          .take(4)
          .toList();

  @override
  State<ParentScreen> createState() => _ParentScreenState();
}

class _ParentScreenState extends State<ParentScreen> {
  ContentPack? _pack;
  String? _pickedLetter;

  @override
  void initState() {
    super.initState();
    PackService.instance.load(widget.language).then((pack) {
      if (mounted) setState(() => _pack = pack);
    });
  }

  @override
  Widget build(BuildContext context) {
    final pack = _pack;
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A2E),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: const Color(0xFFA0C4FF),
        title: Text(
          '👪 ${context.l.parentTitle}',
          style: TextStyle(
            fontFamily: kFont,
            fontFamilyFallback: kFontFallback,
            fontWeight: FontWeight.w900,
            color: Color(0xFFFFD200),
          ),
        ),
      ),
      body: pack == null
          ? const Center(child: CircularProgressIndicator())
          : Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 640),
                child: ListView(
                  padding: const EdgeInsets.fromLTRB(16, 4, 16, 32),
                  children: [
                    _Section(
                        title: context.l.sectionOverview,
                        child: _overview(pack)),
                    _Section(
                        title: context.l.sectionLetters, child: _letters(pack)),
                    _Section(
                        title: context.l.sectionTips,
                        child: _recommendations(pack)),
                    _Section(
                        title: context.l.sectionMethod, child: _method(pack)),
                    _Section(
                        title: context.l.sectionSettings,
                        child: const ParentSettings()),
                    // Obchod je vypnutý (StoreConfig) — žádná záložka. Jen
                    // v debug buildu přepínač na vyzkoušení zámků.
                    if (kDebugMode)
                      _Section(
                          title: context.l.storeDebugTitle,
                          child: const StoreDebugPanel()),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _overview(ContentPack pack) {
    final p = ProgressService.instance;
    final done =
        pack.allLessons.where((l) => p.isCompleted(pack.id, l.id)).length;
    final profile = ProfileService.instance.active;
    final rows = [
      (
        '${profile?.avatar ?? '🦊'} ${profile?.name ?? ''}'.trim(),
        context.l.statProfile
      ),
      ('${SessionService.instance.playedMinToday}', context.l.statMinutesToday),
      (
        '${SessionService.instance.playedMinLastDays(7)}',
        context.l.statMinutesWeek
      ),
      ('${p.playDays.length}', context.l.statPlayDays),
      ('$done / ${pack.allLessons.length}', context.l.statLessons),
      ('${p.totalStars(pack.id)}', context.l.statStars),
      ('${p.wordBag(pack.id).length}', context.l.statWords),
      ('${p.book(pack.id).length}', context.l.statSentences),
      ('${p.badges.length} / ${GameBadge.values.length}', context.l.statBadges),
    ];
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: [
        for (final (value, label) in rows)
          Semantics(
              label: '$value $label',
              child: Container(
                width: 140,
                padding: const EdgeInsets.all(10),
                decoration: _box(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(value, style: _valueStyle),
                    Text(label, style: _labelStyle),
                  ],
                ),
              )),
      ],
    );
  }

  Widget _letters(ContentPack pack) {
    final status = ParentScreen.letterStatus(pack);
    final picked = _pickedLetter;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(context.l.lettersLegend, style: _labelStyle),
        const SizedBox(height: 8),
        for (final row in kRows)
          Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: Wrap(
              spacing: 6,
              children: [
                for (final ch in row)
                  // Čtečka obrazovky: písmeno + stav (rodičovský koutek je
                  // jediná část, kde se čtečka očekává).
                  Semantics(
                      button: status[ch] != LetterStatus.unseen,
                      label: '$ch: ${switch (status[ch]!) {
                        LetterStatus.mastered => context.l.letterMastered,
                        LetterStatus.practicing => context.l.letterPracticing,
                        LetterStatus.unseen => context.l.letterUnseen,
                      }}',
                      child: GestureDetector(
                        key: ValueKey('letter-$ch'),
                        onTap: status[ch] == LetterStatus.unseen
                            ? null
                            : () => setState(
                                () => _pickedLetter = picked == ch ? null : ch),
                        child: Container(
                          width: 34,
                          height: 38,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: switch (status[ch]!) {
                              LetterStatus.mastered =>
                                const Color(0xFF1DD1A1).withValues(alpha: 0.35),
                              LetterStatus.practicing =>
                                const Color(0xFFFFD200).withValues(alpha: 0.3),
                              LetterStatus.unseen =>
                                Colors.white.withValues(alpha: 0.05),
                            },
                            borderRadius: BorderRadius.circular(9),
                            border: Border.all(
                              color: picked == ch
                                  ? Colors.white
                                  : Colors.white.withValues(alpha: 0.1),
                            ),
                          ),
                          child: Text(
                            ch,
                            style: TextStyle(
                              fontFamily: kFont,
                              fontFamilyFallback: kFontFallback,
                              fontWeight: FontWeight.w900,
                              color: Colors.white.withValues(
                                  alpha: status[ch] == LetterStatus.unseen
                                      ? 0.3
                                      : 0.95),
                            ),
                          ),
                        ),
                      )),
              ],
            ),
          ),
        if (picked != null) ...[
          const SizedBox(height: 6),
          Text(
            context.l.troubleWords(
                picked,
                ParentScreen.troubleWords(pack, picked)
                    .map((l) => l.display)
                    .join(', ')),
            key: const ValueKey('trouble-words'),
            style: _bodyStyle,
          ),
        ],
      ],
    );
  }

  Widget _recommendations(ContentPack pack) {
    final weakest = ProgressService.instance.weakestLearned(pack, limit: 3);
    final status = ParentScreen.letterStatus(pack);
    final practicing = status.entries
        .where((e) => e.value == LetterStatus.practicing)
        .map((e) => e.key)
        .take(2)
        .toList();
    final tips = <String>[
      if (weakest.isEmpty)
        context.l.tipNoData
      else
        context.l.tipWeakest(weakest.map((l) => l.display).join(', ')),
      for (final ch in practicing) context.l.tipLetter(ch),
      context.l.tipLongPress,
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final t in tips)
          Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: Text('• $t', style: _bodyStyle),
          ),
      ],
    );
  }

  Widget _method(ContentPack pack) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(context.l.methodLabel(pack.method), style: _bodyStyle),
          const SizedBox(height: 6),
          Text(context.l.methodText, style: _bodyStyle),
        ],
      );

  static BoxDecoration _box() => BoxDecoration(
        color: Colors.white.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
      );

  static TextStyle get _valueStyle => TextStyle(
    fontFamily: kFont,
    fontFamilyFallback: kFontFallback,
    fontSize: 18,
    fontWeight: FontWeight.w900,
    color: Color(0xFFFFD200),
  );
  static TextStyle get _labelStyle => TextStyle(
    fontFamily: kFont,
    fontFamilyFallback: kFontFallback,
    fontSize: 12,
    fontWeight: FontWeight.w700,
    color: Colors.white.withValues(alpha: 0.55),
  );
  static TextStyle get _bodyStyle => TextStyle(
    fontFamily: kFont,
    fontFamilyFallback: kFontFallback,
    fontSize: 14,
    fontWeight: FontWeight.w700,
    height: 1.4,
    color: Colors.white.withValues(alpha: 0.85),
  );
}

class _Section extends StatelessWidget {
  final String title;
  final Widget child;
  const _Section({required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontFamily: kFont,
              fontFamilyFallback: kFontFallback,
              fontSize: 16,
              fontWeight: FontWeight.w900,
              color: Color(0xFFA0C4FF),
            ),
          ),
          const SizedBox(height: 8),
          child,
        ],
      ),
    );
  }
}

/// Nastavení rodiče: zvuk, hudba, zvuky světa, roční období, profily.
/// (Z menu dítěte se přesunulo sem — roadmap v3.1.)
class ParentSettings extends StatefulWidget {
  const ParentSettings({super.key});

  @override
  State<ParentSettings> createState() => _ParentSettingsState();
}

class _ParentSettingsState extends State<ParentSettings> {
  @override
  Widget build(BuildContext context) {
    final audio = AudioService.instance;
    final clock = WorldClockService.instance;
    Widget toggle(String key, String emoji, String label, bool value,
            ValueChanged<bool> onChanged) =>
        SwitchListTile(
          key: ValueKey(key),
          value: value,
          onChanged: (v) => setState(() => onChanged(v)),
          activeThumbColor: const Color(0xFFFFD200),
          contentPadding: EdgeInsets.zero,
          title: Text('$emoji  $label',
              style: TextStyle(
                  fontFamily: kFont,
                  fontFamilyFallback: kFontFallback,
                  fontWeight: FontWeight.w800,
                  color: Colors.white)),
        );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        toggle('sfx-toggle', '🔊', context.l.settingSounds, audio.sfxEnabled,
            (v) => audio.sfxEnabled = v),
        toggle('ambient-toggle', '🌿', context.l.settingAmbient,
            audio.ambientEnabled, (v) => audio.ambientEnabled = v),
        toggle('music-toggle', '🎵', context.l.settingMusic, audio.musicEnabled,
            (v) => audio.musicEnabled = v),
        toggle(
            'left-handed-toggle',
            '🫲',
            context.l.settingLeftHanded,
            SettingsService.instance.leftHanded,
            (v) => SettingsService.instance.leftHanded = v),
        toggle(
            'pet-rounds-toggle',
            '✏️',
            context.l.settingPetRounds,
            SettingsService.instance.petRounds,
            (v) => SettingsService.instance.petRounds = v),
        toggle(
            'dyslexia-font-toggle',
            '🔤',
            context.l.settingDyslexiaFont,
            SettingsService.instance.dyslexiaFont,
            (v) => SettingsService.instance.dyslexiaFont = v),
        const SizedBox(height: 8),
        Text(context.l.settingTimeLimit,
            style: TextStyle(
                fontFamily: kFont,
                fontFamilyFallback: kFontFallback,
                fontWeight: FontWeight.w800,
                color: Colors.white.withValues(alpha: 0.85))),
        const SizedBox(height: 6),
        ListenableBuilder(
          listenable: Listenable.merge(
              [SettingsService.instance, SessionService.instance]),
          builder: (context, _) {
            final settings = SettingsService.instance;
            final session = SessionService.instance;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  spacing: 8,
                  children: [
                    for (final m in SettingsService.sessionLimits)
                      ChoiceChip(
                        key: ValueKey('limit-$m'),
                        label: Text(
                            m == 0 ? context.l.noLimit : context.l.minutes(m)),
                        selected: settings.sessionLimitMin == m,
                        onSelected: (_) => settings.sessionLimitMin = m,
                      ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  (session.limitMinToday > 0
                          ? context.l.playedTodayOf(
                              session.playedMinToday, session.limitMinToday)
                          : context.l.playedToday(session.playedMinToday)) +
                      (session.limitReached ? context.l.guideAsleep : ''),
                  key: const ValueKey('session-today'),
                  style: TextStyle(
                      fontFamily: kFont,
                      fontFamilyFallback: kFontFallback,
                      fontWeight: FontWeight.w700,
                      color: Colors.white.withValues(alpha: 0.7)),
                ),
                if (settings.sessionLimitMin > 0)
                  TextButton(
                    key: const ValueKey('extend-today'),
                    onPressed: session.extendToday,
                    child: Text(
                        context.l.extendToday(SessionService.extendMinutes)),
                  ),
              ],
            );
          },
        ),
        const SizedBox(height: 8),
        Text(context.l.settingSeason,
            style: TextStyle(
                fontFamily: kFont,
                fontFamilyFallback: kFontFallback,
                fontWeight: FontWeight.w800,
                color: Colors.white.withValues(alpha: 0.85))),
        const SizedBox(height: 6),
        ListenableBuilder(
          listenable: clock,
          builder: (context, _) => Wrap(
            spacing: 8,
            children: [
              for (final (label, value) in [
                ('🔄 ${context.l.seasonAuto}', null),
                for (final s in Season.values)
                  ('${s.emoji} ${s.label(context.l)}', s),
              ])
                ChoiceChip(
                  key: ValueKey('season-${value?.name ?? 'auto'}'),
                  label: Text(label),
                  selected: clock.seasonOverride == value,
                  onSelected: (_) => clock.seasonOverride = value,
                ),
            ],
          ),
        ),
        const SizedBox(height: 14),
        Text(context.l.profilesTitle,
            style: TextStyle(
                fontFamily: kFont,
                fontFamilyFallback: kFontFallback,
                fontWeight: FontWeight.w800,
                color: Colors.white.withValues(alpha: 0.85))),
        const SizedBox(height: 6),
        for (final p in ProfileService.instance.profiles)
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: EmojiArt(p.avatar, size: 26, animate: false),
            title: Text(p.label,
                style: TextStyle(
                    fontFamily: kFont,
                    fontFamilyFallback: kFontFallback,
                    fontWeight: FontWeight.w800,
                    color: Colors.white)),
            // Jak průvodce dítě česky osloví (5. pád) — předvyplněno podle
            // pravidel, rodič může opravit (Ester, Dagmar…).
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (p.name.trim().isNotEmpty)
                  TextFormField(
                    key: ValueKey('vocative-${p.id}'),
                    initialValue: p.addressIn(Language.cs),
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: context.l.vocativeLabel,
                      hintText: context.l.vocativeHint,
                      isDense: true,
                    ),
                    onChanged: (v) => ProfileService.instance.setCalled(
                        p.id, v.trim() == czechVocative(p.name) ? '' : v),
                  ),
                // Jazyk rodiny: menu a nápověda v řeči, které doma rozumějí
                // (dítě se učí číst česky, rodina mluví ukrajinsky).
                DropdownButtonFormField<String>(
                  key: ValueKey('home-${p.id}'),
                  initialValue: kHomeLanguages.contains(p.home) ? p.home : '',
                  isExpanded: true,
                  dropdownColor: const Color(0xFF1A1A2E),
                  style: TextStyle(
                      fontFamily: kFont,
                      fontFamilyFallback: kFontFallback,
                      color: Colors.white),
                  decoration: InputDecoration(
                    labelText: context.l.homeLanguageLabel,
                    isDense: true,
                  ),
                  items: [
                    DropdownMenuItem(
                        value: '', child: Text(context.l.homeLanguageSame)),
                    for (final code in kHomeLanguages)
                      DropdownMenuItem(
                        value: code,
                        child: Text(
                            '${homeLanguageFlag(code)} ${homeLanguageName(code)}'),
                      ),
                  ],
                  onChanged: (v) {
                    ProfileService.instance.setHome(p.id, v ?? '');
                    setState(() {});
                  },
                ),
              ],
            ),
            trailing: ProfileService.instance.profiles.length > 1
                ? IconButton(
                    key: ValueKey('delete-profile-${p.id}'),
                    icon: const Icon(Icons.delete_outline,
                        color: Color(0xFFFF6B6B)),
                    onPressed: () => _confirmDelete(p),
                  )
                : null,
          ),
      ],
    );
  }

  Future<void> _confirmDelete(ChildProfile p) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(context.l.deleteProfileTitle(p.label)),
        content: Text(context.l.deleteProfileBody),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: Text(context.l.cancel)),
          TextButton(
              key: const ValueKey('confirm-delete'),
              onPressed: () => Navigator.pop(ctx, true),
              child: Text(context.l.delete)),
        ],
      ),
    );
    if (ok != true) return;
    final wasActive = ProfileService.instance.activeId == p.id;
    await ProgressService.wipeProfile(p.id);
    ProfileService.instance.remove(p.id);
    if (wasActive) {
      await ProgressService.init(profile: ProfileService.instance.activeId);
    }
    if (mounted) setState(() {});
  }
}
