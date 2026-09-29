# SIGA session claim — CENA-015 Narrative Godot 3D runtime

Base: `master@22ee519548fe4b8a9a96d0f55443686fc4a9d5af`

Owned paths/contracts for this session:
- `scenes/visual/narrative_diorama.gd`
- `scenes/visual/narrative_diorama.tscn`
- `scenes/shell/game_shell.gd`
- `scenes/shell/game_shell.tscn`
- `tests/narrative_3d_diorama_test.gd`
- `tests/game_shell_navigation_test.gd`
- `tools/ci_validate.sh`
- `.github/workflows/visual-acceptance.yml`
- `specs/cena-015-narrative-godot-3d/tasks.md`

Semantic boundary: presentation-only Narrative 3D. No narrative resolution, save mutation, time advance, economy, lifecycle, inventory, RNG or finale/coda redesign.

Concurrency: any later session touching these runtime paths must reconcile against this branch/PR before writing.
