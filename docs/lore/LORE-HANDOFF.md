# LORE HANDOFF — DA LATA

## Verified repository
- Repository: `az1nn/growing-rio`
- Default branch: `master`
- Verified master before this wave: `851bd50de53540af84dd9e651aebc7b70201c55b`
- Previous lore PR: **#102 — MERGED** at `56f05518a0dd6a9e4c898851be7cd99c40416b4c`
- Active lore branch: `docs/lore-act-i-dialogue-beat-sheets`
- Active lore PR: **#105 — OPEN**
- Lore PR head before this handoff persistence: `9915bcfc0669424ce5ac981eef647401bbdab6fe`
- Concurrent non-lore PRs at reconciliation: **#97, #98, #100, #101, #104**
- Lore skill: `.agents/skills/lore/SKILL.md`
- Live repository/PR/CI state always overrides SHAs and gate references recorded here.

## Route
**LORE-WATCH**

This invocation reconciled a stale handoff that still described PR #102 as open. Live GitHub showed #102 already merged on 2026-09-26.

Under **LORE-ADVANCE**, the next smallest coherent canonical gap was selected from the accepted Ato I event library itself: Ato I had four implementation-ready event contracts but no dialogue beat sheets, while Atos II–V already had them.

The dialogue wave is now dispatched as PR #105, so the persistent route is **LORE-WATCH** until exact-head validation and guarded merge complete.

## Completed this wave
- Added `docs/lore/ACT-I-DIALOGUE-BEAT-SHEETS.md`.
- Added dialogue intent, subtext, player response tones, NPC reactions, callbacks and explicit non-say guardrails for:
  - `event_duas_portas_mesmo_dia`;
  - `event_chuva_lata_onda`;
  - `event_quarto_como_origem`;
  - `event_primeiro_ciclo_sustentavel`.
- Indexed the new Ato I dialogue document in `docs/lore/README.md`.
- Corrected one pre-existing escaped newline in the same lore index list while touching it.
- Kept the wave narrative-only: no Resource, schema, UI, save, gameplay, balance, CI or deployment implementation.

## Canon delta

### Added
- **CÂNONE:** the four Ato I events now have implementation-facing dialogue intent, subtext and voice guardrails.
- **CÂNONE:** Maya and Nando can directly contest horizon, dependency, credibility and autonomy without either becoming the moral route.
- **CÂNONE:** Dalva explicitly distinguishes remembered detail from inference when the Onda object is discussed.
- **CÂNONE:** Ato I callbacks can preserve player posture into Ato II without promoting choice flags into historical evidence.

### Revised
- The lore index now exposes an explicit Ato I dialogue layer parallel to later acts.
- One malformed escaped newline in the lore index was normalized as a formatting-only correction.

### Preserved open
- Exact provenance, age and custody history of Dalva's Onda can.
- Historical order/common origin of Onda, Sol, Ferrugem and Estrela.
- Authorship/composition of the Caderno de Sal.
- Exact date/voice identity and chronology of the Fita do Farol.
- Historical authenticity of marketed "originals".
- Continuous historical/genetic lineage from the original summer.
- Supernatural status and identity continuity of the Mulher da Lata.
- Final player identity, market alignment and ending.

## Continuity checks
- Characters: **CONSISTENT** — Maya stays objective/formal, Nando autonomous/parallel without operational detail, Dalva separates memory from proof.
- Factions/markets: **CONSISTENT** — Casa Clara and Rede Paralela remain available after the opening choice; neither is the correct route.
- Districts: **CONSISTENT** — Morro do Cedro remains origin/community/small-operator territory without compulsory nostalgia.
- Campaign: **CONSISTENT** — dialogue follows the four accepted Ato I event contracts and points into Ato II without advancing its revelations.
- Historical boundary: **CONSISTENT** — Onda remains a marked object, not authenticated lineage.
- Political boundary: **NOT REQUIRED / CONSISTENT** — no real political actors, elections or persuasion are introduced.
- Safety boundary: **CONSISTENT** — cultivation remains abstract; parallel-market activity remains non-operational.
- Implemented narrative data: **NOT REQUIRED** — this wave remains documentation/contract only.

## Active gate
- PR #105 is the only active lore PR at persistence time.
- It was created from verified `master@851bd50de53540af84dd9e651aebc7b70201c55b`.
- Concurrent non-lore PRs #97/#98/#101/#104 are CENA-owned; #100 is SIGA documentation.
- This handoff persistence moves PR #105 HEAD again; any CI result from `9915bcfc0669424ce5ac981eef647401bbdab6fe` becomes stale.
- Required next evidence: exact-final-head repository validation, unresolved-review check, current master drift and mergeability.
- Merge only if the exact final head is green and new master drift is safe.

## Next lore action
1. Re-read live `master` and PR #105 exact head.
2. Inspect exact-head repository validation and unresolved review threads.
3. Reconcile any master drift; do not overwrite concurrent CENA/SIGA work.
4. If green and mergeable, merge #105 with its exact expected head SHA.
5. Verify resulting `master`.
6. Only after closure, select the next smallest narrative gap; likely candidate is Ato I codex/memory entries that genuinely merit persistence, subject to live canon.

## Boundaries
- `lore` advances only narrative/lore work.
- Choices record posture and consequence, not objective moral truth.
- Cultivation remains abstract and non-instructional.
- Parallel-market activity remains abstract and non-operational.
- Institutional politics remains fictional and systemic.
- No custody, provenance, publication, price, capital, Reputation, Research or Influence can promote `RUMOR` or `ABERTO` into `CÂNONE` without canonical evidence.
- No ending or market route is treated as morally correct.
