#!/usr/bin/env python3
"""Google Play screenshot sets from the real-app captures.

    python3 tool/play_screenshots.py [--phone DIR] [--tablet DIR] [--out DIR]

Play caps screenshots at a 2:1 aspect. The phone captures are 1170×2532
(2.16:1), and the App Store sets built from them are 1320×2868 (2.17:1) — Play
rejects both. Cropping to 9:16 would cut off the top bar and the keyboard, so
the phone shots are *framed*: centred at full height on the icon's yellow.
The desktop captures are 2560×1600 (16:10), exactly the tablet ratio, so they
are only scaled.

Sources default to the olin.now raw screenshots (committed there, written by
`tool/store_screenshots.sh`); point --phone / --tablet at
`build/store/screenshots` filtered copies to use a fresh run instead.

Output (git-ignored, regenerate any time):
  build/store/play/phone/NN-<name>.png   1080×1920, RGB, max 8
  build/store/play/tablet/NN-<name>.png  1920×1200, RGB
"""
import pathlib
import sys

from PIL import Image, ImageDraw, ImageFilter

ROOT = pathlib.Path(__file__).resolve().parent.parent
RAW = ROOT.parent / 'ol1n.now/apps/swypekids/screenshots/raw'

# Play takes 8 phone shots at most. Order = STORE.md §2 (parent corner and the
# onboarding/Japanese/eye-world extras are left out to stay within 8).
PHONE = ['01-mapa', '02-hra', '04-rymy', '05-nalepka', '06-zverinec',
         '07-svet-zviratka', '09-skladej-vetu', '10-ma-knizka']
PHONE_SIZE = (1080, 1920)
TABLET_SIZE = (1920, 1200)
FRAME_BG = (255, 198, 80)  # #FFC650, the icon background


def flatten(im):
    if im.mode != 'RGBA':
        return im.convert('RGB')
    bg = Image.new('RGB', im.size, (0, 0, 0))
    bg.paste(im, (0, 0), im)
    return bg


def cover(im, size):
    tw, th = size
    s = max(tw / im.width, th / im.height)
    im = im.resize((round(im.width * s), round(im.height * s)), Image.LANCZOS)
    l, t = (im.width - tw) // 2, (im.height - th) // 2
    return im.crop((l, t, l + tw, t + th))


def frame(im, size):
    tw, th = size
    margin = round(th * 0.05)
    s = (th - 2 * margin) / im.height
    shot = im.resize((round(im.width * s), round(im.height * s)), Image.LANCZOS)
    mask = Image.new('L', shot.size, 0)
    ImageDraw.Draw(mask).rounded_rectangle(
        [0, 0, shot.width - 1, shot.height - 1],
        radius=round(shot.width * 0.06), fill=255)
    canvas = Image.new('RGB', size, FRAME_BG)
    pos = ((tw - shot.width) // 2, (th - shot.height) // 2)
    shadow = Image.new('RGBA', size, (0, 0, 0, 0))
    shadow.paste((59, 42, 26, 90), (pos[0], pos[1] + round(margin * 0.3)), mask)
    shadow = shadow.filter(ImageFilter.GaussianBlur(round(margin * 0.45)))
    canvas.paste(shadow, (0, 0), shadow)
    canvas.paste(shot, pos, mask)
    return canvas


def find(src, stem):
    for name in (f'{stem}.png', f'phone-{stem}.png', f'desktop-{stem}.png'):
        if (src / name).exists():
            return src / name
    return None


def run(src, stems, out, size, fit):
    out.mkdir(parents=True, exist_ok=True)
    for old in out.glob('*.png'):
        old.unlink()
    n = 0
    for stem in stems:
        path = find(src, stem)
        if path is None:
            print(f'  missing {stem} in {src}', file=sys.stderr)
            continue
        fit(flatten(Image.open(path)), size).save(out / f'{stem}.png', 'PNG')
        n += 1
        print(f'{out.name:<7} {size[0]}x{size[1]}  {stem}.png')
    return n


def main():
    a = sys.argv[1:]
    arg = lambda k, d: pathlib.Path(a[a.index(k) + 1]) if k in a else d
    phone_src = arg('--phone', RAW / 'mobile/ios')
    tablet_src = arg('--tablet', RAW / 'desktop/macos')
    out = arg('--out', ROOT / 'build/store/play')

    run(phone_src, PHONE, out / 'phone', PHONE_SIZE, frame)
    tablet = sorted(p.stem.removeprefix('desktop-')
                    for p in tablet_src.glob('*.png'))
    if run(tablet_src, tablet, out / 'tablet', TABLET_SIZE, cover) < 4:
        print('warning: Play wants at least 4 tablet shots', file=sys.stderr)


if __name__ == '__main__':
    main()
