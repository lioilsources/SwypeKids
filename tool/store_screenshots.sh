#!/bin/bash
# Snímky obrazovek pro web a obchody: spustí skutečnou appku na macOS
# (hlas i zvuky vypnuté), projde všechny sekce a PNG zkopíruje do cíle.
#
#   tool/store_screenshots.sh <cílová složka>
#
# Vzniknou soubory phone-NN-<sekce>.png (390×844 @3x) a
# desktop-NN-<sekce>.png (1280×800 @2x). Trvá asi 2 minuty; na chvíli se
# otevře okno appky.
set -euo pipefail
DEST=${1:?Použití: tool/store_screenshots.sh <cílová složka>}
cd "$(dirname "$0")/.."
LOG=$(mktemp)
flutter test integration_test/store_screenshots_test.dart -d macos | tee "$LOG"
SRC=$(grep -o 'SHOTS_DIR=.*' "$LOG" | tail -1 | cut -d= -f2)
[ -d "$SRC" ] || { echo "Snímky nevznikly (viz výstup výše)." >&2; exit 1; }
mkdir -p "$DEST"
cp "$SRC"/*.png "$DEST"/
echo "$(ls "$SRC"/*.png | wc -l | tr -d ' ') snímků → $DEST"
