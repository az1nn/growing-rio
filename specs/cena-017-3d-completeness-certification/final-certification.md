# CENA-017 — Final 3D certification record

## Certification target

This record closes the player-visible 3D completeness objective on one reconciled exact head after CENA-015, CENA-016 and the CENA-017 audit/capture work have landed.

Canonical rows:

1. Operation
2. Market
3. City
4. Institutional
5. Archive
6. Campaign
7. Narrative
8. Finale selection/handoff
9. Coda/recap

## Structural gate

The canonical audit must pass all 9 rows with:

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

## Rendered gate

The exact certification head must produce:

- 540x960 capture for every canonical destination/phase
- 1080x1920 capture for every canonical destination/phase
- zero browser-console/page errors
- exported Godot Web candidate from the same exact checkout

## Decision matrix

| Surface | Structural | 540x960 | 1080x1920 | CENA decision |
| --- | --- | --- | --- | --- |
| Operation | PENDING exact-head CI | PENDING | PENDING | PENDING |
| Market | PENDING exact-head CI | PENDING | PENDING | PENDING |
| City | PENDING exact-head CI | PENDING | PENDING | PENDING |
| Institutional | PENDING exact-head CI | PENDING | PENDING | PENDING |
| Archive | PENDING exact-head CI | PENDING | PENDING | PENDING |
| Campaign | PENDING exact-head CI | PENDING | PENDING | PENDING |
| Narrative | PENDING exact-head CI | PENDING | PENDING | PENDING |
| Finale selection/handoff | PENDING exact-head CI | PENDING | PENDING | PENDING |
| Coda/recap | PENDING exact-head CI | PENDING | PENDING | PENDING |

## Closure rule

Do not replace the PENDING states with PASS/ACCEPT until the exact PR head has successful Validate project and Visual acceptance capture evidence and the rendered artifact has been inspected. If a visual defect appears, open the smallest corrective runtime slice and keep CENA-017 open.
