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
- [ ] RB-10 — Archive / Research / Narrative UX is implemented in PR #81. The implementation head `ec783dfb7be6a8c5ca01987a57950d5e90c45b5c` passed Validate project #382; Web export then refreshed the branch to `2da54d688e09396c7ef94eedf5ea2b180c44ab1b`. Final persistence creates a newer head that must receive fresh exact-head evidence before any delivery claim. Vercel remains `SOFT_GATE_RATE_LIMIT`.
- [ ] RB-11 — Save / Load / Campaign UX is the next bounded product implementation after RB-10 repository validation.
- [ ] RB-12 — Diorama Scene System.
- [ ] RB-13 — Visual Production Pass.
- [ ] RB-14 — Campaign Progression Revalidation; finale expansion remains frozen until this RB records PASS/unfreeze.
- [ ] RB-15 — Resume Finale, only after RB-14 explicitly unfreezes it.
