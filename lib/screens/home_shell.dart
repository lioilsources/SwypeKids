import 'package:flutter/material.dart';
import '../audio/audio_service.dart';
import '../data/lessons.dart';
import '../services/profile_service.dart';
import '../services/progress_service.dart';
import '../widgets/language_picker.dart';
import '../world/world_clock.dart';
import 'book_screen.dart';
import 'collection_screen.dart';
import 'lesson_map_screen.dart';
import 'onboarding_screen.dart';
import 'sentence_builder_screen.dart';

enum AppView { swype, sentence, collection, book }

class HomeShell extends StatefulWidget {
  final Language initialLanguage;
  const HomeShell({super.key, required this.initialLanguage});

  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> with WidgetsBindingObserver {
  late Language _lang = widget.initialLanguage;
  AppView _view = AppView.swype;
  final _mapKey = GlobalKey<LessonMapScreenState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  /// Ambient hraje jen na mapě a jen když je appka v popředí.
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    _mapKey.currentState?.setAmbientActive(
        state == AppLifecycleState.resumed && _view == AppView.swype);
  }

  void _setLang(Language l) {
    ProgressService.instance.selectedLanguage = l;
    setState(() => _lang = l);
  }

  /// Přepnutí sourozence: načte jeho postup a znovu postaví obrazovky.
  Future<void> _switchProfile(int id) async {
    ProfileService.instance.switchTo(id);
    await ProgressService.init(profile: id);
    if (!mounted) return;
    setState(() {
      _lang = ProgressService.instance.selectedLanguage ?? _lang;
      _view = AppView.swype;
    });
    Navigator.of(context).maybePop();
  }

  /// Nový sourozenec: stejný onboarding jako při prvním startu.
  Future<void> _addProfile() async {
    Navigator.of(context).maybePop();
    await Navigator.of(context).push(MaterialPageRoute(
      builder: (ctx) => OnboardingScreen(
        initialLanguage: _lang,
        onDone: (lang) => Navigator.of(ctx).pop(lang),
      ),
    ));
    if (!mounted) return;
    setState(() {
      _lang = ProgressService.instance.selectedLanguage ?? _lang;
      _view = AppView.swype;
    });
  }

  void _openProfiles() {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: const Color(0xFF1A1A2E),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => _ProfileSheet(
        onPick: _switchProfile,
        onAdd: _addProfile,
      ),
    );
  }

  void _setView(AppView v) {
    AudioService.instance.play(Sfx.tap);
    setState(() => _view = v);
    _mapKey.currentState?.setAmbientActive(v == AppView.swype);
    Navigator.of(context).maybePop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: _AppDrawer(
        currentView: _view,
        onPick: _setView,
        language: _lang,
        onProfileTap: _openProfiles,
      ),
      body: IndexedStack(
        // Jiný profil = jiný postup → obrazovky znovu od začátku.
        key: ValueKey('profile-${ProfileService.instance.activeId}'),
        index: _view.index,
        children: [
          LessonMapScreen(
            key: _mapKey,
            language: _lang,
            onLanguageChanged: _setLang,
            onOpenBag: () => _setView(AppView.sentence),
          ),
          SentenceBuilderScreen(
              language: _lang, onLanguageChanged: _setLang),
          CollectionScreen(language: _lang),
          BookScreen(language: _lang),
        ],
      ),
    );
  }
}

class _AppDrawer extends StatelessWidget {
  final AppView currentView;
  final ValueChanged<AppView> onPick;
  final Language language;
  final VoidCallback onProfileTap;

