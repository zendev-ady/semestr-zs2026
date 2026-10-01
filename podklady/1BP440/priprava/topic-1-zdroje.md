# Téma 1 — Finanční trhy, banky a instituce

Zpracování a otevření níže uvedených webových zdrojů: **30. 9. 2026**. Výstup: `topic-1.html`. Jde o studijní výklad podle sylabu s externím doplněním, nikoli o zápis přednášky.

## Podklady a pokrytí

Přečteny `sylabus.txt`, `studijni_plan.md`, `zadani_pro_agenty.md`, záznam 1BP440 v `data/courses.json`, existující stránka předmětu a `shared.css`. V adresáři předmětu původní prezentace chybí.

Téma pokrývá sylabové **finanční trhy, infrastrukturu a instrumenty** a podle harmonogramu také **banky a finanční instituce**: funkce trhů, přímé/nepřímé financování, tři hlediska členění, vklad/úvěr, akcie, dluhopisy, fondy/ETF, deriváty, role institucí, informační asymetrii, transformaci splatností, bilanci, tvorbu peněz a mezibankovní platby, clearing a vypořádání. Praktická aplikace z pohledu klienta i manažera je obsažena ve výkladu a čtyřech vlastních řešených příkladech. Regulaci a řízení rizik detailně ponechává tématu 3, fintech tématu 2.

## Otevřené a použité zdroje

1. **VŠE, Finanční matematika / Finanční trh**, výukový materiál k 1BP310, bez uvedeného roku; na s. 2 uveden kontakt `radova@vse.cz` (autorství dále nedovozováno). [PDF](https://esf1.vse.cz/wp-content/uploads/page/26/1BP310_FinMat_FinTrh.pdf). Použity s. 3–6 (funkce), 60–67 a 80–82 (členění a primární/sekundární trh). Materiál je výuka jiného předmětu, nikoli studentská práce nebo prezentace 1BP440. Starší tvrzení „OTC není zpravidla regulován“ a obecné T+3 se nepřebírají.
2. **Katharina Lewellen, MIT, Finance Theory II, Introduction**, 5. 2. 2003. [PDF](https://ocw.mit.edu/courses/15-402-finance-theory-ii-spring-2003/501c51301fad50e6ce8bf89c2f5f2ada_lec1bintroduction.pdf), s. 4–7 a 17. Výukový materiál: finanční systém, zdroje financování, dluh a vlastní kapitál. Historická firemní data nebyla použita.
3. **Jake Xia, MIT OCW, Topics in Mathematics with Applications in Finance — Introduction**, podzim 2013. [Přepis přednášky](https://ocw.mit.edu/courses/18-s096-topics-in-mathematics-with-applications-in-finance-fall-2013/172d154dd82133659dbf36bc4d3981ed_wvXDB9dMdEo.pdf), s. 5–10. Produkty, OTC/burza, broker/dealer, instituce a hedging. Americké historické regulace nebyly použity jako evropský právní stav.
4. **MIT OCW, 15.433 Investments, Class 1: Introduction**, jaro 2003. [PDF](https://ocw.mit.edu/courses/15-433-investments-spring-2003/d1b7a985cdbeaa9cca0cc5580ba5cf3e_154331introduction.pdf), části Institutional Perspective a Financial Innovations. Výukový materiál k institucím, fondům a ETF; v samotném PDF není jasně uveden autor, proto citován institucionálně. Historické tržní počty a aktuálnost tehdejšího uspořádání nejsou přebírány.
5. **Erkki Liikanen, ECB, Business models in banking: Is there a best practice?**, projev 21. 9. 2009. [Text](https://www.ecb.europa.eu/press/key/date/2009/html/sp090921.en.html), část What is so special about the business of banking? Funkce bank, transformace velikosti, kvality a splatnosti aktiv a sledování dlužníků. Jde o institucionální odborný projev, nikoli aktuální regulatorní předpis.
6. **ČNB, Podstata peněz a role centrálních bank**, bez data. [Vzdělávací text](https://www.cnb.cz/cs/menova-politika/vzdelavani/1.-podstata-penez-a-role-centralnich-bank/), část Tvorba peněz v moderním peněžním systému. Tvorba vkladů úvěrem, odlišení rezerv a bankovních peněz, omezení úvěrování a zánik peněz splátkou jistiny.
7. **ECB, What is a central bank?**, 10. 7. 2015. [Výklad](https://www.ecb.europa.eu/ecb-and-you/explainers/tell-me/html/what-is-a-central-bank.en.html). Role centrální banky a likviditní důsledky financování dlouhodobých aktiv krátkodobými závazky.
8. **CPSS–IOSCO/BIS, Principles for financial market infrastructures**, duben 2012. [PDF](https://www.bis.org/publications/principles-financial-market-infrastructures.pdf), zejména § 1.10–1.14, principy 4–6 a 11–12 a slovník. PDF bylo otevřeno přes odkaz na stránce publikace. Zdroj použit pro rozdíly rolí a princip správy rizik, nikoli pro tvrzení, že aktuální předpisy jsou přesně totožné s vydáním 2012.
9. **ECB, What is T2S?**, bez data. [Institucionální výklad](https://www.ecb.europa.eu/paym/target/t2s/html/index.en.html). Vypořádání cenných papírů v penězích centrální banky, delivery versus payment. Nepřebírány aktuální počty účastníků nebo ceny.
10. **ČNB, Popis systému CERTIS**, bez data. [Popis](https://www.cnb.cz/cs/platebni-styk/certis/popis-systemu-certis/). Korunové mezibankovní platby, RTGS, peníze centrální banky, fronta při nedostatku likvidity. Nevypisovány počty účastníků, poplatky ani aktuální provozní hodiny.
11. **ECB, Successful launch of new T2 wholesale payment system**, 21. 3. 2023. [Tisková zpráva](https://www.ecb.europa.eu/press/pr/date/2023/html/ecb.pr230321~f5c7bddf6d.en.html). Ověřený historický přechod z TARGET2 na T2 dne 20. 3. 2023. Nezaměněn T2 a T2S.
12. **Swift, Swift standardises payments end-to-end and gives banks ready-to-use tracking services to enhance corporate experience**, 2024. [Text](https://www.swift.com/fr/node/309531), část About Swift. Primární popis poskytovatele: finanční zprávy, bez držení klientských peněz či vedení účtů.

## Nejistoty a omezení

- Přesný výklad a důraz vyučujícího bez prezentace 1BP440 nejsou známy. Návrhy pojmů ve studijním plánu jsou vodítkem, ne dokladem testových požadavků.
- Doporučené knihy Birrer, Amstutz, Wenger (2023) a Levis (2023) nebyly dostupné v plném textu; nejsou vydávány za prostudovanou literaturu.
- Výklad neuvádí aktuální úrokové sazby ani právní limity. Ověřované provozní principy jsou uvedeny s datem zpracování; konkrétní cyklus vypořádání úmyslně není generalizován.
- Vlastní číselné příklady zanedbávají náklady, daně a další výslovně uvedené vlivy. Výstup neobsahuje nové quizové otázky; závěrečný odkaz na procvičování dodržuje kostru skillu.

## Kontrola

HTML má jednu sekci `topic-1`, název odpovídá metadatům a končí shrnutím a odkazem na procvičování. Úvěrový příklad zachovává bilanci; primární a sekundární tok peněz je rozlišen. Žádné sdílené soubory, metadata, quiz ani exporty nebyly měněny.
