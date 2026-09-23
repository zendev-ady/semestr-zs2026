# 1BP443 Data a analytika pro finanční sektor

> Zdroj: `sylabus.txt` (InSIS). Oficiální harmonogram od vyučujícího zatím není. Rozvržení do týdnů je **můj návrh** podle volen a těch pět bloků „Tvorba řešení I–V“ jsem sloučil do čtyř fází projektu (viz níže). Klíčové pojmy jsou mimo sylabus **návrh** podle obecné literatury k datové analytice (CRISP-DM, DAMA-DMBOK, model analytiky od Gartneru) a regulace finančního sektoru. Upřesnit podle seminářů a Slánského knih.

## Přehled

| | |
|---|---|
| Kredity | 3 ECTS · 0/2 (jen semináře/cvičení) |
| Rozvrh | St 07:30–09:00 SB 236 |
| Vyučující | Ing. David Slánský, Ph.D., LL.M., MBA (cvičící, přednášející, zkoušející) · garant prof. PhDr. Petr Teplý, Ph.D. |
| Jazyk | čeština |
| Ukončení | zkouška = datově analytické řešení s obhajobou + ústní zkouška |
| Forma | semináře s **aktivní účastí** + skupinový projekt (tým 3 lidí), nástroje na úrovni business uživatele (bez programování) |

**O čem to je:** k čemu banky, centrální banka, pojišťovny a zprostředkovatelé používají data a analytiku (use cases), a pak vlastní projekt. Ve třech lidech postavíte datově analytický výstup (report, dashboard, model rizika nebo chování klientů), na konci ho odprezentujete a obhájíte, jakou má pro organizaci hodnotu. Roli, kterou kurz trénuje, sylabus nazývá **citizen data analyst**: nejste programátor, ale s daty umíte pracovat sami.

## Hodnocení

| Část | Váha | Příprava podle sylabu |
|---|---|---|
| Datově analytické řešení a jeho obhajoba | **60 %** | 28 h |
| Závěrečná ústní zkouška | **40 %** | 18 h |

Známky: 1 = 90–100 % · 2 = 75–89 % · 3 = 60–74 % · 4 = pod 60 %. **Z každé části je potřeba aspoň 50 %.**

Termíny: zatím neznámé. Podle sylabu jsou prezentace v posledních dvou blocích → po posunu kvůli volnům nejspíš 9. 12. a 16. 12. (**předpoklad**). Termíny ústní zkoušky a to, na co se u ní ptají, zatím nevíme.

## Harmonogram a témata

Výuka ve středu. Odpadá 6. týden (28. 10., státní svátek) a 7. týden (4. 11., inovační týden) → **11 seminářů na 12 bloků sylabu**. Návrh: bloky 6–10 (Tvorba I–V) sloučeny do 4 fází projektu, prezentace ve 12. a 13. týdnu. Číslo tématu = `#topic-N` = `subtopic` v quizu.

| Týden | Datum | Téma | Blok sylabu |
|---|---|---|---|
| 1 | 23. 9. | **1** Data a analytika – úvod | 1 |
| 2 | 30. 9. | **2** Komerční banky | 2 |
| 3 | 7. 10. | **3** Centrální banka | 3 |
| 4 | 14. 10. | **4** Pojišťovny | 4 |
| 5 | 21. 10. | **5** Finanční zprostředkovatelé | 5 |
| 6 | 28. 10. | *státní svátek, výuka odpadá* | |
| 7 | 4. 11. | *inovační týden, výuka odpadá* | |
| 8 | 11. 11. | **6** Řešení: zadání a business case | 6 |
| 9 | 18. 11. | **7** Řešení: data a jejich příprava | 7 |
| 10 | 25. 11. | **8** Řešení: analýza a modely | 8 |
| 11 | 2. 12. | **9** Řešení: vizualizace a dashboard | 9–10 |
| 12 | 9. 12. | **10** Prezentace a obhajoba hodnoty | 11 |
| 13 | 16. 12. | *prezentace II* | 12 |

## Témata ze sylabu a klíčové pojmy

