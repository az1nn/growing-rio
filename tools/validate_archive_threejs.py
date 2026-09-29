from __future__ import annotations

import json
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
APP = ROOT / "threejs" / "archive"
SPEC = ROOT / "specs" / "3js-006-archive-continuity"
REFS = ROOT / "docs" / "visual-references" / "3js-archive"

REQUIRED = [
    APP/"package.json", APP/"package-lock.json", APP/"index.html", APP/"scripts"/"build.mjs",
    APP/"src"/"main.js", APP/"src"/"archive.js", APP/"src"/"presentationModel.js",
    APP/"src"/"styleTokens.js", APP/"src"/"materials.js", APP/"src"/"camera.js",
    APP/"src"/"lighting.js", APP/"src"/"props.js",
    SPEC/"spec.md", SPEC/"plan.md", SPEC/"tasks.md", REFS/"README.md",
]
for path in REQUIRED:
    if not path.is_file():
        raise SystemExit(f"3JS-006 validation failed: missing {path.relative_to(ROOT)}")

package=json.loads((APP/"package.json").read_text())
lock=json.loads((APP/"package-lock.json").read_text())
three_version=package.get("dependencies",{}).get("three")
if three_version!="0.186.1":
    raise SystemExit(f"3JS-006 validation failed: expected exact three@0.186.1, got {three_version!r}")
if any(token in three_version for token in "^~*><="):
    raise SystemExit("3JS-006 validation failed: Three.js version must be an exact pin")
if lock.get("packages",{}).get("node_modules/three",{}).get("version")!=three_version:
    raise SystemExit("3JS-006 validation failed: package-lock Three.js version mismatch")

main=(APP/"src"/"main.js").read_text()
scene=(APP/"src"/"archive.js").read_text()
camera=(APP/"src"/"camera.js").read_text()
props=(APP/"src"/"props.js").read_text()
materials=(APP/"src"/"materials.js").read_text()
tokens=(APP/"src"/"styleTokens.js").read_text()
model=(APP/"src"/"presentationModel.js").read_text()
lighting=(APP/"src"/"lighting.js").read_text()
build=(APP/"scripts"/"build.mjs").read_text()
spec=(SPEC/"spec.md").read_text()
runtime="\n".join((main,scene,camera,props,materials,tokens,model,lighting))

for forbidden in (
    "GameState", "complete_research_step", "resolve_narrative_choice",
    "SaveService", "next_day", "harvest", "sell_inventory"
):
    if forbidden in runtime:
        raise SystemExit(f"3JS-006 validation failed: gameplay/domain token in runtime: {forbidden}")

contracts={
    "fixed orthographic camera":"THREE.OrthographicCamera" in camera and "lookAt" in camera,
    "archive identity":all(name in props for name in (
        "ArchiveFloor","ArchiveBackWall","UncertaintyRail","EvidenceDeskBody",
        "EvidenceTray","ArchiveEvidenceBoxes","AbstractEvidenceDocuments"
    )),
    "evidence desk practical":"WarmEvidenceDeskPractical" in lighting,
    "archive storage instancing":"THREE.InstancedMesh" in props and "ArchiveEvidenceBoxes" in props,
    "abstract evidence marker":"abstract-evidence-memory-no-provenance-claim" in props,
    "style tokens":all(name in tokens for name in ("palette","camera","material","lighting","render","scale")),
    "flat shading":"flatShading:styleTokens.material.flatShading" in materials,
    "read-only model":"Object.freeze" in model,
    "presentation-only boundary":"No research, evidence or canon mutation" in model,
    "canon-safe spec":"Merely viewing the Three.js scene cannot resolve research" in spec,
    "no texture loader":"TextureLoader" not in runtime,
    "zero textures":"authoredTextureBudget:0" in tokens,
    "explicit disposal":"disposeArchive" in scene and "renderer.dispose()" in main,
    "deterministic resize":"updateArchiveCamera" in camera and "window.addEventListener('resize'" in main,
    "DPR cap":"styleTokens.render.pixelRatioCap" in main,
    "shadows disabled":"shadows:false" in tokens,
    "no perpetual loop":"requestAnimationFrame" not in main and "setAnimationLoop" not in main,
    "ready signal":"__DA_LATA_3JS_READY__" in main,
    "scene identity":"__DA_LATA_3JS_SCENE__='archive'" in main,
    "metrics signal":"__DA_LATA_3JS_METRICS__" in main,
    "archive box metric":"archiveBoxCount:archivePresentationModel.archiveBoxes.length" in main,
    "evidence document metric":"evidenceDocumentCount:archivePresentationModel.documents.length" in main,
    "local module":"three.module.js" in build and "three.core.js" in build,
    "reference linked":"docs/visual-references/3js-archive" in model,
    "candidate status":"styleStatus:'CANDIDATE'" in model,
}
failed=[name for name,ok in contracts.items() if not ok]
if failed:
    raise SystemExit("3JS-006 validation failed contracts: "+", ".join(failed))
print("3JS-006 archive structural validation: PASS")
