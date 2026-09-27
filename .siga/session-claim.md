# SIGA session claim

- SIGA-TASK-KEY: `009:T014`
- Parent: PR #141 / `test/009-t013-rng-inventory-invariants`
- Base SHA: `f428089e91137212439396cae214e49af10454ea`
- Intended paths: `tests/campaign_annual_cycle_margin_test.gd`, `.github/workflows/validate.yml`, `specs/009-campaign-calendar-lifecycle/tasks.md`, `docs/SIGA-HANDOFF.md`.
- Semantic scope: regression only; prove four serial 90-day cultivation cycles consume 360 campaign days and leave five playable days before Day-365 closure.
- No runtime/save-schema/economy/yield/RNG/visual/lore behavior change.
