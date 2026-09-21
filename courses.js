/* Konfigurace předmětů — jediný zdroj pravdy pro dashboard, quiz i barvy stránek.
   Obsah za "window.COURSES =" musí zůstat čistý JSON (čte ho i quiz.py).
   topics = seznam témat ze sylabu; pořadí = číslo sekce #topic-N = subtopic v quizu
            (v harmonogramu = týden výuky, pokud sylabus neříká jinak).
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
    "topics": [],
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
    "topics": [],
    "events": []
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
    "topics": [],
    "events": []
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
    "topics": [],
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
    "schedule": ["Cv Út 14:30–16:00 NB B"],
    "topics": [],
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
    "topics": [],
    "events": []
  }
];

/* Semestr — ověřit v harmonogramu VŠE (začátek výuky = pondělí 1. týdne). */
window.SEMESTER = { "name": "ZS 2026/2027", "start": "2026-09-21", "weeks": 13 };

window.courseByCode = (code) => window.COURSES.find((c) => c.code === code);

/* Na stránce předmětu (<body data-course="KÓD">) nastaví akcentovou barvu. */
(function () {
    const code = document.body && document.body.dataset.course;
    const course = code && window.courseByCode(code);
    if (course) document.body.style.setProperty('--accent', course.color);
})();
