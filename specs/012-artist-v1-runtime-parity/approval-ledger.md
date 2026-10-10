# Feature 012 — ARTIST V1 approval ledger

**Purpose:** canonical approval-state ledger for the strict V1 parity workstream.  
**Global authority:** `assets/art-direction/v1/da-lata-v1-style-board.png`  
**Global board SHA-256:** `6f19b2e852ee10fcee8b6e7d16852bb1c03501c0be9ffbb551f842a91bf8ee7d`  
**Candidate source:** PR #190, merged to `master` as `a96334107da56ff48d57b987b6177359e890716d` on 2026-09-30.

## Status vocabulary

- `BOARD_APPROVED`: global V1 style authority approved by the user.
- `SCENE_CANDIDATE`: immutable generated isolated scene candidate; provenance only.
- `BOARD_CONFORMANCE_AUDITED`: candidate compared against board + written style guide.
- `SCENE_CONCEPT_ACCEPTED`: human visual acceptance of the scene target.
- `SCENE_CONCEPT_REVISE`: human review requires another ARTIST round.
- `3D_IMPLEMENTED`: real interactive 3D implementation exists on an exact repository head.
- `RUNTIME_ACCEPTED`: exact-head LENTE + ARTIST/CENA runtime review accepted.

A merged asset is **not** automatically concept-accepted or runtime-accepted.

## Global style authority

| Authority | SHA / version | Status |
| --- | --- | --- |
| Original V1 11-panel board | `6f19b2e852ee10fcee8b6e7d16852bb1c03501c0be9ffbb551f842a91bf8ee7d` | `BOARD_APPROVED` |
| Written style | `docs/art-direction/v1/README.md`, `docs/art-direction/ARTIST-V1-STYLE.md`, `docs/art-direction/v1/BASE-PROMPT.md`, `docs/art-direction/v1/SCENES.json` | binding |
| Candidate asset set | PR #190 / master `a96334107da56ff48d57b987b6177359e890716d` | provenance locked |

## Per-scene ledger

