# CENA-017 — Final 3D certification record

## Certification target

This record closes the player-visible 3D completeness objective on one reconciled delivery line after CENA-015, CENA-016 and the CENA-017 audit/capture work have landed.

Canonical rows:

1. Operation
2. Market
3. City
4. Institutional
5. Archive
6. Campaign
7. Narrative
8. Finale selection / handoff
9. Coda / recap

## Structural gate

The canonical audit enforces all 9 rows with:

- Node3D
- Camera3D
- WorldEnvironment
- Light3D
- MeshInstance3D
- Area3D + CollisionShape3D
- accessible Button fallback
- live pointer/touch contract where exposed
- presentation-only activation semantics for Campaign, Narrative and Finale
- Finale phases selection, handoff, coda and recap
- an explicit invariant that the canonical surface inventory contains exactly 9 rows

## Exact-head candidate evidence

Accepted pre-merge certification candidate:

- PR: #172
- exact head: `6f2f25c1e7403b71f9ee6e2f76e269b3eeca04a1`
- Validate project run: `36594110061` — SUCCESS
- Visual acceptance capture run: `36594110133` — SUCCESS
- visual artifact: `11045322206`
- artifact digest: `sha256:d9374f87ac6082669bde3768692f8841fd8694ecd4dd55933f08570c04beec77`
- captures: 22 PNGs = 11 destination/phase views × 2 portrait sizes
- browser-console/page-error artifact: empty
- Godot Web export: SUCCESS from the same exact checkout

The 540x960 and 1080x1920 artifacts were inspected. Operation, Market, City, Institutional, Archive, Campaign and Narrative present distinct authored 3D compositions. Finale selection/handoff and Coda/recap visibly present the shared dedicated Finale tableau with phase-specific copy. No row is hidden, zero-sized or visually empty.

## Decision matrix

| Surface | Structural | 540x960 | 1080x1920 | CENA decision |
| --- | --- | --- | --- | --- |
| Operation | PASS | PASS | PASS | ACCEPT |
| Market | PASS | PASS | PASS | ACCEPT |
| City | PASS | PASS | PASS | ACCEPT |
| Institutional | PASS | PASS | PASS | ACCEPT |
| Archive | PASS | PASS | PASS | ACCEPT |
| Campaign | PASS | PASS | PASS | ACCEPT |
| Narrative | PASS | PASS | PASS | ACCEPT |
| Finale selection/handoff | PASS | PASS | PASS | ACCEPT |
| Coda/recap | PASS | PASS | PASS | ACCEPT |

## Correction decision

No corrective runtime slice is required from the inspected exact-head evidence. T008 is satisfied as a no-op branch: no canonical surface is 2D-only, hidden, visually empty or missing its intended interaction contract.

## Master certification rule

PR-head ACCEPT is necessary but not the final delivery proof. `Visual acceptance capture` now also runs on relevant pushes to `master`. T009 closes only after #172 is merged and the resulting master commit passes both Validate project and Visual acceptance capture. T010 then persists that exact master commit and run/artifact references in the CENA/SIGA handoffs.

## Closure rule

Do not claim final CENA-017 closure until the post-merge master commit has green structural and rendered evidence. Explicit Vercel free-tier build throttling remains an external availability constraint and does not invalidate green repository/rendered certification.

## Final master closure — 2026-09-29

**Status: CENA ACCEPT / CLOSED.**

The post-merge delivery proof required above is satisfied on one canonical master commit:

- certified master commit: `33f97bcd8e5fb0e48e36ea67b501631f9290a797`
- source delivery: PR #172, merged 2026-09-29
- Validate project: run #818 / `36596189406` — **SUCCESS**
- Visual acceptance capture: run #369 / `36596189548` — **SUCCESS**
- rendered artifact: `11046242559` — `visual-acceptance-33f97bcd8e5fb0e48e36ea67b501631f9290a797`
- artifact digest: `sha256:c16d3d0df04b03a8c4c8c223f7cc70f493c577c97861b52418ba9542679e89e7`
- rendered evidence: 22 PNGs, representing 11 destination/phase captures at 540x960 and 1080x1920
- browser-console/page-error file: empty
- Vercel deployment status on the certified commit: **SUCCESS**

The post-merge screenshots are byte-identical to the accepted pre-merge candidate screenshots. All nine canonical rows remain PASS / ACCEPT. T009 and T010 are complete; CENA-017 is closed. Any later visual regression must open a new bounded task rather than silently reopening this certification record.
