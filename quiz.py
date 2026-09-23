#!/usr/bin/env python3
import sqlite3
import random
import sys
import os
import json
import re
from pathlib import Path

ROOT = Path(__file__).parent
DB_PATH = ROOT / "quiz.db"


def load_courses() -> dict:
    """Kód předmětu → název, načteno z courses.js (JSON za 'window.COURSES =')."""
    src = (ROOT / "courses.js").read_text(encoding="utf-8")
    match = re.search(r"window\.COURSES = (\[.*?\n\]);", src, re.S)
    return {c["code"]: c for c in json.loads(match.group(1))}


def get_db():
    conn = sqlite3.connect(DB_PATH)
    conn.row_factory = sqlite3.Row
    return conn


def init_db():
    with get_db() as conn:
        conn.executescript("""
            CREATE TABLE IF NOT EXISTS questions (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                topic TEXT NOT NULL,
                question TEXT NOT NULL,
                option_a TEXT NOT NULL,
                option_b TEXT NOT NULL,
                option_c TEXT NOT NULL,
                option_d TEXT NOT NULL,
                correct TEXT NOT NULL CHECK(correct IN ('A','B','C','D')),
                explanation TEXT,
                created_at TEXT DEFAULT (datetime('now'))
            );
        """)
        columns = [r["name"] for r in conn.execute("PRAGMA table_info(questions)")]
        if "subtopic" not in columns:
            conn.execute("ALTER TABLE questions ADD COLUMN subtopic INTEGER")


def add_questions(questions_json: str):
    """Add questions from JSON string. Called by Claude."""
    questions = json.loads(questions_json)
    courses = load_courses()
    unknown = {q["topic"] for q in questions} - courses.keys()
    if unknown:
        print(f"Neznámý kód předmětu: {', '.join(sorted(unknown))} (povolené: {', '.join(courses)})")
        sys.exit(1)
    with get_db() as conn:
        for q in questions:
            conn.execute(
                """INSERT INTO questions (topic, subtopic, question, option_a, option_b, option_c, option_d, correct, explanation)
                   VALUES (:topic, :subtopic, :question, :option_a, :option_b, :option_c, :option_d, :correct, :explanation)""",
                {"subtopic": None, **q},
            )
    print(f"Přidáno {len(questions)} otázek.")


def list_questions(topic: str | None = None):
    with get_db() as conn:
        if topic:
            rows = conn.execute(
                "SELECT id, topic, subtopic, question, correct FROM questions WHERE topic LIKE ? ORDER BY topic, subtopic, id",
                (f"%{topic}%",),
            ).fetchall()
        else:
            rows = conn.execute(
                "SELECT id, topic, subtopic, question, correct FROM questions ORDER BY topic, subtopic, id"
            ).fetchall()

    if not rows:
        print("Žádné otázky nenalezeny.")
        return

    current_topic = None
    for r in rows:
        if r["topic"] != current_topic:
            current_topic = r["topic"]
            print(f"\n── {current_topic} ──")
        sub = f"T{r['subtopic']} " if r["subtopic"] else ""
        print(f"  [{r['id']}] {sub}{r['question'][:80]}{'…' if len(r['question']) > 80 else ''}")
    print(f"\nCelkem: {len(rows)} otázek")


def list_topics():
    with get_db() as conn:
        rows = conn.execute(
            "SELECT topic, subtopic, COUNT(*) as cnt FROM questions GROUP BY topic, subtopic"
        ).fetchall()
    counts = {}
    for r in rows:
        counts.setdefault(r["topic"], {})[r["subtopic"]] = r["cnt"]
    print("\nPředměty:")
    for code, course in load_courses().items():
        by_sub = counts.get(code, {})
        detail = ", ".join(f"T{k}: {v}" for k, v in sorted(by_sub.items(), key=lambda kv: kv[0] or 0) if k)
        print(f"  {code} {course['name']} — {sum(by_sub.values())} otázek{f' ({detail})' if detail else ''}")


