#!/usr/bin/env python3
"""Fail-closed guardrails for Feature 012 renderer ownership and SIGA roadmap scope."""
from __future__ import annotations

import argparse
import json
import re
import subprocess
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
SPEC_DIR = ROOT / "specs/012-artist-v1-runtime-parity"
ROADMAP = SPEC_DIR / "SIGA-ROADMAP.md"
DECISION = SPEC_DIR / "renderer-decision.md"
GUARDRAIL = SPEC_DIR / "architecture-execution-guardrail.md"
THREEJS_SKILL = ROOT / ".agents/skills/3js/SKILL.md"
SIGA_SKILL = ROOT / ".agents/skills/siga/SKILL.md"
SCENE_STATUS = ROOT / "docs/art-direction/v1/SCENE-STATUS.json"

LATER_SCENE_PATHS = {
    5: ("scenes/market/", "specs/012-artist-v1-runtime-parity/market-preflight.md"),
    6: ("scenes/city/",),
    7: ("scenes/institutional/",),
    8: ("scenes/archive/",),
    9: ("scenes/campaign/",),
    10: ("scenes/narrative/",),
}

REQUIRED_GUARDRAIL_TOKENS = (
    "STRUCTURAL_REBASE_REQUIRED",
    "Strict roadmap write fence",
    "old Three.js / old generic low-poly blockout",
    "approved ARTIST board + accepted isolated scene",
)

def current_item() -> int:
    text = ROADMAP.read_text(encoding="utf-8")
    match = re.search(r"\*\*Current item:\*\* `R(\d{2})`", text)
    if not match:
        raise ValueError("SIGA roadmap must declare **Current item:** `RNN`")
    return int(match.group(1))

def validate_static() -> list[str]:
    errors: list[str] = []
    required = (ROADMAP, DECISION, GUARDRAIL, THREEJS_SKILL, SIGA_SKILL, SCENE_STATUS)
    for path in required:
        if not path.exists():
            errors.append(f"missing guardrail authority: {path.relative_to(ROOT)}")
    if errors:
        return errors

    roadmap = ROADMAP.read_text(encoding="utf-8")
    decision = DECISION.read_text(encoding="utf-8")
    guardrail = GUARDRAIL.read_text(encoding="utf-8")
    skill = THREEJS_SKILL.read_text(encoding="utf-8")
    siga = SIGA_SKILL.read_text(encoding="utf-8")

    if "STRICT_SEQUENTIAL" not in roadmap:
        errors.append("Feature 012 roadmap lost STRICT_SEQUENTIAL")
    if "**Decision:** `GODOT_NATIVE_V1`" not in decision:
        errors.append("renderer decision is not locked to GODOT_NATIVE_V1")
    if "REFERENCE/FROZEN" not in skill:
        errors.append("3JS skill is no longer visibly REFERENCE/FROZEN")
    for token in (
        "az1nn/growing-rio",
        "Repository scope law",
        "MASTER ORCHESTRATOR",
        "GENERATED VISUAL REPORT IDENTITY FENCE",
        "REPORT_CONTEXT_MISMATCH",
        "REPORT_TEMPLATE_PREFLIGHT",
        "RENDER_REPORT_V1",
        "REPORT_RENDER_IDENTITY_CHECK",
        "REPORT_RENDER_MISMATCH",
        "REPORT_V1",
        "tools/render_relatorio_v1.py",
        "report fact packet",
        "product label: `DA LATA`",
        "ARCHITECTURE OWNERSHIP FENCE",
        "STRUCTURAL_REBASE_REQUIRED",
        "Strict-roadmap write fence applies to preparation too",
    ):
        if token not in siga:
            errors.append(f"repository-local SIGA missing guardrail token: {token}")
    for token in REQUIRED_GUARDRAIL_TOKENS:
        if token not in guardrail:
            errors.append(f"execution guardrail missing token: {token}")
    try:
        current_item()
    except ValueError as exc:
        errors.append(str(exc))
    return errors

def changed_paths(base_ref: str) -> list[str]:
    proc = subprocess.run(
        ["git", "diff", "--name-only", f"{base_ref}...HEAD"],
        cwd=ROOT,
        check=True,
        capture_output=True,
        text=True,
    )
    return [line.strip() for line in proc.stdout.splitlines() if line.strip()]

def validate_pr_scope(base_ref: str, head_ref: str) -> list[str]:
    errors: list[str] = []
    current = current_item()
    normalized_ref = head_ref.lower()

    if "012" in normalized_ref:
        targets = [int(value) for value in re.findall(r"(?:^|[-_/])r(\d{2})(?:[-_/]|$)", normalized_ref)]
        for target in targets:
            if target > current:
                errors.append(
                    f"branch {head_ref} targets locked R{target:02d} while R{current:02d} is current"
                )

    paths = changed_paths(base_ref)

    if current == 5:
        market_runtime_paths = (
            "scenes/market/",
            "scenes/visual/market_diorama.gd",
            "scenes/visual/market_diorama.tscn",
        )
        market_runtime_changed = any(
            path.startswith(market_runtime_paths[0]) or path in market_runtime_paths[1:]
            for path in paths
        )
        if market_runtime_changed:
            status = json.loads(SCENE_STATUS.read_text(encoding="utf-8"))["scenes"]["market"]
            implementation_allowed_states = {
                "CONCEPT_ACCEPTED",
                "IMPLEMENTATION_REVISE",
                "IMPLEMENTATION_REJECTED",
                "IMPLEMENTATION_ACCEPTED",
            }
            if (
                status.get("state") not in implementation_allowed_states
                or not status.get("approved_concept_run")
            ):
                errors.append(
                    "R05 Market runtime changed before ARTIST concept acceptance; "
                    "record and human-ACCEPT the isolated Market concept first"
                )

    for path in paths:
        if current < 16 and path.startswith("threejs/"):
            errors.append(
                f"{path}: Three.js is REFERENCE/FROZEN until R16; Feature 012 production must stay Godot-native"
            )
        for item, prefixes in LATER_SCENE_PATHS.items():
            if item <= current:
                continue
            if any(path.startswith(prefix) for prefix in prefixes):
                errors.append(
                    f"{path}: belongs to locked R{item:02d} while R{current:02d} is current"
                )
    return errors

def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("--base-ref")
    parser.add_argument("--head-ref", default="")
    args = parser.parse_args()

    errors = validate_static()
    if args.base_ref:
        errors.extend(validate_pr_scope(args.base_ref, args.head_ref))

    if errors:
        for error in errors:
            print(f"[feature012-guardrail] ERROR: {error}")
        return 1

    scope = f" + PR scope from {args.base_ref}" if args.base_ref else ""
    print(f"[feature012-guardrail] PASS: static architecture/roadmap lock{scope}")
    return 0

if __name__ == "__main__":
    raise SystemExit(main())
