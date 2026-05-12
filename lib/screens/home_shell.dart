import 'package:flutter/material.dart';
import '../data/lessons.dart';
import '../widgets/language_picker.dart';
import 'game_screen.dart';
import 'sentence_builder_screen.dart';

enum AppView { swype, sentence }

class HomeShell extends StatefulWidget {
  final Language initialLanguage;
  const HomeShell({super.key, required this.initialLanguage});

  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  late Language _lang = widget.initialLanguage;
  AppView _view = AppView.swype;

  void _setLang(Language l) => setState(() => _lang = l);
  void _setView(AppView v) {
    setState(() => _view = v);
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
          GameScreen(language: _lang, onLanguageChanged: _setLang),
          SentenceBuilderScreen(
              language: _lang, onLanguageChanged: _setLang),
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
            const Spacer(),
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