  const _AppDrawer({
    required this.currentView,
    required this.onPick,
    required this.language,
    required this.onProfileTap,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xFF1A1A2E),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(20, 24, 20, 12),
              child: Text(
                '🎹 Swype Kids',
                style: TextStyle(
                  fontFamily: 'Nunito',
                  fontSize: 22,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFFFFD200),
                ),
              ),
            ),
            InkWell(
              key: const ValueKey('profile-header'),
              onTap: onProfileTap,
              child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
              child: Row(
                children: [
                  // Avatar a jméno — ťuknutí otevře přepínání sourozenců
                  Text(ProfileService.instance.avatar,
                      style: const TextStyle(fontSize: 26)),
                  const SizedBox(width: 8),
                  if (ProfileService.instance.name.isNotEmpty) ...[
                    Expanded(
                      child: Text(
                        ProfileService.instance.name,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontFamily: 'Nunito',
                          fontSize: 16,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ] else
                    const Spacer(),
                  Text(
                    kLanguageFlag[language] ?? '🏳️',
                    style: const TextStyle(fontSize: 22),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    language.name.toUpperCase(),
                    style: const TextStyle(
                      fontFamily: 'Nunito',
                      fontSize: 13,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFFA0C4FF),
                      letterSpacing: 1.2,
                    ),
                  ),
                ],
              ),
              ),
            ),
            const Divider(color: Colors.white12, height: 1),
            _MenuTile(
              icon: '🎹',
              label: 'Slabikář (Swype)',
              selected: currentView == AppView.swype,
              onTap: () => onPick(AppView.swype),
            ),
            _MenuTile(
              icon: '🗣️',
              label: 'Skládej větu',
              selected: currentView == AppView.sentence,
              onTap: () => onPick(AppView.sentence),
            ),
            _MenuTile(
              icon: '🏅',
              label: 'Zvěřinec',
              selected: currentView == AppView.collection,
              onTap: () => onPick(AppView.collection),
            ),
            _MenuTile(
              icon: '📖',
              label: 'Má knížka',
              selected: currentView == AppView.book,
              onTap: () => onPick(AppView.book),
            ),
            const Spacer(),
            const Divider(color: Colors.white12, height: 1),
            const _SoundToggle(),
            const _AmbientToggle(),
            const _MusicToggle(),
            const _SeasonPicker(),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                'SwypeKids • mama@home',
                style: TextStyle(
                  fontFamily: 'Nunito',
                  fontSize: 11,
                  color: Colors.white.withOpacity(0.3),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Zapnutí / vypnutí zvukových efektů (dočasně v draweru; v3.1 se přesune
/// do rodičovského koutku).
class _SoundToggle extends StatefulWidget {
  const _SoundToggle();

  @override
  State<_SoundToggle> createState() => _SoundToggleState();
}

class _SoundToggleState extends State<_SoundToggle> {
  @override
  Widget build(BuildContext context) {
    final on = AudioService.instance.sfxEnabled;
    return SwitchListTile(
      value: on,
      onChanged: (v) {
        setState(() => AudioService.instance.sfxEnabled = v);
        if (v) AudioService.instance.play(Sfx.tap);
      },
      activeThumbColor: const Color(0xFFFFD200),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20),
      title: Row(
        children: [
          Text(on ? '🔊' : '🔇', style: const TextStyle(fontSize: 22)),
          const SizedBox(width: 14),
          Text(
            'Zvuky',
            style: TextStyle(
              fontFamily: 'Nunito',
              fontSize: 15,
              fontWeight: FontWeight.w800,
              color: Colors.white.withOpacity(0.85),
            ),
          ),
        ],
      ),
    );
  }
}

/// Výběr sourozence: každý má avatara, jméno a vlastní postup; ➕ založí
/// nového přes onboarding.
class _ProfileSheet extends StatelessWidget {
  final ValueChanged<int> onPick;
  final VoidCallback onAdd;

  const _ProfileSheet({required this.onPick, required this.onAdd});

  @override
  Widget build(BuildContext context) {
    final service = ProfileService.instance;
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 20),
        child: Wrap(
          spacing: 12,
          runSpacing: 12,
          alignment: WrapAlignment.center,
          children: [
            for (final p in service.profiles)
              _ProfileTile(
                key: ValueKey('profile-${p.id}'),
                emoji: p.avatar,
                label: p.label,
                selected: p.id == service.activeId,
                onTap: () => onPick(p.id),
              ),
            if (service.canAdd)
              _ProfileTile(
                key: const ValueKey('profile-add'),
                emoji: '➕',
                label: '',
                selected: false,
                onTap: onAdd,
              ),
          ],
        ),
      ),
    );
  }
}

