# LORE HANDOFF — DA LATA

## Verified repository
- Repository: `az1nn/growing-rio`
- Default branch: `master`
- Verified `master` HEAD at reconcile: `21b3fb221dfc23b262ce706f6603dd7c38655cfa`
- Active lore branch: `docs/lore-dialogue-beats`
- Active lore PR: **#18 — OPEN**
- PR head before this handoff persistence commit: `3b8b4645b9910c236cbf0681f897f158508570f6`
- Lore skill: `.agents/skills/lore/SKILL.md`

## Route
**LORE-ADVANCE**

The event-library wave on `master` was complete and no newer lore PR superseded it. This invocation advanced the explicit next action: dialogue beat sheets for the six canonical Ato II events.

## Completed this wave
- Added `docs/lore/DIALOGUE-BEAT-SHEETS.md`.
- Defined scene objectives and opening beats for all six canonical event-library scenes.
- Defined character-specific subtext for:
  - Dalva;
  - Lúcia;
  - Maya;
  - Joana;
  - Rui;
  - Nando.
- Added 2–3 player response tones per choice without fixing protagonist biography.
- Added consequence callbacks that may alter trust, tone and future line availability without converting player choices into historical proof.
- Added explicit “lines that must remain unsaid” for every scene to protect `RUMOR` and `ABERTO`.
- Added cross-scene callback guidance.
- Added implementation guardrails for later Resource/event-data work.
- Indexed the new beat-sheet document from `docs/lore/README.md`.
- Opened PR **#18**.

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
- PR **#18** is open.
- Final PR head must be verified live after this handoff commit.
- Required CI/check state must be inspected on the exact PR head before merge.
- No human creative decision is required for this wave.

## Next lore action
1. Verify PR #18 exact head, mergeability and required checks after this handoff persistence commit.
2. If checks are green and repository policy permits, merge PR #18 and verify resulting `master`.
3. After merge, the next standalone `lore` should reconcile the new `master` first.
4. If no newer lore work supersedes this state, advance to **first playable codex/archive text set** derived from the six scenes:
   - concise archive entries;
   - provenance labels;
   - `CÂNONE/RUMOR/ABERTO` presentation language;
   - no gameplay implementation under standalone `lore`.
5. Keep codex copy localization-friendly and never let archive UI language silently authenticate disputed material.

## Boundaries
- `lore` advances only narrative/lore work.
- Cultivation remains abstract and non-instructional.
- Parallel-market activity remains abstract and non-operational.
- Institutional politics remains fictional and systemic.
- Real history remains separated from fictional canon.
- Chat/model memory is never canonical lore state.
- Persistent continuation state belongs in this repository.
