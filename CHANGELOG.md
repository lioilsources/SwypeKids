# Changelog

## [02/10/2026] — v2.7.1
- Pandička: první postava průvodce (pracovní verze) místo emoji — mává, jásá, spí

## [02/10/2026] — v2.7.0
- Pásmo B pro němčinu, španělštinu, italštinu, francouzštinu a portugalštinu (+21 lekcí v každém jazyce)

## [01/10/2026] — v2.6.2
- Oprava: mapa zůstávala na 🎹 (načítání packu čekalo samo na sebe) — skutečná příčina chyby z 2.6.0/2.6.1
- Když se mapa nenačte, ukáže se „Zkusit znovu“ s popisem chyby místo prázdné obrazovky

## [01/10/2026] — v2.6.1
- Oprava: na iOS zůstávala mapa na 🎹 (pack nad 50 KB se nenačetl) — packy se teď dekódují bez izolátu
- Sezónní tajné nálepky (jaro 🐣, léto 🍉, podzim 🎃, zima ⛸️) schované na mapě jen v daném období; polička ve Zvěřinci

## [01/10/2026] — v2.6.0 „Obsah"
- Nové typy kol: lov hlásky (ťuknutí na klávesu), spojování slabik („MÁ + MA“), rým (výběr ze tří obrázků)
- Čeština: pásmo B — jednotky 13–17 (hlásky a rýmy, H+C, Y+G, F a delší slova, slova do vět), celkem 91 lekcí
- Angličtina: jednotky 11–15 (sounds & rhymes, J+V+W, blends, sh/ch/th, magic e), celkem 90 lekcí
- Týdenní výprava za opakováním 🧭 na mapě (od 10 naučených slov) a odznak Výpravník
- Průvodce žvatlá, poznámku pro rodiče lze nechat přečíst nahlas

## [01/10/2026] — v2.5.0 „Pro rodiče"
- Menu, hra, oslavy, builder, knížka, Zvěřinec, odznaky i rodičovský koutek ve všech 9 jazycích (jazyk UI = jazyk packu)
- Písmo pro dyslektiky (OpenDyslexic) jako volba v rodičovském koutku
- Rodičovský koutek: přepínače zvuků, hudby, období, levák, časový limit, profily

## [01/10/2026] — v2.4.2
- Profily sourozenců: každé dítě má avatara, jméno a vlastní postup; přepínání v menu
- Zvěřinec jako ostrov: biotopy, zvířátko řekne své jméno nahlas; tajné nálepky ✨ schované na mapě
- Průvodce Pipi: mává, jásá, „ups“, v noci spí; na mapě pozdraví dítě jménem
- Rodičovský koutek za bránou (příklad místo PINu): přehled, mřížka písmen, doporučení pro doma, metoda, nastavení
- Časový limit hraní za den (po limitu Pipi spí, prodloužení jen v koutku), zrcadlená klávesnice pro leváky
- Zásady ochrany soukromí (docs/PRIVACY.md)

## [01/10/2026] — v2.4.1
- Odznaky: 14 achievementů bez streaku (První tah, Bez chyby, Objevitel, Sběratel, Noční sova, Ranní ptáče, Čtyři období, Slovíčkář, Básník, Posluchač, Vytrvalec…), polička ve Zvěřinci
- Onboarding bez čtení: průvodce pozdraví hlasem, jazyk podle vlajky, výběr zvířátka, jméno dítěte

## [01/10/2026] — v2.4.0 „Svět"
- Mapa je svět: každá jednotka má biotop (louka, les, rybník, město, hory, pláž…), zamčené jsou v mlze, odemčení mlhu rozplyne
- Obloha podle denní doby a ročního období (kalendář, nebo ruční volba rodiče v menu), měsíc a hvězdy v noci, mraky s parallaxem
- Částice: květy na jaře, světlušky v letní večer, listí na podzim, sníh v zimě; v noci zvířátka spí 💤
- Ambientní zvuky podle biotopu a denní doby (ptáci, cvrčci, voda) a první hudební smyčka, v noci tišší; vypínače v menu
- Hra na šířku: karta vlevo, klávesnice vpravo (tablet, otočený telefon)
- Respektuje redukci pohybu

## [01/10/2026] — v2.3.2
- Slovo hned do věty: po novém slově v batohu se otevře mini builder s tím slovem
- 📖 Má knížka: ukládání složených vět, čtení nahlas; 🎹 vzít slovo z builderu do hry
- Pásmo A hotové pro všech 9 jazyků (cs 54, en 51, de 58, es 59, it 59, fr 57, pt 50, zh 55, ja 41 lekcí)
- Poznámky pro rodiče u každé lekce ve všech jazycích

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
