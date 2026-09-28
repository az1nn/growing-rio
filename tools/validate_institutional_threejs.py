from __future__ import annotations

import json
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
APP = ROOT / "threejs" / "institutional"
SPEC = ROOT / "specs" / "3js-005-institutional-continuity"
REFS = ROOT / "docs" / "visual-references" / "3js-institutional"

REQUIRED = [
    APP/"package.json", APP/"package-lock.json", APP/"index.html", APP/"scripts"/"build.mjs",
    APP/"src"/"main.js", APP/"src"/"institutional.js", APP/"src"/"presentationModel.js",
    APP/"src"/"styleTokens.js", APP/"src"/"materials.js", APP/"src"/"camera.js",
    APP/"src"/"lighting.js", APP/"src"/"props.js",
    SPEC/"spec.md", SPEC/"plan.md", SPEC/"tasks.md", REFS/"README.md",
]
for path in REQUIRED:
    if not path.is_file():
        raise SystemExit(f"3JS-005 validation failed: missing {path.relative_to(ROOT)}")

package=json.loads((APP/"package.json").read_text())
lock=json.loads((APP/"package-lock.json").read_text())
three_version=package.get("dependencies",{}).get("three")
if three_version!="0.186.1":
    raise SystemExit(f"3JS-005 validation failed: expected exact three@0.186.1, got {three_version!r}")
if any(token in three_version for token in "^~*><="):
    raise SystemExit("3JS-005 validation failed: Three.js version must be an exact pin")
if lock.get("packages",{}).get("node_modules/three",{}).get("version")!=three_version:
    raise SystemExit("3JS-005 validation failed: package-lock Three.js version mismatch")

main=(APP/"src"/"main.js").read_text()
scene=(APP/"src"/"institutional.js").read_text()
camera=(APP/"src"/"camera.js").read_text()
props=(APP/"src"/"props.js").read_text()
materials=(APP/"src"/"materials.js").read_text()
tokens=(APP/"src"/"styleTokens.js").read_text()
model=(APP/"src"/"presentationModel.js").read_text()
build=(APP/"scripts"/"build.mjs").read_text()
spec=(SPEC/"spec.md").read_text()
lighting=(APP/"src"/"lighting.js").read_text()
runtime="\n".join((main,scene,camera,props,materials,tokens,model,lighting)).lower()

for forbidden in (
    "president","congress","senate","election","ballot","political party",
    "presidente","congresso","senado","eleição","urna","partido político",
    "bandeira","brasão"
):
    if forbidden in runtime:
        raise SystemExit(f"3JS-005 validation failed: real-world political/electoral token in runtime: {forbidden}")

contracts={
    "fixed orthographic camera":"THREE.OrthographicCamera" in camera and "lookAt" in camera,
    "institutional identity":all(name in props for name in ("ForumFloor","ParticipationDesk","ProposalPedestals","ArchiveModules","PublicBench")),
    "equal proposal instancing":"THREE.InstancedMesh" in props and "ProposalPedestals" in props and "model.proposals" in props,
    "neutrality marker":"equal-scale-material-lighting" in props,
    "three equal proposal transforms":model.count("scale:[1.10,0.92,1.10]")==3,
    "balanced practicals":"WarmPracticalLeft" in lighting and "WarmPracticalRight" in lighting,
    "style tokens":all(name in tokens for name in ("palette","camera","material","lighting","render","scale")),
    "flat shading":"flatShading:styleTokens.material.flatShading" in materials,
    "read-only model":"Object.freeze" in model,
    "fictional boundary":"No policy semantics, real institutions or electoral content" in model,
    "neutral spec":"No proposal, policy or institutional path may be visually ranked" in spec,
    "no texture loader":"TextureLoader" not in runtime,
    "zero textures":"authoredTextureBudget:0" in tokens,
    "explicit disposal":"disposeInstitutional" in scene and "renderer.dispose()" in main,
    "deterministic resize":"updateInstitutionalCamera" in camera and "window.addEventListener('resize'" in main,
    "DPR cap":"styleTokens.render.pixelRatioCap" in main,
    "shadows disabled":"shadows:false" in tokens,
    "no perpetual loop":"requestAnimationFrame" not in main and "setAnimationLoop" not in main,
    "ready signal":"__DA_LATA_3JS_READY__" in main,
    "scene identity":"__DA_LATA_3JS_SCENE__='institutional'" in main,
    "metrics signal":"__DA_LATA_3JS_METRICS__" in main,
    "proposal metric":"proposalCount:institutionalPresentationModel.proposals.length" in main,
    "local module":"three.module.js" in build and "three.core.js" in build,
    "reference linked":"docs/visual-references/3js-institutional" in model,
    "candidate status":"styleStatus:'CANDIDATE'" in model,
}
failed=[name for name,ok in contracts.items() if not ok]
if failed:
    raise SystemExit("3JS-005 validation failed contracts: "+", ".join(failed))
print("3JS-005 institutional structural validation: PASS")
