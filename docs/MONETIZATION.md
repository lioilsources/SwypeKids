# SwypeKids — plán monetizace (v2, říjen 2026)

Stav: **rozhodnuto** (7. 10. 2026, §8). Nahrazuje v3.1 návrh „jedna koupě
všech jazyků". **Fáze 1 (entitlementy bez obchodu) je hotová a vypnutá**
(`StoreConfig.enabled = false`, §7, §8.7).
Implementace je v roadmapě ve v4.0; tento dokument říká **co** prodávat,
**kde** je hranice zdarma/placené, **za kolik**, a **v jakém pořadí** to
stavět, aby první placený obsah vyšel spolu s obsahem, který za to stojí.

## 0. Odpověď na otázku jedním odstavcem

Ano: **funkční a užitečná appka zdarma, placený obsah od určité kapitoly,
balíček za ~1 $ (29 Kč)** je správný základ. Dvě úpravy: (1) hranici
nedávat „od 13. jednotky" uprostřed dnešního obsahu, ale na konec
dnešního **Ostrova písmenek** (pásmo A) — všechno, co dnes je, zůstane
zdarma, platí se za **nové ostrovy**; (2) k balíčkům za 1 $ přidat jeden
**balíček „Vše napořád"** (~199 Kč / 7,99 $), protože samotné dolarové
balíčky mají strop výnosu, a **školní verzi** jako samostatnou placenou
appku (školy nemohou hromadně kupovat IAP). Zbytek dokumentu je zdůvodnění
a plán.

## 1. Zásady, které se nemění

1. **Dítě nikdy nevidí nákup.** Žádná cena, tlačítko „koupit", měna,
   energie ani obchod v dětské části. Vše placené je za rodičovskou bránou
   (`ParentGate`, otázka a × b).
2. **Žádné reklamy, žádný tracking** (`docs/PRIVACY.md`). Nákup se
   ověřuje obchodem (StoreKit 2 / Play Billing), žádný vlastní server.
3. **Nic, co dítě mělo, nezmizí.** Postup, nálepky, knížka, a také obsah,
   který dítě už hrálo před zavedením plateb (grandfathering, §6).
4. **Žádný tlak na dítě.** Zamčený obsah se dítěti ukáže nejvýš jako
   „další ostrov v mlze" bez jakékoli akce; cesta k nákupu vede jen přes
   rodičovský koutek.
5. **Offline.** Odemčení je uložené lokálně, obchod se ověřuje při startu,
   když je síť; bez sítě platí poslední známý stav.

## 2. Co je zdarma a kde je hranice

**Zdarma = jeden celý výsledek:** dítě se naučí všechna písmena a přečte
první slova. To je dnešní obsah: Ostrov písmenek (pásmo A, cs 17 jednotek /
91 lekcí), builder vět, Zvěřinec včetně světa zvířátka, průvodci (všichni 4),
odznaky, Má knížka, rodičovský koutek, profily sourozenců. Bez časového
limitu, bez „zkušební verze".

Zdarma je **jazyk zařízení** (resp. jazyk zvolený v onboardingu při prvním
startu). Český tablet má zdarma češtinu, německý němčinu. Angličtina jako
druhý jazyk české rodiny je placená — je to nejčastější a nejsilnější důvod
ke koupi; nechat ji zdarma by zbylé balíčky skoro vyprázdnilo.

**Placené = další ostrovy.** Hranice je přirozená: dítě dohraje poslední
jednotku ostrova (dnes `WinScreen`), na mapě se za vodou objeví další
ostrov v mlze. Dítě na něj nemůže kliknout; rodič ho otevře v koutku.

Proč ne „od 13. jednotky" v dnešním obsahu: (a) existující děti by měly
zamčené to, co včera hrály; (b) 5 jednotek pásma B je na balíček málo a
pásmo A by bylo useknuté před „Hlásky a rýmy" a „Slova do vět", které ho
uzavírají; (c) placené by tak vyšlo dřív než obsah, který platbu
ospravedlní. Hranice „nové ostrovy" znamená, že **monetizace vychází
současně s pásmem B** (§7, fáze 3) — to je záměr, ne zpoždění.

## 3. Katalog: co prodávat

Všechno jsou **non-consumable** položky (jednorázové, obnovitelné,
s Family Sharing na iOS). Ceny v nejnižší úrovni obchodu (29 Kč / 0,99 $ /
0,99 €) kromě bundlu. Produktová ID jsou stabilní řetězce, katalog je JSON
v assets (§5), aby šel přidat balíček bez změny kódu.

