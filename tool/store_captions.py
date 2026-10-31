#!/usr/bin/env python3
"""App Store snímky s titulkem pro všech 13 lokalizací záznamu.

    tool/store_screenshots.sh build/store/raw cs en de es fr it pt uk ru vi
    python3 tool/store_captions.py [build/store/raw] [build/store/fastlane/screenshots]

Z holých snímků `<raw>/<jazyk>/appstore-{iphone,ipad}-NN-<scéna>.png`
složí pro každou lokalizaci App Store (`cs`, `en-US`, … — složky, jak je
čte `fastlane deliver`) tři sady: iPhone 6,9" (1320×2868), iPhone 6,3"
(1206×2622) a iPad 13" (2064×2752). Nahoře titulek v jazyce záznamu, pod
ním snímek se zaoblenými rohy na barvě ikony. PNG bez alfa kanálu.

uk, ru a vi nemají vlastní pack: rozhraní je v jazyce rodiny, čte se
česky (snímky z `<raw>/uk` atd.) — titulky to říkají.
"""
import glob
import os
import sys
from pathlib import Path

from PIL import Image, ImageDraw, ImageFilter, ImageFont

ROOT = Path(__file__).resolve().parent.parent
RAW = Path(sys.argv[1] if len(sys.argv) > 1 else ROOT / 'build/store/raw')
OUT = Path(sys.argv[2] if len(sys.argv) > 2
           else ROOT / 'build/store/fastlane/screenshots')

FONTS = sorted(glob.glob(os.path.expanduser(
    '~/.pub-cache/git/CuteKidFonts-*/fonts/')))
BG_TOP, BG_BOTTOM = (255, 214, 102), (247, 169, 59)  # barva ikony → kopec
INK = (59, 42, 26)

# Lokalizace App Store → (složka holých snímků, titulky).
LOCALES = {
    'cs': 'cs', 'en-US': 'en', 'en-GB': 'en', 'de-DE': 'de',
    'fr-FR': 'fr', 'fr-CA': 'fr', 'es-ES': 'es', 'es-MX': 'es',
    'pt-BR': 'pt', 'it': 'it', 'uk': 'uk', 'ru': 'ru', 'vi': 'vi',
}

# Scény v pořadí snímků (NN v názvu) — stejné jako `store` v testu.
SCENES = ['01-mapa', '02-hra', '04-rymy', '05-nalepka', '06-zverinec',
          '07-svet-zviratka', '09-skladej-vetu', '10-ma-knizka',
          '11-pruvodci', '12-rodice']

