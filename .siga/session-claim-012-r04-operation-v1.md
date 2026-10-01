# SIGA session claim — Feature 012 / R04 Operation V1

SIGA-TASK-KEY: `012:R04:T019-T040`

Base SHA: `9b68272bf336e528f6ade32924c5b049a160a8f0`
Execution substate: `STRUCTURAL_REBASE_REQUIRED`

Intended paths/contracts:
- `specs/012-artist-v1-runtime-parity/operation-build-sheet.md`
- `specs/012-artist-v1-runtime-parity/operation-runtime-review.md`
- `specs/012-artist-v1-runtime-parity/tasks.md`
- `scenes/visual/operation_diorama.gd`
- `scenes/visual/operation_diorama.tscn`
- Operation-only tests/evidence under Feature 012
- ARTIST/LENTE Operation runtime evidence only

Semantic scope:
- R04 Operation V1 only.
- Rebuild rejected visible geometry from the accepted ARTIST target; do not create additive Rev14 dressing.
- Preserve existing gameplay, semantic hotspots and accessible fallbacks.
- Use Godot 4.7.2 / GL Compatibility and the shared R03 V1 visual system.
- R05+ remain locked.
- This coordination file is temporary and must be removed before merge.
