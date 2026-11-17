# Store tooling

Moved from CLAUDE.md. Screenshot, metadata and graphics commands for App Store and Google Play. Listing texts and submission steps: [STORE.md](STORE.md).

```bash
tool/store_screenshots.sh <dir>             # real-app screenshots of every section (macOS run, muted) → phone-*.png, desktop-*.png, appstore-iphone-*.png (1320×2868), appstore-iphone63-*.png (1206×2622), appstore-ipad-*.png (2064×2752)
SHOT_DEVICE=<simulator id> tool/store_screenshots.sh <dir> cs en de es fr it pt uk ru vi  # raw App Store sets per UI language → <dir>/<lang>/ (uk/ru/vi read Czech); simulator keeps rendering when the Mac display sleeps
python3 tool/store_captions.py              # captioned App Store shots for all 13 listing locales → build/store/fastlane/screenshots/<locale>/
fastlane screenshots                        # upload those screenshots only (fastlane/Fastfile + Deliverfile; APP_STORE_CONNECT_API_KEY_KEY_ID/_ISSUER_ID/_KEY_FILEPATH)
python3 tool/store_metadata.py              # listing texts from docs/STORE.md §5/§6 (13 locales, limits checked) → build/store/fastlane/metadata/
fastlane metadata                           # upload description, keywords, promo, what's new, URLs (not name/subtitle)
python3 tool/store_feature_graphic.py <DynaPuff.ttf> [out.png] [subtitle]  # Google Play feature graphic 1024×500 → build/store/
python3 tool/play_screenshots.py              # Google Play shots (max 2:1): phone 1080×1920 framed, tablet 1920×1200 → build/store/play/
python3 tool/store_header.py                  # App Store header 3840×1646 + search results 3840×2560 (no text) → build/store/
```
