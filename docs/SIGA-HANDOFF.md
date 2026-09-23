# SIGA HANDOFF — DA LATA

## Verified repository
- Current repository: `az1nn/growing-rio`
- Default branch: `master`
- Reconciled master before this wave: `c8b1e14a004525ecd5466f111fbd5cae4df78ebc`
- Active technical PR: **#25 — OPEN**
- Branch: `feat/v0.5-natural-narrative-unlock`
- Web delivery: no verified `export_presets.cfg`; not an acceptance gate for this slice.
- Live repository/PR/CI state always overrides references recorded here.

## Decision
**WATCH**

The V0.5 natural campaign unlock slice has been implemented and dispatched in PR #25. Merge is blocked until the exact final PR head passes `Validate project`.

## Implemented slice — natural Ato I -> Ato II unlock
- Canonical Ato I closure is tied to the first successful completed sale after the ordinary cultivation/harvest loop.
- Both licensed and parallel abstract sales converge on the same campaign progression helper.
- Successful contract resolution uses the same progression path.
- The first completion of `arc_o_quarto` emits:
  - `contact_char_dalva`;
  - `introduced_char_lucia`;
  - `memory_onda_can_received`.
- The first narrative event can therefore become available without manually seeding arcs or flags.
- Progression remains deterministic and consumes no extra RNG.
- Campaign state remains persisted through existing save schema v10.
- No sales route is treated as morally privileged.

## Regression coverage
Added `tests/campaign_progression_test.gd`:
- starts from a reset GameState;
- reaches harvest through the ordinary deterministic cycle;
- verifies the event is still locked before the first sale;
- verifies licensed sale unlocks the canonical event;
- verifies parallel sale unlocks the same event;
- verifies all prerequisite facts and `arc_o_quarto`;
- verifies the naturally unlocked state survives save v10 round-trip.

The regression is wired into `.github/workflows/validate.yml` and required by `tools/validate_project.py`.

## Roadmap state
- V0.4 remains complete.
- V0.5 Campaign remains in progress.
- Narrative events and historical/cultural references are marked complete in the branch because the first implemented event now has core state, presentation and a natural gameplay unlock.
- Next roadmap item: **Research chain around the fictional DA LATA cultivar**.
- Finale remains future V0.5 work.

## Active gate
- PR #25 is open.
- Required gate: `Validate project` on the exact final PR head.
- Do not merge on a stale successful run.
- If the run fails, classify the next SIGA as **RESUME** and fix the failing gate.
- If the run is still active, remain **WATCH**.
- If the exact final head is green, merge and persist the merge commit; then classify the next slice as **ADVANCE**.

## Next action after green merge
Start the smallest coherent V0.5 **DA LATA research-chain** slice against the persisted campaign contract.

Constraints:
1. Keep research mechanics fictional and abstract.
2. Preserve established CÂNONE / RUMOR / ABERTO uncertainty.
3. Do not claim a continuous historical lineage to the real 1987 episode.
4. Keep cultivation non-instructional and parallel-market activity non-operational.
5. Keep institutions/politics fictional and systemic; no real politicians, parties, elections or targeted persuasion.
6. Continue data-driven Resource/service boundaries rather than putting rules in scenes.

## Boundaries
- Cultivation remains abstract; no real recipes, dosages, climate targets or yield optimization.
- Parallel-market activity remains abstract risk/reward; no trafficking routes, sourcing, concealment, logistics or evasion.
- Districts, institutions, proposals, community state and political actors remain fictionalized.
- No real politicians, parties, elections or targeted political persuasion.
- Real-history inspiration remains distinct from fictional canon.
- Chat/model memory is not canonical project state; repository state and this repo-local handoff govern continuation.
