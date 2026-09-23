# Feature Specification: Act IV Evidence Campaign Bridge

**Feature:** 005-act-iv-evidence-campaign-bridge  
**Status:** Ready for implementation  
**Roadmap:** V0.5 campaign / research chain  
**Created:** 2026-09-23

## Overview

Make the existing fifth DA LATA research step naturally reachable through playable campaign progression without test-only flag injection, while preserving the canonical chronology from the currently implemented Ato II research state through the end of Ato IV.

The feature implements a **minimal canonical campaign spine**, not the complete optional narrative-event libraries for Ato II and Ato III. It may materialize only the already-documented bridge beats and core events required to preserve chronological causality:

1. the existing Ato II first-deposition event and early four-step research dossier;
2. the already-canonical Ato II Sol-photo closing beat;
3. the canonical Ato III Fita do Farol discovery;
4. the already-canonical Ato III business-scale / Conselho invitation closing beat;
5. the five canonical Ato IV core events;
6. `event_foto_estrela`, whose choices all persist the three evidence flags required by `research_material_compatibility_review`.

No new historical fact may be invented to fill gaps. Bridge events may expose only facts already stated in `docs/lore/CAMPAIGN.md` or the canonical event libraries.

## User Scenarios

### Scenario 1 — Player reaches the Ato II closing beat through ordinary play

**Given** the player naturally unlocked and resolved `event_dalva_lucia_primeiro_depoimento`  
**And** completed the early research dossier through `research_evidence_boundary_synthesis`  
**When** campaign availability is queried  
**Then** the canonical Sol-photo closing beat becomes playable  
**And** resolving it records the Sol reveal and closes `arc_o_negocio` without claiming provenance or common origin for the marks.

### Scenario 2 — Ato III reaches the Conselho invitation without a “correct” economic route

**Given** `arc_o_negocio` is complete  
**And** Onda and Sol are already part of the campaign record  
**When** the player resolves the canonical Fita do Farol beat and reaches the defined abstract business-scale gate through ordinary business systems  
**Then** the Conselho invitation closing beat becomes available  
**And** resolving it closes `arc_dois_mercados`  
**And** no licensed/parallel route is morally privileged or required.

### Scenario 3 — Ato IV core events progress in canonical order

**Given** `arc_dois_mercados` is complete and the Conselho invitation was received  
**When** the player advances the Ato IV spine  
**Then** the runtime exposes, in order, the already-canonical core events:
- `event_isa_mesa_sem_palco`;
- `event_leilao_ferrugem`;
- `event_ferrugem_quem_assina_memoria`;
- `event_audiencia_periodo_verde`;
- `event_foto_estrela`.

**And** all eligibility remains owned by Resources/domain/GameState rather than scene-specific UI code.

### Scenario 4 — Estrela unlocks the deferred research review naturally

**Given** the player reaches `event_foto_estrela` through the playable spine  
**When** any canonical choice is resolved  
**Then** the campaign persists:
- `lore_material_origin_compatibility_established = true`;
- `lore_star_mark_revealed = true`;
- `lore_original_lineage_still_unproven = true`.

**And** `research_material_compatibility_review` becomes available through the existing research query  
**And** the player never needs `set_narrative_flag()` or `complete_narrative_arc()` as a progression shortcut.

### Scenario 5 — Protected uncertainty survives every route

**Given** any valid choices across the campaign spine  
**When** Ato IV closes  
**Then** exact Onda provenance remains unresolved  
**And** the historical order/common origin of Onda, Sol, Ferrugem and Estrela remains unresolved  
**And** continuous historical/genetic DA LATA lineage remains unauthenticated  
**And** no choice is labelled politically, economically or morally correct.

### Scenario 6 — Campaign spine survives save/restore

**Given** the player is at any point in the new spine  
**When** schema-v10 campaign state is saved and restored  
**Then** completed arcs, completed events and narrative flags restore exactly  
**And** completed events cannot replay  
**And** the next eligible event/research action remains deterministic.

## Functional Requirements

