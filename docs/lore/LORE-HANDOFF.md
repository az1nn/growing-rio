# LORE HANDOFF — DA LATA

## Verified repository
- Repository: `az1nn/growing-rio`
- Default branch: `master`
- Ato III lore PR: **#21 — MERGED**
- Validated PR #21 head: `39ca0c4de52a7c7e3dcaec806d4e741b5e60dbb2`
- PR #21 gate: `Validate project` **run #99 / 35857024329 — SUCCESS**
- PR #21 merge commit: `3db744fe10dcbb4b69a4e93cc36de88f59c141a4`
- Concurrent campaign-state PR: **#22 — MERGED immediately before #21**
- PR #22 validated head: `ee0e074e1038fa51f428cafef95a29ab92d99391`
- PR #22 gate: `Validate project` **run #98 / 35857005047 — SUCCESS**
- PR #22 merge commit: `1719a97b0e5753a7ff5d1672e2753af9fdd49b59`
- Integration reconciliation: compare `1719a97b... -> 3db744fe...` is ahead by 4 commits and changes only the three lore files from PR #21.
- Active lore PR: **none**
- Lore skill: `.agents/skills/lore/SKILL.md`

## Route
**LORE-ADVANCE**

The Ato III narrative-event-library wave is merged. Live repository state was reconciled against the concurrent V0.5 campaign-state implementation before closing this handoff.

## Completed this wave
- Added `docs/lore/ACT-III-NARRATIVE-EVENT-LIBRARY.md`.
- Defined six implementation-ready Ato III events:
  - `event_bento_fita_farol`;
  - `event_falso_original`;
  - `event_helena_nome_em_contrato`;
  - `event_nando_sem_dono_sem_escala`;
  - `event_maya_prateleira_sem_improviso`;
  - `event_caio_regra_que_mudou`.
- Added stable observation and `choice_*` flag candidates.
- Added relationship consequences and abstract system signals without implementing gameplay.
- Added Ato II -> Ato III callback guidance without turning prior player posture into historical fact.
- Added a campaign guardrail that the Council invitation must not depend on one morally “correct” choice.
- Indexed the new Ato III library from `docs/lore/README.md`.
- Validated exact PR #21 head successfully and merged the lore wave.
- Reconciled the immediately preceding technical merge from PR #22; no file overlap or lore conflict was introduced.

## Canon delta

### Added
- **CÂNONE:** the Fita do Farol event now has a stable narrative structure in which the audible four-mark reference is real inside the fiction while date, voice and priority remain unresolved.
- **CÂNONE:** the contemporary market manufactures its own DA LATA memory through unsupported “original” claims.
- **CÂNONE:** Helena's Ato III conflict explicitly centers scale versus control of cultural identity.
- **CÂNONE:** Nando's Ato III conflict explicitly centers autonomy versus coordination/scale.
- **CÂNONE:** Maya's Ato III conflict explicitly centers formal consistency versus preserving access and context.
- **CÂNONE:** Caio's Ato III conflict explicitly centers rule interpretation versus adaptation inside a contradictory fictional regulatory system.
- Stable implementation candidates for observation flags, choice flags and cross-act callbacks.

### Revised
- No established historical or fictional fact was intentionally replaced.
- The lore index now includes the Ato III event library.
- Ato III campaign beats are decomposed into event-level narrative contracts without changing the campaign outcome.
- Implementation awareness is updated: canonical narrative campaign state now exists in `GameState` after PR #22 and save schema is v10.

### Preserved open
- Exact date of the Fita do Farol.
- Identity of the voice on the Fita do Farol.
- Whether the tape predates public circulation of the Caderno de Sal.
- Relationship between the tape and the Caderno.
- Historical order/common origin of Onda, Sol, Ferrugem and Estrela.
- Authorship/composition of the Caderno de Sal.
- Historical authenticity of any specific item sold as “original”.
- Provenance/date of the Onda-marked can delivered by Dalva.
- Supernatural status and stable identity of the Mulher da Lata.
- Continuous historical lineage between the real 1987 episode and the fictional DA LATA reconstruction remains explicitly unproven.

## Continuity checks
- Characters: **CONSISTENT** — Bento, Helena, Nando, Maya and Caio act from established desires, fears and contradictions; no NPC becomes a moral narrator.
- Factions: **CONSISTENT** — Consórcio, Casa Clara, Rede Paralela and AVM retain explicit benefits, costs and internal contradictions.
- Districts: **CONSISTENT** — Arco Norte carries scale/industry, Mercado da Madrugada remains abstract informal culture, and Orla da Vigia carries prestige/exposure/fake memorabilia.
- Campaign: **CONSISTENT** — all six events fit `arc_dois_mercados`; the Fita do Farol remains the key mystery escalation and the Council invitation remains the act transition.
- Chronology: **CONSISTENT** — Bento inherits the tape at T-1, but the tape's own recording date is not fixed.
- Historical boundary: **CONSISTENT** — no fictional character is inserted into the real 1987 event and no historical lineage is authenticated.
- Implemented narrative data: **CONSISTENT** — after PR #22, `GameState` owns `completed_arc_ids[]`, `completed_event_ids[]` and persistent `narrative_flags`; save schema is v10. The first materialized event remains `event_dalva_lucia_primeiro_depoimento`, and no scene yet presents event/choice UX. This lore wave adds contracts only, not Resources or gameplay.

## Active gate
- **None for this lore wave.**
- PR #21 exact-head validation succeeded before merge.
- Concurrent PR #22 exact-head validation also succeeded before its merge.
- The final integration comparison confirms PR #21 landed directly on top of #22 with only lore-file changes.
- Live repository state still overrides this handoff if subsequent work appears.

## Next lore action
1. Reconcile live `master`, this handoff and any newer lore work.
2. If no newer lore wave supersedes this state, keep **LORE-ADVANCE**.
3. Create **Ato III dialogue beat sheets** for the six event IDs:
   - scene objectives and openings;
   - character subtext;
   - 2–3 player response tones per choice;
   - callbacks from Ato II and Ato III flags;
   - consequence echoes;
   - explicit lines that must remain unsaid to protect `RUMOR` / `ABERTO`;
   - localization/data-driven implementation guardrails.
4. Keep dialogue compatible with the v10 campaign-state contract but narrative-only under standalone `lore`.
5. Do not turn this next lore wave into UI or Resource implementation; that belongs to SIGA.

## Boundaries
- `lore` advances only narrative/lore work.
- Cultivation remains abstract and non-instructional.
- Parallel-market activity remains abstract and non-operational.
- Institutional politics remains fictional and systemic.
- No real politicians, parties, elections or targeted political persuasion.
- Real history remains separated from fictional canon.
- Chat/model memory is never canonical lore state.
- Persistent continuation state belongs only in this repository.
