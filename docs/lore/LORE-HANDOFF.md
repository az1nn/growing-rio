# LORE HANDOFF — DA LATA

## Verified repository
- Repository: `az1nn/growing-rio`
- Default branch: `master`
- Reconciled master before this handoff persistence: `e96e72a6d93e13ec56e9c315607a00d269aba292`
- Active lore branch: `docs/lore-act-iv-codex-set-03-r3`
- Active lore PR: **#42 — OPEN**
- Lore PR head before this handoff persistence: `fcfb1225203088cef9363a4e1075b23904c3560d`
- Superseded lore PR: **#41 — CLOSED**, replaced after concurrent master drift; no force-push used.
- Concurrent engineering PR #40: **MERGED** as feature 005 before the final lore branch was rebuilt.
- Lore skill: `.agents/skills/lore/SKILL.md`
- Live repository/PR/CI state always overrides SHAs and gate references recorded here.

## Route
**LORE-WATCH**

The previous Codex / Archive Set 02 wave is complete. The next declared wave, **Codex / Archive Set 03 — Ato IV: O Sistema**, has been authored on a branch rebuilt from the live default branch after feature 005 and its SIGA handoff landed. The lore diff is ready; the remaining work is exact-head repository validation and guarded merge.

## Completed this wave
- Added `docs/lore/CODEX-ARCHIVE-SET-03.md`.
- Indexed it in `docs/lore/README.md`.
- Added five stable candidate archive IDs:
  - `memory_mesa_nao_e_palco`;
  - `memory_lote_ferrugem_evidencia_mista`;
  - `memory_quem_assina_memoria`;
  - `memory_audiencia_periodo_verde`;
  - `memory_estrela_no_verso`.
- Mapped each entry one-to-one to the five canonical Ato IV event contracts and their dialogue beat sheets.
- Added unlock condition, state classification, provenance, compact archive copy, choice echoes, cross-entry continuity and explicit guardrails.
- Preserved the Ato IV shift from authentication toward governance of memory without turning governance into truth.
- Kept the wave narrative-only: no Resource, schema, UI, save, gameplay, economy, compliance or systems implementation was introduced.
- Reconciled concurrent engineering work by rebuilding the lore branch on the post-feature-005 master rather than force-pushing stale history.
- Closed stale PR #41 as superseded and opened reconciled PR #42.

## Canon delta

### Added
- No new historical date, faction, district, character, market structure, scientific conclusion or ending family was added.
- **CÂNONE:** the five already-canonical Ato IV conflicts now have stable codex/archive representations ready for future materialization.
- **CÂNONE:** participation in the Conselho Cívico da Baía is recorded as access and accountable participation, never control.
- **CÂNONE:** the Ferrugem lot remains mixed evidence; custody never authenticates the whole.
- **CÂNONE:** memory governance creates revisable editorial power without resolving historical authorship.
- **CÂNONE:** the Estrela revelation and limited material-origin compatibility are preserved together with `lore_original_lineage_still_unproven = true`.

### Revised
- `docs/lore/README.md` indexes Codex / Archive Set 03.
- The codex layer now covers the five central Ato IV events in addition to Sets 01 and 02.

### Preserved open
- Exact date and voice identity of the Fita do Farol.
- Relationship and chronology between the Fita and the Caderno de Sal.
- Authorship/composition of the Caderno de Sal.
- Historical order and common/separate origin of Onda, Sol, Ferrugem and Estrela.
- Historical authenticity of any marketed “original”.
- Provenance/date of the Onda-marked can delivered by Dalva.
- Continuous historical/genetic lineage from the original summer to the fictional reconstruction.
- Final institutional form of DA LATA until the already-defined Ato V resolution.
- Supernatural status and identity continuity of the Mulher da Lata.

## Continuity checks
- Characters: **CONSISTENT** — Isa remains process mediator; Lúcia, Rui, Joana, Caio, Maya, Helena, Nando and Bento preserve established tensions.
- Factions/markets: **CONSISTENT** — no route becomes morally canonical; parallel-market material remains decentralized and non-operational.
- Districts: **CONSISTENT** — no new geography introduced.
- Campaign: **CONSISTENT** — each memory maps one-to-one to a canonical Ato IV event and the transition still points to `arc_da_lata` as contemporary reconstruction.
- Chronology: **CONSISTENT** — Estrela is “reunida agora”; no historical priority/order is asserted.
- Historical boundary: **CONSISTENT** — provenance, custody, publication and compatibility are not used as authentication.
- Implemented narrative data: **PASS** — the five feature-005 Resources on `master` use the same event IDs, choice flags and canon guardrails inspected for this wave.
- Political boundary: **CONSISTENT** — the Council remains fictional/systemic; no real politicians, parties, elections, vote solicitation or targeted persuasion.
- Safety boundary: **CONSISTENT** — cultivation, parallel-market activity, acquisition and institutional procedures remain abstract/non-operational.
- Concurrency: **RECONCILED** — feature 005 and its SIGA handoff were incorporated by rebuilding from live `master`; no `docs/lore/` overlap was found.

## Active gate
- PR #42 is the only active lore PR.
- Its branch was synchronized with the inspected `master` before opening.
- This handoff persistence moves the PR HEAD again; any prior CI evidence becomes stale.
- Required next evidence: repository validation on the exact final PR head after this commit.
- Merge only if the exact-head gate is green, PR remains mergeable, and no new master drift requires reconciliation.

## Next lore action
1. Reconcile live `master`, PR #42 head and this handoff.
2. Verify `behind_by: 0` or reconcile any new disjoint master drift before relying on CI.
3. Inspect exact-head repository validation for PR #42.
4. If green and mergeable, merge #42 using the exact expected head SHA.
5. Verify the resulting `master` and post-merge validation.
6. Persist the closed-wave handoff.
7. Only after this wave is verifiably complete, select the next smallest narrative gap from the canonical handoff/canon; do not start it while #42 remains active.

## Boundaries
- `lore` advances only narrative/lore work.
- Cultivation remains abstract and non-instructional.
- Parallel-market activity remains abstract and non-operational.
- Institutional politics remains fictional and systemic.
- No real political actors, elections or targeted persuasion.
- No custody, provenance, publication, rarity, price or Influence can promote `RUMOR` or `ABERTO` into `CÂNONE` without canonical evidence.