class _ProfileTile extends StatelessWidget {
  final String emoji;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _ProfileTile({
    super.key,
    required this.emoji,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 92,
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: selected
              ? const Color(0xFFFFD200).withValues(alpha: 0.22)
              : Colors.white.withValues(alpha: 0.06),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: selected
                ? const Color(0xFFFFD200)
                : Colors.white.withValues(alpha: 0.12),
            width: selected ? 2 : 1,
          ),
        ),
        child: Column(
          children: [
            Text(emoji, style: const TextStyle(fontSize: 36)),
            if (label.isNotEmpty) ...[
              const SizedBox(height: 4),
              Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontFamily: 'Nunito',
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                  color: Colors.white.withValues(alpha: 0.85),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/// Zvuky světa (ptáci, cvrčci, voda) — zvlášť ztlumitelné.
class _AmbientToggle extends StatefulWidget {
  const _AmbientToggle();

  @override
  State<_AmbientToggle> createState() => _AmbientToggleState();
}

class _AmbientToggleState extends State<_AmbientToggle> {
  @override
  Widget build(BuildContext context) {
    final on = AudioService.instance.ambientEnabled;
    return SwitchListTile(
      key: const ValueKey('ambient-toggle'),
      value: on,
      onChanged: (v) => setState(() => AudioService.instance.ambientEnabled = v),
      activeThumbColor: const Color(0xFFFFD200),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20),
      title: Row(
        children: [
          Text(on ? '🌿' : '🍂', style: const TextStyle(fontSize: 22)),
          const SizedBox(width: 14),
          Text(
            'Zvuky světa',
            style: TextStyle(
              fontFamily: 'Nunito',
              fontSize: 15,
              fontWeight: FontWeight.w800,
              color: Colors.white.withOpacity(0.85),
            ),
          ),
        ],
      ),
    );
  }
}

/// Hudba (titulní smyčka) — zvlášť ztlumitelná.
class _MusicToggle extends StatefulWidget {
  const _MusicToggle();

  @override
  State<_MusicToggle> createState() => _MusicToggleState();
}

class _MusicToggleState extends State<_MusicToggle> {
  @override
  Widget build(BuildContext context) {
    final on = AudioService.instance.musicEnabled;
    return SwitchListTile(
      key: const ValueKey('music-toggle'),
      value: on,
      onChanged: (v) => setState(() => AudioService.instance.musicEnabled = v),
      activeThumbColor: const Color(0xFFFFD200),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20),
      title: Row(
        children: [
          Text(on ? '🎵' : '🔇', style: const TextStyle(fontSize: 22)),
          const SizedBox(width: 14),
          Text(
            'Hudba',
            style: TextStyle(
              fontFamily: 'Nunito',
              fontSize: 15,
              fontWeight: FontWeight.w800,
              color: Colors.white.withOpacity(0.85),
            ),
          ),
        ],
      ),
    );
  }
}

/// Roční období: podle kalendáře (🔄), nebo ručně — rodič tak může dítěti
/// ukázat sníh v létě. V3.1 se přesune do rodičovského koutku.
class _SeasonPicker extends StatelessWidget {
  const _SeasonPicker();

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: WorldClockService.instance,
      builder: (context, _) {
        final clock = WorldClockService.instance;
        Widget chip(String emoji, Season? value) {
          final selected = clock.seasonOverride == value;
          return GestureDetector(
            key: ValueKey('season-${value?.name ?? 'auto'}'),
            onTap: () {
              clock.seasonOverride = value;
              AudioService.instance.play(Sfx.tap);
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: selected
                    ? const Color(0xFFFFD200).withValues(alpha: 0.22)
                    : Colors.white.withValues(alpha: 0.06),
                borderRadius: BorderRadius.circular(99),
                border: Border.all(
                  color: selected
                      ? const Color(0xFFFFD200)
                      : Colors.white.withValues(alpha: 0.1),
                ),
              ),
              child: Text(emoji, style: const TextStyle(fontSize: 18)),
            ),
          );
        }

        return Padding(
          padding: const EdgeInsets.fromLTRB(20, 6, 20, 10),
          child: Row(
            children: [
              Text(clock.season.emoji, style: const TextStyle(fontSize: 22)),
              const SizedBox(width: 14),
              Expanded(
                child: Wrap(
                  spacing: 6,
                  children: [
                    chip('🔄', null),
                    for (final s in Season.values) chip(s.emoji, s),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _MenuTile extends StatelessWidget {
  final String icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;
  const _MenuTile({
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        color: selected ? Colors.white.withOpacity(0.06) : null,
        child: Row(
          children: [
            Text(icon, style: const TextStyle(fontSize: 22)),
            const SizedBox(width: 14),
            Text(
              label,
              style: TextStyle(
                fontFamily: 'Nunito',
                fontSize: 15,
                fontWeight: FontWeight.w800,
                color: selected
                    ? const Color(0xFFFFD200)
                    : Colors.white.withOpacity(0.85),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
