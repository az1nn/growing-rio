from pathlib import Path
import re

ROOT = Path(__file__).resolve().parents[1]
BALANCE = ROOT / "specs/009-campaign-calendar-lifecycle/balance.md"

EXPECTED = [
    ("seedling", 0, 22, 22),
    ("Vega", 22, 45, 23),
    ("flora", 45, 68, 23),
    ("late flowering", 68, 90, 22),
]
TERMINAL_STAGE = "pronta"
TERMINAL_START = 90

text = BALANCE.read_text(encoding="utf-8")

row_pattern = re.compile(
    r"\| \`(?P<stage>[^\`]+)\` \| \`(?P<start>\d+) <= grow_day < (?P<end>\d+)\` \| (?P<span>\d+) days \|"
)
rows = [
    (
        match.group("stage"),
        int(match.group("start")),
        int(match.group("end")),
        int(match.group("span")),
    )
    for match in row_pattern.finditer(text)
]

errors = []
if rows != EXPECTED:
    errors.append(f"unexpected pre-ready lifecycle rows: {rows!r}")

terminal_match = re.search(
    r"\| \`pronta\` \| \`grow_day >= (?P<start>\d+)\` \| terminal/readiness \|",
    text,
)
if terminal_match is None:
    errors.append("missing pronta terminal/readiness row")
elif int(terminal_match.group("start")) != TERMINAL_START:
    errors.append("pronta must begin exactly at grow_day >= 90")

if rows:
    if rows[0][1] != 0:
        errors.append("pre-ready lifecycle must begin at grow_day 0")

    previous_end = 0
    coverage = [None] * TERMINAL_START
    stage_order = [stage for stage, *_ in EXPECTED]

    for index, (stage, start, end, span) in enumerate(rows):
        if start != previous_end:
            errors.append(
                f"non-contiguous boundary before {stage}: expected {previous_end}, got {start}"
            )
        if end <= start:
            errors.append(f"non-monotonic range for {stage}: [{start},{end})")
        if span != end - start:
            errors.append(
                f"span mismatch for {stage}: declared {span}, actual {end - start}"
            )

        for grow_day in range(max(0, start), min(TERMINAL_START, end)):
            if coverage[grow_day] is not None:
                errors.append(
                    f"grow_day {grow_day} maps to multiple stages: "
                    f"{coverage[grow_day]} and {stage}"
                )
            coverage[grow_day] = stage

        if stage != stage_order[index]:
            errors.append(f"stage order mismatch at index {index}: {stage}")
        previous_end = end

    if previous_end != TERMINAL_START:
        errors.append(
            f"pre-ready lifecycle must end exactly at {TERMINAL_START}, got {previous_end}"
        )

    missing = [day for day, stage in enumerate(coverage) if stage is None]
    if missing:
        errors.append(f"uncovered pre-ready grow_day values: {missing}")

if "not a horticultural model" not in text:
    errors.append("missing explicit non-horticultural model boundary")
if "MUST NOT be used as real cultivation guidance" not in text:
    errors.append("missing explicit no-real-cultivation-guidance boundary")

if errors:
    print("FEATURE 009 BALANCE VALIDATION FAILED")
    for error in errors:
        print("-", error)
    raise SystemExit(1)

print("FEATURE 009 BALANCE VALIDATION PASSED")
print("stage order: seedling -> Vega -> flora -> late flowering -> pronta")
print("pre-ready coverage: grow_day 0..89 exactly once")
print("terminal readiness: grow_day >= 90")
