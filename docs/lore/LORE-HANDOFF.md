# LORE HANDOFF — DA LATA

## Verified repository
- Repository: `az1nn/growing-rio`
- Default branch: `master`
- Chronology PR: **#7 — MERGED**
- Verified chronology PR head: `99dd32fb83f4e566b9f3805a7c6d8d18c69ab0b2`
- Chronology merge commit: `644f3b6d97fa6b45811abb5a054d4d747670f734`
- Active lore PR: **none**
- Lore skill: `.agents/skills/lore/SKILL.md`

## Route
**LORE-ADVANCE**

The canonical City chronology wave is delivered on `master`. The next standalone `lore` invocation should reconcile live repository state first, then advance only if no newer lore work supersedes this handoff.

## Completed this wave
- Added the first canonical chronology for the Cidade do Rio.
- Separated real 1987/1988 historical reference from all DA LATA fiction.
- Added a relative diegetic clock (`T-N` -> `T0`) anchored to the opening of Ato I.
- Fixed the order in which the major factions and institutions emerge before the campaign.
- Fixed the Período Verde as beginning seven years before the player's opening state.
- Connected faction history to the present motivations of Maya, Lúcia, Joana, Rui, Helena, Bento and the institutional setting.
- Fixed the opening-state chronology for the two first-market opportunities and Dalva's Onda object.
- Preserved unresolved mystery where the canon requires uncertainty.
- Added the chronology to the lore index.
- Opened PR #7, validated its exact head and merged it into `master`.

## Canon delta

### Added
- `docs/lore/CHRONOLOGY.md`.
- `T0` as the opening of `arc_o_quarto`.
- Período Verde begins at `T-7`.
- Autoridade Verde Municipal is created at `T-7`.
- Casa Clara predates the licensed market and enters licensed retail at `T-6`.
- Cooperativa Raiz do Cedro formalizes at `T-5`.
- Consórcio Atlântico creates its green-sector expansion at `T-4`.
- Rui Sal launches `Maré de Fundo` at `T-4`.
- Conselho Cívico da Baía emerges at `T-3`.
- Instituto Aurora begins systematic review of “da lata” provenance at `T-2`.
- Bento inherits the uncatalogued archive boxes at `T-1`.
- The player enters a city with seven years of Período Verde already behind it.

### Revised
- No previous canon fact was intentionally replaced.
- Existing faction and character descriptions are now temporally ordered by the chronology.
- The historical/diegetic boundary is stricter: named fictional characters do not participate in the real 1987 event.

### Preserved open
- Exact authorship and original composition date of the Caderno de Sal.
- Whether all four marks existed in the earliest Caderno material.
- Creation date and provenance of Dalva's Onda-marked can.
- First occurrence and supernatural status of the Mulher da Lata.
- Any continuous historical lineage between 1987 cannabis and the final fictional DA LATA reconstruction.

## Continuity checks
- Characters: **CONSISTENT** — motivations and first-act appearances preserved.
- Factions: **CONSISTENT** — all major factions now have temporal placement; Rede Paralela explicitly has no founding date.
- Districts: **CONSISTENT** — chronology does not create real-world route/jurisdiction mapping.
- Campaign: **CONSISTENT** — `T0` matches Ato I and the Onda incident remains the first direct myth contact.
- Historical boundary: **CONSISTENT** — historical facts remain sourced through `HISTORICAL-INSPIRATION.md`; fictional actors are excluded from the real event.
- Implemented narrative data: **UNCHANGED / NOT REQUIRED** — no narrative Resources exist yet that need migration.

## Active gate
- **None for the chronology wave.**
- PR #7 exact-head repository validation completed successfully before merge.
- Live repository state still overrides this handoff if subsequent commits or lore PRs exist.

## Next lore action
1. Reconcile live `master`, this handoff and any newer lore work.
2. If no newer lore work supersedes this state, keep **LORE-ADVANCE**.
3. Build the first canonical **pre-campaign character relationship history**, using `CHRONOLOGY.md` as the time axis.
4. Prioritize the Ato I/Ato II core: Dalva, Maya, Nando, Lúcia, Joana and Rui.
5. Define what each pair knows, owes, mistrusts or misremembers before `T0`.
6. Preserve player agency: no relationship should pre-decide a morally correct market path.
7. Persist the character-relationship wave back into this handoff.

## Boundaries
- `lore` advances only narrative/lore work.
- Cultivation remains abstract and non-instructional.
- Parallel-market activity remains abstract and non-operational.
- Institutional politics remains fictional and systemic.
- Real history remains separated from fictional canon.
- Chat/model memory is never canonical lore state.
- Persistent continuation state belongs in this repository.
