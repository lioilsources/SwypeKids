# SwypeKids — monetizace: rozhodnutí (v3.1)

Stav: návrh k potvrzení (říjen 2026). Roadmapa §3 P7 a §7 požaduje
rozhodnutí nejpozději ve v3.1; implementace je plánovaná na v4.0.

## Zásady, které se nemění

1. **Dítě nikdy nevidí nákup.** Žádné IAP, „gemy", energie ani obchod
   v dětské části. Vše placené je za rodičovskou bránou.
2. **Žádné reklamy, žádný tracking** (viz `docs/PRIVACY.md`). Platí i pro
   případnou bezplatnou verzi.
3. **Nic, co se dítě naučilo, nezmizí.** Postup, nálepky a knížka zůstávají
   bez ohledu na platbu.
4. **Offline.** Odemčení se ověřuje obchodem (App Store / Google Play
   receipt), ne vlastním serverem.

## Doporučení

**Jednorázová koupě „SwypeKids — všechny jazyky", rodinná.**

| | |
|---|---|
| Zdarma | První jazyk (podle zařízení) kompletní: celé pásmo A, builder vět, Zvěřinec, odznaky, rodičovský koutek. Žádný časový limit zkušební verze. |
| Placené (jednorázově) | Dalších 8 jazyků + budoucí pásma B–C a stahovatelné packy pro všechny jazyky. |
| Cena | Nižší střední pásmo dětských vzdělávacích appek: orientačně 149–249 Kč / 6–10 €/$ (potvrdit podle konkurence v době vydání). |
| Rodina | Apple Family Sharing a Google Play Family Library zapnuté — jedna koupě pro sourozence (profily už fungují). |
| Školy | Apple School Manager / Google Play for Education: stejná aplikace, hromadný nákup, bez zvláštní verze. |

Proč ne předplatné: rodiče dětských appek ho špatně snášejí, obsah je
jednorázový (dítě se naučí číst a odejde) a předplatné by tlačilo na
„engagement" mechaniky, které roadmapa výslovně odmítá (streaky, tlak).

Proč ne reklamy / freemium s měnou: porušuje Kids kategorii a princip
„dítě nikdy nevidí nákup".

## Co to znamená pro kód (v4.0)

- `PackService`: packy mimo první jazyk označené `locked` dokud není
  entitlement; mapa zamčený jazyk nenabízí dítěti (LanguagePicker ukáže
  jen odemčené; další jazyky až z rodičovského koutku).
- Nákup a obnovení nákupů **jen v rodičovském koutku** (za bránou), přes
  `in_app_purchase` (StoreKit 2 / Play Billing), bez vlastního backendu.
- Entitlement uložený lokálně (`sk.settings.entitlement`), při startu
  ověřený proti obchodu, offline fallback = poslední známý stav.
- Testy: zamčený jazyk není v dětském UI; obnovení nákupu; offline start.

## Otázky k potvrzení

- [ ] Souhlas s modelem „první jazyk zdarma, zbytek jednorázově".
- [ ] Cena a zda nabídnout i „jen jeden další jazyk" (doporučení: ne,
  zjednodušit na jeden produkt).
- [ ] Zda nechat zdarma i angličtinu jako druhý jazyk (argument: nejčastější
  druhý jazyk rodin v ČR; proti: snižuje důvod ke koupi).
