# Zadání pro přípravu poznámek — 1BP440

Stav: dokončeno 1. 10. 2026. Všech 12 témat je zkontrolováno a vloženo do stránky předmětu; 96 kvízových otázek (8 na téma) je vloženo do databáze a exportováno pro web. Použitý model GPT-6.1 Sol, reasoning medium. Zdrojové reporty a souhrnný audit kvízu jsou v `priprava/`.

## Cíl a rozsah

Připravit poznámky na celý semestr předmětu **Decentralizované a udržitelné finance**, všech 12 témat. Student chce snadno čitelné poznámky, které mu pomohou pochopit problematiku a vysvětlí složité pojmy. Styl a podoba výstupu se řídí `.claude/skills/semestr/SKILL.md`, včetně pravidel pro zdroje. Nepřidávat další pevná pravidla pro tabulky, délku kapitol nebo členění výkladu.

Aktuálně dostupné podklady:

- `podklady/1BP440/sylabus.txt` — rozsah a výsledky učení z InSIS.
- `podklady/1BP440/studijni_plan.md` — osnova, organizace a návrhy klíčových pojmů.
- `data/courses.json` — závazná čísla a názvy témat pro web.
- `courses/decentralizovane-udrzitelne-finance.html` — existující stránka s organizací předmětu, do níž koordinátor vkládá zkontrolované odborné sekce.
- `shared.css` — existující vzhled poznámek.

Studijní plán a stránka odkazují na úvodní prezentaci z 23. 9. 2026, ale její původní soubor při přípravě zadání nebyl v `podklady/1BP440/`. Nejde proto o dostupný zdroj k nezávislému ověření. Před spuštěním znovu zkontrolovat nové podklady. Odhadované týdny výuky a návrhy pojmů nejsou potvrzeným obsahem přednášek.

Poznámky a sada otázek mají zadání níže. Uživatel následně autorizoval souběžnou tvorbu otázek k již dokončeným a zkontrolovaným tématům; k tématům 11–12 se otázky doplní po jejich dokončení. Týmová práce „Regulace fintech“ a její Word/PPTX výstupy mají samostatné zadání.

## Společný prompt pro autora přednáškového tématu

> Připrav své přidělené přednáškové téma poznámek pro předmět 1BP440 podle `.claude/skills/semestr/SKILL.md`. Nejprve přečti sylabus, studijní plán, údaje předmětu v `data/courses.json`, existující stránku a `shared.css`.
>
> Cílem jsou srozumitelné poznámky pro pochopení i přípravu na test: co pojem znamená, proč mechanismus funguje a jak jej použít v praktické situaci. Vysvětluj složité pojmy podle pravidel skillu. Zachovej odbornou správnost; u zjednodušení vysvětli podstatné podmínky platnosti. Sylabus zdůrazňuje pohled klienta i manažera finanční instituce.
>
> Rozsah určuje sylabus. Klíčové pojmy ze studijního plánu použij jako vodítko k rešerši, nikoli jako doložené požadavky vyučujícího. Příklady testových otázek označ jako vlastní procvičování, pokud nemáš skutečné otázky od vyučujícího.
>
> Proveď internetovou rešerši podle části „Zdroje a ověřování“ ve skillu: nejprve VŠE a dostupná doporučená literatura, dále oficiální materiály renomovaných univerzit. Regulaci a současná data ověřuj v primárních institucionálních zdrojích. Zdroj před použitím otevři a uveď dohledatelný odkaz, případně stránku. Pokud kniha není dostupná, nenaznačuj, že jsi ji použil. U materiálů VŠE rozlišuj výukový materiál, odborný článek a studentskou práci.
>
> Regulatorní stav a trendy ověř k datu skutečného zpracování a toto datum uveď. Rozlišuj platné a účinné předpisy, návrhy změn, přechodná období a historický stav. Starší seznam zkratek v plánu nepřebírej jako aktuální právní stav. Nepřipisuj předem připravený výklad konkrétní přednášce bez původního podkladu.
>
> Drž pořadí a přiřazení témat podle harmonogramu níže. Odevzdej HTML fragment se svou sekcí `topic-N` podle skillu a krátký Markdown přehled použitých zdrojů, pokrytí sylabu a zbývajících nejistot. Piš pouze do přidělených souborů pod `podklady/1BP440/priprava/`. Sdílenou stránku, metadata, quiz a exporty spravuje koordinátor. Adresář pro výstupy založ až při skutečném zpracování.

## Přidělení podle harmonogramu přednášek

Jednotkou zadání je jednotlivé přednáškové téma. Každý autor dostane společný prompt a číslo tématu s odpovídajícími podklady. Poznámky i jejich integrace zachovají pořadí harmonogramu; témata neslučovat do čtyř bloků.

