# SIGA session claim

SIGA-TASK-KEY: `010:ALL-SCENES-3D`

Base SHA: `f4b1717042e90b42295f07019b52b921d0a00ba4`

Intended paths/contracts:
- `specs/010-all-scenes-3d/`
- `scenes/**/*.tscn`
- `scenes/visual/interactive_context_3d.gd`
- `tests/all_scenes_3d_interaction_test.gd`
- `tools/validate_project.py`
- `docs/CENA-HANDOFF.md`
- temporary `.siga/session-claim-010-all-scenes-3d.md` (remove before delivery)

Semantic scope: make every shipped Godot scene instantiate a real 3D runtime subtree with camera, environment, light, visible mesh and a clickable 3D object plus accessible button fallback. Preserve existing gameplay, domain, save schema, lore and Three.js work.