| Typ | ID | Co odemkne | Cena | Poznámka |
|---|---|---|---|---|
| **Ostrov** (kapitola) | `island.<lang>.b` „Ostrov slov", `island.<lang>.c` „Ostrov vět" | Pásmo B / C daného jazyka (15–20 jednotek, ~80–100 lekcí, nálepky, obyvatelé světa zvířátka, nové předměty do builderu) | 29 Kč | Hlavní produkt. Vzniká s obsahem. |
| **Jazyk** | `lang.<xx>` | Ostrov písmenek (pásmo A) dalšího jazyka | 29 Kč | Jazyk zařízení je vždy zdarma. Ostrovy B/C toho jazyka jsou samostatné položky. |
| **Tematický balíček** | `theme.<name>` např. `theme.zima`, `theme.dinosauri`, `theme.vesmir`, `theme.na-statku-2` — **jedna položka pro všechny jazyky** (§8.9) | 3–5 nových jednotek s vlastní slovní zásobou + nálepky + obyvatelé + sezónní tajná nálepka, v každém jazyce, který balíček má | 29 Kč | Opakovatelný „1 $ produkt": JSON + nálepky z pipeline (`tool/emoji_art`, SPARK) + korektura vět (`docs/SENTENCES_REVIEW.md`). Může přijít s novým průvodcem („kamarád z ostrova"), ale průvodce není nikdy samostatně prodejný. |
| **Hlas průvodce** | `voice.<lang>` | Předem syntetizovaný hlas místo TTS za běhu (fráze z manifestu, jména zvířátek, věty) | 29 Kč | Do katalogu až po ověření licence (§10); asset offline, stejný hlas ve všech jazycích. |
| **Rodičovský balíček** | `parent.plus` | Pracovní listy PDF z nejslabších písmen dítěte, tisk Mé knížky jako knížky, týdenní přehled PDF, export/import postupu | 29 Kč | Jediný produkt pro rodiče, ne pro dítě. Užitečný i jako argument pro školy. |
| **Vše napořád** | `all.forever` | Všechny současné **i budoucí** položky výše pro všechny jazyky | 199 Kč / 7,99 $ | Rodinná volba; obchod to nabízí hned vedle balíčků. Apple i Google povolují „včetně budoucího obsahu" u non-consumable. |

Co **neprodávat**, i když by se to prodávalo dobře:

- **Průvodce, pózy, nálepky, biomy jako kosmetika.** Je to přesně to, co
  děti chtějí, a tedy přesně to, co z nákupu dělá tlak na dítě (a co
  recenzenti Kids kategorie trestají). Kosmetika přichází jen jako součást
  obsahu.
- **Další profily dětí.** Sourozenci zdarma jsou prodejní argument, ne
  produkt.
- **Odstranění limitu / zrychlení.** Nic, co mění tempo učení.
- **Předplatné.** Obsah je jednorázový (dítě se naučí číst a odejde),
  rodiče ho u dětských appek špatně snášejí, a tlačí na „engagement"
  mechaniky, které roadmapa odmítá.
- **Dýško / „kup průvodci banán".** V koutku by to šlo, ale výnos je
  zanedbatelný a plete katalog.

## 4. Cena a realistická očekávání

**Proč 29 Kč / 0,99 $:** psychologická nula, bez rozmýšlení, a hlavně
rodič ví, že za 29 Kč dostane *konkrétní* věc (ostrov slov v češtině), ne
„přístup". Po provizi 15 % (Apple Small Business Program i Google do 1 M $
ročně) zůstane ~0,84 $ / ~25 Kč z balíčku.

**Proč navíc bundl 199 Kč:** při čistě dolarových balíčcích je průměrná
útrata platícího rodiče ~1–2 balíčky. Bundl zvedá průměr na 5–8 $ u části
rodin, které chtějí „mít to vyřešené" (dva sourozenci, dva jazyky). Cena
musí být pod součtem 3–4 položek, které rodina reálně chce (cs B + cs C +
en A + hlas = 116 Kč), ale výrazně nad jednou — 199 Kč / 7,99 $ sedí a je
v dolním středu dětských vzdělávacích appek.

**Střízlivá čísla.** Konverze free → platící u dětských vzdělávacích appek
bez marketingu bývá 2–5 % instalací. Modelový měsíc:

