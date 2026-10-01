import 'package:flutter/material.dart';
import '../audio/audio_service.dart';
import '../data/lessons.dart';
import '../services/progress_service.dart';
import '../widgets/language_picker.dart';
import '../world/world_clock.dart';
import 'book_screen.dart';
import 'collection_screen.dart';
import 'lesson_map_screen.dart';
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
      ),
      body: IndexedStack(
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

  const _AppDrawer({
    required this.currentView,
    required this.onPick,
    required this.language,
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
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
              child: Row(
                children: [
                  Text(
                    kLanguageFlag[language] ?? '🏳️',
                    style: const TextStyle(fontSize: 22),
                  ),
                  const SizedBox(width: 8),
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
            const _SeasonPicker(),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                'Verze 1.0 • mama@home',
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
