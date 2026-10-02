#!/usr/bin/env python3
"""Nálepky místo emoji: z draftů (1024 px PNG s pastelovým pozadím, výstup
drafts/stickers/round3) vyřízne postavičku, uloží `assets/emoji/<cp>.webp`
a přegeneruje `lib/ui/emoji_art_index.dart`.

Usage: python3 tool/emoji_art/build.py <složka s emoji-<cp>.png> [--reject cp,cp]
Vyžaduje Pillow (s podporou WebP)."""
import glob, os, sys
from PIL import Image, ImageChops, ImageDraw, ImageFilter

ROOT = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
OUT = os.path.join(ROOT, 'assets', 'emoji')
INDEX = os.path.join(ROOT, 'lib', 'ui', 'emoji_art_index.dart')
SIZE = 320  # px — největší použití je nálepka po lekci (120 dp × ~2,7)
SENT = (1, 254, 3)


def cutout(path):
    im = Image.open(path).convert('RGB')
    w, h = im.size
    work = im.copy()
    # Pozadí = vše, co je od okrajů souvisle podobné barvy (bílý okraj
    # nálepky ho odděluje od postavičky).
    for c in [(0, 0), (w - 1, 0), (0, h - 1), (w - 1, h - 1),
              (w // 2, 0), (0, h // 2), (w - 1, h // 2), (w // 2, h - 1)]:
        if work.getpixel(c) != SENT:
            ImageDraw.floodfill(work, c, SENT, thresh=40)
    diff = ImageChops.difference(work, Image.new('RGB', (w, h), SENT)).convert('L')
    alpha = (diff.point(lambda v: 255 if v > 0 else 0)
             .filter(ImageFilter.MinFilter(3)).filter(ImageFilter.GaussianBlur(1.2)))
    out = im.convert('RGBA')
    out.putalpha(alpha)
    bb = alpha.getbbox()
    if bb is None:
        return None
    out = out.crop(bb)
    s = max(out.size)
    sq = Image.new('RGBA', (s, s), (0, 0, 0, 0))
    sq.paste(out, ((s - out.size[0]) // 2, (s - out.size[1]) // 2))
    return sq.resize((SIZE, SIZE), Image.LANCZOS)


def main():
    src = sys.argv[1]
    reject = set()
    if '--reject' in sys.argv:
        reject = set(sys.argv[sys.argv.index('--reject') + 1].split(','))
    os.makedirs(OUT, exist_ok=True)
    for p in sorted(glob.glob(os.path.join(src, 'emoji-*.png'))):
        cp = os.path.basename(p)[len('emoji-'):-len('.png')]
        dst = os.path.join(OUT, cp + '.webp')
        if cp in reject:
            if os.path.exists(dst):
                os.remove(dst)
            continue
        img = cutout(p)
        if img is not None:
            img.save(dst, 'WEBP', quality=82, method=6)
    keys = sorted(os.path.basename(f)[:-5] for f in glob.glob(os.path.join(OUT, '*.webp')))
    with open(INDEX, 'w') as f:
        f.write('// Generováno: tool/emoji_art/build.py — needitovat ručně.\n')
        f.write('// Emoji, pro která existuje obrázek v assets/emoji/.\n\n')
        f.write('const kEmojiArt = <String>{\n')
        for k in keys:
            f.write(f"  '{k}',\n")
        f.write('};\n')
    total = sum(os.path.getsize(os.path.join(OUT, k + '.webp')) for k in keys)
    print(f'{len(keys)} nálepek, {total / 1e6:.1f} MB')


if __name__ == '__main__':
    main()
