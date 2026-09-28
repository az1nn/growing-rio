SIGA-TASK-KEY: CENA-012:INSTITUTIONAL-GODOT-3D
SESSION: feat/cena-012-institutional-godot-diorama
SCOPE:
- scenes/institutional/**
- scenes/visual/institutional_diorama.*
- tests/institutional_3d_diorama_test.gd
- tools/ci_validate.sh
- docs/SIGA-HANDOFF.md only after fresh overlap scan if unclaimed
SEMANTIC BOUNDARY:
- canonical Godot presentation only
- no gameplay/domain/save-schema/canon mutation
- fictional civic scene; equal visual treatment for three proposal objects
CONCURRENCY:
- PR #156 Archive spec paths are out of scope and parallel-safe
REMOVE-BEFORE-DELIVERY: yes
