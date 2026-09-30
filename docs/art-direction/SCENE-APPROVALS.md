# ARTIST — scene approval ledger

This ledger is an approval record, **not** an aesthetic ranking or runtime verification. Source of scene IDs: current LENTE visual-lab inventory (PR #184 until merged).

| ID | Concept gate | Original concept artifact | CENA/3JS implementation | Exact-head LENTE before/after | Next |
|---|---|---|---|---|---|
| GLOBAL STYLE V1 | **ACCEPTED** 2026-09-30 | Original complete illustration **ARCHIVED** in `assets/art-direction/v1/da-lata-v1-style-board.png`; SHA-256 `6f19b2e852ee10fcee8b6e7d16852bb1c03501c0be9ffbb551f842a91bf8ee7d` | pending CENA review | not applicable to style alone | generate isolated Operation concept; global image safely archived |
| operation | SCENE_PENDING | none verified | not started | missing | generate isolated V1 scene round |
| market | SCENE_PENDING | none | not started | missing | after operation creative gate |
| city | SCENE_PENDING | none | not started | missing | after market creative gate |
| institutional | SCENE_PENDING | none | not started | missing | after city creative gate |
| archive | SCENE_PENDING | none | not started | missing | after institutional gate |
| campaign | SCENE_PENDING | none | not started | missing | after archive gate |
| narrative | SCENE_PENDING | none | not started | missing | after campaign gate |
| finale-selection | SCENE_PENDING | none | not started | missing | after narrative gate |
| finale-handoff | SCENE_PENDING | none | not started | missing | after selection gate |
| finale-coda | SCENE_PENDING | none | not started | missing | after handoff gate |
| finale-recap | SCENE_PENDING | none | not started | missing | after coda gate |

### Write rule
On a specific scene's `ACCEPT`, link its *immutable* round folder and exact portable prompt, record where the **actual bytes** live (or `NOT_ARCHIVED` explicitly), name the accepting user/date and log handoff to CENA/3JS. Approval **does not** imply runtime quality or 3D integration. Revisions create a new round folder; retain rejected prior versions. Do not mark a scene `VERIFIED` until comparison against fresh engine render evidence on the correct commit.

### Verification states
`SCENE_PENDING → PROPOSED → REVISE | REJECTED | ACCEPTED → IMPLEMENTED → RUNTIME_REVIEWED`; `REFERENCE_NOT_ARCHIVED` can coexist with an accepted *aesthetic* decision but blocks any claim that the underlying binary reference has been preserved or ingested into engine assets.

> **Machine-readable current approval register:** `docs/art-direction/v1/SCENE-STATUS.json`. This Markdown table is a human-readable snapshot; do not infer runtime approval from the global style approval. The first `artifacts/artist/runs/20260930T103636Z/` batch contains eleven independent generation BRIEFS only, not generated imagery.
