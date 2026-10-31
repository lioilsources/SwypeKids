#!/bin/bash
# Snímky obrazovek pro web a obchody: spustí skutečnou appku (hlas i zvuky
# vypnuté), projde všechny sekce a PNG uloží do cíle.
#
#   tool/store_screenshots.sh <cílová složka>              # čeština
#   tool/store_screenshots.sh <cílová složka> en de uk …   # jazyky → <cíl>/<jazyk>/
#
# Čeština bez jazyků: phone-NN-<sekce>.png (390×844 @3x),
# desktop-NN-<sekce>.png (1280×800 @2x) a pro obchody
# appstore-iphone-NN-… (1320×2868), appstore-iphone63-NN-… (1206×2622) a
# appstore-ipad-NN-… (2064×2752). S jazyky vzniknou jen sady
# appstore-iphone a appstore-ipad — titulky přidá tool/store_captions.py.
#
# Zařízení: SHOT_DEVICE=<id simulátoru> (doporučeno, ~5 min na jazyk), jinak
# macOS. Okno macOS appky kreslí jen při zapnutém displeji — když displej
# usne nebo je zamčeno, test stojí; simulátor to nemá.
set -euo pipefail
DEST=${1:?Použití: tool/store_screenshots.sh <cílová složka> [jazyk…]}
shift
cd "$(dirname "$0")/.."
DEVICE=${SHOT_DEVICE:-macos}

shoot() { # <jazyk> <cíl>
  local LOG SRC OUT
  LOG=$(mktemp)
  mkdir -p "$2"
  OUT=$(cd "$2" && pwd)
  rm -f "$OUT"/*.png
  if [ "$DEVICE" = macos ]; then
    # -u displej na začátku probudí, -d ho drží zapnutý po celý test.
    caffeinate -d -i -u flutter test integration_test/store_screenshots_test.dart \
      -d macos --dart-define=SHOT_LANG="$1" | tee "$LOG"
  else
    caffeinate -i flutter test integration_test/store_screenshots_test.dart \
      -d "$DEVICE" --dart-define=SHOT_LANG="$1" --dart-define=SHOT_OUT="$OUT" | tee "$LOG"
  fi
  grep -q 'All tests passed' "$LOG" || { echo "Snímky ($1) selhaly." >&2; exit 1; }
  SRC=$(grep -o 'SHOTS_DIR=.*' "$LOG" | tail -1 | cut -d= -f2)
  [ "$SRC" = "$OUT" ] || cp "$SRC"/*.png "$OUT"/
  # App Store odmítá PNG s alfa kanálem; Flutter ho ukládá vždy.
  python3 - "$OUT" <<'PY'
import glob, sys
from PIL import Image
for f in glob.glob(sys.argv[1] + '/appstore-*.png'):
    Image.open(f).convert('RGB').save(f)
PY
  echo "$(ls "$OUT"/*.png | wc -l | tr -d ' ') snímků ($1) → $OUT"
}

if [ $# -eq 0 ]; then
  shoot cs "$DEST"
else
  for lang in "$@"; do shoot "$lang" "$DEST/$lang"; done
fi
