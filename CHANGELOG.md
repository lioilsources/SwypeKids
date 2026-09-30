# Changelog

## [30/09/2026] — v2.3.1
- Poznámky pro rodiče u každé cs/en lekce (dlouhý stisk lekce na mapě)
- Nové typy kol: 🧩 doplňovačka (slovo s dírou) a 🖼️ jen obrázek
- Síla slov, 🔁 opakovací kola s nejslabším slovem a Procvičování na mapě

## [30/09/2026] — v2.3.0 „Batoh slov"
- Slova swypnutá ve hře padají do batohu (🎒 na mapě) a odemykají dlaždice v builderu vět
- Builder: nenaučená slova jako siluetka „?“, nová slova 24 h se štítkem „NOVÉ“
- cs: MÁMA, TÁTA, BÁBA, PES, KOLO, LES, NOS; en: MUM, DAD, DOG, CAT, PIG, CUP, CAP, POT, COT
- Content pack schéma v2 (`sentence`, `vocab`, `parentNote`)

## [30/09/2026] — v2.2.1
- Linux release: ALSA závislost pro zvuky, ruční spuštění workflow
- Obsah jen z JSON packů (smazané Dart lekce) — příprava na v2.3

## [30/09/2026] — v2.2.0 „Živá klávesnice"
- Zvuky: xylofonový tón pro každé písmeno při swype (pentatonika), fanfára, měkká chyba, cinknutí hvězd, nálepka, tap (flutter_soloud; dočasné syntetizované sfx)
- Přepínač zvuků v menu
- Klávesy nadskočí při přejetí, stopa prstu se světluškami
- Hvězdy padají na kartu, třetí hvězda spustí konfety
- Nálepka po dokončení jednotky odletí na své místo na mapě (Hero)
- Pozadí mapy podle denní doby (ráno / den / večer / noc) — základ WorldClockService
- Respektuje systémovou redukci pohybu
- Widget test GameScreen, testy WorldClockService a AudioService

## [15/03/2026]
- Real swype behaviour

## [12/03/2026]
- Focus success letters
- Swype path visualization
- Initial commit