| Instalace/měs. | Platící (3 %) | Útrata/platící | Hrubý výnos | Po provizi |
|---|---|---|---|---|
| 500 | 15 | 2,5 $ (mix balíčků a bundlu) | ~38 $ | ~32 $ |
| 2 000 | 60 | 2,5 $ | ~150 $ | ~128 $ |
| 10 000 | 300 | 2,5 $ | ~750 $ | ~640 $ |

To není obživa; je to pokrytí nákladů (Apple Developer, SPARK, hlas) a
test, zda rodiče platí. Cesta k většímu výnosu nevede přes vyšší ceny
balíčků, ale přes (a) **školy a logopedy** (§3 školní verze, vyšší cena na
zařízení, hromadný nákup), (b) **anglofonní trhy** (jazyk zařízení en →
zdarma angličtina, placené všechno ostatní; trh ~50× větší než ČR),
(c) více tematických balíčků, které se vyrábí levně. Regiony a pořadí vydání: §9.

**Školní verze.** Apple School Manager a Google Play for Education umí
hromadně koupit **aplikaci**, ne IAP. Proto samostatný záznam
„SwypeKids pro školy" (jiné bundle id, stejný kód, build flavor): placená
předem (orientačně 249–399 Kč / zařízení, 50 % sleva při 20+ kusech je
u Apple volbou vývojáře), všechen obsah, až 30 profilů, export třídy CSV,
bez IAP. Logopedi a speciální pedagogové jsou v ČR reálná nika pro appku
na swypování slabik; promo kódy (Apple dává 100 na položku a verzi) na
rozdávání těm, kdo appku doporučují.

**Platformy.** Apple: Family Sharing u non-consumable IAP zapnout (jedna
koupě pro sourozence na různých zařízeních). Google: Family Library IAP
**nepodporuje** — sourozenci na jednom zařízení sdílejí přes profily,
na dvou zařízeních platí dvakrát; v koutku to říct narovinu. Ceny
nastavit v lokálních měnách ručně (29 Kč, 0,99 €, 0,99 $), ne přepočtem.
macOS a Linux: macOS přes App Store stejně jako iOS; Linux bez obchodu →
všechen obsah zdarma (zanedbatelný trh, zjednodušuje build).

## 5. Co to znamená pro kód

**Data.**

- Jednotka dostane `band: "a" | "b" | "c"` (výchozí `a`) a volitelně
  `product: "theme.zima"` (štítek tematického balíčku; taková jednotka se
  řídí jen jím, ne pásmem). Produkt jazyka se do packu nepíše — odvozuje
  se v kódu (`lang.<id>`, `StoreCatalog.languageProductId`).
  `assets/store/catalog.json`: seznam produktů — `id`, `type`
  (`island | language | theme | voice | parent | bundle`), `order` (pořadí
  v koutku) a výslovné `unlocks`: `{"all": true}`, nebo `languages` +
  `bands` (ostrov, jazyk), nebo `tags` (štítky `unit.product`; bez
  `languages` = ve všech jazycích), nebo `features` (`parent.plus`).
  Název/popis se skládá z ARB klíčů podle typu (`CatalogProductL10n`).
  `test/pack_loading_test.dart` ověří unikátní id, výslovné `unlocks`,
  úplnost pro 9 jazyků a že každý `product` v packu je v katalogu. (Že
  každý produkt má obsah, půjde ověřit až s pásmem B — fáze 3b.)
- Pravidlo „nikdy nepřidávat lekce do existující jednotky" platí dál;
  tematický balíček = nové jednotky s vlastním `product`.

**Služby.**

- `EntitlementService` (ChangeNotifier): `owns(productId)`,
  `unlocked(unit)`, `freeLanguage` (jazyk zařízení/onboardingu, uloženo
  jednou provždy v `sk.store.freeLang`), `grandfathered` (§6). Stav v
  `sk.store.owned` (globální, ne per profil). Zdroj pravdy je obchod;
  lokální cache je fallback pro offline.
- `StoreService` nad `in_app_purchase` (StoreKit 2 na iOS 15+, Play
  Billing 6+): načtení produktů, koupě, obnovení, ověření na startu.
  Za rozhraním, aby testy a Linux build měly `FakeStore` (vše zdarma /
  skript nákupu).
- `PackService`: pack jiného než zdarma jazyka se načte, ale jeho
  jednotky mají `locked` podle entitlementu; `LanguagePicker` v dětské
  části ukazuje jen jazyky s odemčeným pásmem A (další jazyky přidává
  rodič v koutku a pak se dítěti objeví vlajka).

