# 1BP461 Case Studies in Capital Markets and Banking

> Zdroje: materiály vyučujícího nahrané do InSIS (`1BP453_00…04_*.pdf`, `Lecture_*.R`, `1BP461_Homework_01_2026.pdf`) a `sylabus.txt`. Poznámky jsou **česky** s anglickými pojmy v závorce, otázky do quizu **anglicky** (výuka i test jsou anglicky).

## ⚠️ Sylabus ≠ skutečná výuka

Sylabus v InSIS slibuje teorii derivátů a řízení rizika podle Witzanyho (swapy, CDS, exotické opce, VaR/ES). **Skutečný předmět je kvantitativní správa portfolia v R.** Slidy mají v záhlaví „Quantitative Portfolio Management“ a soubory se jmenují `1BP453_*`, takže je vyučující převzal z jiného kurzu. Řídíme se osnovou z úvodní prezentace (`1BP453_00`, s. 4), ne sylabem. Dřívější verze poznámek (psaná ze sylabu a literatury) zůstává v gitu (commit `d44e18b` a starší) a použije se jako zdroj, až budou slidy k derivátům.

## Přehled

| | |
|---|---|
| Kredity | 4 ECTS, jen přednášky (Út 14:30–16:00 NB B) |
| Vyučující | Ing. Milan Fičura, Ph.D. (milan.ficura@vse.cz) |
| Jazyk | angličtina |
| Nástroj | R + RStudio (balíčky tidyverse, tidyquant, MASS, pracma) |
| Ukončení | semestrální projekty (50 %) + závěrečný test (50 %) |

## Hodnocení

| Část | Váha |
|---|---|
| Course projects (semestrální projekty) | **50 %** |
| Final test (závěrečný test) | **50 %** |

Známky: 1 = 90–100 % · 2 = 75–89 % · 3 = 60–74 % · 4+ = 50–59 % (možná oprava) · 4 = 0–49 % (bez opravy). Slajd píše „projects“ v množném čísle, takže úkolů bude nejspíš víc než jeden.

## Osnova z úvodní prezentace (`1BP453_00`, s. 4)

1. **Introduction to R** (2 přednášky): datové typy, vektory, podmínky a cykly, funkce, matice, listy, grafy, balíčky
2. **Stock markets** (4): MPT, CAPM, faktorové modely, tržní riziková prémie, equity premium puzzle, aktivní × pasivní investování, EMH, fundamentální a technická analýza, testy efektivity, anomálie, statistická arbitráž, global macro
3. **Bond markets** (1): rizika, durace a konvexita, časová struktura, modely výnosové křivky, likviditní prémie, forwardové sazby, riding the yield curve
4. **Foreign exchange markets** (1): měnové riziko, absolutní a relativní PPP, reálný kurz, CIP a UIP, faktorové modely kurzů
5. **Futures markets** (1): forward × futures, zajištění akcií a dluhopisů, rovnováha spekulantů a arbitražérů, contango × normal backwardation
6. **Option markets** (4): put-call parita, Black–Scholes, binomické stromy, Monte Carlo, metoda konečných diferencí, greeks, hedging, opční strategie, implikovaná volatilita, volatility surface, model-free volatilita, volatility risk premium, CEV, IVF, Heston, SABR, exotické opce

## Co už je odpřednášené (stav k 10. 11. 2026)

| Datum v InSIS | Podklad | Téma v poznámkách |
|---|---|---|
| 24. 9. | `1BP453_00_Course_Introduction`, `1BP453_01_Introduction_to_R` | 1 |
| 6. 10. | `Lecture_01_Script_01–06` (Basics, Vectors, Cycles, Functions, Matrices, Lists) | 1 |
| 13. 10. | `1BP453_02_R_Packages` | 2 |
| 14. 10. | `Lecture_02_Script_01–03` (Tidyverse, Tidyquant, Case Study SP500 Crashes) | 2 |
| 20. 10. | `1BP453_03_Portfolio_Optimization` | 3 |
| 27. 10. | `1BP453_04_Factor_Models` (skripty k přednášce zatím chybí) | 4 |
| 10. 11. | `Lecture_03_Script_01–02` (Portfolio Optimization ETF, + Constrained) a **zadání Homework 1** | 3 |

Data jsou data nahrání podkladů v InSIS, ne nutně dny přednášek.

## Harmonogram a témata

Výuka v úterý. Odpadá 7. týden (3. 11., inovační týden) a 9. týden (17. 11., státní svátek). Týdny témat 5–12 jsou **odhad** (zbývají týdny 8, 10, 11, 12, 13), až bude oficiální rozvrh, upravit `topicWeeks` v `data/courses.json`.

