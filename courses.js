/* Konfigurace předmětů — jediný zdroj pravdy pro dashboard, quiz i barvy stránek.
   Obsah za "window.COURSES =" musí zůstat čistý JSON (čte ho i quiz.py).
   topics = seznam témat ze sylabu; pořadí = číslo sekce #topic-N = subtopic v quizu
            (v harmonogramu = týden výuky, pokud sylabus neříká jinak).
   topicWeeks = volitelně týden výuky pro každé téma, když neplatí téma N = týden N (svátky, inovační týden).
   grading = jednořádkové hodnocení ze sylabu.
   events = termíny: {"date": "YYYY-MM-DD", "type": "test|zkouska|deadline|jine", "title": "..."} */
window.COURSES = [
  {
    "code": "1BP403",
    "name": "Bankovnictví II",
    "slug": "bankovnictvi-2",
    "color": "#0891B2",
    "icon": "fa-university",
    "credits": 6,
    "lang": "cz",
    "group": "P",
    "schedule": ["Př St 16:15–19:30 NB A"],
    "grading": "Semestrální práce (30 %, podmínka k testu) · Závěrečný test (70 %)",
    "topics": [
      "Bankovní bilance",
      "Úrokové, tržní a měnové riziko",
      "Podstata derivátů",
      "Forwardy, futures a swapy",
      "Opce, cap, floor, collar",
      "Likviditní riziko",
      "Úvěrové riziko a zelené úvěry",
      "Kreditní deriváty",
      "Kapitálové riziko",
      "Operační riziko",
      "Ziskovost banky",
      "Účetní zobrazení derivátů"
    ],
    "topicWeeks": [1, 2, 3, 4, 5, 8, 9, 10, 11, 12, 13, 13],
    "events": []
  },
  {
    "code": "1BP404",
    "name": "Kapitálové trhy II",
    "slug": "kapitalove-trhy-2",
    "color": "#2563EB",
    "icon": "fa-chart-line",
    "credits": 6,
    "lang": "cz",
    "group": "V",
    "schedule": ["Př Čt 09:15–12:30 NB B"],
    "topics": [],
    "events": []
  },
  {
    "code": "1BP440",
    "name": "Decentralizované a udržitelné finance",
    "slug": "decentralizovane-udrzitelne-finance",
    "color": "#16A34A",
    "icon": "fa-leaf",
    "credits": 6,
    "lang": "cz",
    "group": "P",
    "schedule": ["Př St 11:00–12:30 NB 177B", "Cv St 12:45–14:15 NB 177B"],
    "grading": "Průběžný online test 11. 11. (20 %) · Semestrální práce (30 %) · Závěrečný online test (50 %) · min. 60 bodů",
    "topics": [
      "Finanční trhy, banky a instituce",
      "Fintech",
      "CeFi: regulace a rizika",
      "Kryptoměny a blockchain",
      "DeFi ekosystém",
      "DeFi: regulace a rizika",
      "Udržitelné finanční trhy a instrumenty",
      "Veřejný sektor v udržitelných financích",
      "Udržitelné finance: regulace a rizika",
      "ESG",
      "ESG: regulace a rizika",
      "Trendy v ESG"
    ],
    "topicWeeks": [1, 2, 3, 4, 5, 8, 9, 10, 11, 12, 13, 13],
    "events": [
      {"date": "2026-11-11", "type": "test", "title": "Průběžný online test 11:00–11:20, NB177B (první polovina semestru, 20 %)"},
      {"date": "2026-11-30", "type": "jine", "title": "Termíny závěrečného testu vypsány v InSIS (3+1)"}
    ]
  },
  {
    "code": "1MT461",
    "name": "Mezinárodní finanční management",
    "slug": "mezinarodni-financni-management",
    "color": "#4F46E5",
    "icon": "fa-globe",
    "credits": 6,
    "lang": "cz",
    "group": "P",
    "schedule": ["Př Po 09:15–10:45 RB 109", "Cv Po 11:00–12:30 RB 109"],
    "grading": "Průběžný test 26. 10. (40 %) · Závěrečný test ve zkouškovém (60 %)",
    "topics": [
      "Firmy na devizovém trhu",
      "Měnové forwardy",
      "Měnové opce",
      "Technologie a motivace obchodování",
      "Investování nadnárodních firem, kurz v dlouhém období",
      "Devizová likvidita, kurz v krátkém období",
      "Transakční a ekonomická expozice",
      "Kurzové systémy",
      "Nadnárodní firmy a PZI",
      "Kurzové riziko ve financování nadnárodní firmy",
      "Cash pooling a netting"
    ],
    "topicWeeks": [1, 3, 4, 5, 6, 8, 9, 10, 11, 12, 13],
    "events": [
      {"date": "2026-10-26", "type": "test", "title": "Průběžný test (40 %)"}
    ]
  },
  {
    "code": "1BP441",
    "name": "Pojišťovnictví a Insurtech",
    "slug": "pojistovnictvi-insurtech",
    "color": "#EA580C",
    "icon": "fa-shield-alt",
    "credits": 4,
    "lang": "cz",
    "group": "P",
    "schedule": ["Př Čt 11:00–12:30 NB 177A (L)", "Př Čt 12:45–14:15 NB 177A (L)", "Cv Čt 12:45–14:15 NB 177A (S)"],
    "grading": "Semestrální práce (10 %) · Prezentace (10 %) · Průběžný test (40 %) · Závěrečný test (40 %)",
    "topics": [
      "Principy pojištění",
      "Konstrukce pojistných produktů",
      "Procesy v pojišťovně",
      "Typy pojišťoven",
      "Regulace pojišťovnictví",
      "Analýza pojistného trhu",
      "Outsourcing",
      "AI v pojišťovnictví",
      "P2P pojištění a mikropojištění",
      "Inovace v distribuci",
      "Inovace v konstrukci produktů",
      "Insurtech v procesech pojišťovny"
    ],
    "topicWeeks": [1, 1, 3, 3, 5, 5, 9, 9, 11, 11, 13, 13],
    "events": []
  },
  {
    "code": "1BP461",
    "name": "Případové studie z kapitálových trhů a bankovnictví",
    "slug": "case-studies",
    "color": "#DB2777",
    "icon": "fa-briefcase",
    "credits": 4,
    "lang": "eng",
    "group": "V",
    "schedule": ["Př Út 14:30–16:00 NB B"],
    "grading": "Semestrální práce (50 %) · Závěrečný test (50 %)",
    "topics": [
      "Kapitálové trhy",
      "Portfolio, CAPM a APT",
      "Efektivita trhu",
      "Dluhopisy a výnosová křivka",
      "Forwardy, futures a zajištění",
      "Contango a backwardation",
      "Swapy a CDS",
      "Opce a řecká písmena",
      "Dynamika cen a exotické opce",
      "Tržní riziko, VaR a ES"
    ],
    "topicWeeks": [1, 2, 3, 4, 5, 6, 8, 10, 11, 12],
    "events": []
  },
  {
    "code": "1BP443",
    "name": "Data a analytika pro finanční sektor",
    "slug": "data-analytika",
    "color": "#7C3AED",
    "icon": "fa-database",
    "credits": 3,
    "lang": "cz",
    "group": "P",
    "schedule": ["Cv St 07:30–09:00 SB 236"],
    "grading": "Datově analytické řešení a obhajoba (60 %) · Ústní zkouška (40 %) · min. 50 % z každé části",
    "topics": [
      "Data a analytika – úvod",
      "Komerční banky",
      "Centrální banka",
      "Pojišťovny",
      "Finanční zprostředkovatelé",
      "Řešení: zadání a business case",
      "Řešení: data a jejich příprava",
      "Řešení: analýza a modely",
      "Řešení: vizualizace a dashboard",
      "Prezentace a obhajoba hodnoty"
    ],
    "topicWeeks": [1, 2, 3, 4, 5, 8, 9, 10, 11, 12],
    "events": [
      {"date": "2026-12-09", "type": "deadline", "title": "Prezentace řešení I (předpoklad podle sylabu)"},
      {"date": "2026-12-16", "type": "deadline", "title": "Prezentace řešení II (předpoklad podle sylabu)"}
    ]
  }
];

/* Semestr — začátek výuky = pondělí 1. týdne. Volna: výuka v těchto dnech odpadá. */
window.SEMESTER = {
  "name": "ZS 2026/2027",
  "start": "2026-09-21",
  "weeks": 13,
  "holidays": [
    { "from": "2026-09-28", "to": "2026-09-28", "title": "Státní svátek" },
    { "from": "2026-10-28", "to": "2026-10-28", "title": "Státní svátek" },
    { "from": "2026-11-02", "to": "2026-11-06", "title": "Inovační týden" },
    { "from": "2026-11-17", "to": "2026-11-17", "title": "Státní svátek" }
  ]
};

window.courseByCode = (code) => window.COURSES.find((c) => c.code === code);

/* Na stránce předmětu (<body data-course="KÓD">) nastaví akcentovou barvu. */
(function () {
    const code = document.body && document.body.dataset.course;
    const course = code && window.courseByCode(code);
    if (course) document.body.style.setProperty('--accent', course.color);
})();
