# SIGA HANDOFF — DA LATA

## Verified repository
- Current repository: `az1nn/growing-rio`
- Default branch: `master`
- Narrative-presentation PR: **#23 — MERGED**
- Validated PR head: `299c9a6fc12f436390c25e302b5104d5b880623d`
- Exact final PR validation: **Validate project run #108 / 35858967468 — SUCCESS**
- Merge commit: `50659ad33add1a25f7a14376e526ae319c3624f5`
- Active technical PR: **none**
- Repository has no verified `export_presets.cfg`; Web delivery is not yet an acceptance gate.
- Live repository/PR/CI state always overrides the SHAs and run references recorded here.

## Decision
**ADVANCE**

The first V0.5 narrative presentation slice is merged. The next coherent technical milestone is to connect canonical Ato I -> Ato II progression to normal gameplay so the first narrative event unlocks without seeded test state.

## Completed V0.5 slice — narrative presentation
- Extended `NarrativeEventDefinition` with Resource-backed presentation fields:
  - `display_title`;
  - `body_text`;
  - `choice_labels`.
- Materialized presentation content for `event_dalva_lucia_primeiro_depoimento` without moving canon or consequence rules into scenes.
- Added a narrative panel to the Main scene.
- Main UI now:
  - queries `GameState.available_narrative_event_ids()`;
  - renders title/body/choices from the event Resource;
  - submits choices only through `GameState.resolve_narrative_choice(event_id, choice_id)`;
  - renders returned semantic signals and persisted narrative state.
- Preserved `lore_dalva_lucia_symbol_order_disputed` as unresolved.
- Added `tests/narrative_presentation_test.gd` covering UI -> GameState -> persistent campaign state.
- Added that regression to GitHub Actions.
- Adjusted Main-scene GameState lookup to `/root/GameState` so the UI can be exercised in isolated headless tests without duplicating domain state.
- Updated architecture documentation for the presentation boundary.

## Validation
Final PR head `299c9a6f...` passed the complete PR merge-ref workflow in **run #108 / 35858967468**:
- structural validation;
- Godot 4.7.2 headless import;
- deterministic simulation;
- economy/business/rooms/staff/contracts/compliance regressions;
- fictional district/policy/community regressions;
- Narrative Event Service regression;
- Campaign State integration regression;
- **Narrative Presentation regression**;
- save schema v10 round-trip and v1-v9 migration regression.

Earlier PR runs exposed and then eliminated two test-harness issues:
- standalone `--script` compilation could not resolve the autoload singleton symbol directly;
- the dynamic availability result required an explicit Array type at the UI boundary.

No domain, canon or persistence rule was weakened to make the test pass.

## Canonical state boundary
- Narrative truth remains owned by Resources + `NarrativeEventService` + `GameState`, not scenes.
- `GameState` owns persisted completion/flag state.
- Scenes only query availability, issue commands and render results.
- The first materialized event remains `event_dalva_lucia_primeiro_depoimento`.
- Narrative-event resolution remains deterministic and RNG-free.
- Save schema remains **v10**.

## Roadmap status
- V0.4 remains complete.
- V0.5 Campaign remains in progress.
- The first narrative event now has a playable presentation surface.
- The roadmap item “Narrative events and historical/cultural references” remains **incomplete** because normal campaign play does not yet produce the canonical Ato I completion + prerequisite flags needed to unlock the event naturally.
- Research-chain and finale items remain future V0.5 work.

## Active gate
- **None for the completed presentation slice.**
- PR #23 is merged.
- Final PR validation is green.
- Subsequent SIGA runs must reconcile live `master`, open PRs and CI before advancing.

## Next action
Implement the smallest V0.5 **campaign progression / natural unlock** slice.

1. Identify the canonical existing gameplay milestone that should complete `arc_o_quarto`.
2. Emit the prerequisite narrative facts through domain/GameState progression rather than UI shortcuts:
   - `contact_char_dalva`;
   - `introduced_char_lucia`;
   - `memory_onda_can_received`.
3. Make the first narrative event become available through ordinary play without seeded test state.
4. Keep progression deterministic and save-persistent through the existing v10 campaign snapshot.
5. Add an end-to-end regression that reaches the event through gameplay transitions instead of directly seeding narrative state.
6. Do not introduce a morally privileged formal/parallel route; either channel must remain compatible with central campaign progression.
7. Only after natural unlock is validated should SIGA consider marking the roadmap narrative-event item complete and move into the DA LATA research chain.

## Web delivery
- No verified browser export configuration or stable playable URL is currently present.
- Web delivery remains future work and is not a gate for this slice.
- Future SIGA runs must rediscover `export_presets.cfg`, deployment workflow and playable URL from repository state.

## Boundaries
- Cultivation remains abstract; no real recipes, dosages, climate targets or yield optimization.
- Parallel-market activity remains abstract risk/reward; no trafficking routes, sourcing, concealment, logistics or evasion.
- Districts, institutions, proposals, community state and political actors remain fictionalized.
- No real politicians, parties, elections or targeted political persuasion.
- Real-history inspiration remains distinct from fictional canon.
- Chat/model memory is not canonical project state; repository state and this repo-local handoff govern continuation.