**UI.**

- Mapa: za poslední odemčenou jednotkou ostrov v mlze (`BiomeBand` fog
  už existuje) s loďkou; žádný hit-test pro dítě. Průvodce o něm nemluví.
- `WinScreen` (dohraný ostrov): oslava pro dítě jako dnes + malá karta
  „Pro rodiče" s ikonou brány; ťuknutí → `ParentGate` → koutek, záložka
  „Další ostrovy".
- Rodičovský koutek, nová záložka **Další ostrovy**: pro aktuální jazyk
  seznam položek s cenou z obchodu (nikdy natvrdo), stav (zdarma / máte /
  koupit), „Vše napořád" nahoře, „Obnovit nákupy" dole, věta o Family
  Sharing / Play omezení. Cizí jazyky pod rozbalením.
- Nic z toho se nerenderuje v dětském UI mimo loďku a kartu pro rodiče.

**Testy.** Zamčená jednotka není ťuknutelná a `GameScreen` ji odmítne
spustit; zamčený jazyk není v dětském pickeru; koupě přes `FakeStore`
odemkne a přežije restart; offline start s cache; grandfathering;
Linux build = vše odemčené; `app_start_test` bez sítě nespadne.
Ruční: StoreKit configuration file v Xcode, sandbox tester; Play interní
dráha s license testery.

## 6. Grandfathering: stávající instalace

Při prvním startu po verzi s obchodem: každý jazyk, ve kterém má
kterýkoli profil aspoň jednu hvězdu, se zapíše do `sk.store.grandfathered`
a jeho pásmo A zůstane odemčené navždy (i když to není jazyk zařízení).
Nové ostrovy B/C jsou pro všechny placené stejně — ty nikdo neměl. Tak se
neporuší zásada 3 a nikomu nic nezmizí.

## 7. Fáze (pro Opus)

| Fáze | Co | Hotovo znamená |
|---|---|---|
| **0 Rozhodnutí** | Potvrdit §2 hranici, §3 katalog, §4 ceny; vytvořit produkty v App Store Connect / Play Console (sandbox); zapnout Family Sharing; vyplnit Kids kategorie dotazník k IAP | Produkty jsou v sandboxu, ceny v Kč/€/$ ručně |
| **1 Entitlementy bez obchodu** ✅ hotovo (v kódu, vypnuto) | `band`/`product` v packech, `catalog.json`, `EntitlementService`, `FakeStore`, zámky (`EntitlementService.unlocked` — mapa, `GameScreen`, procvičování), mapa s ostrovem v mlze, dětský picker jen odemčené jazyky, grandfathering, testy | `flutter test` zelený; v debug buildu jde přepínačem v koutku simulovat koupi; dítě nikde nevidí cenu. Všechno je za `StoreConfig.enabled = false` (§8.7) |
| **2 Obchod** | `in_app_purchase`, `StoreService`, záložka Další ostrovy, obnovení, offline cache, karta „Pro rodiče" na `WinScreen`; PRIVACY.md doplnit odstavec o nákupech (obchod zpracovává platbu, appka nic neposílá) | Sandbox koupě na iOS i Androidu odemkne obsah; TestFlight/interní dráha |
| **3a Dorovnat Ostrov písmenek** (hotovo ve 2.16.0) | Pásmo A na ~15 jednotek tam, kde je kratší (ja 8, zh 11, pt 13), aby zdarma část byla všude „celý výsledek"; věty přes `SENTENCES_REVIEW.md` | Každý jazyk má pásmo A ≥ 15 jednotek, korpus vět `llm: ok` |
| **3b Obsah: Ostrov slov ve všech jazycích** | Pásmo B pro všech 9 jazyků současně (15–20 jednotek, typy `missingLetter`, `syllableJoin`, `reviewMix`, `pictureOnly`), nálepky, obyvatelé, builder předměty, korektura vět; rodilí mluvčí přes nástroje z `tool/sentences/`; playtest cs podle `PLAYTEST.md`. Autorsky: cs a en ručně jako vzor, ostatní jazyky podle stejné kostry jednotek (písmena podle frekvence v jazyce, ne překladem cs) | Vydání s `island.<lang>.b` pro všech 9 jazyků + `lang.*` + `all.forever`; obchod zapnutý ve všech regionech z §9 |
| **4 Opakovatelné balíčky** | Šablona tematického balíčku (skript: JSON kostra + seznam nálepek k výrobě + korpus vět k revizi), první dva (`theme.zima`, `theme.dinosauri`) — každý jako jedna položka katalogu, která odemkne své jednotky ve všech jazycích; hlas průvodce (§10) až po ověření licence | Nový tematický balíček od nápadu k vydání < 1 týden práce |
| **5 Školy** (až po prvních prodejích) | Flavor „SwypeKids pro školy": jiné bundle id, vše odemčeno, 30 profilů, export CSV, bez IAP; záznam v App Store (Education) a Play for Education; promo kódy pro logopedy | Hromadný nákup přes Apple School Manager funguje |

