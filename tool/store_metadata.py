#!/usr/bin/env python3
"""Texty App Store z docs/STORE.md pro `fastlane metadata`.

    python3 tool/store_metadata.py [build/store/fastlane/metadata]

Z §5 (sekce `### Jazyk (lokalizace, …)`) vezme popis, promo text a
„Co je nového“, z §6 klíčová slova, z §1 URL podpory a marketingu. Pro
každou ze 13 lokalizací zapíše `<lokalizace>/*.txt`, jak je čte
`fastlane deliver`. Název a podtitul nezapisuje (App Information se mění
ručně). Kontroluje limity Applu; při chybě nic nezapíše.
"""
import re
import shutil
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
OUT = Path(sys.argv[1] if len(sys.argv) > 1
           else ROOT / 'build/store/fastlane/metadata')
LOCALES = ['cs', 'en-US', 'en-GB', 'de-DE', 'fr-FR', 'fr-CA', 'es-ES',
           'es-MX', 'pt-BR', 'it', 'uk', 'ru', 'vi']
LIMITS = {'description': 4000, 'keywords': 100, 'promotional_text': 170,
          'release_notes': 4000}


def field(body, name):
    m = re.search(rf'^\*\*{name}[^*]*:\*\* (.+)$', body, re.M)
    return m and m[1].strip()


def main():
    text = (ROOT / 'docs/STORE.md').read_text()
    texts = text.split('\n## 5. ', 1)[1].split('\n## 6. ', 1)[0]
    keywords = dict(re.findall(r'^\| (\S+) \| \d+ \| `([^`]*)` \|$', text, re.M))
    support = re.search(r'^\| Podpora \(URL\) \| `([^`]+)`', text, re.M)[1]
    marketing = re.search(r'^\| Marketing \(URL[^|]*\| `([^`]+)`', text, re.M)[1]

    meta = {}
    for head, body in re.findall(r'^### [^(\n]*\(([^)\n]+)\)\n(.*?)(?=^### |\Z)',
                                 texts, re.M | re.S):
        locs = re.findall(r'\b(?:[a-z]{2}-[A-Z]{2}|cs|it|uk|ru|vi)\b', head)
        desc = re.search(r'\*\*Popis:\*\*\n\n```\n(.*?)\n```', body, re.S)[1]
        for loc in locs:
            meta[loc] = {
                'description': desc.strip(),
                'promotional_text': field(body, 'Promo text'),
                'release_notes': field(body, 'Co je nového'),
                'keywords': keywords.get(loc),
                'support_url': support,
                'marketing_url': marketing,
            }

    errors = []
    for loc in LOCALES:
        if loc not in meta:
            errors.append(f'{loc}: chybí sekce v §5')
            continue
        for key, value in meta[loc].items():
            if not value:
                errors.append(f'{loc}: chybí {key}')
            elif len(value) > LIMITS.get(key, 10 ** 6):
                errors.append(f'{loc}: {key} má {len(value)} > {LIMITS[key]}')
    if errors:
        raise SystemExit('\n'.join(errors))

    shutil.rmtree(OUT, ignore_errors=True)
    for loc in LOCALES:
        d = OUT / loc
        d.mkdir(parents=True)
        for key, value in meta[loc].items():
            (d / f'{key}.txt').write_text(value + '\n')
    print(f'{len(LOCALES)} lokalizací → {OUT}')


if __name__ == '__main__':
    main()
