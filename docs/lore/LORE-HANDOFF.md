# LORE HANDOFF — DA LATA

## Verified repository
- Repository: `az1nn/growing-rio`
- Default branch: `master`
- Verified base before this wave: `473cef46e4dd9926c1033318b7ad97cc05c68c41`
- Previous lore PR: **#105 — MERGED**
- Active lore branch: `docs/lore-365-day-campaign-cycle`
- Active lore PR: **#123 — OPEN**
- Concurrent non-lore delivery: **#121 / 3JS-004 Cidade**, with no lore-file overlap at branch creation.
- Lore skill: `.agents/skills/lore/SKILL.md`
- Live repository/PR/CI state always overrides this handoff.

## Route
**LORE-WATCH**

The user explicitly set a new temporal canon. Previous lore work is merged, so this invocation classified **LORE-ADVANCE**, created one coherent calendar wave, and dispatched it as PR #123. The persistent route is now LORE-WATCH until exact-head validation and guarded merge complete.

## Completed this wave
- Added `docs/lore/CAMPAIGN-CALENDAR.md`.
- Fixed campaign duration at exactly **365 in-game days**.
- Fixed each individual plant cycle at exactly **90 in-game days / 3 production months**.
- Canonized stage order: `seedling → Vega → flora → late flowering → pronta`.
- Defined `pronta` as the terminal cycle state.
- Normalized final yield at cycle completion so moving time between stages cannot multiply output.
- Established the annual identity: **4 × 90 = 360 days + 5 closing days**.
- Anchored the Ato I “primeiro ciclo sustentável” event to a completed 90-day cycle.
- Indexed the calendar in the lore README.

## Canon delta

### Added
- **CÂNONE:** one campaign lasts Days 1–365.
- **CÂNONE:** one individual plant cycle lasts 90 days.
- **CÂNONE:** stage order is `seedling → Vega → flora → late flowering → pronta`.
- **CÂNONE:** final baseline yield is recognized only when the cycle reaches `pronta`.
- **CÂNONE:** four complete 90-day cycles occupy 360 campaign days.
- **CÂNONE:** the remaining five days are annual closure/finale margin, not a fifth complete cycle.
- **CÂNONE:** Ato I cannot close its first sustainable cycle before one 90-day cycle reaches `pronta`.

### Revised
- Campaign chronology now has a hard annual boundary instead of an unspecified duration.
- “Primeiro ciclo sustentável” now has a temporal anchor while keeping cultivation abstract.

### Preserved open
- Exact day allocation of the four pre-`pronta` stages inside each 90-day cycle.
- Exact numerical yield unit and any future balance modifiers.
- Exact distribution of Acts II–V across Days 91–365.
- Whether future systems allow overlapping batches or multiple spaces; each individual cycle still remains 90 days.
- Existing lore mysteries, provenance questions and ending interpretation remain unchanged.

## Continuity checks
- Characters: **CONSISTENT** — no character history or motivation changed.
- Factions: **CONSISTENT** — no market route or institution was privileged.
- Districts: **CONSISTENT** — no geography changed.
- Campaign: **REVISED / CONSISTENT** — hard 365-day clock and 90-day cycle now constrain progression.
- Historical boundary: **CONSISTENT** — no historical claim added.
- Implemented narrative data: **NOT REQUIRED** — documentation-only wave.
- Safety boundary: **CONSISTENT** — stage names and durations are game abstractions; no real cultivation recipe or parameter was introduced.

## Active gate
- PR #123 is the active lore PR.
- It was created from verified `master@473cef46e4dd9926c1033318b7ad97cc05c68c41`.
- PR #121 is a concurrent Three.js delivery and did not overlap this lore wave at creation.
- This handoff persistence advances PR #123 again, so checks from earlier heads are historical.
- Before merge: re-read exact PR head, exact-head checks, mergeability, unresolved review threads and current master drift.

## Next lore action
1. Reconcile PR #123 exact head against live `master`.
2. Require repository validation and any required provider checks for that exact head.
3. Confirm #121 or later concurrent work did not introduce overlapping lore changes.
4. If green and mergeable, guarded-merge PR #123 with expected-head protection.
5. Verify resulting `master`.
6. Only after closure, advance the next narrative gap; do not invent stage-day splits unless balance explicitly defines them.

## Boundaries
- Lore defines temporal canon and narrative meaning, not real cultivation guidance.
- Exact stage-day splits remain balance-owned.
- No save schema, gameplay code, renderer, UI, asset or deployment behavior changes in this wave.
- Chat/model memory is not canonical project state.
