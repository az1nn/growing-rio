# LORE HANDOFF — DA LATA

## Verified repository
- Repository: `az1nn/growing-rio`
- Default branch: `master`
- Dialogue-beat PR: **#18 — MERGED**
- Validated PR head: `08c459d16d8c67b401c32735622e636021f853da`
- Verified repository gate: `Validate project` run **#81 / 35854984972 — SUCCESS**
- Dialogue-beat merge commit: `6cf34c83531959a598654c7998af25c18d55aff7`
- Active lore PR: **none**
- Lore skill: `.agents/skills/lore/SKILL.md`

## Route
**LORE-ADVANCE**

The dialogue-beat-sheet wave is delivered on `master`. The next standalone `lore` invocation must reconcile live repository state first, then advance only if no newer lore work supersedes this handoff.

## Completed this wave
- Added `docs/lore/DIALOGUE-BEAT-SHEETS.md`.
- Defined scene objectives and opening beats for all six canonical Ato II event-library scenes.
- Defined character-specific subtext for Dalva, Lúcia, Maya, Joana, Rui and Nando.
- Added 2–3 player response tones per choice without fixing protagonist biography.
- Added consequence callbacks that may alter trust, tone and future line availability without converting player choices into historical proof.
- Added explicit “lines that must remain unsaid” for every scene to protect `RUMOR` and `ABERTO`.
- Added cross-scene callback guidance.
- Added implementation guardrails for later Resource/event-data work.
- Indexed the new beat-sheet document from `docs/lore/README.md`.
- Validated the exact final PR head successfully and merged PR #18.

## Canon delta

### Added
- The six existing event specifications now have canonical dialogue intent, subtext, player-response tone space and continuity guardrails.
- Player dialogue tone is explicitly posture-based rather than biography-based.
- Cross-scene callbacks may reference earlier player posture but cannot authenticate disputed history.

### Revised
- No established fictional historical fact was intentionally replaced.
- `docs/lore/README.md` now indexes the dialogue beat sheets.
- The six events remain specifications, not implemented Godot Resources.

### Preserved open
- Authorship and composition history of the Caderno de Sal.
- Order and common origin of Onda, Sol, Ferrugem and Estrela.
- Provenance/date of Dalva's Onda-marked can.
- Supernatural status and stable identity of the Mulher da Lata.
- Continuous historical lineage between the real 1987 episode and the fictional DA LATA reconstruction.
- Rui's claim that Nando saw a Caderno page before `T0` remains **RUMOR**.
- Dalva/Lúcia disagreement about the first symbol mentioned remains **ABERTO**.
- Rui/Lúcia disagreement about who first noticed the four-mark pattern remains **ABERTO**.
- The exact interpretation of the Dalva/Rui non-interview night remains **ABERTO**.

## Continuity checks
- Characters: **CONSISTENT** — dialogue intent follows established desire/fear/tension profiles.
- Factions: **CONSISTENT** — no faction is made morally privileged.
- Districts: **CONSISTENT** — Cedro remains lived territory, not decorative shorthand.
- Campaign: **CONSISTENT** — all six scenes remain inside Ato II / bridge to Ato III windows already defined.
- Chronology: **CONSISTENT** — no pre-`T0` relationship or event moved.
- Historical boundary: **CONSISTENT** — no real person or unsupported real-world fact introduced.
- Implemented narrative data: **UNCHANGED / NOT REQUIRED** — no Resource, save schema or gameplay code changed.

## Active gate
- **None for this wave.**
- PR #18 exact-head validation completed successfully before merge.
- Live repository state still overrides this handoff if subsequent commits or lore PRs exist.

## Next lore action
1. Reconcile live `master`, this handoff and any newer lore work.
2. If no newer lore wave supersedes this state, keep **LORE-ADVANCE**.
3. Build the **first playable codex/archive text set** derived from the six scenes:
   - concise archive entries;
   - provenance labels;
   - `CÂNONE/RUMOR/ABERTO` presentation language;
   - optional short flavor copy tied to the four symbols;
   - no gameplay implementation under standalone `lore`.
4. Keep codex copy localization-friendly and never let archive UI language silently authenticate disputed material.
5. Keep the supernatural inconclusive and preserve all current historical boundaries.

## Boundaries
- `lore` advances only narrative/lore work.
- Cultivation remains abstract and non-instructional.
- Parallel-market activity remains abstract and non-operational.
- Institutional politics remains fictional and systemic.
- Real history remains separated from fictional canon.
- Chat/model memory is never canonical lore state.
- Persistent continuation state belongs in this repository.
