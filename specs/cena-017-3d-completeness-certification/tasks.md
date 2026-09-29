# CENA-017 tasks — 3D completeness certification

- [x] T001 Reconcile the current player-facing surface inventory against merged CENA/3JS work and the live CENA-015/CENA-016 branches.
- [x] T002 Define the hard certification matrix for visible 3D, pointer/touch interaction, accessibility fallback, state preservation and portrait evidence.
- [x] T003 After CENA-015 and CENA-016 runtime integration, rebase onto current master and scan every player-facing surface for structural 3D coverage.
- [x] T004 Add a dedicated automated 3D completeness audit that fails when a required surface lacks camera/world/geometry/interaction contracts.
- [x] T005 Extend canonical validation so the completeness audit runs on every relevant PR.
- [x] T006 Extend visual acceptance to capture Finale and Coda/recap at 540x960 and 1080x1920 on the exact head.
- [x] T007 Inspect rendered evidence for all rows and record CENA ACCEPT or REVISE per surface.
- [x] T008 If any surface is 2D-only, hidden, visually empty, or lacks its intended clickable object, create the smallest corrective runtime task and repeat exact-head validation.
- [x] T009 Reconcile concurrent branches, merge only green non-colliding work, then run the matrix once on a single master commit.
- [x] T010 Publish the final certification in CENA/SIGA handoffs with exact commit and evidence references.

## Reconciliation evidence for T003–T006

- CENA-015 Narrative runtime is merged.
- CENA-016 Finale/Coda runtime is merged.
- `tests/three_d_completeness_audit_test.gd` enumerates all 9 canonical rows and enforces Node3D, Camera3D, WorldEnvironment, Light3D, MeshInstance3D, Area3D, CollisionShape3D, Button and presentation-only interaction contracts.
- `tools/ci_validate.sh` runs the CENA-017 completeness audit.
- `.github/workflows/visual-acceptance.yml` captures Operation, Market, City, Institutional, Archive, Campaign, Narrative plus Finale selection/handoff/coda/recap at both required portrait sizes and rejects browser/page errors.
- PRs #169, #170 and #171 delivered the audit, canonical CI wiring and Finale/Coda capture extension to `master`.

## Done

CENA-017 closes only when every required row is PASS on one reconciled master commit. Source code presence alone is not evidence.


## Final delivery evidence

- certified master commit: `33f97bcd8e5fb0e48e36ea67b501631f9290a797`
- post-merge Validate project: run `36596189406` — SUCCESS
- post-merge Visual acceptance capture: run `36596189548` — SUCCESS
- post-merge visual artifact: `11046242559`
- artifact digest: `sha256:c16d3d0df04b03a8c4c8c223f7cc70f493c577c97861b52418ba9542679e89e7`
- rendered evidence: 22 PNGs, byte-identical to the final accepted PR-head capture
- browser console/page errors: empty
- CENA decision: ACCEPT on all 9 canonical rows