| # | Zkratka | Text ze sylabu | Klíčové pojmy |
|---|---|---|---|
| 1 | Úvod | Základní vysvětlení dat a analytiky a uvedení do problematiky | *(návrh)* DIKW, typy dat (strukturovaná / nestrukturovaná, kmenová / transakční), deskriptivní → diagnostická → prediktivní → preskriptivní analytika, BI × pokročilá analytika × AI, datová architektura (zdroje → ETL → DWH / data lake → reporting), role (data engineer, data scientist, analyst, citizen data analyst, data steward, CDO), data governance a kvalita dat, CRISP-DM, regulace (GDPR, BCBS 239, AI Act) |
| 2 | Komerční banky | Praktické ukázky z oblasti komerčních bank | *(návrh)* credit scoring (aplikační × behaviorální), PD/LGD/EAD, IFRS 9 (stage 1–3), early warning, fraud, AML/KYC (false positives), churn, CLV, next best offer, segmentace, regulatorní reporting (COREP/FINREP), matice záměn, AUC/Gini |
| 3 | Centrální banka | Praktické ukázky z oblasti centrálního bankovnictví | *(návrh)* role ČNB, nowcasting, vysokofrekvenční a alternativní data, prognóza, textová analýza komunikace, statistika a reporting bank, SupTech, zátěžové testy, systémové riziko, CCyB, Centrální registr úvěrů |
| 4 | Pojišťovny | Praktické ukázky z oblasti pojišťoven | *(návrh)* tarifikace (frekvence × severita, GLM), telematika (pay-as/how-you-drive), pojistný podvod, automatizace likvidace, rezervy (IBNR), škodní poměr / combined ratio, retence, katastrofické modely, Solventnost II, IFRS 17 |
| 5 | Zprostředkovatelé | Praktické ukázky z oblasti finančních zprostředkovatelů | *(návrh)* typy zprostředkovatelů, CRM, obchodní trychtýř a konverze, lead scoring, produktivita poradců, storno, compliance (IDD, MiFID II, spotřebitelský úvěr), srovnávače, robo-advisory |
| 6 | Zadání | Tvorba datově analytického řešení I | *(návrh)* business problém, uživatel a rozhodnutí, KPI, use-case canvas, zdroje dat (otevřená data, Kaggle), GDPR |
| 7 | Data | Tvorba datově analytického řešení II | *(návrh)* tidy data, hvězdicové schéma (fakta × dimenze), Power Query, čištění, spojování tabulek, granularita, kontrola kvality |
| 8 | Analýza | Tvorba datově analytického řešení III | *(návrh)* popisná statistika, korelace × kauzalita, segmentace (RFM, k-means), klasifikace (rozhodovací strom, logistická regrese), prognóza, train/test, overfitting, paradox přesnosti, leakage |
| 9 | Dashboard | Tvorba datově analytického řešení IV–V | *(návrh)* volba grafu podle sdělení, KPI karty, kontext (plán, minulé období), filtry a drill-down, Power BI (datový model, DAX míry), storytelling |
| 10 | Prezentace | Prezentace vytvořených řešení I–II | *(návrh)* struktura pitch (problém → řešení → hodnota → implementace → rizika), kvantifikace přínosu, ROI a návratnost, Minto (pyramida), odpovědi na dotazy |

## Výsledky učení → kde se testují

- zařazení a přidaná hodnota dat a analytiky ve finančních institucích → 1–5 (hlavně ústní zkouška)
- práce s daty a nástroji jako citizen data analyst → 6–9 (projekt)
- vysvětlit využití výstupu a přesvědčit o přidané hodnotě → 10 (obhajoba)

## Literatura

- **Základní:** SLÁNSKÝ, D. *Data a analytika pro 21. století: Nástroje.* Professional Publishing, 2018
- **Základní:** SLÁNSKÝ, D. *Data a analytika pro 21. století. Kniha 4, Praktické příklady.* Professional Publishing, 2018
- Terminologie v poznámkách má být podle Slánského. Knihy zatím nemám, takže poznámky vycházejí z obecné literatury. Až bude k dispozici kniha nebo slidy, platí jejich značení.

## Na co se zaměřit v podkladech

- **Ústní zkouška (40 %):** pro každý typ instituce umět říct 3–4 use cases: *jaký problém řeší, jaká data potřebuje, jaká analytika se použije, jakou má hodnotu a jaká jsou rizika a regulace*
- **Projekt (60 %):** hned na začátku sestavit tým a domluvit téma s vyučujícím. Pracovat podle fází 6–9 a mít vyčíslený přínos pro organizaci
- Jednoduché výpočty, které se hodí k obhajobě: přesnost × precision × recall z matice záměn, Gini = 2·AUC − 1, čistá riziková pojistná sazba, combined ratio, konverze v trychtýři, ROI a návratnost
