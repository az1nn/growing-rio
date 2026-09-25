# LORE HANDOFF — DA LATA

## Verified repository
- Repository: `az1nn/growing-rio`
- Default branch: `master`
- Verified master before this wave: `c0523ebaa2681963334165e05c2c586d2c72a874`
- Previous lore PR: **#52 — MERGED** at `4f26d94d34f39162c8dde4e26362c15ccf83bd56`
- Active lore branch: `docs/lore-act-i-event-library`
- Active lore PR: **#102 — OPEN**
- Lore PR head before this handoff persistence: `552485954eb3480c5adeeffb94d568ad6464753d`
- Concurrent non-lore PRs at reconciliation: **#97, #98, #100, #101**
- Lore skill: `.agents/skills/lore/SKILL.md`
- Live repository/PR/CI state always overrides SHAs and gate references recorded here.

## Route
**LORE-WATCH**

This invocation began by reconciling a stale handoff that still described PR #52 as open. Live GitHub showed #52 already merged and no active lore PR. The smallest coherent canonical gap was then selected under **LORE-ADVANCE**: Ato I had campaign canon, characters and factions, but no implementation-ready event library equivalent to later acts.

The wave has now been dispatched as PR #102, so the persistent route is **LORE-WATCH** until exact-head validation and guarded merge complete.

## Completed this wave
- Added `docs/lore/ACT-I-NARRATIVE-EVENT-LIBRARY.md`.
- Added four stable Act I event contracts:
  - `event_duas_portas_mesmo_dia`;
  - `event_chuva_lata_onda`;
  - `event_quarto_como_origem`;
  - `event_primeiro_ciclo_sustentavel`.
- Clarified `docs/lore/NARRATIVE-EVENT-LIBRARY.md` as an Ato II relational library; all six existing event windows are Ato II.
- Indexed the new Ato I library in `docs/lore/README.md`.
- Kept the wave narrative-only: no Resource, schema, UI, save, gameplay, balance, CI or deployment implementation.

## Canon delta

### Added
- **CÂNONE:** the Ato I opening tension can be represented by a stable event contract where Maya and Nando present different economic relationships without permanently locking either route.
- **CÂNONE:** the rain/Onda handoff now has an implementation-ready narrative contract while the can's provenance, age, custody chain and historical meaning remain unresolved.
- **CÂNONE:** the Quarto can carry player-defined meaning as reference, stage or responsibility without forcing nostalgia or permanent smallness.
- **CÂNONE:** the first sustainable-cycle closure can record whether the player foregrounds credibility, autonomy or reciprocity without making one posture morally correct.

### Revised
- The legacy `NARRATIVE-EVENT-LIBRARY.md` heading now reflects its actual scope: **Ato II**.
- The lore index now separates Ato I event contracts from Ato II relational contracts.

### Preserved open
- Exact provenance, age and custody history of Dalva's can.
- Historical order/common origin of Onda, Sol, Ferrugem and Estrela.
- Authorship/composition of the Caderno de Sal.
- Exact date/voice identity and chronology of the Fita do Farol.
- Historical authenticity of marketed "originals".
- Continuous historical/genetic lineage from the original summer.
- Supernatural status and identity continuity of the Mulher da Lata.
- Final player identity and market alignment; Ato I flags express posture, not destiny.

## Continuity checks
- Characters: **CONSISTENT** — Maya remains pragmatic/formal without moral primacy; Nando remains independent/parallel without operational detail; Dalva separates memory from proof.
- Factions/markets: **CONSISTENT** — Casa Clara and Rede Paralela remain available after the opening choice; neither is written as the correct route.
- Districts: **CONSISTENT** — Morro do Cedro remains origin/community/small-operator territory and is not romanticized as a required permanent state.
- Campaign: **CONSISTENT** — the four events map opening incident -> Onda handoff -> origin/identity beat -> first sustainable-cycle closure into Ato II.
- Historical boundary: **CONSISTENT** — the Onda can remains evidence of an object/mark, not authentication of lineage.
- Political boundary: **NOT REQUIRED / CONSISTENT** — no real political actors, elections or persuasion are introduced.
- Safety boundary: **CONSISTENT** — cultivation is absent; parallel-market activity remains abstract/non-operational.
- Implemented narrative data: **NOT REQUIRED** — this wave defines contracts only; future SIGA work may materialize Resources.

## Active gate
- PR #102 is the only active lore PR at persistence time.
- It was created from verified `master@c0523ebaa2681963334165e05c2c586d2c72a874`.
- Non-lore PRs #97/#98/#101 are CENA-owned and #100 is SIGA documentation; reconcile master drift before trusting stale evidence.
- This handoff persistence moves PR #102 HEAD again; any CI result from the pre-handoff head is stale.
- Required next evidence: exact-head repository validation, unresolved-review check and current mergeability.
- Merge only if the exact final head is green and any new master drift is safe.

## Next lore action
1. Re-read live `master` and PR #102 exact head.
2. Inspect exact-head repository validation and review threads.
3. Reconcile any new master drift; do not overwrite concurrent non-lore work.
4. If green and mergeable, merge #102 with its exact expected head SHA.
5. Verify resulting `master`.
6. Persist the closed-wave handoff only if a follow-up lore persistence commit is still necessary.
7. Only after closure, select the next smallest narrative gap; likely candidates are Ato I dialogue beat sheets or codex entries, subject to live canon.

## Boundaries
- `lore` advances only narrative/lore work.
- Choices record posture and consequence, not objective moral truth.
- Cultivation remains abstract and non-instructional.
- Parallel-market activity remains abstract and non-operational.
- Institutional politics remains fictional and systemic.
- No custody, provenance, publication, price, capital, Reputation, Research or Influence can promote `RUMOR` or `ABERTO` into `CÂNONE` without canonical evidence.
- No ending or market route is treated as morally correct.
