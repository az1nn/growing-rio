from __future__ import annotations

import json
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
APP = ROOT / "threejs" / "market-diorama"
GROW = ROOT / "threejs" / "grow-room"
SPEC = ROOT / "specs" / "3js-003-market-diorama-propagation"
REFS = ROOT / "docs" / "visual-references" / "3js-market"

REQUIRED = [
    APP / "package.json",
    APP / "package-lock.json",
    APP / "index.html",
    APP / "scripts" / "build.mjs",
    APP / "src" / "main.js",
    APP / "src" / "marketDiorama.js",
    APP / "src" / "presentationModel.js",
    APP / "src" / "styleTokens.js",
    APP / "src" / "materials.js",
    APP / "src" / "camera.js",
    APP / "src" / "lighting.js",
    APP / "src" / "props.js",
    SPEC / "spec.md",
    SPEC / "plan.md",
    SPEC / "tasks.md",
    REFS / "README.md",
]

for path in REQUIRED:
    if not path.is_file():
        raise SystemExit(f"3JS-003 validation failed: missing {path.relative_to(ROOT)}")

package = json.loads((APP / "package.json").read_text())
lock = json.loads((APP / "package-lock.json").read_text())
three_version = package.get("dependencies", {}).get("three")

if three_version != "0.186.1":
    raise SystemExit(f"3JS-003 validation failed: expected exact three@0.186.1, got {three_version!r}")
if any(token in three_version for token in "^~*><="):
    raise SystemExit("3JS-003 validation failed: Three.js version must be an exact pin")
if lock.get("packages", {}).get("node_modules/three", {}).get("version") != three_version:
    raise SystemExit("3JS-003 validation failed: package-lock Three.js version mismatch")

main = (APP / "src" / "main.js").read_text()
scene = (APP / "src" / "marketDiorama.js").read_text()
camera = (APP / "src" / "camera.js").read_text()
props = (APP / "src" / "props.js").read_text()
materials = (APP / "src" / "materials.js").read_text()
tokens = (APP / "src" / "styleTokens.js").read_text()
grow_tokens = (GROW / "src" / "styleTokens.js").read_text()
model = (APP / "src" / "presentationModel.js").read_text()
build = (APP / "scripts" / "build.mjs").read_text()
spec = (SPEC / "spec.md").read_text()
references = (REFS / "README.md").read_text()

contracts = {
    "fixed orthographic camera": "THREE.OrthographicCamera" in camera and "lookAt" in camera,
    "accepted token inheritance": tokens == grow_tokens,
    "flat shading": "flatShading: styleTokens.material.flatShading" in materials,
    "market architecture": all(name in props for name in ("MarketFloor", "BackWall", "SideWall")),
    "deal counter": "DealCounter" in props,
    "vendor storage bay": "VendorStorage" in props and "StorageCrates" in props,
    "loading rhythm": "LoadingShutterRhythm" in props,
    "commerce trolley": "CommerceTrolley" in props,
    "instanced repeated geometry": "THREE.InstancedMesh" in props,
    "warm/cool lighting": "CoolKey" in (APP / "src" / "lighting.js").read_text() and "WarmPractical" in (APP / "src" / "lighting.js").read_text(),
    "read-only presentation model": "Object.freeze" in model,
    "CENA visual contract": "docs/visual-references/3js-market/README.md" in model and "CENA-020" in references,
    "abstract non-operational boundary": "non-operational" in spec and "no real routes" in props,
    "no texture loader": "TextureLoader" not in main and "TextureLoader" not in scene and "TextureLoader" not in props,
    "zero authored texture baseline": "authoredTextureBudget: 0" in tokens,
    "explicit disposal": "disposeMarketDiorama" in scene and "renderer.dispose()" in main,
    "deterministic resize": "updateMarketCamera" in camera and "window.addEventListener('resize'" in main,
    "DPR cap": "styleTokens.render.pixelRatioCap" in main,
    "dynamic shadows disabled": "shadows: false" in tokens,
    "no perpetual animation loop": "requestAnimationFrame" not in main and "setAnimationLoop" not in main,
    "ready signal": "__DA_LATA_3JS_READY__" in main,
    "scene identity": "__DA_LATA_3JS_SCENE__ = 'market-diorama'" in main,
    "metrics signal": "__DA_LATA_3JS_METRICS__" in main,
    "candidate review status": "styleStatus: 'CANDIDATE'" in model and "styleStatus: 'CANDIDATE'" in main,
    "local Three.js module": "three.module.js" in build and "three.core.js" in build,
}

failed = [name for name, ok in contracts.items() if not ok]
if failed:
    raise SystemExit("3JS-003 validation failed contracts: " + ", ".join(failed))

print("3JS-003 market-diorama structural validation: PASS")
