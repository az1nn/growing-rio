#!/usr/bin/env python3
"""Validate the canonical DA LATA validation latency contract."""

from __future__ import annotations

import json
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
CONTRACT = ROOT / "tools" / "validation_latency_budgets.json"
DOC = ROOT / "docs" / "VALIDATION-LATENCY-BUDGETS.md"

REQUIRED_DIMENSIONS = {
    "queue_ms",
    "bootstrap_ms",
    "ready_wait_ms",
    "execute_ms",
    "artifact_ms",
    "total_ms",
}

def fail(message: str) -> None:
    raise SystemExit(f"[latency-contract] FAIL: {message}")

def main() -> None:
    if not CONTRACT.is_file():
        fail(f"missing {CONTRACT.relative_to(ROOT)}")
    if not DOC.is_file():
        fail(f"missing {DOC.relative_to(ROOT)}")

    try:
        data = json.loads(CONTRACT.read_text(encoding="utf-8"))
    except json.JSONDecodeError as exc:
        fail(f"invalid JSON: {exc}")

    if data.get("version") != 1:
        fail("version must be 1")
    if data.get("repository") != "az1nn/growing-rio":
        fail("repository identity mismatch")
    if data.get("authority") != "docs/VALIDATION-LATENCY-BUDGETS.md":
        fail("authority path mismatch")
    if data.get("status") != "active":
        fail("contract must be active")

    measurement = data.get("measurement", {})
    dimensions = set(measurement.get("dimensions", []))
    if not REQUIRED_DIMENSIONS.issubset(dimensions):
        fail(f"missing measurement dimensions: {sorted(REQUIRED_DIMENSIONS - dimensions)}")
    if measurement.get("queue_is_separate") is not True:
        fail("queue time must remain separate")
    if measurement.get("bootstrap_is_separate") is not True:
        fail("bootstrap time must remain separate")
    if measurement.get("timeout_is_budget") is not False:
        fail("timeout must not be treated as a budget")

    hard = data.get("hard_invariants", {})
    if hard.get("still_ready_to_file_ms") != 1000:
        fail("still ready-to-file hard limit must remain 1000 ms")
    if hard.get("video_active_capture_target_multiplier") != 1.0:
        fail("video acquisition target must equal requested duration")
    tolerance = hard.get("video_active_capture_scheduler_tolerance_ms")
    if not isinstance(tolerance, int) or tolerance < 0 or tolerance > 250:
        fail("video scheduler tolerance must be 0..250 ms")
    if hard.get("video_postprocess_target_ms") != 1000:
        fail("video post-process target must remain 1000 ms")
    if hard.get("fixed_sleep_when_observable_allowed") is not False:
        fail("observable readiness must not be replaced by fixed sleep")

    targets = data.get("operation_targets")
    if not isinstance(targets, dict) or not targets:
        fail("operation_targets must be a non-empty object")

    for name, budget in targets.items():
        try:
            p50 = int(budget["p50_ms"])
            p90 = int(budget["p90_ms"])
            hard_target = int(budget["hard_target_ms"])
        except (KeyError, TypeError, ValueError):
            fail(f"{name}: malformed p50/p90/hard target")
        if not (0 < p50 <= p90 <= hard_target):
            fail(f"{name}: expected 0 < p50 <= p90 <= hard target")
        if budget.get("clock") not in REQUIRED_DIMENSIONS:
            fail(f"{name}: invalid clock {budget.get('clock')!r}")

    baseline = data.get("baseline_2026_10_05", {})
    if baseline.get("sample_completed_runs") != 298:
        fail("baseline sample count drifted; create a new dated baseline instead")
    for required in ("validate.yml", "visual-acceptance.yml", "visual-lab.yml", "export-web.yml"):
        if required not in baseline.get("workflows", {}):
            fail(f"baseline missing {required}")

    doc = DOC.read_text(encoding="utf-8")
    for marker in (
        "Still image",
        "Video",
        "LATENCY_HARD_INVARIANT_BREACH",
        "LATENCY_BUDGET_BREACH",
        "298 completed runs",
    ):
        if marker not in doc:
            fail(f"documentation missing marker: {marker}")

    print(
        "[latency-contract] PASS: canonical budgets valid; "
        f"{len(targets)} operation targets + hard media invariants"
    )

if __name__ == "__main__":
    main()
