#!/usr/bin/env python3
"""Create immutable ARTIST scene-concept rounds; self-test and validate their metadata.

No image is generated, saved, or claimed by this scaffolder. Use the actual
image-generation capability separately, then add verified source provenance.
"""
from __future__ import annotations

import argparse
import json
import re
import tempfile
from datetime import datetime, timezone
from pathlib import Path

REPO = Path(__file__).resolve().parents[2]
SCENES = (
    "operation", "market", "city", "institutional", "archive", "campaign",
    "narrative", "finale-selection", "finale-handoff", "finale-coda",
    "finale-recap",
)
KINDS = ("concept", "object", "implementation-review")
STATUSES = ("PROPOSED", "REVISE", "REJECTED", "ACCEPTED")
REQUIRED = ("ROUND.json", "BRIEF.md", "PROMPTS.md", "REVIEW.md", "ASSETS.md")


def require_style(root: Path, scene: str) -> tuple[str, str, str]:
    path = root / "docs/art-direction/ARTIST-V1-STYLE.md"
    if not path.is_file():
        raise ValueError("ARTIST V1 style document missing: " + str(path))
    content = path.read_text(encoding="utf-8")
    try:
        base = content.split("## Portable BASE_V1 image prompt (English)", 1)[1]
        base = base.split("## NEGATIVE_V1", 1)[0].strip()
        negative = content.split("## NEGATIVE_V1", 1)[1]
        negative = negative.split("## Prompt assembly", 1)[0].strip()
        match = re.search(r"^\| " + re.escape(scene) + r" \| (.+?) \|$", content, re.M)
        if not match or not base or not negative:
            raise ValueError("incomplete style grammar or missing scene seed")
    except IndexError as exc:
        raise ValueError("missing V1 style sections") from exc
    return base, match.group(1), negative


def new_round(
    *, root: Path, scene: str, head: str, kind: str = "concept",
    object_name: str | None = None, parent_round: str | None = None,
    clock: str | None = None,
) -> Path:
    if scene not in SCENES:
        raise ValueError("unknown canonical scene")
    if not re.fullmatch(r"[0-9a-fA-F]{40}", head):
        raise ValueError("head must be a verified exact 40-character commit SHA")
    if kind not in KINDS:
        raise ValueError("unsupported round kind")
    if kind == "object" and not object_name:
        raise ValueError("object round requires --object")
    if kind != "object" and object_name:
        raise ValueError("--object is only valid for an object round")
    if object_name and (len(object_name) > 90 or not re.fullmatch(r"[a-zA-Z0-9_.:-]+", object_name)):
        raise ValueError("unsafe object identifier")
    if parent_round and (len(parent_round) > 150 or not re.fullmatch(r"[a-zA-Z0-9_-]+", parent_round)):
        raise ValueError("unsafe parent round identifier")

    base, delta, negative = require_style(root, scene)
    stamp = clock or datetime.now(timezone.utc).strftime("%Y%m%dT%H%M%SZ")
    if not re.fullmatch(r"\d{8}T\d{6}Z", stamp):
        raise ValueError("invalid UTC round timestamp")
    runs = root / "docs/art-direction/runs"
    runs.mkdir(parents=True, exist_ok=True)

    # Sequence is per scene across timestamps/heads; no round is ever overwritten.
    pattern = re.compile(r"^\d{8}T\d{6}Z-" + re.escape(scene) + r"-[a-f0-9]{12}-r(\d{3})$")
    numbers = [
        int(m.group(1)) for p in runs.iterdir() if p.is_dir()
        if (m := pattern.fullmatch(p.name))
    ]
    sequence = max(numbers, default=0) + 1
    if sequence > 999:
        raise ValueError("scene exceeded r999; preserve old history and revise versioning")
    folder = runs / f"{stamp}-{scene}-{head[:12].lower()}-r{sequence:03d}"
    folder.mkdir(parents=False, exist_ok=False)

    metadata = {
        "schema": 1,
        "id": folder.name,
        "scene": scene,
        "kind": kind,
        "object": object_name,
        "parent_round": parent_round,
        "created_utc": stamp,
        "source_head": head.lower(),
        "status": "PROPOSED",
        "concept_asset_status": "NOT_ARCHIVED",
        "implementation_status": "NOT_STARTED",
        "lente_evidence_state": "MISSING",
        "human_approval": None,
    }
    (folder / "ROUND.json").write_text(
        json.dumps(metadata, ensure_ascii=False, indent=2) + "\n", encoding="utf-8"
    )
    (folder / "BRIEF.md").write_text(
        f"# ARTIST round — {scene} / {kind}\n\n"
        f"Exact source head: `{head.lower()}`. Object: `{object_name or 'scene'}`.\n"
        f"Previous round: `{parent_round or 'none'}`.\n\n"
        "## OBSERVED (cite actual LENTE capture; do not invent)\n"
        "Evidence: MISSING. Full-page PNG: __. Isolated PNG: __. WebM: __.\n\n"
        "## CREATIVE INTENT\nReplace with a bounded scene/object-specific brief.\n\n"
        "## CLICKABLE 3D OBJECTS / UI SAFE AREAS\n"
        "List real scene nodes only after verification; concept hypotheses separately.\n",
        encoding="utf-8",
    )
    (folder / "PROMPTS.md").write_text(
        "# Replayable ARTIST V1 prompts\n\n## BASE_V1\n" + base
        + "\n\n## SCENE_DELTA (seed; edit and retain exact final prompt)\n"
        + delta
        + "\n\n## OBJECT_DELTA\n"
        + ("Isolate " + object_name + " in the approved scene grammar." if object_name else "Not applicable.")
        + "\n\n## NEGATIVE_V1\n" + negative
        + "\n\n## RUNTIME_CONSTRAINTS\n"
        "Reference concept, not gameplay footage. Godot Web/mobile; actual modeled 3D, clear touch targets, mobile portrait readable.\n",
        encoding="utf-8",
    )
    (folder / "REVIEW.md").write_text(
        "# Gate: PROPOSED\n\n"
        "Human scene verdict: PENDING (ACCEPT / REVISE / REJECT).\n"
        "Concept critique: pending isolated reference.\n"
        "CENA/3JS handoff: pending concept acceptance.\n"
        "Runtime LENTE before/after exact-head verdict: INCONCLUSIVE / NOT RUN.\n"
        "CAVEMAN: what we have; where it hurts; what to do now.\n",
        encoding="utf-8",
    )
    (folder / "ASSETS.md").write_text(
        "# Provenance (never fabricate binary claims)\n\n"
        "Concept image: NOT_GENERATED_OR_NOT_ARCHIVED\n"
        "Durable locator: UNKNOWN\n"
        "SHA256: UNKNOWN\n"
        "License / user permission: UNVERIFIED\n"
        "Actual engine screenshot: MISSING (not interchangeable with concept).\n"
        "Actual reviewed engine commit: NOT_IMPLEMENTED\n",
        encoding="utf-8",
    )
    return folder


