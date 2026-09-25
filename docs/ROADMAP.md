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
- [x] RB-02 — Game Shell / Navigation delivered and merged.
- [x] RB-03 — Operation Management Surface is present on the reconciled default branch.
- [x] RB-04 — Rooms / Staff / Upgrades is present on the reconciled default branch.
- [x] RB-05 — Market / Contracts / Buyer Relationships is present on the reconciled default branch; older stacked PR #72 was superseded after its work became ancestry of `master`.
- [x] RB-06 — Compliance Experience is present on the reconciled default branch; older stacked PR #74 was superseded after its work became ancestry of `master`.
- [x] RB-07 — City / District / Demand Surface delivered through PR #76.
- [x] RB-08 — Community Feedback delivered through PR #77.
- [ ] RB-09 — Policy / Institutional Surface is implemented in PR #79 at `5e5a30182a085cd128691bf57d1da5a0c7697bdf`; exact-head Validate project #378 and Visual acceptance #22 succeeded, while Vercel remains `SOFT_GATE_RATE_LIMIT`, so guarded delivery is deferred.
- [ ] RB-10 — Archive / Research / Narrative UX is implemented in PR #81 at `c7ce8caf8b53afe7184715a5584a6149aca61ca0`; exact-head Validate project #387 and Visual acceptance #31 succeeded. Vercel remains `SOFT_GATE_RATE_LIMIT`, so guarded delivery is deferred.
- [ ] RB-11 — Save / Load / Campaign UX is implemented in stacked PR #83 on RB-10. Implementation head `24a39c844ae75dea4d6c392de17bbd8459735536` passed Validate project #393, including current-schema round-trip, v10 migration through the durable slot, corrupt-save handling, invalid-load atomicity and New Campaign slot preservation. Final docs/handoff persistence creates a newer head that requires fresh exact-head evidence. Vercel remains `SOFT_GATE_RATE_LIMIT`.
- [ ] RB-12 — Diorama Scene System implemented on `feat/rb-12-diorama-scene-system`, stacked on CENA-010 / PR #82; exact-head Validate #402 and Visual #46 succeeded, while Vercel remains `SOFT_GATE_RATE_LIMIT`.
- [ ] RB-13 — Visual Production Pass implemented in stacked PR #86 on CENA-011 / PR #84. Exact-head `c8d1315426ba806995455fe3be707bf8bea1b4e9` passed Validate project #412 and Visual acceptance #56, including isolated Web export and rendered evidence. T004-T009 are materially complete; final delivery remains guarded by the explicit Vercel `SOFT_GATE_RATE_LIMIT` and a final post-documentation exact-head check.
- [ ] RB-14 — Campaign Progression Revalidation implemented in stacked PR #88. Integrated RB-09/10/11 product surfaces with RB-12/13 ancestry; natural Ato I→pre-finale regression plus representative save/load round-trips passed on implementation head `061768b52f5aaf59253a13f661704bbf430009b9` in Validate #417, and Visual #61 succeeded. Result: **PASS**, with no campaign gate mutation required. Guarded delivery remains provider-gated.
- [ ] RB-15 — Resume Finale is implemented in stacked PR #89 on RB-14 / #88. The flow presents only eligible endings in neutral alphabetical order, preserves immutable selection, renders data-driven handoff/codas, completes `arc_da_lata` idempotently, and reuses save schema v11. Implementation head `f48f08620e4e27c12def360c394626a8c638a44f` passed Validate project #427; exact-head visual/post-documentation evidence remains required. Vercel remains the documented `SOFT_GATE_RATE_LIMIT`, so guarded delivery is deferred.