# Titulky: krátké, pro rodiče, dva řádky nejvýš. de/es/fr/it/pt jsou
# strojové, uk/ru/vi navíc ověřit rodilým mluvčím (docs/STORE.md).
CAPTIONS = {
    'cs': ['Čtení krok za krokem', 'Slova skládá tahem prstu',
           'Rýmy, poslech a hádanky', 'Za každou jednotku nálepka',
           'Vlastní Zvěřinec zvířátek', 'Nakrm zvířátko slovy',
           'První věty z naučených slov', 'Má knížka čte věty nahlas',
           'Čtyři průvodci na výběr', 'Rodič vidí, co dítěti nejde'],
    'en': ['Learn to read, step by step', 'Swipe letters to build words',
           'Rhymes, listening and puzzles', 'A sticker for every unit',
           'Your own animal Zoo', 'Feed your pet with words',
           'First sentences from new words', 'My Book reads them aloud',
           'Four friendly guides', 'Parents see what needs practice'],
    'de': ['Lesen lernen, Schritt für Schritt', 'Wörter mit dem Finger wischen',
           'Reime, Hören und Rätsel', 'Für jede Einheit ein Sticker',
           'Dein eigener Tier-Zoo', 'Füttere dein Tier mit Wörtern',
           'Erste Sätze aus neuen Wörtern', '„Mein Buch“ liest sie vor',
           'Vier Begleiter zur Wahl', 'Eltern sehen, was noch schwerfällt'],
    'es': ['Aprende a leer paso a paso', 'Desliza el dedo y forma palabras',
           'Rimas, escucha y adivinanzas', 'Una pegatina por cada unidad',
           'Tu propio Zoo de animales', 'Dale de comer con palabras',
           'Primeras frases con palabras nuevas', '«Mi libro» las lee en voz alta',
           'Cuatro guías para elegir', 'Los padres ven qué letra cuesta'],
    'fr': ['Apprendre à lire pas à pas', 'Glisse le doigt, forme des mots',
           'Rimes, écoute et devinettes', 'Un autocollant par unité',
           'Ton propre Zoo', 'Nourris ton animal avec des mots',
           'Premières phrases avec tes mots', '« Mon livre » les lit à voix haute',
           'Quatre guides au choix', 'Les parents voient ce qui coince'],
    'it': ['Impara a leggere passo dopo passo', 'Scorri il dito e componi parole',
           'Rime, ascolto e indovinelli', 'Un adesivo per ogni unità',
           'Il tuo Zoo di animali', 'Nutri il tuo animale con le parole',
           'Prime frasi con le parole nuove', '«Il mio libro» le legge ad alta voce',
           'Quattro guide tra cui scegliere', 'I genitori vedono cosa è difficile'],
    'pt': ['Aprender a ler passo a passo', 'Deslize o dedo e forme palavras',
           'Rimas, escuta e adivinhas', 'Uma figurinha a cada unidade',
           'Seu próprio Zoológico', 'Alimente o bichinho com palavras',
           'Primeiras frases com palavras novas', '«Meu livro» lê em voz alta',
           'Quatro guias para escolher', 'Os pais veem qual letra está difícil'],
    'uk': ['Читання чеською крок за кроком', 'Слова — рухом пальця',
           'Рими, слухання й загадки', 'Наліпка за кожен розділ',
           'Власний зоопарк тваринок', 'Нагодуй тваринку словами',
           'Перші речення з нових слів', '«Моя книжка» читає вголос',
           'Чотири провідники на вибір', 'Меню й поради батькам українською'],
    'ru': ['Чтение на чешском шаг за шагом', 'Слова — движением пальца',
           'Рифмы, слушание и загадки', 'Наклейка за каждый раздел',
           'Собственный зоопарк зверят', 'Покорми зверька словами',
           'Первые предложения из новых слов', '«Моя книжка» читает вслух',
           'Четыре проводника на выбор', 'Меню и советы родителям по-русски'],
    'vi': ['Học đọc tiếng Séc từng bước', 'Vuốt ngón tay để ghép chữ',
           'Vần, nghe và đố vui', 'Mỗi bài học một nhãn dán',
           'Vườn thú của riêng bé', 'Cho thú cưng ăn bằng từ',
           'Câu đầu tiên từ những từ mới', '"Sách của em" đọc to',
           'Bốn bạn dẫn đường', 'Menu và lời khuyên bằng tiếng Việt'],
}

# (výstupní rozměr, holá sada, výška pásu s titulkem, název souboru)
DEVICES = [
    ((1320, 2868), 'iphone', 560, 'iphone69'),
    ((1206, 2622), 'iphone', 512, 'iphone63'),
    ((2064, 2752), 'ipad', 470, 'ipad13'),
]


def font_for(lang, size):
    """Jako appka: DynaPuff, azbuka Nunito, vietnamština Baloo 2."""
    name = {'uk': 'Nunito-Variable.ttf', 'ru': 'Nunito-Variable.ttf',
            'vi': 'Baloo2-Variable.ttf'}.get(lang, 'DynaPuff-Variable.ttf')
    for d in reversed(FONTS):
        if os.path.exists(d + name):
            f = ImageFont.truetype(d + name, size)
            try:
                f.set_variation_by_axes([800 if 'Nunito' in name else 700])
            except Exception:
                pass
            return f
    raise SystemExit('Chybí písma cute_kid_fonts (flutter pub get).')


