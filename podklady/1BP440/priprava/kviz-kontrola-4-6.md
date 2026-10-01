# Kontrola kvízu 1BP440 — témata 4–6

Celkem 24 otázek, po 8 pro témata 4, 5 a 6. Zdrojem jsou hotové HTML fragmenty těchto témat a instrukce `.claude/skills/semestr/otazky.md`; bez nové rešerše. Výstupy mají požadovaný JSON formát, prostý text bez HTML a TeXu. Do DB ani exportů nebylo zapisováno.

| Téma | Počet | Nejdelší: znaky | Nejkratší: znaky | Nejdelší: slova | Nejkratší: slova |
|---|---:|---:|---:|---:|---:|
| 4 | 8 | 25.00 % | 31.25 % | 22.92 % | 22.92 % |
| 5 | 8 | 29.17 % | 12.50 % | 25.00 % | 25.00 % |
| 6 | 8 | 16.67 % | 37.50 % | 8.33 % | 27.08 % |
| celkem | 24 | 23.61 % | 27.08 % | 18.75 % | 25.00 % |

Při shodě délek se započítává náhodný výběr mezi všemi shodnými možnostmi: správná mezi k shodami přispívá 1/k. Znaky počítány včetně mezer a interpunkce; slova rozdělením podle mezer. Referenční náhodné hádání je 25 %. Odchylky v osmipoložkových sadách byly obsahově zkontrolovány; žádná délková strategie nemá soustavnou výhodu napříč tématy.

Správné pozice jsou v každém tématu A/B/C/D po dvou, celkem po šesti. Sekvence: téma4 B,D,A,C,C,A,D,B; téma5 D,B,C,A,B,D,A,C; téma6 A,C,B,D,A,D,C,B. Nejde o opakující se cyklus.

Obsahová kontrola ověřila právě jednu správnou odpověď za uvedených podmínek, návaznost na poznámky, srovnatelnou konkrétnost a gramatiku. Podle review root byly nahrazeny slabé distraktory u faktické decentralizace, vyvolání kontraktu, oracle a MEV reálnými záměnami. Vysvětlení mají 2–3 věty a rozebírají mechanismus, nikoli jen označení správné možnosti.

Početní kontrola: UTXO poplatek0,001BTC; gas0,000378ETH; AMM0,9091ETH; IL−20%; HF0,96; korunovývýnos−23%; růstTVL50%; likvidačníschodek3000USD; depeg9000USD. MiCA přechod končící1.7.2026 je vztahován k září2026; vlastní klíč ani marketingDeFi nevytvářejí automatickou regulatorní výjimku.
