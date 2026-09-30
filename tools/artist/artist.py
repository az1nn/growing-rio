#!/usr/bin/env python3
"""ARTIST V1: append-only, one-scene-per-image art direction and review workflow.

No image model credentials or generated image claims are embedded here. Agents call an
image model using generation-request.json; this CLI records artifacts and gates.
"""
from __future__ import annotations

import argparse
import hashlib
import json
import re
import shutil
import sys
from datetime import datetime, timezone
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
STYLE_DIR = ROOT / "docs" / "art-direction" / "v1"
RUNS = ROOT / "artifacts" / "artist" / "runs"
BOARD = ROOT / "assets" / "art-direction" / "v1" / "da-lata-v1-style-board.png"
STATUS_FILE = STYLE_DIR / "SCENE-STATUS.json"
BOARD_SHA256 = "6f19b2e852ee10fcee8b6e7d16852bb1c03501c0be9ffbb551f842a91bf8ee7d"
VALID_IMAGE_EXTS = {".png", ".jpg", ".jpeg", ".webp"}
COMMIT_RE = re.compile(r"^[0-9a-f]{40}$")
SESSION_RE = re.compile(r"^[0-9]{8}T[0-9]{6}Z(?:-[a-z0-9-]+)?$")


def load_catalog() -> dict:
    return json.loads((STYLE_DIR / "SCENES.json").read_text(encoding="utf-8"))


def now_utc() -> str:
    return datetime.now(timezone.utc).strftime("%Y%m%dT%H%M%SZ")


def checksum(path: Path) -> str:
    hash_ = hashlib.sha256()
    with path.open("rb") as fh:
        for block in iter(lambda: fh.read(131072), b""):
            hash_.update(block)
    return hash_.hexdigest()


def save_json(path: Path, data: dict) -> None:
    path.write_text(json.dumps(data, ensure_ascii=False, indent=2, sort_keys=True) + "\n", encoding="utf-8")


def load_run(run: str) -> tuple[Path, dict]:
    path = Path(run).resolve()
    if not path.is_dir():
        raise ValueError(f"Run folder does not exist: {path}")
    # Only allow modifying this repository's versioned run area.
    if not path.is_relative_to(RUNS.resolve()):
        raise ValueError(f"Run folder must live under {RUNS}")
    manifest_path = path / "manifest.json"
    if not manifest_path.exists():
        raise ValueError("Missing run manifest")
    return path, json.loads(manifest_path.read_text(encoding="utf-8"))


def generate_prompt(scene_slug: str, catalog: dict, object_id: str | None = None) -> str:
    scene = catalog["scenes"][scene_slug]
    base = (STYLE_DIR / "BASE-PROMPT.md").read_text(encoding="utf-8")
    # Remove Markdown guidance around the prompt; the source is retained for review.
    prompt_body = base.split("## Negative prompt")[0].split("**DA LATA:", 1)[1]
    prompt = "**DA LATA:" + prompt_body
    if object_id:
        return (
            f"# ARTIST V1 ISOLATED OBJECT — {scene_slug} / {object_id}\n\n"
            + prompt.strip()
            + f"\n\n## OBJECT DELTA\n\nGenerate exactly ONE isolated 3D pixel-art prop: {object_id} "
            + f"from the {scene['title']} scene, in the identical V1 pixel-art graffiti material vocabulary. "
            + "Three-quarter orthographic turntable-like framing, one central clearly readable silhouette, "
            + "dark neutral void, no scene grid, no labels. Include front/top/side detail only in separate "
            + "subsequent images if asked; this call is ONE object in ONE image. Specify plausible Godot/Three.js "
            + "mesh volumes and physical touch affordance; no real-world cultivation operational labels.\n"
        )
    return (
        f"# ARTIST V1 ISOLATED SCENE — {scene_slug}\n\n"
        f"{prompt.strip()}\n\n"
        f"## SCENE DELTA — {scene['title']}\n\n{scene['diorama']}\n\n"
        "### Exactly three visible foreground interactive-object silhouettes\n\n"
        + "\n".join(f"- {x}" for x in scene["interaction_foci"])
        + "\n\n### Story constraint\n\n" + scene["visual_story"]
        + "\n\n### Non-negotiable generation frame\n\n"
        "Generate ONE **isolated** full-size 9:16 portrait artwork of ONLY this scene; "
        "no image grid, contact sheet, borders, text overlays or other location previews. "
        "Use the approved V1 style-board image as a style reference, never as a "
        "source to crop and misrepresent as a new full-scene generation.\n"
    )


