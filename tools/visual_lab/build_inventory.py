#!/usr/bin/env python3
"""Build and validate the DA LATA LENTE visual inventory."""

from __future__ import annotations

import argparse
import json
import re
from pathlib import Path


NODE_RE = re.compile(
    r'^\[node name="(?P<name>[^"]+)"(?: type="(?P<type>[^"]+)")?(?: parent="(?P<parent>[^"]*)")?.*\]$'
)
AUDIT_ROW_RE = re.compile(
    r'\{\s*"id":\s*"(?P<id>[^"]+)",\s*"path":\s*"(?P<path>[^"]+)"',
    re.DOTALL,
)


def repo_path(root: Path, resource_path: str) -> Path:
    if not resource_path.startswith("res://"):
        raise ValueError(f"expected res:// path, got {resource_path!r}")
    return root / resource_path.removeprefix("res://")


def parse_scene(path: Path) -> dict:
    nodes: list[dict[str, str]] = []
    for raw_line in path.read_text(encoding="utf-8").splitlines():
        match = NODE_RE.match(raw_line.strip())
        if not match:
            continue
        nodes.append(
            {
                "name": match.group("name"),
                "type": match.group("type") or "instance",
                "parent": match.group("parent") or ".",
            }
        )

    def names_of(node_type: str) -> list[str]:
        return [node["name"] for node in nodes if node["type"] == node_type]

    light_types = {"DirectionalLight3D", "OmniLight3D", "SpotLight3D"}
    return {
        "node_count": len(nodes),
        "mesh_nodes": names_of("MeshInstance3D"),
        "interaction_nodes": names_of("Area3D"),
        "camera_nodes": names_of("Camera3D"),
        "environment_nodes": names_of("WorldEnvironment"),
        "light_nodes": [node["name"] for node in nodes if node["type"] in light_types],
        "button_nodes": names_of("Button"),
        "label_nodes": names_of("Label"),
    }


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("--manifest", default="tools/visual_lab/manifest.json")
    parser.add_argument("--output", default="visual-lab/inventory.json")
    parser.add_argument("--root", default=".")
    args = parser.parse_args()

    root = Path(args.root).resolve()
    manifest_path = root / args.manifest
    manifest = json.loads(manifest_path.read_text(encoding="utf-8"))

    errors: list[str] = []
    canonical_audit = root / manifest["canonical_audit"]
    if not canonical_audit.is_file():
        errors.append(f"missing canonical audit: {canonical_audit}")
        audit_rows: list[dict[str, str]] = []
    else:
        audit_text = canonical_audit.read_text(encoding="utf-8")
        audit_rows = [
            {"id": match.group("id"), "path": match.group("path")}
            for match in AUDIT_ROW_RE.finditer(audit_text)
        ]

    expected_rows = set(manifest["canonical_rows"])
    actual_rows = {row["id"] for row in audit_rows}
    if actual_rows != expected_rows:
        errors.append(
            "canonical row drift: "
            f"manifest={sorted(expected_rows)} audit={sorted(actual_rows)}"
        )

    for page in manifest["pages"]:
        target = repo_path(root, page["canonical_scene"])
        if not target.is_file():
            errors.append(f"page {page['id']} missing canonical scene {page['canonical_scene']}")

    isolated_inventory: list[dict] = []
    manifest_scene_paths: set[str] = set()
    for scene in manifest["isolated_scenes"]:
        resource_path = scene["path"]
        manifest_scene_paths.add(resource_path)
        target = repo_path(root, resource_path)
        if not target.is_file():
            errors.append(f"isolated scene {scene['id']} missing {resource_path}")
            continue

        parsed = parse_scene(target)
        isolated_inventory.append(
            {
                "id": scene["id"],
                "path": resource_path,
                "phase": scene.get("phase"),
                **parsed,
            }
        )
        if not parsed["mesh_nodes"]:
            errors.append(f"isolated scene {scene['id']} has no MeshInstance3D")
        if not parsed["camera_nodes"]:
            errors.append(f"isolated scene {scene['id']} has no Camera3D")

    discovered_dioramas = {
        "res://" + str(path.relative_to(root)).replace("\\", "/")
        for path in (root / "scenes" / "visual").glob("*_diorama.tscn")
    }
    missing_from_manifest = sorted(discovered_dioramas - manifest_scene_paths)
    if missing_from_manifest:
        errors.append(
            "new visual diorama(s) are not covered by LENTE: "
            + ", ".join(missing_from_manifest)
        )

    output = {
        "schema_version": 1,
        "manifest_version": manifest["version"],
        "canonical_rows": audit_rows,
        "page_count": len(manifest["pages"]),
        "isolated_scene_count": len(manifest["isolated_scenes"]),
        "isolated_scenes": isolated_inventory,
        "discovered_visual_dioramas": sorted(discovered_dioramas),
        "errors": errors,
    }

    output_path = root / args.output
    output_path.parent.mkdir(parents=True, exist_ok=True)
    output_path.write_text(
        json.dumps(output, ensure_ascii=False, indent=2) + "\n",
        encoding="utf-8",
    )

    if errors:
        for error in errors:
            print(f"[lente] ERROR: {error}")
        return 1

    print(
        "[lente] inventory OK: "
        f"{output['page_count']} pages, "
        f"{output['isolated_scene_count']} isolated captures, "
        f"{len(discovered_dioramas)} visual diorama files"
    )
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
