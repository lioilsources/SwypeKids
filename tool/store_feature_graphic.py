#!/usr/bin/env python3
"""Hlavní obrázek pro Google Play (1024×500) z průvodce a nálepek.

    python3 tool/store_feature_graphic.py <DynaPuff-Variable.ttf> [výstup.png]

Font je v balíčku cute_kid_fonts (~/.pub-cache/git/CuteKidFonts-*/fonts/).
"""
import sys
from pathlib import Path
from PIL import Image, ImageDraw, ImageFont

ROOT = Path(__file__).resolve().parent.parent
font_path = sys.argv[1]
out = Path(sys.argv[2] if len(sys.argv) > 2 else ROOT / 'build/store/feature-graphic.png')

W, H = 1024, 500
img = Image.new('RGB', (W, H), '#FFC650')  # barva ikony
d = ImageDraw.Draw(img)
# Měkký kopec dole, ať nálepky na něčem stojí.
d.ellipse((-200, 360, W + 200, 900), fill='#F7A93B')


def font(size, weight=700):
    f = ImageFont.truetype(font_path, size)
    try:
        f.set_variation_by_axes([weight, 100])
    except Exception:
        try:
            f.set_variation_by_axes([weight])
        except Exception:
            pass
    return f


def paste(path, size, x, y):
    im = Image.open(ROOT / path).convert('RGBA')
    im.thumbnail((size, size), Image.LANCZOS)
    img.paste(im, (x, y), im)


paste('assets/characters/panda/wave.png', 400, 40, 70)
for cp, x, y, s in (('1f42d', 560, 330, 130), ('1f42f', 700, 320, 140),
                    ('1f34c', 850, 335, 120)):
    p = f'assets/emoji/{cp}.webp'
    if (ROOT / p).exists():
        paste(p, s, x, y)

def fit(text, size, weight, width):
    """Největší velikost, při které se text vejde do šířky."""
    while size > 10:
        f = font(size, weight)
        if d.textlength(text, font=f) <= width:
            return f
        size -= 2
    return font(size, weight)


LEFT, RIGHT = 460, W - 36
title = fit('SwypeKids', 120, 700, RIGHT - LEFT)
sub = fit('Objevuj svět písmen', 48, 500, RIGHT - LEFT)
d.text((LEFT, 60), 'SwypeKids', font=title, fill='#3B2A1A')
d.text((LEFT + 4, 190), 'Objevuj svět písmen', font=sub, fill='#5A3F22')

out.parent.mkdir(parents=True, exist_ok=True)
img.save(out)
print(out)
