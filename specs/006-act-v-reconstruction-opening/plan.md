# Implementation Plan: Act V Reconstruction Opening

**Feature:** 006-act-v-reconstruction-opening  
**Spec:** [spec.md](./spec.md)

## Technical Context

- Engine: Godot 4.7.2
- Language: GDScript
- Narrative content: `NarrativeEventDefinition` Resources
- Domain: `domain/events/narrative_event_service.gd`
- Orchestration/catalog: `autoload/game_state.gd`
- Presentation: existing generic narrative renderer in `scenes/main/main.gd`
- Persistence: save schema v10 campaign arrays/flags
- Canon sources:
  - `docs/lore/ACT-V-NARRATIVE-EVENT-LIBRARY.md`
  - `docs/lore/ACT-V-DIALOGUE-BEAT-SHEETS.md`
  - `docs/lore/CAMPAIGN.md`
- Validation: `tools/validate_project.py` + headless Godot regressions

## Constitution Check

- Repository reality first: PASS — branch created from validated `master@e96e72a6d93e13ec56e9c315607a00d269aba292`.
- Spec-first: PASS — runtime mutation follows this feature contract.
- UI/domain separation: PASS by design — existing generic renderer requires no scene rule changes.
- Determinism: REQUIRED — narrative resolution consumes no RNG.
- Persistence discipline: PASS expected — reuse v10 event IDs and narrative flags.
- Canon/safety: REQUIRED — reconstruction remains contemporary; protected uncertainty remains open.
- Small coherent wave: PASS — only the first three Ato V events, ending at canonical naming.
- Exact-head evidence: REQUIRED before merge.
- Concurrency: PR #42 is lore-only on the inspected state; re-scan before merge.

## Design

### 1. Materialize three canonical Resources

Add:
- `event_reconstrucao_sem_original`
- `event_sete_partes_da_cidade`
- `event_nome_da_lata`

Each Resource carries stable IDs, canonical choice IDs, shared observation flags, relationship effects, system signals, guardrails and presentation copy from the Ato V canon.

### 2. First-event gate

`event_reconstrucao_sem_original` uses:
- `unlock_after_arc_id = arc_o_sistema`;
- required `event_foto_estrela` consequences already present as flags;
- required `research_material_compatibility_reviewed`;
- required `lore_original_lineage_still_unproven`.

This makes the Ato V opening follow the completed evidence review rather than merely the Estrela reveal.

### 3. Sequential shared flags

- Reconstruction event -> `lore_act_v_reconstruction_framed`.
- Seven-parts event -> `lore_act_v_city_contributions_mapped`.
- Naming event -> `lore_da_lata_name_canonical`.

The existing narrative service already prevents replay through completed event IDs and persists choice flags via GameState.

### 4. No arc completion yet

Do not add any event-to-arc mapping for these three events.

`arc_da_lata` remains incomplete until a later feature implements the final-form debate and finale handoff.

### 5. Persistence and strict validation

No schema bump. New IDs become known through the expanded Resource catalog, so existing save validation accepts only the declared flags/events and continues rejecting unknown IDs.

### 6. Acceptance regression

Add `tests/act_v_reconstruction_opening_test.gd`.

The test will:
1. follow ordinary player-facing progression through the existing feature-005 path;
2. complete `research_material_compatibility_review`;
3. assert the reconstruction event unlocks;
4. resolve the three new events in order;
5. assert shared/choice flags and protected uncertainty;
6. assert `arc_da_lata` is still incomplete;
7. assert narrative RNG stability;
8. save/restore and verify no replay.

### 7. Structural/docs convergence

Update:
- `tools/validate_project.py` for feature 006 artifacts/resources/test;
- `docs/ARCHITECTURE.md` with the Ato V opening sequence;
- `docs/SIGA-HANDOFF.md` only after live PR/CI reconciliation.

Do not mark the V0.5 finale roadmap item complete in this feature.

## Expected Files

- `specs/006-act-v-reconstruction-opening/spec.md`
- `specs/006-act-v-reconstruction-opening/plan.md`
- `specs/006-act-v-reconstruction-opening/tasks.md`
- `specs/006-act-v-reconstruction-opening/checklists/requirements.md`
- `resources/events/reconstrucao_sem_original.tres`
- `resources/events/sete_partes_da_cidade.tres`
- `resources/events/nome_da_lata.tres`
- `autoload/game_state.gd`
- `tests/act_v_reconstruction_opening_test.gd`
- `tools/validate_project.py`
- `docs/ARCHITECTURE.md`
- `docs/SIGA-HANDOFF.md`

## Validation Strategy

1. Structural validator.
2. Narrative Resource/service validation.
3. Existing Ato I–IV campaign/research regressions.
4. New natural Ato V opening regression.
5. Save-v10 regressions.
6. Exact-head GitHub Actions validation.
7. Open-PR overlap re-scan and latest-master reconciliation.
8. Guarded merge using current PR head.
9. Post-merge/default-head validation.
