# LORE HANDOFF — DA LATA

## Verified repository
- Repository: `az1nn/growing-rio`
- Default branch: `master`
- Verified master HEAD before this wave: `fdeb622026adc9b2764ad830bf621ebb24d4c18f`
- Active lore branch: `docs/lore-event-library`
- Active lore PR: **#17 — OPEN**
- PR head at creation: `afea1ba1598f65e136215fac6fec08e4400d2972`
- Lore content commit: `72ac502aa1c00083b876719dd99bd3b698d0a973`
- Lore skill: `.agents/skills/lore/SKILL.md`

## Route
**LORE-WATCH**

The previous character-relationship wave was already complete on `master`. This invocation advanced the declared next action by materializing the six reserved Ato I/Ato II hooks into a narrative event library and opening PR #17.

The wave is now dispatched. No second lore initiative should begin until the exact PR head is validated and the PR is merged or requires correction.

## Completed this wave
- Added `docs/lore/NARRATIVE-EVENT-LIBRARY.md`.
- Converted all six reserved relationship hooks into narrative event specifications:
  - `event_dalva_lucia_primeiro_depoimento`;
  - `event_maya_joana_porta_estreita`;
  - `event_rui_cedro_contexto`;
  - `event_nando_procedencia_insuficiente`;
  - `event_rui_lucia_quatro_marcas`;
  - `event_dalva_rui_entrevista_que_nao_foi`.
- Defined for each event:
  - narrative window;
  - preconditions;
  - participants;
  - dramatic beat;
  - player-facing choices;
  - lore flags;
  - relationship consequences;
  - abstract system signals;
  - continuity invariants.
- Added stable narrative flags and explicit `choice_*` semantics.
- Added a suggested Ato II ordering without making the events hard-linear.
- Added an implementation-facing `NarrativeEvent` data contract as a non-binding lore specification.
- Indexed the new library from `docs/lore/README.md`.
- Opened PR #17.

## Canon delta

### Added
- The six reserved hooks now have canonical event shapes suitable for future campaign implementation.
- Player decisions can alter relationships, memory framing, research posture, Community/Reputation/Legitimacy/Risk signals and narrative emphasis without authenticating disputed history.
- The expression “porta estreita” is now the organizing motif for the Maya/Joana supplier-access event.
- The Dalva/Lúcia symbol-order contradiction becomes an explicit playable archive decision.
- The Rui/Joana Cedro dispute becomes an explicit “context is not control” editorial event.
- Nando's uncertain Caderno lead can be catalogued, circulated or held without becoming proof.
- Rui/Lúcia priority over the four-mark pattern remains playable but unresolved.
- The “interview that never happened” now has a playable dual-record structure without producing a complete recording.

### Revised
- No prior canon fact was intentionally replaced.
- `docs/lore/README.md` now indexes the event library.
- The six hook IDs are no longer concepts only; they are narrative specifications, but still not implemented game Resources.

### Preserved open
- Authorship and composition history of the Caderno de Sal.
- Order and common origin of Onda, Sol, Ferrugem and Estrela.
- Provenance/date of Dalva's Onda-marked can.
- Supernatural status and stable identity of the Mulher da Lata.
- Continuous historical lineage between the real 1987 episode and the fictional DA LATA reconstruction.
- Rui's claim that Nando saw a Caderno page before `T0` remains **RUMOR**.
- Dalva/Lúcia disagreement about the first symbol mentioned remains **ABERTO**.
- Rui/Lúcia disagreement about who first noticed the four-mark pattern remains **ABERTO**.

## Continuity checks
- Characters: **CONSISTENT** — desires, fears, methods and tensions are preserved.
- Factions: **CONSISTENT** — events humanize existing tensions without creating fixed alliances.
- Districts: **CONSISTENT** — Cedro/Orla/Centro associations remain fictionalized and non-operational.
- Campaign: **CONSISTENT** — all six events fit Ato II or its bridge to Ato III without replacing campaign milestones.
- Chronology: **CONSISTENT** — no event moves a pre-`T0` relationship or institution before its canonical origin.
- Historical boundary: **CONSISTENT** — no fictional character is inserted into the real 1987 event and no fictional artifact is promoted to historical fact.
- Implemented narrative data: **UNCHANGED / NOT REQUIRED** — no Godot Resources or save schema changed in this lore wave.

## Active gate
- PR #17 is open.
- GitHub validation must be inspected on the exact final PR head before merge.
- If validation is green and repository policy permits, merge.
- If the PR head changes, prior gate evidence is stale and must not be reused.

## Next lore action
1. Reconcile PR #17 head, checks, review state and mergeability.
2. If a gate fails because of this lore wave, correct only the smallest lore/documentation defect.
3. If all gates are green, merge PR #17 and verify resulting `master`.
4. After merge, the next coherent lore wave is **dialogue beat sheets for these six events**:
   - opening line/scene objective;
   - character subtext;
   - 2–3 player response tones per choice;
   - consequence callbacks;
   - explicit lines that must remain unsaid to preserve `RUMOR/ABERTO`.
5. Do not implement gameplay under standalone `lore`; SIGA may later translate the event contract into Resources/services.

## Boundaries
- `lore` advances only narrative/lore work.
- Cultivation remains abstract and non-instructional.
- Parallel-market activity remains abstract and non-operational.
- Institutional politics remains fictional and systemic.
- Real history remains separated from fictional canon.
- Chat/model memory is never canonical lore state.
- Persistent continuation state belongs in this repository.
