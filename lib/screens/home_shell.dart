import 'package:flutter/material.dart';
import '../audio/audio_service.dart';
import '../data/lessons.dart';
import '../services/entitlement_service.dart';
import '../services/profile_service.dart';
import '../services/progress_service.dart';
import '../services/session_service.dart';
import '../parent/parent_gate.dart';
import '../parent/parent_screen.dart';
import '../widgets/language_picker.dart';
import 'book_screen.dart';
import 'collection_screen.dart';
import 'lesson_map_screen.dart';
import 'onboarding_screen.dart';
import 'sentence_builder_screen.dart';
import '../ui/app_font.dart';
import '../ui/l10n.dart';
import '../ui/emoji_art.dart';
import '../characters/guide.dart';
import '../characters/mascot.dart';
import '../services/tts_service.dart';

enum AppView { swype, sentence, collection, book }

class HomeShell extends StatefulWidget {
  final Language initialLanguage;
  const HomeShell({super.key, required this.initialLanguage});

  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> with WidgetsBindingObserver {
  late Language _lang =
      EntitlementService.instance.allowed(widget.initialLanguage);
  AppView _view = AppView.swype;
  final _mapKey = GlobalKey<LessonMapScreenState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    EntitlementService.instance.addListener(_onEntitlements);
  }

  /// Změna odemčení (rodič v koutku): vlajky a mapa se překreslí; jazyk,
  /// který dítě hrát nesmí, se vymění za odemčený.
  void _onEntitlements() {
    if (!mounted) return;
    final allowed = EntitlementService.instance.allowed(_lang);
    if (allowed != _lang) {
      _setLang(allowed);
    } else {
      setState(() {});
    }
  }

  @override
  void dispose() {
    EntitlementService.instance.removeListener(_onEntitlements);
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  /// Ambient hraje jen na mapě a jen když je appka v popředí; čas session
  /// se počítá jen v popředí.
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final resumed = state == AppLifecycleState.resumed;
    _mapKey.currentState?.setAmbientActive(resumed && _view == AppView.swype);
    if (resumed) {
      SessionService.instance.start();
    } else {
      SessionService.instance.stop();
    }
  }

  void _setLang(Language l) {
    ProgressService.instance.selectedLanguage = l;
    AppLanguage.instance.value = l;
    setState(() => _lang = l);
  }

  /// Přepnutí sourozence: načte jeho postup a znovu postaví obrazovky.
  Future<void> _switchProfile(int id) async {
    ProfileService.instance.switchTo(id);
    await ProgressService.init(profile: id);
    if (!mounted) return;
    setState(() {
      _lang = EntitlementService.instance
          .allowed(ProgressService.instance.selectedLanguage ?? _lang);
      _view = AppView.swype;
    });
    AppLanguage.instance.value = _lang;
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
    AppLanguage.instance.value = _lang;
  }

  /// Rodičovský koutek za bránou (příklad místo PINu).
  Future<void> _openParent() async {
    Navigator.of(context).maybePop();
    await Navigator.of(context).push(MaterialPageRoute(
      builder: (ctx) => ParentGate(
        onPassed: () => Navigator.of(ctx).pushReplacement(MaterialPageRoute(
          builder: (_) => ParentScreen(language: _lang),
        )),
      ),
    ));
    if (!mounted) return;
    // Rodič mohl smazat/přepnout profil nebo změnit nastavení.
    setState(() {
      _lang = ProgressService.instance.selectedLanguage ?? _lang;
    });
    AppLanguage.instance.value = _lang;
  }

