# Implementation Plan: Act IV Evidence Campaign Bridge

**Feature:** 005-act-iv-evidence-campaign-bridge  
**Spec:** [spec.md](./spec.md)

## Technical Context

- Engine: Godot 4.7.2
- Language: GDScript
- Narrative content: `NarrativeEventDefinition` Resources
- Narrative domain: `domain/events/narrative_event_service.gd`
- Canonical orchestration: `autoload/game_state.gd`
- Presentation: `scenes/main/main.gd`
- Persistence: save schema v10 campaign arrays/flags
- Canon sources:
  - `docs/lore/CAMPAIGN.md`
  - `docs/lore/NARRATIVE-EVENT-LIBRARY.md`
  - `docs/lore/ACT-III-NARRATIVE-EVENT-LIBRARY.md`
  - `docs/lore/ACT-IV-NARRATIVE-EVENT-LIBRARY.md`
  - corresponding dialogue beat sheets
- Validation: `tools/validate_project.py` + Godot headless regressions

## Constitution Check

- Repository reality first: PASS — feature starts from validated `master@6e41652d66a1d7c23b645960f1750f403fe3c74b`.
- Spec-first: PASS — no runtime mutation before these artifacts.
- UI/domain separation: REQUIRED — Main must stop assuming one hardcoded narrative event.
- Determinism: REQUIRED — progression/events consume no RNG.
- Persistence discipline: EXPECTED PASS — reuse v10 completed arcs/events/flags.
- Canon/safety: REQUIRED — no new historical claims, real politics or operational illicit/cultivation detail.
- Small coherent wave: the feature implements the **minimum playable spine** needed to close the existing research-chain gap; optional events stay out of scope.
- Exact-head evidence: REQUIRED before merge.
- Concurrency: PR #38 is currently lore-only and disjoint, but any mutation to source canon documents requires reclassification.

## Design

### 1. Generalize narrative presentation before adding events

Current `Main._refresh_narrative()` preloads and renders only `FIRST_NARRATIVE_EVENT`. Replace that one-event assumption with a read-only GameState presentation boundary analogous to research presentation:

- `narrative_event_presentation(event_id) -> Dictionary`
- presentation returns only display-safe Resource metadata;
- Main chooses the first currently available canonical event ID and renders its returned title/body/choices;
- Main submits the selected stable IDs through `resolve_narrative_choice()`;
- Main owns no availability, arc transition or consequence rule.

This is required before the catalog grows.

### 2. Canonical bridge beats

Use Resource-backed narrative events for two already-documented non-branching campaign closing beats. They are implementation wrappers around existing canon, not new lore.

#### Ato II close
Stable technical event ID: `event_act_ii_sol_photo_reveal`.

Availability:
- `event_dalva_lucia_primeiro_depoimento` completed;
- `research_evidence_boundaries_synthesized` true;
- Sol not already revealed.

Resolution:
- one neutral continue/record action;
- persists `lore_sol_mark_revealed`;
- GameState marks `arc_o_negocio` complete;
- does not assert provenance, order or common origin.

#### Ato III close
Stable technical event ID: `event_act_iii_council_invitation`.

Availability:
- `event_bento_fita_farol` completed;
- `campaign_business_scale_reached` true;
- invitation not already received.

Resolution:
- one neutral acknowledgement action;
- persists `lore_council_invitation_received`;
- GameState marks `arc_dois_mercados` complete;
- no economic route is required.

### 3. Derived playable progression facts

Keep service eligibility flag-based and derive two persistent campaign facts from existing gameplay rather than teaching UI or Resources to inspect arbitrary runtime state.

#### `campaign_business_scale_reached`
Becomes true on the **second successful completed sale** through either existing licensed or parallel sale path. The first successful sale already closes Ato I; using the next completed sale as the abstract scale milestone keeps the gate reachable from the current player-facing controls and route-neutral.

No new sale counter is introduced: GameState can distinguish the first-sale transition from any later successful sale using the already-persisted `arc_o_quarto` completion plus this monotonic flag. The fact is persisted in `campaign.narrative_flags`.

#### `campaign_council_participation_ready`
Becomes true once the player has earned at least 4 Influence at any point through existing abstract institutional gameplay. The threshold matches one existing player-facing `civic_engagement()` gain and is a game progression gate, not a real political model.

The fact is monotonic once achieved. Update after Influence-producing actions and preserve it through schema-v10 narrative flags.

Both IDs are campaign/gameplay facts, not historical assertions.

### 4. Ato III spine event

Materialize `event_bento_fita_farol` from the canonical Ato III library.

Availability:
- `arc_o_negocio` completed;
- `lore_sol_mark_revealed` true;
- existing Onda evidence remains present.

All choices must preserve:
- `lore_farol_tape_four_marks_heard`;
- `lore_farol_tape_date_unverified`;
- no proof that the tape predates the Caderno;
- unidentified voice;
- no operational cultivation content.

### 5. Ato IV core Resource chain