def new_scene(scene_slug: str, session: str, object_id: str | None = None) -> Path:
    catalog = load_catalog()
    if scene_slug not in catalog["scenes"]:
        raise ValueError(f"Unknown scene '{scene_slug}'. Use 'list' to inspect valid IDs.")
    if not SESSION_RE.fullmatch(session):
        raise ValueError("Session must be YYYYMMDDTHHMMSSZ optionally followed by -slug")
    if object_id and not re.fullmatch(r"[a-z0-9][a-z0-9_-]{0,63}", object_id):
        raise ValueError("Object ID must be lowercase letters, digits, '-' or '_', max 64 chars")
    run_dir = RUNS / session / (scene_slug if not object_id else f"{scene_slug}--object-{object_id}")
    if run_dir.exists():
        raise FileExistsError(f"Refusing to overwrite versioned run: {run_dir}")
    for folder in ("images/concept", "images/before", "images/after", "images/detail", "images/ui", "images/compare"):
        (run_dir / folder).mkdir(parents=True, exist_ok=False)
    scene = catalog["scenes"][scene_slug]
    prompt = generate_prompt(scene_slug, catalog, object_id)
    negative = (STYLE_DIR / "BASE-PROMPT.md").read_text(encoding="utf-8").split("## Negative prompt — also locked\n\n", 1)[1].split("\n## Fixed", 1)[0].strip()
    (run_dir / "PROMPT.md").write_text(prompt, encoding="utf-8")
    (run_dir / "NEGATIVE.md").write_text(negative + "\n", encoding="utf-8")
    (run_dir / "CAVEMAN.md").write_text(
        f"# ARTIST CAVEMAN — {scene_slug} / {session}\n\n"
        "STATUS: BRIEFED. NO concept, fresh screenshot, or runtime implementation has been verified.\n\n"
        "## BEFORE: What player actually sees\n\nTODO: LENTE isolated screenshots, exact commit, viewport and device/browser.\n\n"
        "## TARGET: What must visibly change\n\nTODO: check V1 pixel edges, graffiti, scene-specific silhouette and three clickable anchors.\n\n"
        "## DELTA: Concept versus implemented screenshot\n\nTODO: compare all three images; record concrete matches and deviations.\n\n"
        "## HARD GATES\n\n- [ ] Single-scene concept was approved by a human\n"
        "- [ ] Exactly named scene is actually modeled in 3D; no wallpaper substitution\n"
        "- [ ] Visible clickable anchors work on Web/mobile at portrait width\n"
        "- [ ] Godot/Three.js exact-head runtime visual evidence was captured\n"
        "- [ ] Mobile legibility and acceptable performance checked\n"
        "- [ ] Canon and scope checked by LORE as needed\n"
        "- [ ] Human confirms AFTER screenshot matches approved concept\n\n"
        "## NEXT ACTION\n\nCapture/generate ONE concept for this scene and request review.\n",
        encoding="utf-8",
    )
    request = {
        "schema": "artist-single-scene-generation/v1",
        "scene_id": scene_slug,
        "object_id": object_id,
        "session_id": session,
        "count": 1,
        "ratio": "9:16" if not object_id else "1:1",
        "reference_style_board": str(BOARD.relative_to(ROOT)),
        "prompt_file": "PROMPT.md",
        "negative_prompt_file": "NEGATIVE.md",
        "output_hint": "images/concept/concept-v001.png",
        "mandatory": "ONE SCENE ONLY. Visual asset is concept art, NOT integrated 3D.",
    }
    save_json(run_dir / "generation-request.json", request)
    manifest = {
        "schema": "artist-scene-run/v1",
        "style": catalog["style_version"],
        "session": session,
        "scene": scene_slug,
        "object_id": object_id,
        "state": "BRIEFED",
        "v1_board_sha256": BOARD_SHA256,
        "created_utc": now_utc(),
        "implementation_hints": scene.get("implementation_hints", []),
        "evidence": {"concept": [], "before": [], "after": [], "detail": [], "ui": []},
        "reviews": [],
        "notes": "This manifest is an isolated plan; no art-generation or runtime acceptance is implied.",
    }
    save_json(run_dir / "manifest.json", manifest)
    return run_dir