Fáze 1 a 2 lze stavět hned (bez obsahu). Fáze 3 je kritická cesta:
**nic placeného nevyjde dřív než Ostrov slov.** Do té doby obchod v
appce není (fáze 2 se nasadí jen s vypnutým katalogem), aby store
recenze nehodnotily prázdnou nabídku. Fáze 5 se otevře až podle prvních
prodejů (rozhodnutí §8).

## 8. Rozhodnutí (7. 10. 2026)

1. **Hranice za dnešním obsahem.** Všechno, co dnes je, zůstává zdarma;
   platí se za nové ostrovy.
2. **Jazyk zařízení zdarma, ostatní jazyky 29 Kč**, i angličtina pro
   českou rodinu. Plán regionů podle podporovaných jazyků je v §9; Čína
   se nevydává.
3. **Bundl „Vše napořád" 199 Kč / 7,99 $ včetně budoucího obsahu.**
4. **Školní verze až po prvních prodejích** (fáze 5 je podmíněná).
5. **Hlas průvodce syntézou**, ne nahrávkou; před výrobou ověřit licenci
   (§10). Do té doby produkt `voice.<lang>` není v katalogu.
6. **Ostrov slov pro všechny jazyky současně**, ne jen cs + en (fáze 3b);
   kratší pásma A se nejdřív dorovnají (fáze 3a).
7. **První vydání v App Store je bez obchodu.** Všech 9 jazyků je zdarma
   až do konce dnešního obsahu (Ostrov písmenek = pásmo `a`), v appce není
   žádný obchod. Celý mechanismus proto vychází vypnutý jedním přepínačem
   v kódu (`StoreConfig.enabled = false`): všechno je odemčené, nikde žádné
   nákupní UI, chování stejné jako dosud. Zamykání prověřují jen testy a
   ladicí přepínač v rodičovském koutku (`kDebugMode`, `FakeStore`).
   Jazyk zdarma (`sk.store.freeLang`) se zapisuje už teď, grandfathering
   (§6) proběhne až při prvním startu se zapnutým obchodem.
