# LORE HANDOFF — DA LATA

## Verified repository
- Repository: `az1nn/growing-rio`
- Default branch: `master`
- Event-library PR: **#17 — MERGED**
- Validated PR head: `f179e7e87af07bcfe639f3bd57b4d54768ef801f`
- Verified repository gate: `Validate project` run **#77 / 35854331495 — SUCCESS**
- Event-library merge commit: `2463585012b5777da26e52b8fab38088513ae698`
- Active lore PR: **none**
- Lore skill: `.agents/skills/lore/SKILL.md`

## Route
**LORE-ADVANCE**

The Ato I/Ato II narrative-event-library wave is delivered on `master`. The next standalone `lore` invocation must reconcile live repository state first, then advance only if no newer lore work supersedes this handoff.

## Completed this wave
- Added `docs/lore/NARRATIVE-EVENT-LIBRARY.md`.
- Converted all six reserved relationship hooks into narrative event specifications:
  - `event_dalva_lucia_primeiro_depoimento`;
  - `event_maya_joana_porta_estreita`;
  - `event_rui_cedro_contexto`;
  - `event_nando_procedencia_insuficiente`;
  - `event_rui_lucia_quatro_marcas`;
  - `event_dalva_rui_entrevista_que_nao_foi`.
- Defined narrative windows, preconditions, participants, dramatic beats, player-facing choices, lore flags, relationship consequences, abstract system signals and continuity invariants.
- Added stable observation flags plus `choice_*` semantics that never act as historical proof.
- Added a suggested Ato II ordering without forcing a single route.
- Added a non-binding `NarrativeEvent` implementation contract for future SIGA work.
- Indexed the new library from `docs/lore/README.md`.
- Validated the exact final PR head successfully and merged PR #17.

## Canon delta

### Added
- The six reserved hooks now have canonical event shapes suitable for future campaign implementation.
- Player decisions may alter relationship posture, memory framing, research posture and abstract Community/Reputation/Legitimacy/Risk signals without authenticating disputed history.
- “Porta estreita” is the organizing motif of the Maya/Joana supplier-access event.
- The Dalva/Lúcia symbol-order contradiction is now a playable archive decision.
- The Rui/Joana Cedro dispute is now a playable “context is not control” editorial event.
- Nando's uncertain Caderno lead may be catalogued, circulated or held without becoming proof.
- Rui/Lúcia priority over the four-mark pattern remains playable but unresolved.
- The “interview that never happened” now has a dual-record playable structure without producing a complete recording.

### Revised
- No prior canon fact was intentionally replaced.
- `docs/lore/README.md` now indexes the event library.
- The six hook IDs are narrative specifications rather than concepts only; they are still not implemented game Resources.

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
- Characters: **CONSISTENT** — desires, fears, methods and tensions preserved.
- Factions: **CONSISTENT** — no fixed alliance or morally privileged route introduced.
- Districts: **CONSISTENT** — Cedro/Orla/Centro associations remain fictionalized and non-operational.
- Campaign: **CONSISTENT** — all six events fit Ato II or its bridge to Ato III without replacing campaign milestones.
- Chronology: **CONSISTENT** — no event moves a pre-`T0` relationship or institution before its canonical origin.
- Historical boundary: **CONSISTENT** — no fictional character is inserted into the real 1987 episode and no fictional artifact is promoted to historical fact.
- Implemented narrative data: **UNCHANGED / NOT REQUIRED** — no Godot Resources or save schema changed in this lore wave.

## Active gate
- **None for this wave.**
- PR #17 exact-head validation completed successfully before merge.
- Live repository state still overrides this handoff if subsequent commits or lore PRs exist.

## Next lore action
1. Reconcile live `master`, this handoff and any newer lore work.
2. If no newer lore wave supersedes this state, keep **LORE-ADVANCE**.
3. Build **dialogue beat sheets for the six event-library scenes**:
   - scene objective and opening beat;
   - character subtext;
   - 2–3 player response tones per choice;
   - consequence callbacks;
   - lines that must remain unsaid to preserve `RUMOR/ABERTO`.
4. Keep dialogue concise enough for future localization and Resource-based implementation.
5. Do not implement gameplay under standalone `lore`; SIGA may later translate the event contract into Resources/services.

## Boundaries
- `lore` advances only narrative/lore work.
- Cultivation remains abstract and non-instructional.
- Parallel-market activity remains abstract and non-operational.
- Institutional politics remains fictional and systemic.
- Real history remains separated from fictional canon.
- Chat/model memory is never canonical lore state.
- Persistent continuation state belongs in this repository.
