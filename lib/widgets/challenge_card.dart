import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import '../data/keyboard_data.dart';
import '../data/lessons.dart';
import '../ui/app_font.dart';
import '../ui/l10n.dart';

enum GameStatus { idle, success, error }

/// Co karta prozradí. Po chybě GameScreen přepne na [full] (scaffolding).
enum CardMode {
  /// Text i všechna písmena.
  full,

  /// Poslech: text i písmena skryté, hraje TTS.
  listen,

  /// Jen obrázek: text i písmena skryté, bez zvuku.
  picture,

  /// Slovo s dírou: skryté jen písmeno na [ChallengeCard.gapIndex].
  gap,

  /// Lov hlásky: průvodce řekl písmeno, dítě ho ťukne (text skrytý).
  hunt,

  /// Spojování slabik: nad slovem letí slabiky z `lesson.parts`.
  join,

  /// Rým: karta ukazuje cíl, výběr je mimo klávesnici.
  rhyme,
}

class ChallengeCard extends StatelessWidget {
  final Lesson lesson;
  final List<String> path;
  final GameStatus status;
  final bool shake;

  /// Co je skryté (poslech, obrázek, díra). Trefená písmena se odkrývají
  /// průběžně.
  final CardMode mode;

  /// Přehrát zadání znovu (jen poslechové kolo).
  final VoidCallback? onReplayAudio;

  /// Per-jazyková emoji mnemotechnika kláves (PackService.keyEmojiFor).
  final String Function(String letter) emojiFor;

  const ChallengeCard({
    super.key,
    required this.lesson,
    required this.path,
    required this.status,
    required this.shake,
    required this.emojiFor,
    this.mode = CardMode.full,
    this.onReplayAudio,
  });

  bool get _hideAll =>
      mode == CardMode.listen ||
      mode == CardMode.picture ||
      mode == CardMode.hunt;

  bool _isHidden(int i) =>
      _hideAll || (mode == CardMode.gap && i == lesson.gapIndex);

  String get _labelText => switch (mode) {
        CardMode.listen || CardMode.picture || CardMode.hunt => '• • •',
        CardMode.gap => _gapped(),
        CardMode.join => lesson.parts.join(' + '),
        CardMode.full || CardMode.rhyme => lesson.label,
      };

  /// Slovo s „?" místo chybějícího písmene. Když display odpovídá targetu
  /// písmeno po písmenu (MÁMA ↔ MAMA), zachová diakritiku.
  String _gapped() {
    final display = lesson.display.characters.toList();
    final source = display.length == lesson.target.length
        ? display
        : lesson.target.split('');
    return [
      for (final (i, ch) in source.indexed) i == lesson.gapIndex ? '?' : ch,
    ].join();
  }

  @override
  Widget build(BuildContext context) {
    final letters = lesson.target.split('');

    return AnimatedContainer(
      duration: const Duration(milliseconds: 80),
      transform: shake
          ? (Matrix4.identity()..translate(6.0))
          : Matrix4.identity(),
      margin: const EdgeInsets.symmetric(horizontal: 8),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.08),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withOpacity(0.13)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Hint emoji (+ 🔊 replay u poslechového kola)
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(lesson.hint, style: const TextStyle(fontSize: 40)),
              if (onReplayAudio != null) ...[
                const SizedBox(width: 14),
                GestureDetector(
                  onTap: onReplayAudio,
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: const Text('🔊', style: TextStyle(fontSize: 28)),
                  ),
                ),
              ],
            ],
          ),
          const SizedBox(height: 2),
          // Název slova (skrytý u poslechu a obrázku, s dírou u doplňovačky)
          Text(
            _labelText,
            style: TextStyle(
              fontFamily: kFont,
              fontSize: 22,
              fontWeight: FontWeight.w900,
              color: const Color(0xFFFFD200)
                  .withOpacity(_hideAll ? 0.35 : 1.0),
              letterSpacing: 5,
              shadows: [
                Shadow(
                  color: const Color(0xFFFFD200).withOpacity(0.4),
                  blurRadius: 16,
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),

          // Cílová písmena
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: letters.asMap().entries.map((e) {
              final i = e.key;
              final ch = e.value;
              final reached = path.length > i;
              final hit = reached && path[i] == ch;
              final miss = reached && path[i] != ch;
              final hidden = _isHidden(i);
              final col = keyColor(ch);
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Column(
                  children: [
                    // Mini emoji nad písmenkem
                    AnimatedDefaultTextStyle(
                      duration: const Duration(milliseconds: 200),
                      style: TextStyle(
                        fontSize: hit ? 20 : 16,
                      ),
                      child: Text(miss
                          ? '❌'
                          : (hidden && !hit ? '❓' : emojiFor(ch))),
                    ),
                    const SizedBox(height: 3),
                    // Políčko s písmenkem
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 180),
                      curve: Curves.easeOutCubic,
                      width: hit ? 48 : 44,
                      height: hit ? 54 : 50,
                      decoration: BoxDecoration(
                        color: hit
                            ? col
                            : miss
                                ? const Color(0xFFE74C3C).withOpacity(0.25)
                                : Colors.white.withOpacity(0.08),
                        borderRadius: BorderRadius.circular(12),
                        border: miss
                            ? Border.all(
                                color: const Color(0xFFE74C3C), width: 2)
                            : null,
                        boxShadow: hit
                            ? [
                                BoxShadow(
                                  color: col.withOpacity(0.6),
                                  blurRadius: 14,
                                  spreadRadius: 1,
                                ),
                              ]
                            : null,
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        hidden && !hit && !miss ? '?' : ch,
                        style: TextStyle(
                          fontFamily: kFont,
                          fontSize: 26,
                          fontWeight: FontWeight.w900,
                          color: hit
                              ? Colors.white
                              : miss
                                  ? const Color(0xFFE74C3C)
                                  : Colors.white.withOpacity(0.2),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 8),

          // Status zpráva
          SizedBox(
            height: 24,
            child: _statusText(context),
          ),
        ],
      ),
    );
  }

  Widget _statusText(BuildContext context) {
    switch (status) {
      case GameStatus.success:
        return Text('🎉 ${context.l.successText}',
            style: TextStyle(
                fontFamily: kFont,
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: const Color(0xFF2ECC71)));
      case GameStatus.error:
        return Text('❌ ${context.l.errorText}',
            style: TextStyle(
                fontFamily: kFont,
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: const Color(0xFFE74C3C)));
      case GameStatus.idle:
        if (path.isEmpty) {
          final prompt = switch (mode) {
            CardMode.listen => '🔊 ${context.l.promptListen}',
            CardMode.picture => '🖼️ ${context.l.promptPicture}',
            CardMode.gap => '🧩 ${context.l.promptGap}',
            CardMode.hunt => '👂 ${context.l.promptHunt}',
            CardMode.join => '🧱 ${context.l.promptJoin}',
            CardMode.rhyme => '🎵 ${context.l.promptRhyme}',
            CardMode.full => null,
          };
          if (prompt != null) {
            return Text(
              prompt,
              style: TextStyle(
                  fontFamily: kFont,
                  fontSize: 13,
                  color: Colors.white.withOpacity(0.35)),
            );
          }
          final isDesktop =
              Platform.isMacOS || Platform.isWindows || Platform.isLinux;
          return Text(
            isDesktop
                ? '🖱️ ${context.l.promptSwipeTrackpad}'
                : '☝️ ${context.l.promptSwipeTouch}',
            style: TextStyle(
                fontFamily: kFont,
                fontSize: 13,
                color: Colors.white.withOpacity(0.35)),
          );
        }
        return const SizedBox.shrink();
    }
  }
}
