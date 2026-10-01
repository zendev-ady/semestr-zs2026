# Kontrola kvízu – témata 7–12

Dokončeno 1. 10. 2026 podle `.claude/skills/semestr/otazky.md`. Obsah vychází z hotových HTML fragmentů; aktuální regulatorní stav v poznámkách je ověřován k 30. 9. 2026. Žádná nová obecná rešerše ani změna databáze/exportů nebyla provedena.

**48 otázek, 8 na každé téma.** Výstupy: `topic-7-otazky.json` až `topic-12-otazky.json`. Každý soubor je JSON pole objektů pro `topic: 1BP440` a odpovídající `subtopic`. Výpočty a vysvětlení používají prostý text a Unicode, nikoli HTML či TeX.

## Audit délky

Při shodě extrému je započtena pravděpodobnost 1 / počet shodných možností, je-li mezi nimi správná. Základ pro porovnání je náhodné hádání 25 %. Počty znaků zahrnují mezery, slova jsou oddělena bílými znaky.

| Téma | Otázek | Nejdelší: znaky | Nejdelší: slova | Nejkratší: znaky | Nejkratší: slova |
|---|---:|---:|---:|---:|---:|
| 7 | 8 | 25,00 % | 22,92 % | 12,50 % | 33,33 % |
| 8 | 8 | 21,88 % | 19,79 % | 26,04 % | 32,29 % |
| 9 | 8 | 32,29 % | 13,54 % | 21,88 % | 23,96 % |
| 10 | 8 | 28,12 % | 22,92 % | 21,88 % | 27,08 % |
| 11 | 8 | 26,04 % | 32,29 % | 13,54 % | 13,54 % |
| 12 | 8 | 37,50 % | 34,38 % | 6,25 % | 21,88 % |
| Celkem | 48 | 28,47 % | 24,31 % | 17,01 % | 25,35 % |

První verze měla v některých tématech téměř vždy krátkou správnou možnost. Byly přeformulovány celé možnosti s využitím potřebné informace, ne prodlouženy výplní. Výsledná sada nevykazuje soustavnou výhodu volby nejdelší nebo nejkratší možnosti; malé osmipoložkové části přirozeně kolísají. Téma 12 bylo kvůli vyššímu výsledku nejdelší znovu přečteno: správné možnosti nemají výhradní podmínky, odborný styl či vysvětlení, které by ostatní postrádaly.

## Obsahová a technická kontrola

- Každé téma má A/B/C/D po dvou správných odpovědích, celkem po dvanácti. Pořadí mezi tématy není opakující sekvence ABCD.
- Prověřena jedna správná odpověď za uvedených podmínek; číselné příklady mají podmínky v zadání a zkontrolovaný výsledek. Vysvětlení mají 2–3 věty a rozlišují správnou odpověď od chybných mechanismů.
- Zkontrolována gramatická návaznost a konkrétnost. Slabé distraktory byly nahrazeny skutečnými záměnami: právní versus tržní standard EuGB/ICMA, povinný versus dobrovolný reporting TNFD a jeho přírodní versus čistě klimatický rozsah.
- U vody je v zadání výslovně odlišena **potřeba vody pro provoz** od **znečišťování**, protože samotný odběr může současně mít dopad. U SFDR nejsou články vykládány jako stupnice bezpečnosti.
- U firemních povinností není přijetí evropské směrnice zaměněno za dokončenou českou transpozici. Revidované ESRS nejsou vydávány za pouhý návrh; oddělena je použitelnost pro účetní období.
- Ověřena validita všech šesti JSON souborů, čtyři různé možnosti každé otázky, povolená správná pozice, kód předmětu a absence HTML/TeX ve vysvětleních.

Import, kontrola celé sady 1–12 a export zůstávají koordinátorovi. Tyto otázky jsou vlastní procvičování, nikoli doložené otázky vyučujícího.
