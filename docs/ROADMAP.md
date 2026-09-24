# DA LATA — Roadmap

> **Product maturity re-baseline (2026-09-23):** roadmap checkboxes below record historical implementation milestones and MUST NOT be interpreted alone as proof of a complete player-facing feature. Use `docs/SPEC-KIT-PRODUCT-REBASELINE.md` and classify capabilities as `DOMAIN -> PLAYABLE -> PRESENTED -> POLISHED`. V0.3 Business and V0.4 City are currently domain-complete but not product-complete. Finale expansion after feature 008 is frozen until the re-baseline backlog is addressed.

## V0.1 — Vertical slice
- [x] One abstract grow room.
- [x] 30-day cycle.
- [x] Care / advance / harvest loop.
- [x] Licensed and parallel-market channels.
- [x] Cash, Heat, Reputation and Influence.
- [x] Random events.
- [x] Structural CI validation.
- [x] Godot 4.7.2 headless import/runtime smoke in CI.

## V0.2 — Data-driven simulation
- [x] Extract batch/cultivation state transitions from GameState.
- [x] Extract economy and market resolution from GameState.
- [x] Resource-based cultivars, buyers and upgrades.
- [x] Deterministic seeded simulation regression test.
- [x] Save schema v1.

## V0.3 — Business layer
- [x] Multiple rooms and operating costs.
- [x] Per-room cultivation state and active-room switching.
- [x] Staff and upgrades.
- [x] Contract board and buyer relationships.
- [x] Compliance progression.

## V0.4 — City systems
- [x] Fictional city districts and demand simulation.
- [x] Policy proposals and institutional progression.
- [x] Community / reputation feedback loops.
- [x] No real politicians or targeted political persuasion.

## V0.5 — Campaign
- [x] Narrative events and historical/cultural references.
- [x] Research chain around the fictional DA LATA cultivar.
- [ ] Finale inspired by the cultural memory of the Verão da Lata.


## Product re-baseline delivery
- [x] RB-01 — Product Experience Map delivered and merged.
- [x] RB-02 — Game Shell / Navigation merged via PR #66; default-branch Web refresh is present.
- [ ] RB-03 — Operation Management Surface is exact-head repository-green in PR #68 after retargeting to `master`; Vercel remains `SOFT_GATE_RATE_LIMIT`, so guarded merge is deferred.
- [ ] RB-04 — Rooms / Staff / Upgrades is stacked on PR #68 in PR #70 at `d49757ea5b66520454e9da7028d08b82aa92bab8`; exact-head Validate project #321 is green, while Vercel remains `SOFT_GATE_RATE_LIMIT`, so guarded merge is deferred.
- [ ] RB-05 — Market / Contracts / Buyer Relationships is implemented in stacked PR #72 with canonical `market_snapshot()`, dedicated Market presentation, contract/relationship feedback and parity/save regression; implementation head `06be097fbe30d4add72983de456731422f9de39e` passed Validate project #323, while final-head/provider delivery closure remains pending.
- [ ] RB-06 — Compliance Experience implemented in stacked PR #74 with canonical `compliance_snapshot()`, dedicated Institucional presentation and parity/save regression; exact-final-head CI/provider delivery closure remains pending.
- [ ] RB-07..RB-15 — proceed in re-baseline order; finale expansion stays frozen until RB-14 records PASS/unfreeze.
