# Kontrola kompletního kvízu 1BP440

Dokončeno 1. 10. 2026. **96 otázek, osm pro každé z 12 témat**, vloženo do databáze po obsahové kontrole koordinátora. Otázky vycházejí z dokončených poznámek; jde o vlastní procvičování, nikoli otázky od vyučujícího.

Správné pozice: A = 24, B = 24, C = 24, D = 24. Pořadí otázek při importu promícháno.

Při shodě délky se započítává náhodný výběr mezi možnostmi se shodným maximem či minimem. Náhodné hádání ze čtyř možností má 25 %.

| Téma | Počet | Nejdelší: znaky | Nejdelší: slova | Nejkratší: znaky | Nejkratší: slova |
|---|---:|---:|---:|---:|---:|
| 1 | 8 | 35.42 % | 18.75 % | 6.25 % | 27.08 % |
| 2 | 8 | 25.00 % | 22.92 % | 39.58 % | 22.92 % |
| 3 | 8 | 8.33 % | 44.79 % | 0.00 % | 21.88 % |
| 4 | 8 | 25.00 % | 22.92 % | 31.25 % | 22.92 % |
| 5 | 8 | 29.17 % | 25.00 % | 12.50 % | 25.00 % |
| 6 | 8 | 16.67 % | 8.33 % | 37.50 % | 27.08 % |
| 7 | 8 | 25.00 % | 22.92 % | 12.50 % | 33.33 % |
| 8 | 8 | 21.88 % | 19.79 % | 26.04 % | 32.29 % |
| 9 | 8 | 32.29 % | 13.54 % | 21.88 % | 23.96 % |
| 10 | 8 | 28.12 % | 22.92 % | 21.88 % | 27.08 % |
| 11 | 8 | 26.04 % | 32.29 % | 13.54 % | 13.54 % |
| 12 | 8 | 37.50 % | 34.38 % | 6.25 % | 21.87 % |
| **Celkem** | **96** | **25.87 %** | **24.05 %** | **19.10 %** | **24.91 %** |

Malé sady osmi otázek mohou výrazně kolísat; hlavním doplňkem statistiky byla kontrola všech zadání, možností a vysvětlení. Přepracovány zjevně nesouvisející distraktory u BaaS, P2P, pákového poměru, MEV a smart kontraktů; zpřesněny otázky o EuGB, TNFD, závislosti na vodě a případném poplatku flash loan.

Ověřeny výpočty a jediná správná odpověď při zadaných předpokladech. Kontrola konkrétnosti sledovala srovnatelné podmínky, odborné výrazy a podrobnost možností; délka nebyla vyrovnávána výplní. Ověřena také opačná nápověda podle nejkratší odpovědi.

Technická kontrola: validní JSON, správné vazby na témata 1–12, jedinečná zadání a čtyři různé možnosti, vysvětlení v prostém textu bez TeXu, integrita SQLite. Existujících 148 otázek ostatních předmětů zachováno.
