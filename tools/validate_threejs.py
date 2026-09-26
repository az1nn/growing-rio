from __future__ import annotations

import json
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
APP = ROOT / "threejs" / "operation-diorama"

REQUIRED = [
    APP / "package.json",
    APP / "package-lock.json",
    APP / "index.html",
    APP / "scripts" / "build.mjs",
    APP / "src" / "main.js",
    APP / "src" / "operationDiorama.js",
    APP / "src" / "presentationModel.js",
    ROOT / "specs" / "3js-001-operation-diorama-parity" / "spec.md",
    ROOT / "specs" / "3js-001-operation-diorama-parity" / "plan.md",
    ROOT / "specs" / "3js-001-operation-diorama-parity" / "tasks.md",
]

for path in REQUIRED:
    if not path.is_file():
        raise SystemExit(f"3JS validation failed: missing {path.relative_to(ROOT)}")

package = json.loads((APP / "package.json").read_text())
lock = json.loads((APP / "package-lock.json").read_text())
three_version = package.get("dependencies", {}).get("three")

if three_version != "0.186.1":
    raise SystemExit(f"3JS validation failed: expected exact three@0.186.1, got {three_version!r}")
if any(token in three_version for token in "^~*><="):
    raise SystemExit("3JS validation failed: Three.js version must be an exact pin")
if lock.get("packages", {}).get("node_modules/three", {}).get("version") != three_version:
    raise SystemExit("3JS validation failed: package-lock Three.js version does not match package.json")

main = (APP / "src" / "main.js").read_text()
scene = (APP / "src" / "operationDiorama.js").read_text()
build = (APP / "scripts" / "build.mjs").read_text()
plan = (ROOT / "specs" / "3js-001-operation-diorama-parity" / "plan.md").read_text()

contracts = {
    "orthographic camera": "THREE.OrthographicCamera" in scene,
    "CENA-019 landing": "ForegroundServiceLanding" in scene,
    "instanced repeated plant geometry": "THREE.InstancedMesh" in scene,
    "explicit disposal": "disposeOperationDiorama" in scene and "renderer.dispose()" in main,
    "deterministic resize": "updateParityCamera" in scene and "window.addEventListener('resize'" in main,
    "DPR cap": "Math.min(window.devicePixelRatio || 1, 1.5)" in main,
    "no perpetual animation loop": "setAnimationLoop" not in main and "requestAnimationFrame" not in main,
    "ready signal": "__DA_LATA_3JS_READY__" in main,
    "metrics signal": "__DA_LATA_3JS_METRICS__" in main,
    "local vendor copy": "node_modules', 'three', 'build', 'three.module.js" in build,
    "local Three.js core copy": "node_modules', 'three', 'build', 'three.core.js" in build,
    "generated web excluded": "outside generated `web/`" in plan,
}

failed = [name for name, ok in contracts.items() if not ok]
if failed:
    raise SystemExit("3JS validation failed contracts: " + ", ".join(failed))

print("3JS-001 structural validation: PASS")