- **FR-001** The feature MUST preserve the current `NarrativeEventDefinition -> NarrativeEventService -> GameState -> Main` boundary.
- **FR-002** New playable narrative content MUST be Resource-backed and MUST NOT hardcode availability or consequences in the Main scene.
- **FR-003** The feature MUST materialize a minimal spine only; optional Ato II/Ato III events not needed for chronology remain out of scope.
- **FR-004** The Ato II closing bridge MUST represent only the existing campaign fact that an old photograph reveals Sol and MUST NOT authenticate the origin/order of the marks.
- **FR-005** Resolving the Ato II closing bridge MUST complete `arc_o_negocio` through GameState orchestration.
- **FR-006** The Ato III spine MUST include `event_bento_fita_farol` and preserve the tape's unverified date/voice and its non-proof relationship to the Caderno de Sal.
- **FR-007** The Ato III closing bridge MUST require an abstract business-scale fact derived deterministically from existing business state; it MUST NOT require one market route over another.
- **FR-008** Resolving the Ato III closing bridge MUST persist the Conselho invitation and complete `arc_dois_mercados`.
- **FR-009** The Ato IV runtime spine MUST include the five stable canonical event IDs from the Ato IV event library.
- **FR-010** Ato IV events MUST preserve the existing `CÂNONE | RUMOR | ABERTO` boundaries and event-specific guardrails.
- **FR-011** The Audience gate MUST represent sufficient fictional/systemic participation without modeling real politicians, parties, elections, demographic targeting or individual persuasion.
- **FR-012** All three `event_foto_estrela` choice families MUST persist the same three research prerequisite evidence flags and only their documented choice-specific posture flag.
- **FR-013** Resolving `event_foto_estrela` MAY close `arc_o_sistema`, but MUST NOT add Ato V events, endings or finale behavior.
- **FR-014** The fifth research step MUST become available naturally after `event_foto_estrela` when the existing early research prerequisites are satisfied.
- **FR-015** Tests MUST prove the full natural path without calling public test/setup helpers `set_narrative_flag()` or `complete_narrative_arc()` to fabricate progression.
- **FR-016** Narrative and campaign progression MUST consume no simulation RNG.
- **FR-017** Existing licensed and parallel abstract market routes MUST both remain capable of reaching the spine.
- **FR-018** Existing save schema v10 MUST remain the persistence shape unless implementation proves a new canonical field is unavoidable; a schema change requires a separate explicit spec amendment and migrations.
- **FR-019** Unknown event IDs, arc IDs and narrative flags MUST remain rejected by save/GameState validation.
- **FR-020** Full structural and Godot regression validation MUST pass on the exact final PR head before merge.
- **FR-021** Web export/deployment configuration MUST remain intact and the feature MUST NOT mutate generated `web/` artifacts by hand.
- **FR-022** The concurrent Lore PR #38 is semantically disjoint unless it changes one of the source canon documents used by this feature; any such drift MUST be reconciled before implementation/merge.

## Success Criteria

- **SC-001** A fresh deterministic run can progress from the currently implemented first narrative event through the Ato IV evidence gate using player-facing gameplay/actions only.
- **SC-002** No manual narrative-flag or arc-completion injection is needed in the end-to-end acceptance test.
- **SC-003** `event_foto_estrela` naturally unlocks `research_material_compatibility_review`.
- **SC-004** All valid routes preserve the protected provenance/order/lineage uncertainties.
- **SC-005** Both licensed and parallel abstract economic routes can reach the campaign spine.
- **SC-006** The new sequence is deterministic and leaves RNG state unchanged across narrative resolutions.
- **SC-007** Save v10 round-trip preserves a mid-spine state and the completed final evidence state.
- **SC-008** Existing narrative/research presentation renders new Resources without owning eligibility rules.
- **SC-009** Repository validation is green on the exact current PR head.
- **SC-010** The V0.5 research-chain roadmap item can be marked complete only after the natural end-to-end path and fifth research completion are both validated.

## Out of Scope

- Full materialization of every optional Ato II or Ato III event in the lore libraries.
- Ato V reconstruction events, ending selection, finale implementation or a “true ending”.
- Resolving exact Onda provenance.
- Proving a historical order or common origin for Onda, Sol, Ferrugem and Estrela.
- Authenticating a continuous historical/genetic DA LATA lineage.
- Real cultivation parameters, recipes, dosages, climate targets or yield optimization.
- Operational parallel-market sourcing, routes, concealment, logistics or evasion.
- Real politicians, parties, elections, voter targeting or political persuasion.
- Real legal/compliance advice.
