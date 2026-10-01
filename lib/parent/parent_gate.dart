import 'dart:math';

import 'package:flutter/material.dart';
import '../ui/app_font.dart';

/// Rodičovská brána (roadmap P6): ne PIN, ale jednoduchý příklad
/// („7 × 3 = ?"), který dítě 5–9 let nespočítá a rodič nemusí pamatovat.
/// Tři odpovědi, špatná zatřese a vylosuje nový příklad.
class ParentGate extends StatefulWidget {
  final VoidCallback onPassed;
  final Random? random;

  const ParentGate({super.key, required this.onPassed, this.random});

  /// Příklad: (a, b, [možnosti], index správné). Součin 2–9 × 2–9.
  static (int, int, List<int>, int) makeQuestion(Random rnd) {
    final a = 2 + rnd.nextInt(8);
    final b = 2 + rnd.nextInt(8);
    final correct = a * b;
    final wrong = <int>{};
    while (wrong.length < 2) {
      final w = correct + (rnd.nextInt(7) - 3) * (rnd.nextBool() ? 1 : 2);
      if (w != correct && w > 0) wrong.add(w);
    }
    final options = [correct, ...wrong]..shuffle(rnd);
    return (a, b, options, options.indexOf(correct));
  }

  @override
  State<ParentGate> createState() => _ParentGateState();
}

class _ParentGateState extends State<ParentGate> {
  late final Random _rnd = widget.random ?? Random();
  late (int, int, List<int>, int) _q = ParentGate.makeQuestion(_rnd);
  bool _shake = false;

  void _answer(int index) {
    if (index == _q.$4) {
      widget.onPassed();
      return;
    }
    setState(() {
      _shake = true;
      _q = ParentGate.makeQuestion(_rnd);
    });
    Future.delayed(const Duration(milliseconds: 400), () {
      if (mounted) setState(() => _shake = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    final (a, b, options, _) = _q;
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A2E),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 420),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('👪', style: TextStyle(fontSize: 56)),
                const SizedBox(height: 8),
                Text(
                  'Pro rodiče',
                  style: TextStyle(
                    fontFamily: kFont,
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                    color: Colors.white.withValues(alpha: 0.85),
                  ),
                ),
                const SizedBox(height: 24),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 80),
                  transform: Matrix4.translationValues(_shake ? 8 : 0, 0, 0),
                  child: Text(
                    'Kolik je $a × $b?',
                    key: const ValueKey('gate-question'),
                    style: TextStyle(
                      fontFamily: kFont,
                      fontSize: 26,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFFFFD200),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Wrap(
                  spacing: 12,
                  children: [
                    for (var i = 0; i < options.length; i++)
                      ElevatedButton(
                        key: ValueKey('gate-option-${options[i]}'),
                        onPressed: () => _answer(i),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white.withValues(alpha: 0.1),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 22, vertical: 14),
                          shape: const StadiumBorder(),
                          textStyle: TextStyle(
                            fontFamily: kFont,
                            fontSize: 22,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        child: Text('${options[i]}'),
                      ),
                  ],
                ),
                const SizedBox(height: 32),
                TextButton(
                  onPressed: () => Navigator.of(context).maybePop(),
                  child: Text(
                    'Zpět ke hře',
                    style: TextStyle(
                      fontFamily: kFont,
                      color: Colors.white.withValues(alpha: 0.5),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
