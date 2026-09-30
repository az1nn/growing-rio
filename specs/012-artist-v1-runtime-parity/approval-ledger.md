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
| operation | `3ae82a5638e60666de27b7d8deec37cadda2e86e031d88b0dda72658171036ce` | `SCENE_CANDIDATE` | pending | pending | pending |
| market | `c7d9390f9cba7db434997ca5102841df09a30e95333811b3c297217c2c998075` | `SCENE_CANDIDATE` | pending | pending | pending |
| city | `0c86c37b4bb90795a7ff72a7f226141c38a21085edcb52a6275d21e3290956d2` | `SCENE_CANDIDATE` | pending | pending | pending |
| institutional | `a85019b353c1e0285a23a5290824d4cdabc84e36695651aadba855055485fecc` | `SCENE_CANDIDATE` | pending | pending | pending |
| archive | `37b9c7193f432efcd48d17c0bdce760ad10e0c87445b7e6ce343428ff3f6879b` | `SCENE_CANDIDATE` | pending | pending | pending |
| campaign | `28ed857a076dd3c8d6b04d6fdd207b67c442f54f8679890193a13e4f7a7d3746` | `SCENE_CANDIDATE` | pending | pending | pending |
| narrative | `4de8a9c32b1c47b292ddae961d493e9aa9f1a9e52017c4eaed012d7d83cabd05` | `SCENE_CANDIDATE` | pending | pending | pending |
| finale-selection | `d8a5bea9c0c0599186af92cb2f15a7d95e37814d5ecefd5b0e9423a4baad53de` | `SCENE_CANDIDATE` | pending | pending | pending |
| finale-handoff | `34c5a3e252323066b6afc1a929398008aed3b59ccba6440eaa38bb7482bceb0e` | `SCENE_CANDIDATE` | pending | pending | pending |
| finale-coda | `1bc566829ff1a65abb1f9d799cce91fa8e40e383676313cf7c5647b9c096bb1a` | `SCENE_CANDIDATE` | pending | pending | pending |
| finale-recap | `8bfd2dbdad22061deade4c2bd5539d851422cd078cac89fd0f1bc97e00dad172` | `SCENE_CANDIDATE` | pending | pending | pending |

## Gate rule

For each row, the only valid forward sequence is:

`SCENE_CANDIDATE -> BOARD_CONFORMANCE_AUDITED -> SCENE_CONCEPT_ACCEPTED -> 3D_IMPLEMENTED -> RUNTIME_ACCEPTED`

A `SCENE_CONCEPT_REVISE` decision starts a new immutable ARTIST round and replaces the candidate SHA only after the new artifact is generated and reviewed.

## Current handoff

T005 is complete: PR #190 is merged into `master` and all 11 candidate SHA-256 values are locked above.  
T006 is complete: approval states now distinguish global board approval, candidate provenance, concept acceptance and runtime acceptance.  
Next: T007, the 11-scene board↔candidate conformance audit, beginning with Operation.