def record_artifact(run: str, kind: str, filename: str, commit: str | None, platform: str | None) -> Path:
    path, manifest = load_run(run)
    src = Path(filename).resolve()
    if not src.is_file() or src.suffix.lower() not in VALID_IMAGE_EXTS:
        raise ValueError("Input must be an existing .png/.jpg/.webp image")
    if manifest["state"] == "IMPLEMENTATION_ACCEPTED":
        raise ValueError("Accepted run is frozen; create a new versioned run")
    if kind == "concept" and manifest["state"] not in {"BRIEFED", "CONCEPT_REVISE", "CONCEPT_REJECTED"}:
        raise ValueError("Concept already reviewed/accepted; create a new versioned run for revisions")
    if kind in {"before", "after"} and (not commit or not COMMIT_RE.fullmatch(commit)):
        raise ValueError("Before/after runtime screenshot requires exact 40-character --commit SHA")
    if commit and not COMMIT_RE.fullmatch(commit):
        raise ValueError("--commit must be an exact 40-character lowercase hex commit SHA")
    if kind == "after" and manifest["state"] not in {"CONCEPT_ACCEPTED", "IMPLEMENTATION_REVISE", "IMPLEMENTATION_REJECTED"}:
        raise ValueError("Approve a concept before recording implementation screenshots")
    records = manifest["evidence"][kind]
    dest = path / "images" / kind / f"{kind}-v{len(records) + 1:03d}{src.suffix.lower()}"
    if dest.exists():
        raise FileExistsError(dest)
    dest.parent.mkdir(parents=True, exist_ok=True)
    shutil.copy2(src, dest)
    records.append({
        "path": str(dest.relative_to(path)), "sha256": checksum(dest),
        "source": src.name, "recorded_utc": now_utc(), "commit": commit, "platform": platform,
    })
    save_json(path / "manifest.json", manifest)
    return dest


