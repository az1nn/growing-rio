# Feature Specification: Act V Reconstruction Opening

**Feature:** 006-act-v-reconstruction-opening  
**Status:** Merged — final handoff gate pending  
**Roadmap:** V0.5 campaign / finale reconstruction path  
**Created:** 2026-09-23

## Overview

Materialize the first bounded playable slice of Ato V after feature 005: the player converts the completed evidence review into an explicitly contemporary reconstruction, maps the seven city forces and then canonically adopts the name **DA LATA**.

This feature stops at the naming scene. It does **not** implement ending selection, the final institutional-form debate, the final handoff/coda, or completion of `arc_da_lata`.

## User Scenarios

### Scenario 1 — Ato V opens only after the evidence review

**Given** `arc_o_sistema` is complete  
**And** `event_foto_estrela` is complete  
**And** `research_material_compatibility_reviewed = true`  
**When** narrative availability is queried  
**Then** `event_reconstrucao_sem_original` becomes available  
**And** the scene states that reconstruction is contemporary and that continuous historical/genetic lineage remains unproven.

### Scenario 2 — Reconstruction framing preserves route plurality

**Given** the reconstruction-opening event is available  
**When** the player chooses any canonical framing option  
**Then** `lore_act_v_reconstruction_framed = true` is persisted  
**And** exactly one corresponding `choice_reconstruction_*` posture flag is persisted  
**And** no choice authenticates an original lineage, Caderno authorship, Fita chronology, symbol order or common origin.

### Scenario 3 — Seven city contributions become playable without a moral winner

**Given** `lore_act_v_reconstruction_framed = true`  
**When** narrative availability is queried  
**Then** `event_sete_partes_da_cidade` becomes available  
**And** any choice records `lore_act_v_city_contributions_mapped = true`  
**And** no faction is encoded as the uniquely correct owner, market or institutional form.

### Scenario 4 — The project is named DA LATA in the present

**Given** city contributions are mapped  
**When** the player resolves `event_nome_da_lata` through any canonical tone  
**Then** `lore_da_lata_name_canonical = true` is persisted  
**And** the event establishes the present-day project name only  
**And** Dalva does not authenticate a historical name, artifact, origin or lineage.

### Scenario 5 — Opening state is deterministic and persistent

**Given** any valid route through the three events  
**When** the state is saved and restored under schema v10  
**Then** completed events and narrative flags restore exactly  
**And** completed events do not replay  
**And** simulation RNG is unchanged by narrative resolution.

## Functional Requirements

- **FR-001** The feature MUST preserve the existing `NarrativeEventDefinition -> NarrativeEventService -> GameState -> Main` boundary.
- **FR-002** The three Ato V events MUST be Resource-backed and registered in the GameState narrative catalog.
- **FR-003** `event_reconstrucao_sem_original` MUST require `arc_o_sistema`, completed Estrela evidence and `research_material_compatibility_reviewed`.
- **FR-004** Every reconstruction-opening choice MUST set `lore_act_v_reconstruction_framed` plus exactly one documented choice flag.
- **FR-005** `event_sete_partes_da_cidade` MUST require `lore_act_v_reconstruction_framed`.
- **FR-006** Every city-contribution choice MUST set `lore_act_v_city_contributions_mapped` plus exactly one documented choice flag.
- **FR-007** `event_nome_da_lata` MUST require `lore_act_v_city_contributions_mapped`.
- **FR-008** Every naming choice MUST set `lore_da_lata_name_canonical` plus exactly one documented choice flag.
- **FR-009** The naming event MUST establish DA LATA as a present collective decision and MUST NOT authenticate the 1987 history or Dalva's can.
- **FR-010** The feature MUST preserve `lore_original_lineage_still_unproven = true` and all protected provenance/order/authorship uncertainty.
- **FR-011** No choice MAY label a faction, market structure, institutional form or future ending morally correct.
- **FR-012** Institutional content MUST remain fictional/systemic; no real politicians, parties, elections, voter targeting or persuasion are modeled.
- **FR-013** Parallel-market references MUST remain abstract and non-operational.
- **FR-014** Narrative resolution MUST consume no simulation RNG.
- **FR-015** Save schema v10 MUST be reused; no new persistent shape is introduced.
- **FR-016** Unknown event/flag validation MUST remain strict through the expanded catalogs.
- **FR-017** `arc_da_lata` MUST remain incomplete after this feature.
- **FR-018** `event_forma_da_lata`, `event_da_lata_handoff`, ending eligibility and codas are out of scope for feature 006.
- **FR-019** Tests MUST prove the three-event sequence follows the completed feature-005 path and survives save/restore.
- **FR-020** Full repository validation MUST pass on the exact current PR head before merge.
- **FR-021** Web export/deployment configuration MUST remain intact; generated `web/` artifacts are not hand-edited.
- **FR-022** Concurrent lore PR #42 is treated as disjoint unless it changes Ato V source contracts or a file touched by this feature; any such drift MUST be reconciled before merge.

## Success Criteria

- **SC-001** Completing the fifth research step naturally unlocks `event_reconstrucao_sem_original`.
- **SC-002** The player can resolve the three-event Ato V opening in canonical order.
- **SC-003** All nine route choices across the three events preserve protected uncertainty.
- **SC-004** `lore_da_lata_name_canonical` is reachable without ending selection or manual flag injection.
- **SC-005** Narrative resolution is RNG-stable.
- **SC-006** Schema-v10 round-trip preserves the completed Ato V opening exactly.
- **SC-007** Existing Ato I–IV/research regressions remain green.
- **SC-008** Repository validation is green on the exact final PR head.

## Out of Scope

- `event_forma_da_lata`.
- `event_da_lata_handoff`.
- Ending-family eligibility, ranking, selection or codas.
- Completion of `arc_da_lata`.
- New economic, policy, market, community or cultivation mechanics.
- New historical claims, lineage authentication or resolution of protected ambiguity.
