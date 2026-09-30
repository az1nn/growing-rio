# CENA-018 — Plan

## Scope

Use responsive shell layout values rather than editing Finale geometry or camera semantics.

### Implementation

- Add explicit responsive Finale presentation budgets in `scenes/shell/game_shell.gd`.
- Apply them only while `active_overlay_id` begins with `finale:`.
- Re-apply the budget when viewport layout changes and when overlay ownership changes.
- Restore default card/diorama sizing when leaving Finale.

### Verification

- Extend `tests/visual_production_pass_test.gd` with 540×960 and 1080×1920 structural gates.
- Run the canonical project validation workflow.
- Run visual acceptance capture and LENTE exact-head capture.
- Compare Finale page captures against the immutable #184 baseline, especially embedded tableau scale and control legibility.
- Preserve all existing semantic-hotspot and campaign-state regressions.