def run_quiz(topic: str | None = None, count: int = 10):
    with get_db() as conn:
        if topic:
            rows = conn.execute(
                "SELECT * FROM questions WHERE topic LIKE ?", (f"%{topic}%",)
            ).fetchall()
        else:
            rows = conn.execute("SELECT * FROM questions").fetchall()

    if not rows:
        print("Žádné otázky pro toto téma.")
        return

    questions = random.sample(rows, min(count, len(rows)))
    score = 0

    print(f"\n=== QUIZ{f': {topic}' if topic else ''} — {len(questions)} otázek ===\n")

    for i, q in enumerate(questions, 1):
        print(f"[{i}/{len(questions)}] {q['question']}")
        print(f"  A) {q['option_a']}")
        print(f"  B) {q['option_b']}")
        print(f"  C) {q['option_c']}")
        print(f"  D) {q['option_d']}")

        while True:
            answer = input("\nTvoje odpověď (A/B/C/D nebo q=konec): ").strip().upper()
            if answer == "Q":
                print(f"\nUkončeno. Skóre: {score}/{i-1}")
                return
            if answer in ("A", "B", "C", "D"):
                break
            print("Zadej A, B, C nebo D.")

        correct = q["correct"]
        if answer == correct:
            print("✓ Správně!")
            score += 1
        else:
            print(f"✗ Špatně. Správná odpověď: {correct}) {q[f'option_{correct.lower()}']}")

        if q["explanation"]:
            print(f"  → {q['explanation']}")
        print()

    pct = round(score / len(questions) * 100)
    print(f"=== VÝSLEDEK: {score}/{len(questions)} ({pct}%) ===")


def delete_question(qid: int):
    with get_db() as conn:
        conn.execute("DELETE FROM questions WHERE id = ?", (qid,))
    print(f"Otázka {qid} smazána.")


def export_json(output: str = "quiz-data.js"):
    with get_db() as conn:
        rows = conn.execute("SELECT * FROM questions ORDER BY topic, subtopic, id").fetchall()
    data = [dict(r) for r in rows]
    out_path = ROOT / output
    with open(out_path, "w", encoding="utf-8") as f:
        f.write("window.QUIZ_DATA = ")
        json.dump(data, f, ensure_ascii=False, indent=2)
        f.write(";\n")
    print(f"Exportováno {len(data)} otázek → {out_path}")
    export_plans()


def export_plans(output: str = "plans-data.js"):
    """Studijní plány podklady/<KÓD>/studijni_plan.md → plans-data.js (plan.html)."""
    plans = {
        path.parent.name: path.read_text(encoding="utf-8")
        for path in sorted((ROOT / "podklady").glob("*/studijni_plan.md"))
    }
    out_path = ROOT / output
    with open(out_path, "w", encoding="utf-8") as f:
        f.write("window.PLANS = ")
        json.dump(plans, f, ensure_ascii=False, indent=2)
        f.write(";\n")
    print(f"Exportováno {len(plans)} studijních plánů → {out_path}")


def show_help():
    print("""
Použití:
  python quiz.py quiz [téma] [--count N]   Spustit quiz (volitelně filtrovat téma, výchozí 10 otázek)
  python quiz.py list [téma]               Vypsat otázky
  python quiz.py topics                    Počty otázek po předmětech a tématech
  python quiz.py delete <id>               Smazat otázku
  python quiz.py add '<json>'              Přidat otázky z JSON (používá Claude)
  python quiz.py export                    Export do quiz-data.js a plans-data.js pro webový frontend

Téma = kód předmětu z courses.js (např. 1BP403), subtopic = číslo tématu (#topic-N).

Příklady:
  python quiz.py quiz 1BP403
  python quiz.py quiz --count 5
  python quiz.py list 1BP404
  python quiz.py export
""")


def main():
    init_db()
    args = sys.argv[1:]

    if not args or args[0] in ("-h", "--help", "help"):
        show_help()
        return

    cmd = args[0]

    if cmd == "quiz":
        topic = None
        count = 10
        rest = args[1:]
        filtered = []
        i = 0
        while i < len(rest):
            if rest[i] == "--count" and i + 1 < len(rest):
                count = int(rest[i + 1])
                i += 2
            else:
                filtered.append(rest[i])
                i += 1
        if filtered:
            topic = " ".join(filtered)
        run_quiz(topic, count)

    elif cmd == "list":
        topic = " ".join(args[1:]) if len(args) > 1 else None
        list_questions(topic)

    elif cmd == "topics":
        list_topics()

    elif cmd == "delete":
        if len(args) < 2:
            print("Zadej ID otázky.")
            sys.exit(1)
        delete_question(int(args[1]))

    elif cmd == "add":
        if len(args) < 2:
            print("Zadej JSON jako argument.")
            sys.exit(1)
        add_questions(args[1])

    elif cmd == "export":
        export_json()

    else:
        print(f"Neznámý příkaz: {cmd}")
        show_help()
        sys.exit(1)


if __name__ == "__main__":
    main()
