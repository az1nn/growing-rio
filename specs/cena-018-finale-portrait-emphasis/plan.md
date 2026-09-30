# CENA-018 — Plan

## Implementation

1. Keep the responsive Finale card/diorama budget from the original A/B.
2. Replace the shared Finale tableau with four phase-owned Node3D compositions.
3. Keep common room shell, camera, lights and interaction area, but drive their phase-specific state from `set_phase()`.
4. Synchronize `active_overlay_id` into `finale_diorama.set_phase()` in real campaign transitions, not only visual fixtures.
5. Retain neutral equal-weight selection doors.
6. Add a regression that fails if phases collapse back to one visible composition or reuse the same primary/camera contract.
7. Extend campaign completion regression to verify selection → handoff → coda → recap visual synchronization.

## Verification

- Canonical `tools/ci_validate.sh`.
- `tests/finale_phase_visual_test.gd`.
- `tests/finale_completion_test.gd`.
- Visual acceptance capture.
- LENTE exact-head page + isolated-scene captures at both portrait sizes.
- CAVEMAN comparison against #184 baseline and the rejected size-only preview.
- Human visual gate before ready-for-review/merge.