| # | Zkratka | Podklady | Klíčové pojmy |
|---|---|---|---|
| 1 | Úvod do R | slidy 01, skripty L1 | proměnné, vektory a sekvence, statistické funkce, `if`/`for`, vlastní funkce, matice a maticové operace, simulace náhodné procházky, lineární regrese přes matice, listy |
| 2 | Tidyverse a tidyquant | slidy 02, skripty L2 | tibble, dplyr (`filter`, `arrange`, `select`, `mutate`, `group_by`, `summarize`), tidyr (`gather`, `spread`), `tq_get`, OHLCV, dividendy a splity, upravené ceny, kumulativní výnosy, drawdown, log × prosté výnosy, case study S&P 500 po propadech |
| 3 | Optimalizace portfolia a CAPM | slidy 03, skripty L3 | averze k riziku, equity premium puzzle, diverzifikace, MPT, CML, CAPM, SCL, SML, equal-weight, minimum-variance, tangency, Kelly, omezení vah, numerická optimalizace |
| 4 | Faktorové modely | slidy 04 | faktorové prémie, factor-mimicking portfolia, rebalancing, Fama–MacBeth |
| 5 | Efektivita trhu a strategie | *(zatím bez podkladů)* | aktivní × pasivní investování, EMH, fundamentální a technická analýza, anomálie, statistická arbitráž, global macro |
| 6 | Dluhopisové trhy | *(zatím bez podkladů)* | durace, konvexita, časová struktura, modely výnosové křivky, likviditní prémie, forwardové sazby, riding the yield curve |
| 7 | Devizové trhy | *(zatím bez podkladů)* | PPP, reálný kurz, CIP, UIP, faktorové modely kurzů |
| 8 | Futures | *(zatím bez podkladů)* | forward × futures, hedging, contango, normal backwardation |
| 9 | Oceňování opcí | *(zatím bez podkladů)* | put-call parita, Black–Scholes, binomické stromy, Monte Carlo, konečné diference |
| 10 | Řecká písmena a hedging | *(zatím bez podkladů)* | greeks, hedging opčního portfolia, opční strategie |
| 11 | Implikovaná volatilita a VRP | *(zatím bez podkladů)* | implikovaná volatilita, volatility surface, model-free volatilita, volatility risk premium |
| 12 | Stochastické modely a exotické opce | *(zatím bez podkladů)* | CEV, IVF, Heston, SABR, exotické opce |

## Úkol 1 (Homework 1)

| | |
|---|---|
| Deadline | **15. 12. 2026** |
| Kam | odevzdávárna v InSIS |
| Jazyk | R |
| Co odevzdat | **(A)** krátký report (Word/PDF): kroky analýzy, výsledky, diskuse a interpretace · **(B)** R kód. Obojí je povinné. |
| Část 1 | mean-variance optimalizace 8 ETF (SPY, EFA, LQD, HYG, VNQ, REM, GLD, TLT): portfolia A equal-weight, B minimum-variance, C tangency, D constrained tangency (0 < w < 0,5); in-sample 2007/05–2023/12, out-sample 2024/01–2026/10, rf = 3 % p.a. |
| Část 2 | čtyři dual-momentum strategie (Equity SPY/EFA, Credit LQD/HYG, Real estate VNQ/REM, Stress GLD/TLT, vždy proti BIL), pak stejná optimalizace A–D na výnosech strategií |

Návod krok za krokem je v poznámkách (`courses/case-studies.html#ukol-1`).

## Literatura (slajd 3 úvodní prezentace)

- **Základní (RQ):** WITZANY, J. *Financial Derivatives. Valuation, Hedging and Risk Management.* 2013
- Doporučená (RE): WITZANY, J. *International Financial Markets.* 2012 · HULL, J. *Options, Futures and Other Derivatives.* 2015 · HULL, J. *Risk Management and Financial Institutions.* 2012 · BODIE, KANE, MARCUS. *Investments.* 2009 · EAKINS, MISHKIN. *Financial Markets and Institutions.* 2018 · WILMOTT, P. *Paul Wilmott on Quantitative Finance, Vol. 2.* 2006 · RAČEV, S. *Financial Econometrics.* 2007
- K úkolu 2: ANTONACCI, G. (2017) *Risk Premia Harvesting Through Dual Momentum* (odkaz v zadání, v podkladech není)

## Na co se zaměřit

- **Test:** nejspíš R kód (co vypíše, doplnit funkci) a teorie z přednášek (MPT, CAPM, faktory). Forma zatím není známá.
- **Početní příklady:** váhy minimum-variance a tangency portfolia, Sharpe ratio (anualizace $\sqrt{12}$), beta a očekávaný výnos z CAPM, převody log × prosté výnosy
- **Projekt:** úkol 1 je hlavní hmatatelná práce v následujících týdnech

## Otevřené otázky

- Datum a forma závěrečného testu (teorie? R kód? obojí?)
- Kolik bude „course projects“ a jak se dělí 50 %?
- Zadání úkolu 1 má dvě nesrovnalosti: úvod Části 1 mluví o „6 factor ETFs (Value a Size)“, ale vyjmenovává 8 multi-asset ETF; dále „data do 2024/10“ × kroky „2007/05–2026/10“ a out-sample do 2026/10. Doporučení: držet se seznamu 8 ETF a období do 2026/10, v reportu to uvést, případně se zeptat vyučujícího.
- Co se přednášelo 10. 11. (skripty k portfoliím jsou z tohoto data) a kdy přijdou skripty k faktorovým modelům?
- Zůstanou v kurzu bloky o dluhopisech, FX, futures a opcích tak, jak je uvádí osnova? Čekáme na slidy.
