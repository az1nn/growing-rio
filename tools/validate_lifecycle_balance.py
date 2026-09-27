from __future__ import annotations

import json
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
CONTRACT = ROOT / "specs/009-campaign-calendar-lifecycle/balance.json"
DOC = ROOT / "specs/009-campaign-calendar-lifecycle/balance.md"

EXPECTED_STAGE_IDS = ["seedling", "Vega", "flora", "late flowering"]
EXPECTED_READY_ID = "pronta"
EXPECTED_CYCLE_DAYS = 90

errors: list[str] = []

try:
    data = json.loads(CONTRACT.read_text(encoding="utf-8"))
except (OSError, json.JSONDecodeError) as exc:
    raise SystemExit(f"Feature 009 balance contract unreadable: {exc}")

if data.get("purpose") != "game_pacing_only":
    errors.append("purpose must be game_pacing_only")
if data.get("cultivation_guidance") is not False:
    errors.append("cultivation_guidance must be false")
if data.get("cycle_days") != EXPECTED_CYCLE_DAYS:
    errors.append(f"cycle_days must equal {EXPECTED_CYCLE_DAYS}")

stages = data.get("pre_ready_stages")
if not isinstance(stages, list) or len(stages) != len(EXPECTED_STAGE_IDS):
    errors.append("pre_ready_stages must contain exactly four stages")
    stages = []

ids = [stage.get("id") for stage in stages if isinstance(stage, dict)]
if ids != EXPECTED_STAGE_IDS:
    errors.append(f"stage ids/order must be {EXPECTED_STAGE_IDS!r}")

coverage: list[int] = []
previous_end = 0
for index, stage in enumerate(stages):
    if not isinstance(stage, dict):
        errors.append(f"stage {index} must be an object")
        continue
    start = stage.get("start_day")
    end = stage.get("end_day_exclusive")
    if not isinstance(start, int) or not isinstance(end, int):
        errors.append(f"stage {index} boundaries must be integers")
        continue
    if start != previous_end:
        errors.append(f"stage {index} must start at {previous_end}, got {start}")
    if end <= start:
        errors.append(f"stage {index} must have a positive span")
    coverage.extend(range(start, end))
    previous_end = end

expected_coverage = list(range(EXPECTED_CYCLE_DAYS))
if coverage != expected_coverage:
    errors.append("pre-ready stages must cover each integer grow_day 0..89 exactly once")
if previous_end != EXPECTED_CYCLE_DAYS:
    errors.append(f"pre-ready stages must end at {EXPECTED_CYCLE_DAYS}")

ready = data.get("ready_stage")
if not isinstance(ready, dict):
    errors.append("ready_stage must be an object")
else:
    if ready.get("id") != EXPECTED_READY_ID:
        errors.append(f"ready stage id must be {EXPECTED_READY_ID}")
    if ready.get("start_day") != EXPECTED_CYCLE_DAYS:
        errors.append(f"{EXPECTED_READY_ID} must begin exactly at day {EXPECTED_CYCLE_DAYS}")

try:
    doc = DOC.read_text(encoding="utf-8").lower()
except OSError as exc:
    errors.append(f"balance.md unreadable: {exc}")
else:
    required_doc_phrases = [
        "game-pacing",
        "not a horticultural model",
        "not real cultivation guidance",
    ]
    for phrase in required_doc_phrases:
        if phrase not in doc:
            errors.append(f"balance.md missing safety/purpose phrase: {phrase!r}")

if errors:
    for error in errors:
        print(f"ERROR: {error}")
    raise SystemExit(1)

print("Feature 009 lifecycle balance validation passed.")
