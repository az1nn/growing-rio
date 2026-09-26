from __future__ import annotations

import json
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
APP = ROOT / "threejs" / "grow-room"
SPEC = ROOT / "specs" / "3js-002-grow-room-style-lock"
REFS = ROOT / "docs" / "visual-references" / "3js-grow-room"

REQUIRED = [
    APP / "package.json",
    APP / "package-lock.json",
    APP / "index.html",
    APP / "scripts" / "build.mjs",
    APP / "src" / "main.js",
    APP / "src" / "growRoom.js",
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
        raise SystemExit(f"3JS-002 validation failed: missing {path.relative_to(ROOT)}")

package = json.loads((APP / "package.json").read_text())
lock = json.loads((APP / "package-lock.json").read_text())
three_version = package.get("dependencies", {}).get("three")

if three_version != "0.186.1":
    raise SystemExit(f"3JS-002 validation failed: expected exact three@0.186.1, got {three_version!r}")
if any(token in three_version for token in "^~*><="):
    raise SystemExit("3JS-002 validation failed: Three.js version must be an exact pin")
if lock.get("packages", {}).get("node_modules/three", {}).get("version") != three_version:
    raise SystemExit("3JS-002 validation failed: package-lock Three.js version mismatch")

main = (APP / "src" / "main.js").read_text()
scene = (APP / "src" / "growRoom.js").read_text()
camera = (APP / "src" / "camera.js").read_text()
props = (APP / "src" / "props.js").read_text()
materials = (APP / "src" / "materials.js").read_text()
tokens = (APP / "src" / "styleTokens.js").read_text()
model = (APP / "src" / "presentationModel.js").read_text()
build = (APP / "scripts" / "build.mjs").read_text()
spec = (SPEC / "spec.md").read_text()

contracts = {
    "fixed orthographic camera": "THREE.OrthographicCamera" in camera and "lookAt" in camera,
    "cutaway shell": all(name in props for name in ("RoomFloor", "BackWall", "SideWall")),
    "style tokens": all(name in tokens for name in ("palette", "camera", "material", "lighting", "render", "scale")),
    "flat shading": "flatShading: styleTokens.material.flatShading" in materials,
    "instanced repeated geometry": "THREE.InstancedMesh" in props and "Canopies" in props,
    "authored prop density": all(name in props for name in ("StorageCrates", "LooseDressing", "WorktableTops")),
    "warm/cool lighting": "CoolKey" in (APP / "src" / "lighting.js").read_text() and "WarmPractical" in (APP / "src" / "lighting.js").read_text(),
    "read-only presentation model": "Object.freeze" in model,
    "abstract non-operational boundary": "non-operational" in spec and "no real operating parameters" in props,
    "no texture loader": "TextureLoader" not in main and "TextureLoader" not in scene and "TextureLoader" not in props,
    "zero authored texture candidate": "authoredTextureBudget: 0" in tokens,
    "explicit disposal": "disposeGrowRoom" in scene and "renderer.dispose()" in main,
    "deterministic resize": "updateGrowRoomCamera" in camera and "window.addEventListener('resize'" in main,
    "DPR cap": "styleTokens.render.pixelRatioCap" in main,
    "dynamic shadows disabled": "shadows: false" in tokens,
    "no perpetual animation loop": "requestAnimationFrame" not in main and "setAnimationLoop" not in main,
    "ready signal": "__DA_LATA_3JS_READY__" in main,
    "scene identity": "__DA_LATA_3JS_SCENE__ = 'grow-room'" in main,
    "metrics signal": "__DA_LATA_3JS_METRICS__" in main,
    "local Three.js module": "three.module.js" in build and "three.core.js" in build,
    "reference pack linked": "docs/visual-references/3js-grow-room" in model,
    "accepted style status": "styleStatus: 'ACCEPT'" in model and "styleStatus: 'ACCEPT'" in main,
}

failed = [name for name, ok in contracts.items() if not ok]
if failed:
    raise SystemExit("3JS-002 validation failed contracts: " + ", ".join(failed))

print("3JS-002 grow-room structural validation: PASS")