Harmonogram přebíráme ze `studijni_plan.md`. Jeho přiřazení témat k datům je zatím návrh; pokud přibude oficiální harmonogram od vyučujícího, má přednost. Datum v tabulce není důkazem, že konkrétní výklad zazněl na dané přednášce.

| Týden | Datum 2026 | Téma / sekce |
|---|---|---|
| 1 | 23. 9. | 1. Finanční trhy, banky a finanční instituce |
| 2 | 30. 9. | 2. Fintech |
| 3 | 7. 10. | 3. Centralizované finance: regulace a rizika |
| 4 | 14. 10. | 4. Kryptoměny, blockchain a smart kontrakty |
| 5 | 21. 10. | 5. DeFi ekosystém |
| 6 | 28. 10. | Státní svátek — bez výuky |
| 7 | 4. 11. | Inovační týden — bez pravidelné výuky |
| 8 | 11. 11. | Průběžný test; 6. DeFi: regulace a rizika |
| 9 | 18. 11. | 7. Udržitelné finanční trhy, infrastruktura a instrumenty |
| 10 | 25. 11. | 8. Role veřejného sektoru v udržitelných financích |
| 11 | 2. 12. | 9. Udržitelné finance: regulace a rizika |
| 12 | 9. 12. | 10. ESG |
| 13 | 16. 12. | 11. ESG: regulace a rizika; 12. Trendy v ESG |

Výstupy každého tématu při spuštění: `podklady/1BP440/priprava/topic-N.html` a `podklady/1BP440/priprava/topic-N-zdroje.md`. Témata 11 a 12 jsou podle současného harmonogramu na jedné přednášce, ale zachovají své dvě sekce a čísla.

## Návaznosti mezi tématy

- Pojmy vysvětluj v příslušném přednáškovém tématu podle harmonogramu a studijního plánu. Banky a instituce patří do tématu 1, fintech do tématu 2.
- Na dřívější výklad odkazuj přes `#topic-N`; potřebný základ krátce připomeň. Případné překryvy řeš návazností, ne změnou pořadí nebo sloučením témat.
- Regulaci a rizika vysvětluj v kontextu příslušného tématu. Udržuj jednotnou terminologii napříč přednáškami.

## Zadání pro koordinátora a kontrolu

Po autorizovaném spuštění přiděluj jednotlivá přednášková témata v pořadí harmonogramu. Při omezeném počtu souběžných agentů spouštěj další témata postupně. Výsledky integruj v pořadí témat 1–12. Sdílené soubory upravuje jen koordinátor.

Před vložením výstupů zkontroluj:

- pokrytí všech bodů sylabu a výsledků učení, nejen návrhů ve studijním plánu;
- vysvětlení složitých pojmů, návaznost a správnost řešených příkladů;
- skutečnou podporu tvrzení v citovaných zdrojích, hlavně regulace, čísel a trendů;
- jednotnou terminologii a návaznosti mezi přednáškovými tématy bez zbytečných duplicit;
- označení externích doplnění a nejistot, bez smyšlených údajů o přednáškách.

Opravy vrať příslušnému autorovi nebo je proveď při integraci. Výstupy vlož do existující stránky, doplň obsah a odstraň placeholder. Zachovej organizaci předmětu, harmonogram a skripty. Nevytvářej samostatnou novou stránku ani neměň čísla témat.

Technickou kontrolu proveď podle skillu: vazby témat a navigace, validita dat a požadované exporty.

## Následná fáze — sada otázek

Po dokončení a kontrole poznámek vytvoř otázky podle `.claude/skills/semestr/otazky.md`, po jednotlivých tématech ve stejném pořadí harmonogramu. Rozsah přibližně 8–12 otázek na téma přizpůsob jeho obsahu. Otázky musí vycházet z dokončených poznámek a ověřovat pojmy, mechanismy a aplikaci v situacích klienta nebo manažera finanční instituce.

> Správná odpověď nesmí být poznatelná tím, že je nejdelší nebo nejkonkrétnější. Všechny čtyři možnosti formuluj se srovnatelnou podrobností a stylem. Chybné možnosti založ na skutečných záměnách a chybách, nikoli na absurdních tvrzeních. Společné podmínky patří do zadání a zdůvodnění do vysvětlení. Délku nevyrovnávej výplní ani na úkor správnosti.
>
> Před předáním proveď obsahovou kontrolu i audit nápověd podle `otazky.md`. Uveď počet otázek a úspěšnost výběru nejdelší možnosti podle znaků i slov, se shodami započtenými jako náhodný výběr mezi nejdelšími. Zkontroluj také konkrétnost a styl — délková statistika sama nestačí. Odhalené nápovědy oprav a kontrolu zopakuj.

Autoři odevzdají otázky do `podklady/1BP440/priprava/topic-N-otazky.json` ve formátu podle `otazky.md`. Koordinátor zkontroluje i celou spojenou sadu a teprve potom vloží otázky do databáze a provede export; do sdílené databáze nepíše více agentů současně.
