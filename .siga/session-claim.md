# SIGA session claim

- SIGA-TASK-KEY: `009:T009`
- base: `3d3048e025cb565b1f88895bd051135ab1fa9780` / PR #133
- scope: expose derived lifecycle stage through GameState/room presentation state
- intended paths: `autoload/game_state.gd`, Feature 009 tests/tasks/workflow, handoff as needed
- boundary: reuse `CultivationService.lifecycle_stage`; do not persist stage and do not duplicate lifecycle rules