def review(run: str, stage: str, decision: str, reviewer: str, notes: str) -> str:
    path, manifest = load_run(run)
    if not reviewer.strip() or len(notes.strip()) < 12:
        raise ValueError("Human reviewer and meaningful (>=12 characters) notes required")
    if stage == "concept":
        if manifest["state"] == "CONCEPT_ACCEPTED":
            raise ValueError("Human-approved concept is immutable; open a new versioned run")
        if not manifest["evidence"]["concept"]:
            raise ValueError("Concept image evidence must be recorded before concept review")
        if manifest["state"] == "IMPLEMENTATION_ACCEPTED":
            raise ValueError("Do not modify an accepted run; start a new versioned run")
        statuses = {"ACCEPT": "CONCEPT_ACCEPTED", "REVISE": "CONCEPT_REVISE", "REJECT": "CONCEPT_REJECTED"}
    else:
        if manifest["state"] not in {"CONCEPT_ACCEPTED", "IMPLEMENTATION_REVISE", "IMPLEMENTATION_REJECTED"}:
            raise ValueError("Human concept acceptance required before implementation review")
        if not manifest["evidence"]["before"] or not manifest["evidence"]["after"]:
            raise ValueError("Before AND exact-head after runtime screenshots required")
        if not (path / "images/compare/comparison.png").exists():
            raise ValueError("Run 'compare' before implementation review")
        comparison = manifest.get("comparison") or {}
        latest_after = manifest["evidence"]["after"][-1]
        if (comparison.get("after_commit") != latest_after["commit"]
                or comparison.get("after_sha256") != latest_after["sha256"]
                or checksum(path / latest_after["path"]) != latest_after["sha256"]):
            raise ValueError("Comparison is stale relative to exact-head AFTER evidence")
        analysis = (path / "CAVEMAN.md").read_text(encoding="utf-8")
        if decision == "ACCEPT" and ("TODO:" in analysis or "- [ ]" in analysis):
            raise ValueError("Complete CAVEMAN analysis and all hard-gate checkboxes before implementation ACCEPT")
        statuses = {"ACCEPT": "IMPLEMENTATION_ACCEPTED", "REVISE": "IMPLEMENTATION_REVISE", "REJECT": "IMPLEMENTATION_REJECTED"}
    manifest["state"] = statuses[decision]
    reviewed_evidence = manifest["evidence"]["concept"][-1] if stage == "concept" else manifest["evidence"]["after"][-1]
    if stage == "concept" and decision == "ACCEPT":
        if checksum(path / reviewed_evidence["path"]) != reviewed_evidence["sha256"]:
            raise ValueError("Concept bytes changed since recording; approval prohibited")
        manifest["accepted_concept"] = {"path": reviewed_evidence["path"], "sha256": reviewed_evidence["sha256"]}
    manifest["reviews"].append({"stage": stage, "decision": decision, "reviewer": reviewer, "notes": notes, "evidence_sha256": reviewed_evidence["sha256"], "at_utc": now_utc()})
    if decision == "ACCEPT" and not manifest.get("object_id"):
        register = json.loads(STATUS_FILE.read_text(encoding="utf-8"))
        scene_status = register["scenes"][manifest["scene"]]
        if stage == "concept":
            scene_status["state"] = "CONCEPT_ACCEPTED"
            scene_status["approved_concept_run"] = f"{manifest['session']}/{manifest['scene']}"
        elif stage == "implementation":
            expected = f"{manifest['session']}/{manifest['scene']}"
            if scene_status["approved_concept_run"] != expected:
                raise ValueError("Another run was approved for this scene; reconcile before updating status ledger")
            scene_status["state"] = "IMPLEMENTATION_ACCEPTED"
            scene_status["accepted_runtime_run"] = expected
        save_json(STATUS_FILE, register)
    save_json(path / "manifest.json", manifest)
    return manifest["state"]


def compare(run: str) -> Path:
    path, manifest = load_run(run)
    for kind in ("concept", "before", "after"):
        if not manifest["evidence"][kind]:
            raise ValueError(f"Record {kind} image before comparing")
    try:
        from PIL import Image, ImageDraw
    except ImportError as e:
        raise RuntimeError("Pillow is required for visual comparison: pip install Pillow") from e
    records = manifest["evidence"]
    approved = manifest.get("accepted_concept")
    if not approved or checksum(path / approved["path"]) != approved["sha256"]:
        raise ValueError("Approved concept missing or modified; do not compare against unapproved art")
    labels = [("BEFORE", records["before"][-1]), ("APPROVED CONCEPT", approved), ("EXACT-HEAD AFTER", records["after"][-1])]
    width, height = 480, 860
    board = Image.new("RGB", (width * 3, height), (9, 13, 25))
    draw = ImageDraw.Draw(board)
    for idx, (label, record) in enumerate(labels):
        with Image.open(path / record["path"]) as im:
            im = im.convert("RGB")
            im.thumbnail((width - 24, height - 72))
            x = idx * width + (width - im.width) // 2
            y = 45 + (height - 65 - im.height) // 2
            board.paste(im, (x, y))
        draw.text((idx * width + 18, 17), label, fill=(235, 235, 235))
    target = path / "images/compare/comparison.png"
    target.parent.mkdir(parents=True, exist_ok=True)
    if target.exists():
        raise FileExistsError("Comparison already exists; create a new run for a new review cycle")
    board.save(target, optimize=True)
    manifest["comparison"] = {"path": str(target.relative_to(path)), "sha256": checksum(target), "after_commit": records["after"][-1]["commit"], "after_sha256": records["after"][-1]["sha256"], "approved_concept_sha256": approved["sha256"]}
    save_json(path / "manifest.json", manifest)
    return target


