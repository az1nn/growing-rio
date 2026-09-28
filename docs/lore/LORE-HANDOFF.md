# LORE HANDOFF — DA LATA

## Verified repository
- Repository: `az1nn/growing-rio`
- Default branch: `master`
- Verified default head at this reconciliation: `a8d1c3efae578e1325cd69783108a4f0aa5747b9`
- Lore skill: `.agents/skills/lore/SKILL.md`
- Live repository/PR/CI state overrides this handoff.

## Current route
**LORE-WATCH — PR #150 is a repository-state reconciliation only. After it receives exact-head validation and merges, the persistent lore route returns to LORE-ADVANCE at the next justified narrative-gap selection boundary.**

No new canon is introduced by this reconciliation.

## Closed calendar wave
- Previous lore PR **#123 — `docs(lore): canonize 365-day campaign cycle`** is **MERGED**.
- Merge time: **2026-09-27T10:01:37Z**.
- Merge commit: `2dd01c8d9921b9ddcfdb1d49a390305db63dd6d7`.
- The stale pre-merge `LORE-WATCH` state that described #123 as OPEN is retired.

## Calendar canon preserved
- **CÂNONE:** one campaign spans Days 1–365.
- **CÂNONE:** one individual plant cycle spans 90 in-game days.
- **CÂNONE:** lifecycle order is `seedling → Vega → flora → late flowering → pronta`.
- **CÂNONE:** `pronta` is the terminal cycle state.
- **CÂNONE:** baseline final yield is recognized only at terminal completion.
- **CÂNONE:** four complete 90-day cycles occupy 360 campaign days, leaving five closing days.
- **CÂNONE:** the Ato I first sustainable cycle cannot close before one 90-day cycle reaches `pronta`.

Feature 009 may define game-pacing thresholds and validation around this canon, but those implementation details do not convert real cultivation guidance into lore.

## Existing Ato II material — duplication guard
The apparent filename gap for Ato II is only naming, not missing content:
- `docs/lore/NARRATIVE-EVENT-LIBRARY.md` is already the canonical **Ato II narrative event library**.
- `docs/lore/DIALOGUE-BEAT-SHEETS.md` is already the canonical **Ato II dialogue beat-sheet set**.

Do **not** create duplicate `ACT-II-*` documents merely because Acts I, III, IV and V use act-prefixed filenames. Any future rename must be an explicit documentation-maintenance task preserving links and semantic identity.

## Open narrative boundaries
These remain deliberately unresolved unless a future bounded lore task has authority to decide them:
- exact distribution of Acts II–V across Days 91–365;
- exact numerical yield unit and future balance modifiers;
- exact stage-day allocation as lore — current stage thresholds are game-pacing/balance data, not horticultural canon;
- whether future mechanics allow overlapping batches or multiple production spaces;
- provenance mysteries around the Caderno de Sal, the four marks and the Mulher da Lata;
- interpretation of endings beyond their existing non-ranked canonical presentations.

## Concurrency
At claim time for this reconciliation:
- Feature 009 stack #137→#147 owns lifecycle/runtime/testing and `docs/SIGA-HANDOFF.md`.
- 3JS-005 PR #148 owns Institutional Three.js presentation paths.
- SIGA CI recovery PR #149 owns `.agents/skills/siga/SKILL.md`.
- None of those claims overlap `docs/lore/LORE-HANDOFF.md`.
- PR #150 passed the mandatory post-claim overlap barrier with no competing lore-handoff owner.

## Next lore action
After PR #150 merges:
1. re-read live repository state and current implemented narrative surfaces;
2. classify the next smallest justified narrative gap from existing canon rather than filename symmetry;
3. prefer, in order: unresolved campaign dependency, campaign-required character/faction/district depth, reusable event/dialogue/codex content, chronology consistency;
4. create a repository-visible task/claim and execute the first meaningful lore artifact in the same invocation;
5. preserve the `CÂNONE / RUMOR / ABERTO` boundary and all safety constraints.

## Boundaries
- Cultivation remains abstract and non-operational.
- Parallel-market activity remains abstract; no logistics, concealment or evasion guidance.
- Institutional/political fiction remains systemic and neutral, with no real parties, politicians, elections or targeted persuasion.
- No faction, market route, institutional form or ending is treated as morally correct.
- Chat/model memory is not canonical project state.