  void _openProfiles() {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: const Color(0xFF1A1A2E),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => _ProfileSheet(
        language: _lang,
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
        onParent: _openParent,
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
          SentenceBuilderScreen(language: _lang, onLanguageChanged: _setLang),
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
  final VoidCallback onParent;

  const _AppDrawer({
    required this.currentView,
    required this.onPick,
    required this.language,
    required this.onProfileTap,
    required this.onParent,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xFF1A1A2E),
      child: SafeArea(
        // Menu scrolluje: na malém telefonu se přepínače a období nevejdou.
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 12),
              child: Text(
                '🎹 SwypeKids',
                style: TextStyle(
                  fontFamily: kDisplayFont,
                  fontFamilyFallback: kFontFallback,
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
                    EmojiArt(ProfileService.instance.avatar, size: 26),
                    const SizedBox(width: 8),
                    if (ProfileService.instance.name.isNotEmpty) ...[
                      Expanded(
                        child: Text(
                          ProfileService.instance.name,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontFamily: kFont,
                            fontFamilyFallback: kFontFallback,
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
                      style: TextStyle(
                        fontFamily: kFont,
                        fontFamilyFallback: kFontFallback,
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
              label: context.l.menuSyllabary,
              selected: currentView == AppView.swype,
              onTap: () => onPick(AppView.swype),
            ),
            _MenuTile(
              icon: '🗣️',
              label: context.l.menuSentence,
              selected: currentView == AppView.sentence,
              onTap: () => onPick(AppView.sentence),
            ),
            _MenuTile(
              icon: '🏅',
              label: context.l.menuZoo,
              selected: currentView == AppView.collection,
              onTap: () => onPick(AppView.collection),
            ),
            _MenuTile(
              icon: '📖',
              label: context.l.menuBook,
              selected: currentView == AppView.book,
              onTap: () => onPick(AppView.book),
            ),
            const SizedBox(height: 8),
            const Divider(color: Colors.white12, height: 1),
            _MenuTile(
              icon: '👪',
              label: context.l.menuParents,
              selected: false,
              onTap: onParent,
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                'SwypeKids • mama@home',
                style: TextStyle(
                  fontFamily: kFont,
                  fontFamilyFallback: kFontFallback,
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

/// Výběr sourozence: každý má avatara, jméno a vlastní postup; ➕ založí
/// nového přes onboarding.
class _ProfileSheet extends StatelessWidget {
  final ValueChanged<int> onPick;
  final VoidCallback onAdd;

  final Language language;

  const _ProfileSheet({
    required this.language,
    required this.onPick,
    required this.onAdd,
  });

  void _pickGuide(Guide g) {
    AudioService.instance.play(Sfx.tap);
    final service = ProfileService.instance;
    service.setGuide(service.activeId, g);
    TtsService.speak(g.nameIn(language), language);
  }

  @override
  Widget build(BuildContext context) {
    final service = ProfileService.instance;
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 20),
        // Na malém telefonu na šířku se sourozenci + průvodci nevejdou.
        child: SingleChildScrollView(
            child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Wrap(
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
            // Výběr průvodce aktivního dítěte — obrázky, žádné čtení.
            const SizedBox(height: 18),
            Text(
              context.l.guideTitle,
              style: TextStyle(
                fontFamily: kFont,
                fontFamilyFallback: kFontFallback,
                fontSize: 15,
                fontWeight: FontWeight.w800,
                color: const Color(0xFFA0C4FF),
              ),
            ),
            const SizedBox(height: 10),
            ValueListenableBuilder<Guide>(
              valueListenable: ProfileService.instance.guide,
              builder: (context, current, _) => Wrap(
                spacing: 10,
                runSpacing: 10,
                alignment: WrapAlignment.center,
                children: [
                  for (final g in Guide.values)
                    _GuideTile(
                      key: ValueKey('guide-${g.name}'),
                      guide: g,
                      label: g.nameIn(language),
                      selected: g == current,
                      onTap: () => _pickGuide(g),
                    ),
                ],
              ),
            ),
          ],
        )),
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
            EmojiArt(emoji, size: 36),
            if (label.isNotEmpty) ...[
              const SizedBox(height: 4),
              Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontFamily: kFont,
                  fontFamilyFallback: kFontFallback,
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
            Expanded(
              child: Text(
                label,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontFamily: kFont,
                  fontFamilyFallback: kFontFallback,
                  fontSize: 15,
                  fontWeight: FontWeight.w800,
                  color: selected
                      ? const Color(0xFFFFD200)
                      : Colors.white.withOpacity(0.85),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Průvodce na výběr: obrázek v klidu + jméno; vybraný zamává.
class _GuideTile extends StatelessWidget {
  final Guide guide;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _GuideTile({
    super.key,
    required this.guide,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 84,
        padding: const EdgeInsets.symmetric(vertical: 8),
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
            Image.asset(
              Mascot.imageFor(selected ? MascotMood.wave : MascotMood.idle,
                  guide: guide),
              width: 60,
              height: 60,
              errorBuilder: (_, __, ___) =>
                  Text(guide.emoji, style: const TextStyle(fontSize: 44)),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontFamily: kFont,
                fontFamilyFallback: kFontFallback,
                fontSize: 11,
                fontWeight: FontWeight.w800,
                color: Colors.white.withValues(alpha: 0.85),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
