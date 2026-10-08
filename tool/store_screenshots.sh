#!/bin/bash
# Snímky obrazovek pro web a obchody: spustí skutečnou appku na macOS
# (hlas i zvuky vypnuté), projde všechny sekce a PNG zkopíruje do cíle.
#
#   tool/store_screenshots.sh <cílová složka>
#
# Vzniknou soubory phone-NN-<sekce>.png (390×844 @3x),
# desktop-NN-<sekce>.png (1280×800 @2x) a pro obchody
# appstore-iphone-NN-… (1320×2868) a appstore-ipad-NN-… (2064×2752). Trvá asi 4 minuty; na chvíli se
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