Materialize, in canonical order:

1. `event_isa_mesa_sem_palco`
2. `event_leilao_ferrugem`
3. `event_ferrugem_quem_assina_memoria`
4. `event_audiencia_periodo_verde`
5. `event_foto_estrela`

Each Resource uses the stable choice IDs, shared observation flags, relationship semantics, system signals and guardrails already documented in the Ato IV event library/beat sheets.

Chaining:
- first event unlocks after `arc_dois_mercados` + `lore_council_invitation_received`;
- each subsequent event requires the shared observation flag established by its predecessor;
- Audience additionally requires `campaign_council_participation_ready`;
- `event_foto_estrela` requires the Audience flag, Ferrugem evidence state, preserved tape evidence and Onda campaign evidence.

All valid choices in `event_foto_estrela` set:
- `lore_material_origin_compatibility_established`;
- `lore_star_mark_revealed`;
- `lore_original_lineage_still_unproven`.

GameState may mark `arc_o_sistema` complete when this event resolves. No Ato V content is added.

### 6. Arc transitions remain orchestration, not Resource side effects

NarrativeEventService stays pure and caller-state independent. GameState applies a small explicit event-to-arc completion mapping after successful resolution:

- `event_act_ii_sol_photo_reveal -> arc_o_negocio`;
- `event_act_iii_council_invitation -> arc_dois_mercados`;
- `event_foto_estrela -> arc_o_sistema`.

This avoids adding mutable arc behavior to Resources and keeps transitions testable.

### 7. Persistence

No schema-shape change is expected:
- event IDs persist in `campaign.completed_event_ids`;
- arc IDs persist in `campaign.completed_arc_ids`;
- derived/gameplay/lore facts persist in `campaign.narrative_flags`.

The known-ID/known-flag catalogs must include all additions so v10 validation remains strict.

### 8. End-to-end acceptance regression

Add a new `tests/act_iv_evidence_bridge_test.gd` that proves a natural path:

1. use ordinary cultivation/sale to close Ato I;
2. resolve the first canonical Ato II event;
3. complete early research through step four;
4. resolve the Sol-photo bridge;
5. complete a second successful sale through either normal player-facing market route to establish abstract business scale;
6. resolve Fita do Farol;
7. resolve Conselho invitation;
8. earn council-participation readiness through normal institutional action;
9. resolve all five Ato IV events;
10. assert the fifth research step appears;
11. complete it;
12. assert RNG stability and protected uncertainties;
13. save/restore and verify exact campaign continuation.

The test MUST NOT use `set_narrative_flag()` or `complete_narrative_arc()` to fabricate progression.

Existing narrative/campaign/research tests are updated for the larger catalog.

### 9. Structural validation and docs

Update:
- `tools/validate_project.py` for feature 005 artifacts, new Resources, generalized narrative presentation and end-to-end test;
- `docs/ARCHITECTURE.md` with the campaign spine and event-to-arc orchestration;
- `docs/ROADMAP.md` only after end-to-end evidence proves the V0.5 research chain is naturally reachable and completed;
- `docs/SIGA-HANDOFF.md` from live final PR/CI facts.

## Expected Files

- `specs/005-act-iv-evidence-campaign-bridge/spec.md`
- `specs/005-act-iv-evidence-campaign-bridge/plan.md`
- `specs/005-act-iv-evidence-campaign-bridge/tasks.md`
- `specs/005-act-iv-evidence-campaign-bridge/checklists/requirements.md`
- `resources/events/act_ii_sol_photo_reveal.tres`
- `resources/events/bento_fita_farol.tres`
- `resources/events/act_iii_council_invitation.tres`
- `resources/events/isa_mesa_sem_palco.tres`
- `resources/events/leilao_ferrugem.tres`
- `resources/events/ferrugem_quem_assina_memoria.tres`
- `resources/events/audiencia_periodo_verde.tres`
- `resources/events/foto_estrela.tres`
- `autoload/game_state.gd`
- `scenes/main/main.gd`
- `tests/narrative_event_service_test.gd`
- `tests/campaign_state_test.gd`
- `tests/campaign_progression_test.gd`
- `tests/research_chain_test.gd`
- `tests/research_presentation_test.gd`
- `tests/act_iv_evidence_bridge_test.gd`
- `tools/validate_project.py`
- `docs/ARCHITECTURE.md`
- `docs/ROADMAP.md`
- `docs/SIGA-HANDOFF.md`

## Validation Strategy

1. Structural validator.
2. Narrative-event service regressions.
3. Campaign state/save-v10 regressions.
4. Existing ordinary-play campaign progression regression for both market routes.
5. Research-chain and research-presentation regressions.
6. New natural Ato II -> Ato IV -> fifth-research end-to-end regression.
7. Full GitHub Actions `Validate project` on exact PR head.
8. Reconcile current `master` and open PR overlap before merge.
9. Guarded merge using exact current PR head.
10. Post-merge/final-head validation per repository policy.
