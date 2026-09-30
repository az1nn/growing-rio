#!/usr/bin/env python3
"""Structural validator for Feature 012 R03 shared ARTIST V1 visual system."""
from __future__ import annotations

import json
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
SCENES = ROOT / "docs/art-direction/v1/SCENES.json"
MATERIALS = ROOT / "resources/visual/v1/material-vocabulary.json"
COMPOSITION = ROOT / "resources/visual/v1/composition-anchors.json"
PROVENANCE = ROOT / "resources/visual/v1/provenance.json"
GRAFFITI = ROOT / "resources/visual/v1/graffiti-pipeline.json"
PIXEL_POLICY = ROOT / "scenes/visual/v1/v1_pixel_render_policy.gd"
MATERIAL_BUILDER = ROOT / "resources/visual/v1/v1_material_vocabulary.gd"
GRAFFITI_SHADER = ROOT / "resources/visual/v1/shaders/v1_graffiti_stencil.gdshader"
BUDGET = ROOT / "specs/012-artist-v1-runtime-parity/v1-performance-budget.md"

REQUIRED_ROLES = {
    "structural_dark", "petrol_shadow", "worn_concrete", "brick_coral",
    "repaired_wood", "painted_metal", "off_white", "accent_magenta",
    "accent_cyan", "accent_amber", "foliage_muted",
}

def load(path: Path) -> dict:
    return json.loads(path.read_text(encoding="utf-8"))

def validate() -> list[str]:
    errors: list[str] = []
    for path in (SCENES, MATERIALS, COMPOSITION, PROVENANCE, GRAFFITI, PIXEL_POLICY, MATERIAL_BUILDER, GRAFFITI_SHADER, BUDGET):
        if not path.exists():
            errors.append(f"missing required R03 file: {path.relative_to(ROOT)}")
    if errors:
        return errors

    scenes = load(SCENES)
    materials = load(MATERIALS)
    composition = load(COMPOSITION)
    provenance = load(PROVENANCE)
    graffiti = load(GRAFFITI)

    if set(materials.get("roles", {})) != REQUIRED_ROLES:
        errors.append("material vocabulary roles do not match the R03 shared contract")

    if composition.get("portrait_targets") != [[540, 960], [1080, 1920]]:
        errors.append("composition portrait targets must be 540x960 and 1080x1920")

    contracts = composition.get("scene_contracts", {})
    if set(contracts) != set(scenes["scene_order"]):
        errors.append("composition registry must cover exactly the 11 canonical scenes")
    else:
        for slug in scenes["scene_order"]:
            expected = scenes["scenes"][slug]["interaction_foci"]
            if contracts[slug].get("source_foci") != expected:
                errors.append(f"{slug}: composition foci drift from SCENES.json")
            mappings = contracts[slug].get("provisional_zone_mapping", [])
            if [m.get("focus") for m in mappings] != expected:
                errors.append(f"{slug}: hotspot zone mapping must preserve focus order")

    pixel = PIXEL_POLICY.read_text(encoding="utf-8")
    for token in ("DEFAULT_SHRINK := 2", "stretch_shrink = normalized_shrink", "TEXTURE_FILTER_NEAREST"):
        if token not in pixel:
            errors.append(f"pixel policy missing {token}")

    shader = GRAFFITI_SHADER.read_text(encoding="utf-8")
    for token in ("filter_nearest", "stencil_texture", "ALPHA", "ROUGHNESS"):
        if token not in shader:
            errors.append(f"graffiti shader missing {token}")

    provenance_paths = {entry["path"] for entry in provenance.get("assets", [])}
    required_provenance = {
        "scenes/visual/v1/v1_pixel_render_policy.gd",
        "resources/visual/v1/material-vocabulary.json",
        "resources/visual/v1/v1_material_vocabulary.gd",
        "resources/visual/v1/shaders/v1_graffiti_stencil.gdshader",
        "resources/visual/v1/graffiti-pipeline.json",
        "resources/visual/v1/composition-anchors.json",
    }
    missing = sorted(required_provenance - provenance_paths)
    if missing:
        errors.append("provenance missing: " + ", ".join(missing))

    if graffiti.get("shader") != "res://resources/visual/v1/shaders/v1_graffiti_stencil.gdshader":
        errors.append("graffiti pipeline shader path drift")

    budget = BUDGET.read_text(encoding="utf-8")
    for token in ("8,308,868 bytes", "39,514,754 bytes", "279,815 bytes", "270×480", "540×960"):
        if token not in budget:
            errors.append(f"performance budget missing measured evidence {token}")

    return errors

def main() -> int:
    errors = validate()
    if errors:
        for error in errors:
            print(f"[v1-visual-system] ERROR: {error}")
        return 1
    print("[v1-visual-system] PASS")
    return 0

if __name__ == "__main__":
    raise SystemExit(main())
