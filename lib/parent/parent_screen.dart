import 'package:flutter/material.dart';

import '../audio/audio_service.dart';
import '../data/keyboard_layout.dart' show kRows;
import '../data/lessons.dart';
import '../data/models/content_pack.dart';
import '../services/achievement_service.dart';
import '../services/pack_service.dart';
import '../services/profile_service.dart';
import '../services/progress_service.dart';
import '../world/world_clock.dart';

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
        title: const Text(
          '👪 Pro rodiče',
          style: TextStyle(
            fontFamily: 'Nunito',
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
                    _Section(title: 'Přehled', child: _overview(pack)),
                    _Section(title: 'Písmena', child: _letters(pack)),
                    _Section(
                        title: 'Doporučení pro doma',
                        child: _recommendations(pack)),
                    _Section(title: 'Jak appka učí', child: _method(pack)),
                    const _Section(title: 'Nastavení', child: ParentSettings()),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _overview(ContentPack pack) {
    final p = ProgressService.instance;
    final done = pack.allLessons.where((l) => p.isCompleted(pack.id, l.id)).length;
    final profile = ProfileService.instance.active;
    final rows = [
      ('${profile?.avatar ?? '🦊'} ${profile?.name ?? ''}'.trim(), 'profil'),
      ('${p.playDays.length}', 'hracích dnů'),
      ('$done / ${pack.allLessons.length}', 'lekcí'),
      ('${p.totalStars(pack.id)}', 'hvězd'),
      ('${p.wordBag(pack.id).length}', 'slov v batohu'),
      ('${p.book(pack.id).length}', 'vět v Mé knížce'),
      ('${p.badges.length} / ${GameBadge.values.length}', 'odznaků'),
    ];
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: [
        for (final (value, label) in rows)
          Container(
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
          ),
      ],
    );
  }

  Widget _letters(ContentPack pack) {
    final status = ParentScreen.letterStatus(pack);
    final picked = _pickedLetter;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('🟢 zvládnuté · 🟡 procvičuje · ⚪ ještě nepotkalo',
            style: _labelStyle),
        const SizedBox(height: 8),
        for (final row in kRows)
          Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: Wrap(
              spacing: 6,
              children: [
                for (final ch in row)
                  GestureDetector(
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
                          fontFamily: 'Nunito',
                          fontWeight: FontWeight.w900,
                          color: Colors.white.withValues(
                              alpha: status[ch] == LetterStatus.unseen ? 0.3 : 0.95),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        if (picked != null) ...[
          const SizedBox(height: 6),
          Text(
            'Slova s $picked, která se pletou: '
            '${ParentScreen.troubleWords(pack, picked).map((l) => l.display).join(', ')}',
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
        'Zatím není co procvičovat — po pár lekcích se tu objeví tipy.'
      else
        'Nejslabší slova: ${weakest.map((l) => l.display).join(', ')}. '
            'Zkuste je doma vytleskat po slabikách a hledat, co jimi začíná.',
      for (final ch in practicing)
        'Písmeno $ch ještě sedá: hledejte spolu doma věci, které začínají na $ch.',
      'Dlouhý stisk lekce na mapě ukáže, co se v ní procvičuje a proč.',
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
          Text('Metoda: ${pack.method}', style: _bodyStyle),
          const SizedBox(height: 6),
          Text(
            'Dítě přejíždí prstem po písmenech v pořadí, jak slabiku nebo slovo '
            'slyší. Nejdřív otevřené slabiky (MA, TA), pak celá slova, poslechová '
            'kola bez textu, doplňovačky a opakování nejslabších slov. Chyba '
            'nikdy neblokuje postup — karta se jen zatřese a napoví. Naučená '
            'slova dítě hned použije ve větě (builder vět) a může si je uložit '
            'do Mé knížky.',
            style: _bodyStyle,
          ),
        ],
      );

  static BoxDecoration _box() => BoxDecoration(
        color: Colors.white.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
      );

  static const _valueStyle = TextStyle(
    fontFamily: 'Nunito',
    fontSize: 18,
    fontWeight: FontWeight.w900,
    color: Color(0xFFFFD200),
  );
  static final _labelStyle = TextStyle(
    fontFamily: 'Nunito',
    fontSize: 12,
    fontWeight: FontWeight.w700,
    color: Colors.white.withValues(alpha: 0.55),
  );
  static final _bodyStyle = TextStyle(
    fontFamily: 'Nunito',
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
            style: const TextStyle(
              fontFamily: 'Nunito',
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
              style: const TextStyle(
                  fontFamily: 'Nunito',
                  fontWeight: FontWeight.w800,
                  color: Colors.white)),
        );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        toggle('sfx-toggle', '🔊', 'Zvuky', audio.sfxEnabled,
            (v) => audio.sfxEnabled = v),
        toggle('ambient-toggle', '🌿', 'Zvuky světa', audio.ambientEnabled,
            (v) => audio.ambientEnabled = v),
        toggle('music-toggle', '🎵', 'Hudba', audio.musicEnabled,
            (v) => audio.musicEnabled = v),
        const SizedBox(height: 8),
        Text('Roční období na mapě',
            style: TextStyle(
                fontFamily: 'Nunito',
                fontWeight: FontWeight.w800,
                color: Colors.white.withValues(alpha: 0.85))),
        const SizedBox(height: 6),
        ListenableBuilder(
          listenable: clock,
          builder: (context, _) => Wrap(
            spacing: 8,
            children: [
              for (final (label, value) in [
                ('🔄 podle kalendáře', null),
                for (final s in Season.values) ('${s.emoji} ${_seasonName(s)}', s),
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
        Text('Profily',
            style: TextStyle(
                fontFamily: 'Nunito',
                fontWeight: FontWeight.w800,
                color: Colors.white.withValues(alpha: 0.85))),
        const SizedBox(height: 6),
        for (final p in ProfileService.instance.profiles)
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Text(p.avatar, style: const TextStyle(fontSize: 26)),
            title: Text(p.label,
                style: const TextStyle(
                    fontFamily: 'Nunito',
                    fontWeight: FontWeight.w800,
                    color: Colors.white)),
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

  static String _seasonName(Season s) => switch (s) {
        Season.spring => 'jaro',
        Season.summer => 'léto',
        Season.autumn => 'podzim',
        Season.winter => 'zima',
      };

  Future<void> _confirmDelete(ChildProfile p) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Smazat profil ${p.label}?'),
        content: const Text('Smaže se i celý postup, nálepky a knížka. '
            'Nejde to vrátit.'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: const Text('Zrušit')),
          TextButton(
              key: const ValueKey('confirm-delete'),
              onPressed: () => Navigator.pop(ctx, true),
              child: const Text('Smazat')),
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