| Scene | Candidate SHA-256 | Candidate status | Board audit | Concept decision | Runtime decision |
| --- | --- | --- | --- | --- | --- |
| operation | `3ae82a5638e60666de27b7d8deec37cadda2e86e031d88b0dda72658171036ce` | `SCENE_CANDIDATE` | `BOARD_CONFORMANCE_AUDITED` — `PASS_TO_HUMAN_REVIEW` | **`SCENE_CONCEPT_ACCEPTED`** (user, 2026-09-30; current V1 concept) | pending |
| market | `c7d9390f9cba7db434997ca5102841df09a30e95333811b3c297217c2c998075` | `SCENE_CANDIDATE` | `BOARD_CONFORMANCE_AUDITED` — `REVISE_REQUIRED` | **SCENE_CONCEPT_ACCEPTED** (revised run `20261002T091800Z/market`) | **RUNTIME_ACCEPTED** (human, head `c6ebed7dc7319df435d2a6ade8ebf09d6fcea68e`, PR #205 merged) |
| city | `0c86c37b4bb90795a7ff72a7f226141c38a21085edcb52a6275d21e3290956d2` | `SCENE_CANDIDATE` | `BOARD_CONFORMANCE_AUDITED` — `REVISE_REQUIRED` | **SCENE_CONCEPT_ACCEPTED** (revised run `20261004T110406Z/city`) | **REJECT ALL / NOT RUNTIME ACCEPTED** (human 2026-10-08, head `1f799128d9efe33cfdcb8365119fc2eb2371166e`) |
| institutional | `a85019b353c1e0285a23a5290824d4cdabc84e36695651aadba855055485fecc` | `SCENE_CANDIDATE` | `BOARD_CONFORMANCE_AUDITED` — `REVISE_REQUIRED` | pending | pending |
| archive | `37b9c7193f432efcd48d17c0bdce760ad10e0c87445b7e6ce343428ff3f6879b` | `SCENE_CANDIDATE` | `BOARD_CONFORMANCE_AUDITED` — `REVISE_REQUIRED` | pending | pending |
| campaign | `28ed857a076dd3c8d6b04d6fdd207b67c442f54f8679890193a13e4f7a7d3746` | `SCENE_CANDIDATE` | `BOARD_CONFORMANCE_AUDITED` — `REVISE_REQUIRED` | pending | pending |
| narrative | `4de8a9c32b1c47b292ddae961d493e9aa9f1a9e52017c4eaed012d7d83cabd05` | `SCENE_CANDIDATE` | `BOARD_CONFORMANCE_AUDITED` — `REVISE_REQUIRED` | pending | pending |
| finale-selection | `d8a5bea9c0c0599186af92cb2f15a7d95e37814d5ecefd5b0e9423a4baad53de` | `SCENE_CANDIDATE` | `BOARD_CONFORMANCE_AUDITED` — `PASS_TO_HUMAN_REVIEW` | pending | pending |
| finale-handoff | `34c5a3e252323066b6afc1a929398008aed3b59ccba6440eaa38bb7482bceb0e` | `SCENE_CANDIDATE` | `BOARD_CONFORMANCE_AUDITED` — `REVISE_REQUIRED` | pending | pending |
| finale-coda | `1bc566829ff1a65abb1f9d799cce91fa8e40e383676313cf7c5647b9c096bb1a` | `SCENE_CANDIDATE` | `BOARD_CONFORMANCE_AUDITED` — `PASS_TO_HUMAN_REVIEW` | pending | pending |
| finale-recap | `8bfd2dbdad22061deade4c2bd5539d851422cd078cac89fd0f1bc97e00dad172` | `SCENE_CANDIDATE` | `BOARD_CONFORMANCE_AUDITED` — `REVISE_REQUIRED` | pending | pending |

## Gate rule

For each row, the only valid forward sequence is:

`SCENE_CANDIDATE -> BOARD_CONFORMANCE_AUDITED -> SCENE_CONCEPT_ACCEPTED -> 3D_IMPLEMENTED -> RUNTIME_ACCEPTED`

A `SCENE_CONCEPT_REVISE` decision starts a new immutable ARTIST round and replaces the candidate SHA only after the new artifact is generated and reviewed.

## Current handoff

T007 is complete in `board-candidate-audit.md`: all 11 candidates were compared against the locked board + written style.  
`PASS_TO_HUMAN_REVIEW`: operation, finale-selection, finale-coda.  
`REVISE_REQUIRED`: market, city, institutional, archive, campaign, narrative, finale-handoff, finale-recap.  
Operation concept `ACCEPT` was explicitly provided by the user on 2026-09-30: "Accept, por ora está ótimo." The existing candidate bytes/SHA above are the accepted **current V1 concept**, subject to later explicit art revision; this is NOT runtime or renderer acceptance. Evidence sheet: `operation-concept-acceptance.md`. ARTIST CLI canonical run/SCENE-STATUS synchronization remains a required follow-up: the preexisting `artifacts/artist/runs/20260930T103636Z/operation` manifest has no copied PR #190 candidate evidence yet; run `artist.py record` + `artist.py review` on the real repo before claiming that the script registry is updated. Next independent execution: T012 renderer integration map and T010/T011 captures. Divergent scenes remain T008.

## R05/R06 live-state reconciliation — 2026-10-09

PR #205 was merged on 2026-10-04 (merge `f73190b89bafca1e05310f4f816c2cdc788bd03d`) after user Market runtime acceptance of exact head `c6ebed7dc7319df435d2a6ade8ebf09d6fcea68e`; R05 is PASS. R06 is the only current Feature 012 item, PR #213 Draft. The PR #190 candidate hashes and original board-audit `REVISE_REQUIRED` are **historical provenance**; later approved Market `20261002T091800Z/market` and City `20261004T110406Z/city` runs supersede those concept-gate assessments, without replacing original file hashes.

City user `REJECT ALL` remains in force for head `1f799128d9efe33cfdcb8365119fc2eb2371166e`. `SCENE-STATUS.json#city` has `approved_concept_run` but `accepted_runtime_run=null`; later two SVG upper-building candidate sources have `UNREVIEWED` status and are unmounted. User accepted ARTIST Review Draft v0.2 on 2026-10-09 (G1–G25 and R1 D/R2 D/R3 D/R4 D/R5 B) but its requested real-3D construction conflicts with 2026-10-08 user-authorized City SVG-25D implementation. See [review/gate record](./R06-CITY-V1-ARTIST-REVIEW-V02.md). Neither architecture was chosen during documentary reconciliation; R06 visual execution is BLOCKED for human A/B/C architecture selection, no City runtime accept and R07+ locked.

## R06 architecture gate resolution — 2026-10-09

The user explicitly selected **B — Godot authored modular SVG 2.5D** for R06 and authorized documentary reconciliation only. This is an explicit City-only amendment to ARTIST Review v0.2's original real-3D construction requirement, preserving G1–G25 and R1 D/R2 D/R3 D/R4 D/R5 B. VIS-01 now evaluates independently authored architectural faces/roof silhouette, coherent apparent depth/occlusion and bounded 2-axis pan/parallax, **not** physical mesh orbit. Original global V1 style authority, approved City concept `20261004T110406Z/city`, old runtime `REJECT ALL`, R05 PASS and R07+ LOCKED are unchanged. Existing SVG candidate assets remain UNREVIEWED, not activated or accepted. R06 `WATCH / IMPLEMENTATION_PLAN_APPROVAL_PENDING`. See [updated review contract](./R06-CITY-V1-ARTIST-REVIEW-V02.md).

## 2026-10-09 — ARTIST two source-object approvals, not City acceptance

**Human:** "Aprovado como itens individuais, não como cena completa." Individually `OBJECT_ART_ACCEPTED`: `coral-terrace-house.svg` and `ochre-shop-terrace.svg`, each pinned to its source blob at commit `6e5dc5b7fac702ea7310f33d8a1565b945d02856`, with visually displayed source-SVG previews. Immutable preview record: [upper REVIEW.md](../../assets/city/v1/svg25d/source/upper/REVIEW.md); machine-readable source decision: `assets/city/v1/svg25d/source/upper/candidate-family.json`.

**Not accepted:** upper family composition; new sprite families; Godot import/pixel appearance; runtime City scene; ARTIST R5 B VIS-01..VIS-08; human R06 runtime ACCEPT; R06 PASS. `SCENE-STATUS.json#city` remains `CONCEPT_ACCEPTED / accepted_runtime_run=null`; user prior `REJECT_ALL` on the City renderer remains. Review-scope enforcement lives in `.agents/skills/artist/SKILL.md` and `tests/test_r06_svg25d_upper.py`.

## ARTIST COMP-01 — composition direction resolved (2026-10-09)

**Read [R06-CITY-V1-ARTIST-COMPOSITION-01.md](./R06-CITY-V1-ARTIST-COMPOSITION-01.md)** for the source-locked 940×1672 review coordinates, ratio-preserving Coral-left/Ochre-right stagger, unobstructed blue skyline, central staircase corridor, depth-layer order and `LIGHT-01=A` criteria. These are **design-only target boxes**, not a rendered combined composition or Godot implementation. Existing sprite `rect_hint` values are merely suggestions and would distort 480:620 source aspect if stretched directly against the reference portrait; preserve natural proportions. Both assets remain separately `OBJECT_ART_ACCEPTED`, while family, scene/runtime, import QA and VIS-01..VIS-08 remain unapproved. No production work/gates are unlocked.


## 2026-10-09 — ARTIST UPPER/03 concept only: water tank + terrace

Human explicitly **ACCEPTED** the recovered preview of the **isolated original PNG concept** for the UPPER/03 rooftop water tank and terrace. A prior **REJECT / PREVIEW_BROKEN** described a broken preview delivery, not a rejected art style; after re-delivery of the unchanged PNG the human responded **"Aprovado"**.

- Final decision: `CONCEPT_OBJECT_ACCEPTED` (PNG concept only), verified SHA-256 `3fe3552b76b652a8d792a303f423275af5e9a0e27c270326ae390282fd8e8c0b`.
- The original source PNG was generated and verified within the conversation, **not** committed as production art; exact provenance and preview-delivery history: [R06 City UPPER/03 concept review](./R06-CITY-UPPER-03-CONCEPT-REVIEW.md).
- Independently accepted original SVG sources remain exactly `coral-terrace-house.svg` and `ochre-shop-terrace.svg`. Their SVG import QA remains pending. **This approval does not make a third production SVG.**
- No upper-family composite or Godot/City runtime approval; old City `REJECT_ALL`, R05 `PASS`, R06 sole current and R07+ `LOCKED` unchanged. No manufacturing, compositor, merge or R06 `PASS` authorized.


## 2026-10-09 — ARTIST SKY/FAR/01 revised concept ACCEPT (isolated only)

The human requested **REVISE** of the first SKY/FAR/01 panorama and then explicitly said **"Aprovado"** after viewing the second, revised image. **Only that second image** is accepted as `CONCEPT_OBJECT_ACCEPTED` for the isolated SKY/FAR/01 design reference. Verified PNG RGB 1536×1024 / SHA-256 `5b3f279cf6c7288b12c52b97f027363263e0de083e8fb488c4cd73b3e5d50f1b`; generation ID `73f71498-b7c8-4482-9c30-42bd0f3100f0`. The bytes are attached to the originating ChatGPT conversation, **not** a production GitHub asset. Detailed provenance, scope and translation constraints: [SKY/FAR/01 concept review](./R06-CITY-SKY-FAR-01-CONCEPT-REVIEW.md).

Human approval **does not approve** a Godot runtime, the whole City scene, a skyline sprite family/composition, modified global art style, identified real landmarks or the use of this entire panorama as a wallpaper. V1 pixel-art/graffiti and fictional-city constraints continue to govern asset derivation. `R05 PASS`, `R06` only current item, previous City `REJECT_ALL`, `R06-B-01B` QA pending, PR #213 Draft, `R07+ LOCKED`; no sprite production, compositor activation or merge authorized.

## 2026-10-09 — ARTIST SKY/01 standalone sky concept ACCEPT

The user explicitly answered **"Aprovado"** to the directly displayed new isolated SKY/01 sky-and-cloud image (distinct from the earlier approved revised SKY/FAR/01 landscape). Decision: **`CONCEPT_OBJECT_ACCEPTED`** for SKY/01 PNG concept only, `1536×1024` RGB / 1,318,631 bytes / verified SHA-256 `c517229e33a960dd9600be926a1bf89fad567dc039237dfc3edabea98e95a798` / generation ID `781caf7e-2690-4257-87ff-39b301a6e054`. Exact provenance, preview-delivery evidence and immutable boundaries: [SKY/01 review](./R06-CITY-SKY-01-CONCEPT-REVIEW.md).

This isolated blue-sky/daylight pixel-art visual is **not** a committed PNG, production SVG, accepted assembled skyline, modified CITY reference, Godot rasterization proof or R06 runtime ACCEPT. Original bytes live in the conversation artifact and must be verified by SHA before downstream production. Next ARTIST concept-only queue item: `FAR/01` vegetated fictional distant hills. **No engineering gate unlock**: original City `REJECT_ALL`, R05 `PASS`, R06 sole CURRENT, `R06-B-01B` separately pending, PR #213 Draft and R07+ LOCKED remain.

## 2026-10-09 — ARTIST lean-production strategy approved (R06 scope only)

Human agreed to consolidate DA LATA V1 art around **one BG + 5–6 principal visual elements**, using background-integrated or reusable generic decoration instead of 23+ granular production reviews. **Fully 2D Godot is acceptable if near/mid/far depth is readable**; 2.5D/parallax is optional. The [R06-CITY-LEAN-ART-BUDGET.md](./R06-CITY-LEAN-ART-BUDGET.md) is the binding production inventory for *planning*; the older SVG handoff is retained as historical decomposition wherever conflicting. Previous separately approved `coral-terrace-house.svg`, `ochre-shop-terrace.svg`, UPPER/03, SKY/FAR/01 revised concept, SKY/01 concept and accepted City run retain their exact individual scopes and hashes. No new individual source/review, import, combined-scene review or runtime gate has been passed by this decision. Prior City `REJECT_ALL`, R05 PASS, R06 CURRENT and R07+ LOCKED persist.

## 2026-10-10 — ARTIST STAIR/01 approved image concept (not production import)

The human explicitly responded **"Aprovado"** after the second, stairway-focused visual preview (despite ARTIST's earlier `REVISE_REQUIRED` comment about extraneous surrounding buildings). The *visual composition* is therefore **`CONCEPT_OBJECT_ACCEPTED`** for STAIR/01 only. Exact original image: `a_vibrant_detailed_stylized_pixel_art_painted.png`, 1536×1024 RGBA PNG, 2,968,926 bytes, SHA-256 `9b49257b41ad7f0c9add6cea8b99e60521036a3561cf9e92c41fdf0a776760df`, generation ID `7b8daa4c-ad07-4cbd-a49f-be681531eb66`. Source is a **conversation artifact not committed production art**. Details and scope: [R06-CITY-STAIR-01-CONCEPT-REVIEW.md](./R06-CITY-STAIR-01-CONCEPT-REVIEW.md). Existing background and side buildings embedded in that preview must be separated or reconciled during **later** production QA, without forcing another concept variant or accepting the composed City. Approved references/SVG objects remain unchanged, R06 City runtime remains `REJECT_ALL`, R05 PASS and R07+ LOCKED.
