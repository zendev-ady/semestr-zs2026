# 1BP461 Case Studies in Capital Markets and Banking

> Zdroj: `sylabus.txt` (InSIS). Oficiální harmonogram od vyučujícího zatím není — rozvržení témat do týdnů je **můj návrh** podle volen. Sekce **Klíčové pojmy** nad rámec sylabu jsou návrh podle literatury (Witzany, Hull) — upřesnit podle přednášek. Poznámky a otázky k předmětu jsou **anglicky**.

## Přehled

| | |
|---|---|
| Kredity | 4 ECTS · v InSIS 0/2, ve skutečnosti jen přednášky (cvičení nejsou — 1. hodina 22. 9.) |
| Rozvrh | Út 14:30–16:00 NB B (přednáška) |
| Vyučující | Ing. Milan Fičura, Ph.D. (přednášející, garant, zkoušející) |
| Jazyk | angličtina |
| Ukončení | zkouška = semestrální práce + závěrečný test |
| Navazuje na | Kapitálové trhy II, Finanční deriváty I |

**O čem to je:** praktická aplikace modelů výnosnosti a rizika (akcie, dluhopisy, deriváty) na reálná data — CAPM/APT/faktorové modely, výnosová křivka, oceňování derivátů, contango/backwardation, stochastické procesy cen a Value at Risk. Důraz na „case studies“ → počítání na datech v **R (RStudio)** — instalace a úvod do R na 1. přednášce 22. 9.

## Hodnocení

| Část | Váha | Příprava podle sylabu |
|---|---|---|
| Semestrální práce | **50 %** | 26 h |
| Závěrečný test | **50 %** | 26 h |

Známky: 1 = 90–100 % · 2 = 75–89 % · 3 = 60–74 % · 4 = pod 60 %

Termíny: zatím neznámé (zadání a odevzdání semestrální práce, termíny závěrečného testu, forma testu).

## Harmonogram a témata

Výuka v úterý. Odpadá: 7. týden (3. 11., inovační týden) a 9. týden (17. 11., státní svátek) → 11 přednášek na 10 témat. **Návrh** rozvržení (téma N = týden N do 6. týdne, pak posun), 13. týden rezerva / opakování. Číslo tématu = `#topic-N` = `subtopic` v quizu.

| Týden | Datum | Téma |
|---|---|---|
| 1 | 22. 9. | **1** Capital Markets Overview |
| 2 | 29. 9. | **2** Portfolio Theory, CAPM & APT |
| 3 | 6. 10. | **3** Market Efficiency |
| 4 | 13. 10. | **4** Bond Markets & Yield Curve |
| 5 | 20. 10. | **5** Forwards & Futures Hedging |
| 6 | 27. 10. | **6** Contango & Backwardation |
| 7 | 3. 11. | *inovační týden — výuka odpadá* |
| 8 | 10. 11. | **7** Swaps & CDS |
| 9 | 17. 11. | *státní svátek — výuka odpadá* |
| 10 | 24. 11. | **8** Options Pricing & Greeks |
| 11 | 1. 12. | **9** Asset Price Dynamics & Exotics |
| 12 | 8. 12. | **10** Market Risk, VaR & ES |
| 13 | 15. 12. | *rezerva / opakování (návrh)* |

## Témata ze sylabu a klíčové pojmy