def validate() -> list[str]:
    errors = []
    if not BOARD.exists():
        errors.append("V1 official board is missing")
    elif checksum(BOARD) != BOARD_SHA256:
        errors.append("V1 board SHA256 changed: create V2, do not silently mutate V1")
    catalog = load_catalog()
    if len(catalog["scene_order"]) != 11 or set(catalog["scene_order"]) != set(catalog["scenes"]):
        errors.append("Scene roster must contain exactly 11 distinct approved board scenes")
    if not (STYLE_DIR / "BASE-PROMPT.md").exists():
        errors.append("Missing locked base prompt")
    try:
        ledger = json.loads(STATUS_FILE.read_text(encoding="utf-8"))
        if set(ledger["scenes"]) != set(catalog["scene_order"]):
            errors.append("Scene status ledger is missing scene IDs")
    except (OSError, ValueError, KeyError):
        errors.append("Missing or invalid SCENE-STATUS.json")
    for scene_id, scene in catalog["scenes"].items():
        if len(scene.get("interaction_foci", [])) != 3:
            errors.append(f"{scene_id}: define exactly 3 primary interactive silhouettes")
        if not scene.get("diorama") or not scene.get("implementation_hints"):
            errors.append(f"{scene_id}: missing diorama description or implementation targets")
    return errors


def main(argv=None):
    ap = argparse.ArgumentParser(description=__doc__)
    sub = ap.add_subparsers(dest="cmd", required=True)
    sub.add_parser("list")
    sub.add_parser("validate")
    p = sub.add_parser("start"); p.add_argument("--scene", required=True); p.add_argument("--object", default=None); p.add_argument("--session", default=None)
    p = sub.add_parser("start-all"); p.add_argument("--session", default=None)
    p = sub.add_parser("record"); p.add_argument("--run", required=True); p.add_argument("--kind", choices=["concept", "before", "after", "detail", "ui"], required=True); p.add_argument("--file", required=True); p.add_argument("--commit"); p.add_argument("--platform")
    p = sub.add_parser("review"); p.add_argument("--run", required=True); p.add_argument("--stage", choices=["concept", "implementation"], required=True); p.add_argument("--decision", choices=["ACCEPT", "REVISE", "REJECT"], required=True); p.add_argument("--reviewer", required=True); p.add_argument("--notes", required=True)
    p = sub.add_parser("compare"); p.add_argument("--run", required=True)
    p = sub.add_parser("status"); p.add_argument("--run", required=True)
    args = ap.parse_args(argv)
    try:
        if args.cmd == "list":
            cat = load_catalog()
            for name in cat["scene_order"]:
                print(name, "—", cat["scenes"][name]["title"])
        elif args.cmd == "validate":
            errors = validate()
            if errors:
                for error in errors: print("FAIL:", error)
                return 1
            print("PASS: V1 board checksum, locked prompt, all 11 scene specifications")
        elif args.cmd == "start":
            path = new_scene(args.scene, args.session or now_utc(), args.object)
            print(path.relative_to(ROOT))
        elif args.cmd == "start-all":
            session = args.session or now_utc()
            path = RUNS / session
            if path.exists():
                raise FileExistsError("Never reuse an ARTIST session folder")
            for scene in load_catalog()["scene_order"]:
                print(new_scene(scene, session).relative_to(ROOT))
            (path / "QUEUE.md").write_text("# One at a time — human approval between scenes\n\n" + "\n".join(f"- [ ] {name}: isolated concept → approval → implementation → review" for name in load_catalog()["scene_order"]) + "\n", encoding="utf-8")
        elif args.cmd == "record":
            print(record_artifact(args.run, args.kind, args.file, args.commit, args.platform).relative_to(ROOT))
        elif args.cmd == "review":
            print(review(args.run, args.stage, args.decision, args.reviewer, args.notes))
        elif args.cmd == "compare":
            print(compare(args.run).relative_to(ROOT))
        elif args.cmd == "status":
            _, manifest = load_run(args.run)
            print(json.dumps({"scene": manifest["scene"], "object_id": manifest.get("object_id"), "session": manifest["session"], "state": manifest["state"], "evidence_counts": {k: len(v) for k, v in manifest["evidence"].items()}}, indent=2))
    except (ValueError, FileExistsError, RuntimeError, OSError) as err:
        print("ARTIST ERROR:", err, file=sys.stderr)
        return 2
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
