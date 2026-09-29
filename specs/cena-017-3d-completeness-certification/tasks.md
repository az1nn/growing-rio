# CENA-017 tasks — 3D completeness certification

- [x] T001 Reconcile the current player-facing surface inventory against merged CENA/3JS work and the live CENA-015/CENA-016 branches.
- [x] T002 Define the hard certification matrix for visible 3D, pointer/touch interaction, accessibility fallback, state preservation and portrait evidence.
- [ ] T003 After CENA-015 and CENA-016 runtime integration, rebase onto current master and scan every player-facing surface for structural 3D coverage.
- [ ] T004 Add a dedicated automated 3D completeness audit that fails when a required surface lacks camera/world/geometry/interaction contracts.
- [ ] T005 Extend canonical validation so the completeness audit runs on every relevant PR.
- [ ] T006 Extend visual acceptance to capture Finale and Coda/recap at 540x960 and 1080x1920 on the exact head.
- [ ] T007 Inspect rendered evidence for all rows and record CENA ACCEPT or REVISE per surface.
- [ ] T008 If any surface is 2D-only, hidden, visually empty, or lacks its intended clickable object, create the smallest corrective runtime task and repeat exact-head validation.
- [ ] T009 Reconcile concurrent branches, merge only green non-colliding work, then run the matrix once on a single master commit.
- [ ] T010 Publish the final certification in CENA/SIGA handoffs with exact commit and evidence references.

## Done

CENA-017 closes only when every required row is PASS on one reconciled master commit. Source code presence alone is not evidence.
