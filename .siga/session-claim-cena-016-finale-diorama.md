# SIGA session claim — CENA-016 Finale isolated diorama

Base: `master@22ee519548fe4b8a9a96d0f55443686fc4a9d5af`

Owned paths in this parallel-safe slice:
- `scenes/visual/finale_diorama.gd`
- `scenes/visual/finale_diorama.tscn`
- `tests/finale_3d_diorama_test.gd`
- `specs/cena-016-finale-godot-3d/tasks.md`

This branch intentionally does not touch `game_shell.*`, `tools/ci_validate.sh`, visual-acceptance workflow, campaign flow, save state, eligibility, ending selection or completion. Those integration paths wait for CENA-015 runtime to clear.
