"""Načítání a export studijních dat z data/*.json."""

import json
from datetime import date
from pathlib import Path

ROOT = Path(__file__).parent
DATA_DIR = ROOT / "data"


def read_json(name: str, data_dir: Path):
    return json.loads((data_dir / f"{name}.json").read_text(encoding="utf-8"))


def load_study_data(data_dir: Path = DATA_DIR) -> tuple[list, dict]:
    courses = read_json("courses", data_dir)
    semester = read_json("semester", data_dir)
    events = read_json("events", data_dir)
    if not isinstance(courses, list) or not isinstance(events, list) or not isinstance(semester, dict):
        raise ValueError("courses a events musí být seznamy, semester objekt.")
    date.fromisoformat(semester["start"])
    weeks = semester["weeks"]
    if type(weeks) is not int or weeks < 1:
        raise ValueError("Počet týdnů semestru musí být kladné celé číslo.")
    for holiday in semester["holidays"]:
        if date.fromisoformat(holiday["from"]) > date.fromisoformat(holiday["to"]):
            raise ValueError(f"Neplatný rozsah volna: {holiday['title']}")
    by_code = {}
    slugs = set()
    for course in courses:
        code = course["code"]
        if code in by_code or course["slug"] in slugs:
            raise ValueError(f"Duplicitní kód nebo slug předmětu: {code}")
        if "events" in course:
            raise ValueError(f"Termíny {code} patří do events.json.")
        for field in ("schedule", "topics"):
            if not isinstance(course[field], list) or not all(isinstance(item, str) for item in course[field]):
                raise ValueError(f"{code}: {field} musí být seznam textů.")
        if "topicWeeks" in course:
            topic_weeks = course["topicWeeks"]
            if len(topic_weeks) != len(course["topics"]) or any(
                type(week) is not int or not 1 <= week <= weeks for week in topic_weeks
            ):
                raise ValueError(f"{code}: topicWeeks musí přiřazovat platný týden každému tématu.")
        by_code[code] = course
        slugs.add(course["slug"])
        course["events"] = []
    for event in events:
        code = event["courseCode"]
        if code not in by_code:
            raise ValueError(f"Termín odkazuje na neznámý předmět: {code}")
        date.fromisoformat(event["date"])
        if event["type"] not in {"test", "zkouska", "deadline", "jine"}:
            raise ValueError(f"Neznámý typ termínu: {event['type']}")
        if not isinstance(event["title"], str) or not event["title"].strip():
            raise ValueError(f"Termín {code} musí mít název.")
        by_code[code]["events"].append({key: value for key, value in event.items() if key != "courseCode"})
    return courses, semester


def load_courses() -> dict:
    courses, _ = load_study_data()
    return {course["code"]: course for course in courses}


def export_study_data(output: Path = ROOT / "study-data.js"):
    courses, semester = load_study_data()
    source = "// Generováno z data/*.json příkazem python3 quiz.py export. Neupravovat ručně.\n"
    for name, value in (("COURSES", courses), ("SEMESTER", semester)):
        source += f"window.{name} = {json.dumps(value, ensure_ascii=False, indent=2)};\n"
    output.write_text(source, encoding="utf-8")
    print(f"Exportováno {len(courses)} předmětů a nastavení semestru → {output}")