| # | Zkratka | Text ze sylabu | Klíčové pojmy |
|---|---|---|---|
| 1 | Capital Markets Overview | typy kapitálových trhů, instrumenty, funkce, subjekty, postavení bank a pojišťoven | *(návrh)* primary vs. secondary market, money vs. capital market, exchange vs. OTC, market participants (issuers, investors, intermediaries), bank vs. insurance balance sheet, disintermediation |
| 2 | Portfolio Theory, CAPM & APT | akciové trhy, teorie portfolia, CAPM, APT, faktorové modely, tržní riziková prémie, equity premium puzzle | *(návrh)* mean-variance, efficient frontier, diversification, systematic vs. idiosyncratic risk, beta, SML/CML, Sharpe ratio, alpha, Fama–French 3/5-factor, market risk premium estimation |
| 3 | Market Efficiency | aktivní vs. pasivní investování, EMH, fundamentální a technická analýza, empirické testy efektivnosti, anomálie | *(návrh)* weak/semi-strong/strong form, random walk, event study, abnormal returns, momentum, size/value effect, January effect, joint hypothesis problem |
| 4 | Bond Markets & Yield Curve | dluhopisové trhy, rizika, durace a konvexita, modely výnosové křivky, likviditní prémie, forwardové sazby | *(návrh)* YTM, spot/zero rates, bootstrapping, Macaulay/modified duration, convexity, DV01, Nelson–Siegel, expectations vs. liquidity preference theory, credit/interest-rate/reinvestment risk |
| 5 | Forwards & Futures Hedging | forwardové a futures trhy, rozdíl forward × futures, zajištění akciového a dluhopisového portfolia futures | *(návrh)* cost of carry, marking to market, margin, basis risk, minimum-variance hedge ratio, beta hedging with index futures, duration-based hedging, CTD bond |
| 6 | Contango & Backwardation | rovnováha spekulanta a arbitražéra, rovnovážná cena futures, normální vs. invertovaná křivka, contango a backwardation | *(návrh)* Keynes normal backwardation, hedging pressure, convenience yield, storage costs, roll yield, expected spot vs. futures price |
| 7 | Swaps & CDS | swapové trhy, úrokové, měnové a equity swapy, CDS | *(návrh)* IRS valuation (bond vs. FRA approach), swap rate, currency swap, equity swap, CDS spread, hazard rate, recovery rate |
| 8 | Options Pricing & Greeks | put-call parita, Black–Scholes, binomické stromy, Monte Carlo, greeks, hedging opčního portfolia, opční strategie | *(návrh)* delta/gamma/vega/theta/rho, delta hedging, risk-neutral valuation, CRR tree, spreads, straddle, strangle, protective put, covered call |
| 9 | Asset Price Dynamics & Exotics | dynamika cen, volatility smile, alternativní stochastické procesy, exotické opce, dynamika úrokových sazeb | *(návrh)* GBM, implied volatility, smile/skew, jump diffusion, local vol, barrier/Asian/lookback options, Vasicek, CIR, Hull–White, mean reversion |
| 10 | Market Risk, VaR & ES | modelování cen, stochastická volatilita a korelace, řízení tržního rizika, VaR a ES různými přístupy | *(návrh)* historical simulation, parametric (variance-covariance), Monte Carlo VaR, EWMA, GARCH(1,1), Heston, correlation modelling, backtesting (Kupiec), Expected Shortfall, Basel/FRTB |

## Výsledky učení → kde se testují

- modelovat výnosnost a riziko portfolia (akcie, dluhopisy, deriváty) → 2, 4, 10
- oceňovat standardní i exotické deriváty (forwardy, swapy, opce) → 5, 7, 8, 9
- zajistit portfolio proti různým rizikům → 4, 5, 8
- modelovat dynamiku akcií, sazeb a volatility → 9, 10

## Literatura

- **Základní:** WITZANY, J. *Financial Derivatives. Valuation, Hedging and Risk Management.* Oeconomica, 2013 → terminologie a značení v poznámkách podle ní
- Doporučená: WITZANY, J. *International Financial Markets.* 2012 (téma 1)
- Doporučená: HULL, J. *Options, Futures and Other Derivatives.* 2015 (5–9)
- Doporučená: HULL, J. *Risk Management and Financial Institutions.* 2012 (10)
- Doporučená: BODIE, KANE, MARCUS. *Investments.* 2009 (2, 3, 4)
- Doporučená: MISHKIN, EAKINS. *Financial Markets and Institutions.* 2018 (1)
- Doporučená: WILMOTT, P. *Paul Wilmott on Quantitative Finance, Vol. 2.* 2006 (9)
- Doporučená: RAČEV, S. *Financial Econometrics.* 2007 (10)

## Na co se zaměřit v podkladech

- **Početní příklady:** beta a očekávaný výnos z CAPM, durace/konvexita a změna ceny dluhopisu, forwardová sazba z výnosové křivky, cena forwardu/futures (cost of carry), počet kontraktů pro zajištění (beta / durace), ocenění IRS, binomický strom, Black–Scholes, delta hedge, VaR (parametrický × historický) a ES
- **Pojmové otázky:** formy EMH a anomálie, contango × backwardation a proč vzniká, forward × futures, smile a co vypovídá o rozdělení, VaR × ES (subaditivita)
- **Semestrální práce** = polovina známky → jakmile bude zadání, uložit do `podklady/1BP461/`
