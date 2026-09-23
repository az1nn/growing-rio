# LORE HANDOFF — DA LATA

## Verified repository
- Repository: `az1nn/growing-rio`
- Default branch: `master`
- Verified post-merge master before this handoff persistence: `e7bbf8ed01adf205d89123895b0252fdb5bc9def`
- Completed lore branch: `docs/lore-act-iii-codex-set-02`
- Completed lore PR: **#38 — MERGED**
- Final PR head: `96aa387d9cd340088e18fac61ae06558bfcb4caa`
- Exact-head PR validation: `Validate project` run #201 / 35906608919 — **SUCCESS**
- PR merge commit: `e7bbf8ed01adf205d89123895b0252fdb5bc9def`
- Post-merge validation: `Validate project` run #205 / 35907027600 — **SUCCESS**
- Active lore PR: **none**
- Active repository PR at reconciliation: **#40 — draft**, engineering/spec work, no overlap with `docs/lore/` on the inspected head.
- Lore skill: `.agents/skills/lore/SKILL.md`
- Live repository/PR/CI state always overrides SHAs and gate references recorded here.

## Route
**LORE-ADVANCE**

Codex / Archive Set 02 — Ato III: Dois Mercados is verifiably complete. PR #38 passed repository validation on its exact final head, merged cleanly into `master`, and the resulting merge commit passed post-merge validation. No lore PR remains active.

## Completed this wave
- Added `docs/lore/CODEX-ARCHIVE-SET-02.md`.
- Indexed it in `docs/lore/README.md`.
- Added six stable candidate archive IDs:
  - `memory_fita_farol_quatro_marcas`;
  - `memory_original_1987_contestado`;
  - `memory_nome_em_contrato`;
  - `memory_rede_sem_dono`;
  - `memory_historia_na_prateleira`;
  - `memory_regra_que_mudou`.
- Mapped each entry to one canonical Ato III event and its dialogue-beat-sheet guardrails.
- Added unlock condition, state classification, provenance, compact archive copy, choice echoes and future callback constraints.
- Added cross-entry continuity rules for Fita -> Original, Original -> Nome em Contrato, Rede -> Nome em Contrato, Prateleira -> Nome em Contrato and Regra -> Conselho.
- Kept the wave narrative-only: no Resource, schema, UI, save, gameplay, economy, compliance or systems implementation was introduced.
- Reconciled concurrent engineering work without lore-file overlap before merge.

## Canon delta

### Added
- No new historical fact, faction, district, character, market structure or ending family was added.
- **CÂNONE:** the six already-canonical Ato III conflicts now have stable codex/archive representations ready for future materialization.
- **CÂNONE:** archive provenance records source without functioning as authentication.
- **CÂNONE:** choice echoes record posture/consequence and cannot promote `RUMOR` or `ABERTO` into `CÂNONE`.
- **CÂNONE:** access/influence in the fictional institutional layer remains participation, not control.

### Revised
- `docs/lore/README.md` indexes Codex / Archive Set 02.
- The codex layer now covers the six central Ato III events in addition to the Ato II-derived Set 01.

### Preserved open
- Exact date and voice identity of the Fita do Farol.
- Whether the Fita predates public circulation of the Caderno de Sal.
- Relationship between the Fita and the Caderno.
- Historical order and common/separate origin of Onda, Sol, Ferrugem and Estrela.
- Historical authenticity of any marketed “original”.
- Authorship/composition of the Caderno de Sal.
- Provenance/date of the Onda-marked can delivered by Dalva.
- Continuous historical/genetic lineage from the original summer to the fictional reconstruction.
- Final institutional form of DA LATA until the already-defined Ato V resolution.
- Supernatural status and identity continuity of the Mulher da Lata.

## Continuity checks
- Characters: **CONSISTENT** — established motivations preserved; none becomes moral arbiter.
- Factions/markets: **CONSISTENT** — formal and parallel structures remain trade-off spaces; the Rede Paralela remains decentralized and non-operationally described.
- Districts: **CONSISTENT** — no new geography introduced.
- Campaign: **CONSISTENT** — each memory maps one-to-one to a canonical Ato III event; the Council invitation remains progression-based rather than reward for a “correct” choice.
- Chronology: **CONSISTENT** — no new historical date, sequence or priority asserted.
- Historical boundary: **CONSISTENT** — archive language distinguishes evidence, allegation, record, interpretation and non-verification.
- Implemented narrative data: **NOT MUTATED BY THIS WAVE**.
- Political boundary: **CONSISTENT** — AVM and Council remain fictional/systemic; no real politicians, parties, elections or targeted persuasion.
- Safety boundary: **CONSISTENT** — cultivation, parallel-market activity, compliance and institutional procedures remain abstract/non-operational.
- Concurrency: **CONSISTENT** — active PR #40 is engineering/spec work and had no inspected `docs/lore/` overlap at reconciliation.

## Active gate
- **None for Codex / Archive Set 02.**
- PR #38 final head passed `Validate project` run #201.
- PR #38 merged as `e7bbf8ed01adf205d89123895b0252fdb5bc9def`.
- The merge commit passed `Validate project` run #205.
- This handoff persistence commit should be treated under the repository's normal validation; live CI state overrides this record.

## Next lore action
1. Reconcile live `master`, this handoff and any newer lore work.
2. If no newer narrative priority supersedes this state, keep **LORE-ADVANCE**.
3. Create **Codex / Archive Set 03 — Ato IV: O Sistema** from the five canonical Ato IV event contracts and `docs/lore/ACT-IV-DIALOGUE-BEAT-SHEETS.md`.
4. Give each entry a stable `memory_*` candidate ID, source event, unlock condition, `CÂNONE | RUMOR | ABERTO` state, provenance, compact archive text, choice echoes and explicit guardrails.
5. Preserve unresolved provenance, four-mark order/common origin, marketed “original” authenticity, continuous historical/genetic lineage and supernatural ambiguity unless canonical evidence already closes them.
6. Keep the wave narrative-only; Resource/schema/UI/save/gameplay implementation belongs to SIGA.

## Boundaries
- `lore` advances only narrative/lore work.
- Cultivation remains abstract and non-instructional.
- Parallel-market activity remains abstract and non-operational.
- Contracts, compliance and institutional processes remain fictional and non-advisory.
- Institutional politics remains fictional and systemic.
- No real politicians, parties, elections or targeted political persuasion.
- No ending, faction, proposal or institutional response is labelled morally correct.
- Real history remains separated from fictional canon.
- Chat/model memory is never canonical lore state.
- Persistent continuation state belongs only in this repository.
