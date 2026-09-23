# Implementation Plan: Act V Final Form Eligibility

**Feature:** 007-act-v-final-form-eligibility  
**Spec:** [spec.md](./spec.md)

## Technical Context

- Engine: Godot 4.7.2
- Language: GDScript
- Narrative content: `NarrativeEventDefinition` Resources
- Narrative domain: `domain/events/narrative_event_service.gd`
- Eligibility domain: new `domain/ending/ending_eligibility_service.gd`
- Orchestration/catalog: `autoload/game_state.gd`
- Persistence: save schema v10; eligibility remains derived
- Canon:
  - `docs/lore/ACT-V-NARRATIVE-EVENT-LIBRARY.md`
  - `docs/lore/ACT-V-DIALOGUE-BEAT-SHEETS.md`
  - `docs/lore/CAMPAIGN.md`
- Validation: `tools/validate_project.py` + headless Godot regressions + exact-head CI

## Constitution Check

- Repository reality first: PASS — feature branch starts from validated `master@b615eb367fdd12d8341644fee9b37b5df99b1afb`.
- Spec-first: PASS — this plan follows the bounded feature contract.
- UI/domain separation: PASS by design — ending eligibility lives in a domain service.
- Determinism: REQUIRED — service and narrative event consume no RNG.
- Persistence discipline: PASS expected — no schema bump.
- Canon/safety: REQUIRED — no ranking, no true ending, no real political persuasion.
- Small coherent wave: PASS — debate event + minimum derived eligibility boundary only.
- Exact-head evidence: REQUIRED before merge.

## Design

### 1. Materialize `event_forma_da_lata`

Add `resources/events/forma_da_lata.tres` with four canonical interventions:

- fragmentary-origin clause;
- reciprocity clause;
- execution clause;
- no-single-narrative-owner clause.

Every route sets `lore_final_form_debate_seen` and one choice flag. No route stores an ending ID.

### 2. Add a neutral eligibility service

Create `EndingEligibilityService` with named maturity constants and one primary function:

`eligible_ending_ids(snapshot: Dictionary) -> PackedStringArray`

The snapshot is assembled by GameState from canonical state. The service is pure, deterministic and non-persistent.

The service returns a stable list of IDs only. Stable order is an API/serialization convenience, not a ranking.

### 3. Minimum maturity vectors

Use intentionally small, explicit floors that express readiness rather than preference:

- minimum Cash: 250;
- minimum Reputation: 5.0;
- minimum Influence: 1.0;
- minimum average Community: 50.0;
- market participation: buyer relationship > 0.

Ending-family predicates:

- Marca Nacional: Cash + Reputation + licensed relationship.
- Rede Viva: average Community + Reputation.
- Noite Sem Rótulo: parallel relationship + prior distributed/autonomy signal.
- Arquivo Público: completed material-compatibility research + uncertainty/provenance-preserving signal.
- Atlântico: Cash + Influence + prior central-coordination/execution signal.
- O Verão Volta: completed research + Community + Reputation + Influence + both market relationships.

No predicate uses a final-form choice as its sole condition.

### 4. GameState boundary

GameState will:

- preload/register the final-form event;
- own an `EndingEligibilityService` instance;
- expose `eligible_ending_ids()`;
- construct the service snapshot from current canonical state.

No UI-specific rules are added.

### 5. Regression coverage

Add `tests/act_v_final_form_eligibility_test.gd` to prove:

- natural unlock from the feature-006 path;
- four-choice shared-flag contract;
- no arc completion / no ending persistence;
- each ending family has a reachable maturity vector;
- composite ending fails when either market side or a maturity dimension is missing;
- RNG remains unchanged;
- schema-v10 restore recomputes the same eligibility set.

Update feature-006/campaign catalog expectations to account for the new event.

### 6. Structural/docs convergence

Update:

- `.github/workflows/validate.yml`;
- `tools/validate_project.py`;
- `docs/ARCHITECTURE.md`;
- `docs/SIGA-HANDOFF.md` only after live PR/CI reconciliation.

## Expected Files

- `specs/007-act-v-final-form-eligibility/*`
- `resources/events/forma_da_lata.tres`
- `domain/ending/ending_eligibility_service.gd`
- `autoload/game_state.gd`
- `tests/act_v_final_form_eligibility_test.gd`
- `tests/act_v_reconstruction_opening_test.gd`
- `tests/campaign_state_test.gd`
- `.github/workflows/validate.yml`
- `tools/validate_project.py`
- `docs/ARCHITECTURE.md`
- `docs/SIGA-HANDOFF.md`

## Validation Strategy

1. Structural validator.
2. Godot import smoke.
3. Existing deterministic simulation/domain regressions.
4. Existing campaign/research/Ato IV/Ato V opening regressions.
5. New final-form eligibility regression.
6. Save-v10 regression.
7. Open-PR overlap scan and latest-master reconciliation.
8. Exact current PR-head CI and Vercel.
9. Guarded merge using the exact current PR head.
10. Post-merge default-head validation and final handoff persistence.
