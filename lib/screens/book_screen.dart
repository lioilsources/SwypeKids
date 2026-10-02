import 'package:flutter/material.dart';
import '../audio/audio_service.dart';
import '../data/lessons.dart';
import '../data/models/content_pack.dart';
import '../services/pack_service.dart';
import '../services/progress_service.dart';
import '../services/tts_service.dart';
import '../ui/app_font.dart';
import '../ui/l10n.dart';

/// Má knížka — věty, které dítě složilo a uložilo (builder vět, slovo do
/// věty). Ťuknutí na stránku ji přečte nahlas; rodič si ji může nechat číst.
class BookScreen extends StatefulWidget {
  final Language language;

  const BookScreen({super.key, required this.language});

  @override
  State<BookScreen> createState() => _BookScreenState();
}

class _BookScreenState extends State<BookScreen> {
  ContentPack? _pack;

  @override
  void initState() {
    super.initState();
    _loadPack();
  }

  @override
  void didUpdateWidget(covariant BookScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.language != widget.language) {
      setState(() => _pack = null);
      _loadPack();
    }
  }

  Future<void> _loadPack() async {
    final pack = await PackService.instance.load(widget.language);
    if (mounted && pack.language == widget.language) {
      setState(() => _pack = pack);
    }
  }

  void _read(BookPage page) {
    AudioService.instance.play(Sfx.tap);
    TtsService.speak(page.text, widget.language);
  }

  @override
  Widget build(BuildContext context) {
    final pack = _pack;
    final pages = pack == null
        ? const <BookPage>[]
        : ProgressService.instance.book(pack.id);

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF1A1A2E), Color(0xFF16213E), Color(0xFF0F3460)],
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
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
                  const SizedBox(width: 10),
                  Text(
                    '📖 ${context.l.bookTitle}',
                    style: TextStyle(
                      fontFamily: kFont,
                      fontFamilyFallback: kFontFallback,
                      fontSize: 15,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFFFFD200),
                    ),
                  ),
                  const Spacer(),
                  Text(
                    '${pages.length}',
                    style: TextStyle(
                      fontFamily: kFont,
                      fontFamilyFallback: kFontFallback,
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFFA0C4FF),
                    ),
                  ),
                  const SizedBox(width: 8),
                ],
              ),
            ),
            Expanded(
              child: pages.isEmpty
                  ? const _EmptyBook()
                  : ListView.separated(
                      padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
                      itemCount: pages.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 10),
                      itemBuilder: (_, i) => _PageCard(
                        page: pages[i],
                        onTap: () => _read(pages[i]),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PageCard extends StatelessWidget {
  final BookPage page;
  final VoidCallback onTap;

  const _PageCard({required this.page, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: const Color(0xFFFFF8E7).withValues(alpha: 0.95),
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.25),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(page.emojis, style: const TextStyle(fontSize: 30)),
                  const SizedBox(height: 4),
                  Text(
                    page.text,
                    style: TextStyle(
                      fontFamily: kDisplayFont,
                      fontFamilyFallback: kFontFallback,
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF3A2E1F),
                    ),
                  ),
                ],
              ),
            ),
            const Text('🔊', style: TextStyle(fontSize: 26)),
          ],
        ),
      ),
    );
  }
}

class _EmptyBook extends StatelessWidget {
  const _EmptyBook();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('📖', style: TextStyle(fontSize: 72)),
          const SizedBox(height: 12),
          // Bez čtení: obrázkový návod „slož větu → ulož".
          const Text('🗣️ ➡️ 📖', style: TextStyle(fontSize: 32)),
          const SizedBox(height: 8),
          Text(
            context.l.bookEmptyHint,
            style: TextStyle(
              fontFamily: kFont,
              fontFamilyFallback: kFontFallback,
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: Colors.white.withValues(alpha: 0.5),
            ),
          ),
        ],
      ),
    );
  }
}
