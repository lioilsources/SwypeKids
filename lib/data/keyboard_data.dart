import 'package:flutter/material.dart';

// ─── QWERTY řady ──────────────────────────────────────────────────────────────
const List<List<String>> kRows = [
  ['Q','W','E','R','T','Y','U','I','O','P'],
  ['A','S','D','F','G','H','J','K','L'],
  ['Z','X','C','V','B','N','M'],
];

// ─── Emoji pro každé písmeno ──────────────────────────────────────────────────
const Map<String, String> kEmoji = {
  'M': '🐭', 'A': '🍎', 'T': '🐯', 'B': '🍌',
  'E': '🐘', 'L': '🦁', 'O': '🐙', 'K': '🐱',
  'S': '☀️', 'N': '✂️', 'P': '🐷', 'R': '🐟',
  'D': '🍩', 'I': '🌈', 'U': '🦆', 'V': '🐺',
  'G': '🍇', 'H': '🏠', 'J': '🍓', 'F': '🍟',
  'C': '🥕', 'Z': '🦓', 'X': '🎸', 'Y': '🪁',
  'W': '🐸', 'Q': '👑',
};

// ─── Barvy kláves ─────────────────────────────────────────────────────────────
const Map<String, Color> kColors = {
  'M': Color(0xFFFF6B6B), 'A': Color(0xFFFF9F43), 'T': Color(0xFFFECA57),
  'B': Color(0xFF48DBFB), 'E': Color(0xFFFF9FF3), 'L': Color(0xFF54A0FF),
  'O': Color(0xFF9B59B6), 'K': Color(0xFF1DD1A1), 'S': Color(0xFFFD9644),
  'N': Color(0xFFA29BFE), 'P': Color(0xFF00D2D3), 'R': Color(0xFFFF6B81),
  'D': Color(0xFFE67E22), 'I': Color(0xFFF368E0), 'U': Color(0xFFEE5A24),
  'V': Color(0xFF2ECC71), 'G': Color(0xFFE17055), 'H': Color(0xFFFDCB6E),
  'J': Color(0xFF6C5CE7), 'F': Color(0xFF00B894), 'C': Color(0xFFFD79A8),
  'Z': Color(0xFF74B9FF), 'X': Color(0xFFA29BFE), 'Y': Color(0xFF55EFC4),
  'W': Color(0xFF00CEC9), 'Q': Color(0xFFD63031),
};

Color keyColor(String l) => kColors[l] ?? const Color(0xFF888888);
String keyEmoji(String l) => kEmoji[l] ?? '?';