def wrap(draw, text, lang, width, size):
    """Největší písmo, při kterém se titulek vejde na dva řádky."""
    while size > 24:
        f = font_for(lang, size)
        words, lines, line = text.split(), [], ''
        for w in words:
            test = f'{line} {w}'.strip()
            if draw.textlength(test, font=f) <= width:
                line = test
            else:
                lines.append(line)
                line = w
        lines.append(line)
        if len(lines) <= 2 and all(draw.textlength(l, font=f) <= width for l in lines):
            return f, lines
        size -= 4
    return font_for(lang, size), [text]


def background(w, h):
    bg = Image.new('RGB', (w, h))
    d = ImageDraw.Draw(bg)
    for y in range(h):
        t = y / h
        d.line([(0, y), (w, y)], fill=tuple(
            round(a + (b - a) * t) for a, b in zip(BG_TOP, BG_BOTTOM)))
    return bg


def compose(shot, caption, lang, size, band):
    w, h = size
    canvas = background(w, h)
    draw = ImageDraw.Draw(canvas)

    # Titulek: na střed pásu nahoře.
    f, lines = wrap(draw, caption, lang, w * 0.86, round(w * 0.085))
    line_h = f.size * 1.18
    y = (band - line_h * len(lines)) / 2 + f.size * 0.1
    for line in lines:
        draw.text((w / 2, y + line_h / 2), line, font=f, fill=INK, anchor='mm')
        y += line_h

    # Snímek: od pásu dolů s okrajem, zaoblené rohy a stín.
    margin = round(h * 0.03)
    sh = h - band - margin
    sw = round(shot.width * sh / shot.height)
    if sw > w * 0.9:  # iPad: snímek je širší, omezit šířkou
        sw = round(w * 0.9)
        sh = round(shot.height * sw / shot.width)
    shot = shot.convert('RGB').resize((sw, sh), Image.LANCZOS)
    radius = round(sw * 0.06)
    mask = Image.new('L', (sw, sh), 0)
    ImageDraw.Draw(mask).rounded_rectangle([0, 0, sw - 1, sh - 1], radius, fill=255)
    x, top = (w - sw) // 2, band
    shadow = Image.new('L', (w, h), 0)
    shadow.paste(mask, (x, top + round(margin * 0.3)))
    shadow = shadow.filter(ImageFilter.GaussianBlur(round(w * 0.012)))
    canvas.paste((150, 90, 20), (0, 0), shadow.point(lambda v: v * 0.45))
    canvas.paste(shot, (x, top), mask)
    return canvas


def main():
    done = 0
    for locale, lang in LOCALES.items():
        src = RAW / lang
        missing = [f'appstore-{kind}-{scene}.png' for scene in SCENES
                   for kind in ('iphone', 'ipad')
                   if not (src / f'appstore-{kind}-{scene}.png').exists()]
        if missing:
            print(f'{locale}: v {src} chybí {len(missing)} snímků — přeskočeno')
            continue
        out = OUT / locale
        out.mkdir(parents=True, exist_ok=True)
        for old in out.glob('*.png'):
            old.unlink()  # přečíslování nesmí nechat staré snímky
        for n, (scene, caption) in enumerate(zip(SCENES, CAPTIONS[lang]), 1):
            for size, kind, band, name in DEVICES:
                raw = src / f'appstore-{kind}-{scene}.png'
                img = compose(Image.open(raw), caption, lang, size, band)
                img.save(out / f'{n:02d}_{name}_{scene[3:]}.png')
                done += 1
        print(f'{locale}: {len(SCENES)} scén × {len(DEVICES)} zařízení')
    print(f'{done} snímků → {OUT}')


if __name__ == '__main__':
    main()