8. **Katalog je datový.** Každý produkt v `assets/store/catalog.json` má
   `id`, `type` (`island | language | theme | voice | parent | bundle`) a
   výslovný popis `unlocks` (jazyky + pásma, štítky jednotek, nebo „vše"),
   takže produkt může odemknout ostrov jednoho jazyka i obsah napříč
   jazyky bez změny kódu.
9. **Tematický balíček = jedna položka pro všechny jazyky; ostrovy a
   jazyky po jazycích.** Id je `theme.<name>` (ne `theme.<lang>.<name>`):
   jednotky se štítkem `product: "theme.<name>"` se po koupi odemknou
   v každém packu, který je má. Ostrovy zůstávají `island.<lang>.b|c`,
   jazyky `lang.<xx>`, `all.forever` odemyká všechno.

## 9. Regiony: kde a jak vydávat

Zdarma je vždy jazyk zařízení, takže každý podporovaný jazyk je zároveň
domácí trh, kde appka startuje bez bariéry. Pořadí vydání se řídí tím, kde
umíme ověřit kvalitu (rodilí mluvčí, playtest) a velikostí trhu.

| Vlna | Jazyk | Trhy (storefronty) | Co víme | Poznámky k vydání |
|---|---|---|---|---|
| 1 | cs | ČR | Domácí trh, playtesty, ~70 % Android | Vzor pro ostatní; Play „Designed for Families", App Store Kids 6–8. Slovensko: cs pack není sk, nevydávat jako sk. |
| 2 | en | US, UK, IE, CA, AU, NZ (+ en jako druhý jazyk všude) | Největší trh, největší konkurence (Khan Kids zdarma, Endless Alphabet, Teach Your Monster) | Vyhraněná pozice: swype klávesnice + Zvěřinec + bez reklam a předplatného. Play „Teacher Approved" žádost. en-GB varianty slov až ve v4.x. |
| 2 | de | DE, AT, CH | Vysoká ochota platit za vzdělávání, přísné GDPR-K (plníme) | Store texty de; rodičovský koutek je silný argument. |
| 3 | es | ES + LatAm (MX, AR, CO, CL, PE) | Velký trh, nižší cenová citlivost v LatAm | V LatAm nastavit nižší lokální úroveň ceny (obchody umí cenu per storefront), ne přepočet z 0,99 $. |
| 3 | pt | PT, BR | Brazílie = obří Android trh | Nižší lokální cena v BR; pt pack je **pt-BR** (suco, mamãe), takže domácí trh je Brazílie; pro Portugalsko zkontrolovat slovník rodilým mluvčím, případně později varianta pt-PT. |
| 3 | fr | FR, BE, CH, CA (Québec) | Střední trh, vysoké nároky na jazyk | Québec: francouzská verze listingu je povinná. |
| 3 | it | IT | Menší trh | Vydat s vlnou 3 bez zvláštní práce. |
| 4 | ja | JP | iOS silný, ochota platit vysoká; pásmo A má jen 8 jednotek; swype romaji → hiragana je pro JP netypické | Vydat až po fázi 3a a playtestu s japonskou rodinou; jinak hrozí špatné recenze na domácím trhu. |
| — | zh | **nevydávat v Číně**; zh zůstává v appce | App Store v ČLR vyžaduje místního vydavatele a ICP; Google Play tam není; pack je zjednodušená čínština s pinyinem (ne tradiční znaky pro TW/HK) | zh je k dispozici všude jako `lang.zh` (bilingvní rodiny v zahraničí), nikde není domácím jazykem storefrontu. Čínský storefront v App Store Connect vyřadit. |

Společné pro všechny regiony:

- **Ceny ručně per storefront** v nejnižší úrovni (29 Kč, 0,99 €, 0,99 $,
  0,99 £, odpovídající JPY), bundl v ekvivalentu 199 Kč / 7,99 $; LatAm a
  BR o úroveň níž. Nikdy nespoléhat na automatický přepočet.
- **Store listing ve všech 8 vydávaných jazycích** (`docs/STORE.md` dnes
  cs + en; doplnit de, es, pt, fr, it, ja) a screenshoty z
  `tool/store_screenshots.sh` s příslušným jazykem. Privacy policy URL
  v každém jazyce (přeložit `docs/PRIVACY.md`).
- **Věkové hodnocení** per region (IARC na Play, Apple dotazník) a Kids
  kategorie všude, kde existuje.
- **Family Sharing** zapnuté u všech položek na iOS; na Play v koutku
  věta o nesdílení IAP.
- Jazyk zdarma = jazyk zařízení při prvním startu (fallback: jazyk
  vybraný v onboardingu, když zařízení má nepodporovaný jazyk). Zapsat
  jednou provždy, aby změna jazyka telefonu neodemykala další jazyk.

## 10. Hlas průvodce: syntéza a licence

Rozhodnuto nenahrávat, ale syntetizovat předem (soubory v assetu
produktu, offline), ne volat TTS za běhu (to dělá dnešní `flutter_tts`
zdarma a zůstává). Před výrobou ověřit u zvolené služby (Azure Neural
TTS, Google Cloud TTS, ElevenLabs, OpenAI TTS…):

- licence dovoluje **komerční redistribuci vygenerovaného audia** jako
  součást placené aplikace (ne jen „použití v produktu za běhu");
- žádné omezení na **obsah pro děti** ani požadavek na označení „syntetický
  hlas" v UI (když je, splnit v koutku);
- hlas není klonem reálné osoby bez souhlasu; u „preset" hlasů ověřit,
  že služba drží práva;
- stejný hlas (nebo rodina hlasů) existuje pro všech 9 jazyků, aby
  průvodce zněl všude stejně.

Výstup: krátký zápis v tomto dokumentu (služba, hlas, odkaz na podmínky,
datum) a potom teprve `voice.<lang>` do katalogu. Rozsah: fráze průvodce
z manifestu, jména nálepek (`reward.label`), věty z korpusu
(`SentenceCorpus`) — ty se dají generovat skriptem z `review/sentences_<lang>.tsv`,
takže nový balíček dostane hlas automaticky.
