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


## Post-merge master certification

CENA-017 is finally certified on the reconciled default-branch commit:

- master: `33f97bcd8e5fb0e48e36ea67b501631f9290a797`
- Validate project: run `36596189406` — SUCCESS
- Visual acceptance capture: run `36596189548` — SUCCESS
- artifact: `11046242559`
- artifact digest: `sha256:c16d3d0df04b03a8c4c8c223f7cc70f493c577c97861b52418ba9542679e89e7`
- 22 expected PNG captures present
- all 22 PNGs are byte-identical to the final accepted PR-head evidence
- browser-console/page-error file is empty
- Godot Web export completed successfully from the master checkout

### Final decision

**CENA ACCEPT — 9/9 canonical rows PASS.**

Operation, Market, City, Institutional, Archive, Campaign, Narrative, Finale selection/handoff and Coda/recap all satisfy the CENA-017 structural and rendered contracts on one reconciled master commit. No corrective runtime task is required.

CENA-017 is closed. Future player-facing destinations automatically inherit the same 3D completeness contract and must extend the canonical inventory before they can be treated as certified.
