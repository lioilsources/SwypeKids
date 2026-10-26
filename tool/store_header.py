#!/usr/bin/env python3
"""Obrázky pro App Store „Header and Search Results“ z průvodců a nálepek.

    python3 tool/store_header.py [výstupní složka]

  header-3840x1646.png   hlavička stránky aplikace (21:9)
  search-3840x2560.png   obrázek ve výsledcích hledání (3:2)

Bez textu, takže jeden obrázek slouží všem jazykům záznamu. Apple zveřejňuje
rozměry, ne ořez na jednotlivých zařízeních: čtyři průvodci stojí uprostřed
(u hlavičky v pásu 1646×661, který šablona Applu značí jako bezpečný), stěna
nálepek kolem se smí oříznout kdekoli. Před odesláním zkontrolovat v App
Store Connect přes Preview. PNG je bez alfa kanálu (jinak ho Apple odmítne).
"""
import random
import sys
from pathlib import Path

from PIL import Image, ImageDraw, ImageFilter

ROOT = Path(__file__).resolve().parent.parent
OUT = Path(sys.argv[1] if len(sys.argv) > 1 else ROOT / 'build/store')

BG = '#FFC650'  # barva ikony
HILL = '#F7A93B'
GUIDES = ('giraffe', 'panda', 'capybara', 'cheetah')


def stickers():
    """Základní nálepky (bez póz -eat/-happy/-sleep), v pevném pořadí."""
    files = sorted(p for p in (ROOT / 'assets/emoji').glob('*.webp')
                   if not p.stem.endswith(('-eat', '-happy', '-sleep')))
    random.Random(7).shuffle(files)
    return files


def place(canvas, im, centre, angle=0):
    im = im.rotate(angle, resample=Image.BICUBIC, expand=True)
    x = round(centre[0] - im.width / 2)
    y = round(centre[1] - im.height / 2)
    blur = max(4, im.width // 40)
    shadow = Image.new('RGBA', canvas.size, (0, 0, 0, 0))
    shadow.paste((120, 70, 10, 70), (x, y + blur), im.getchannel('A'))
    canvas.alpha_composite(shadow.filter(ImageFilter.GaussianBlur(blur)))
    canvas.alpha_composite(im, (x, y))


def render(w, h, guide, cell, name):
    canvas = Image.new('RGBA', (w, h), BG)
    ImageDraw.Draw(canvas).ellipse(
        (-w * 0.2, h * 0.62, w * 1.2, h * 1.9), fill=HILL)

    # Průvodci vedle sebe uprostřed; pás kolem nich zůstane bez nálepek.
    gap = round(guide * 0.08)
    row = len(GUIDES) * guide + (len(GUIDES) - 1) * gap
    left, top = (w - row) // 2, (h - guide) // 2
    clear = (left - cell * 0.45, top - cell * 0.4,
             left + row + cell * 0.45, top + guide + cell * 0.4)

    rnd = random.Random(11)
    pool = stickers()
    size = round(cell * 0.74)
    n = 0
    for r in range(-1, h // cell + 2):
        for c in range(-1, w // cell + 2):
            # Liché řady o půl buňky vedle, ať to není mříž.
            x = c * cell + (cell // 2 if r % 2 else 0) + rnd.randint(-18, 18)
            y = r * cell + cell // 2 + rnd.randint(-18, 18)
            if clear[0] < x < clear[2] and clear[1] < y < clear[3]:
                continue
            im = Image.open(pool[n % len(pool)]).convert('RGBA')
            n += 1
            im.thumbnail((size, size), Image.LANCZOS)
            place(canvas, im, (x, y), rnd.uniform(-12, 12))

    for i, g in enumerate(GUIDES):
        im = Image.open(ROOT / f'assets/characters/{g}/wave.png').convert('RGBA')
        im = im.resize((guide, guide), Image.LANCZOS)
        place(canvas, im, (left + i * (guide + gap) + guide / 2, h / 2))

    OUT.mkdir(parents=True, exist_ok=True)
    path = OUT / name
    canvas.convert('RGB').save(path)
    print(path)


render(3840, 1646, guide=380, cell=330, name='header-3840x1646.png')
render(3840, 2560, guide=640, cell=400, name='search-3840x2560.png')
