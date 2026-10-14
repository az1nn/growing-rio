# Implementation plan — eight-skill architecture

## Claim reconciliation (2026-10-14)
- PR #213 owns active ARTIST/CENA changes for City; do not touch those skill files or their dependent runtime/asset paths.
- PR #224 owns active LENTE changes; do not touch LENTE or capture tooling.
- This PR owns only the architectural skill inventory, SIGA/concurrency routing and documentation.
- New post-claim scan identified no overlapping active PR on the initial spec path.

## Migration phases
1. Introduce canonical skill inventory and route 3JS to historical archive, never to production V1.
2. Move the complete SIGA-CONCURRENCY protocol to a SIGA-owned internal reference, retaining all text and invariants. Update all consumers to the new path only after it exists.
3. Retire the two top-level directories after validating every remaining reference and protocol test.
4. Preserve ARTIST/CENA/GODOT/QA/LENTE/LORE/RELATORIO as distinct authorities; changes to ARTIST/CENA/LENTE must wait for integration of #213/#224 or occur in separate conflict-safe waves.
5. Run structural validators, protocol tests, Godot headless and applicable exact-head checks; keep draft until green. Never merge from stale evidence.

## Migration guardrails
- Do not replace concurrency with a summary; migrate verbatim.
- Do not delete Three.js historical docs, assets, or PR evidence.
- Preserve human visual ACCEPT/REVISE and deterministic REPORT_V1.
- No edits to PR #213 or #224 branches.

## Execution state
T001 COMPLETE: spec and draft claim.
T002 PENDING: atomic protocol migration and archival.
T003 PENDING: routing and reference rewrite.
T004 PENDING: validators/tests.
T005 PENDING: exact-head CI, review, guarded merge.