def verify_all(root: Path) -> int:
    runs = root / "docs/art-direction/runs"
    checked = 0
    if not runs.exists():
        print("ARTIST: no concept rounds yet; scaffold and style can be validated independently.")
        return 0
    for folder in sorted(p for p in runs.iterdir() if p.is_dir()):
        missing = [name for name in REQUIRED if not (folder / name).is_file()]
        if missing:
            raise ValueError(f"{folder.name}: missing {missing}")
        meta = json.loads((folder / "ROUND.json").read_text(encoding="utf-8"))
        if (
            meta.get("id") != folder.name
            or meta.get("scene") not in SCENES
            or meta.get("kind") not in KINDS
            or meta.get("status") not in STATUSES
            or not re.fullmatch(r"[a-f0-9]{40}", str(meta.get("source_head", "")))
        ):
            raise ValueError(f"{folder.name}: invalid exact-head metadata or gate")
        if not (folder / "PROMPTS.md").read_text(encoding="utf-8").find("## BASE_V1") >= 0:
            raise ValueError(f"{folder.name}: missing replayable BASE_V1 prompt")
        checked += 1
    print(f"ARTIST: verified {checked} immutable round folder(s)")
    return checked


def self_test() -> None:
    with tempfile.TemporaryDirectory(prefix="artist-round-test-") as tmp:
        root = Path(tmp)
        style = root / "docs/art-direction/ARTIST-V1-STYLE.md"
        style.parent.mkdir(parents=True)
        style.write_text(
            (REPO / "docs/art-direction/ARTIST-V1-STYLE.md").read_text(encoding="utf-8"),
            encoding="utf-8",
        )
        sha = "a" * 40
        first = new_round(root=root, scene="operation", head=sha, clock="20260930T120000Z")
        second = new_round(root=root, scene="operation", head=sha, clock="20260930T120000Z")
        assert first != second and first.name.endswith("-r001")
        assert second.name.endswith("-r002")
        assert verify_all(root) == 2
        try:
            new_round(root=root, scene="operation", head="master")
        except ValueError:
            pass
        else:
            raise AssertionError("unverified head was accepted")
        try:
            new_round(root=root, scene="operation", head=sha, kind="object", object_name="../unsafe")
        except ValueError:
            pass
        else:
            raise AssertionError("unsafe object identifier was accepted")
        print("ARTIST self-test PASS: versioning, completeness, SHA guard, safe object ID")


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--scene", choices=SCENES)
    parser.add_argument("--head")
    parser.add_argument("--kind", choices=KINDS, default="concept")
    parser.add_argument("--object")
    parser.add_argument("--parent-round")
    parser.add_argument("--root", type=Path, default=REPO)
    parser.add_argument("--self-test", action="store_true")
    parser.add_argument("--verify-all", action="store_true")
    args = parser.parse_args()
    if args.self_test:
        self_test()
        return
    if args.verify_all:
        verify_all(args.root)
        return
    if not args.scene or not args.head:
        parser.error("--scene and --head are required to open a round")
    try:
        folder = new_round(
            root=args.root, scene=args.scene, head=args.head, kind=args.kind,
            object_name=args.object, parent_round=args.parent_round,
        )
    except ValueError as exc:
        parser.error(str(exc))
    print(f"CREATED: {folder.relative_to(args.root)}")
    print("PROPOSED only. Generate actual image separately and retain honest provenance.")


if __name__ == "__main__":
    main()
