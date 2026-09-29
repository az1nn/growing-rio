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
- [x] Finale inspired by the cultural memory of the Verão da Lata — delivered through RB-15 / PR #89.


## Product re-baseline delivery
- [x] RB-01 — Product Experience Map delivered and merged.
- [x] RB-02 — Game Shell / Navigation delivered and merged.
- [x] RB-03 — Operation Management Surface is present on the reconciled default branch.
- [x] RB-04 — Rooms / Staff / Upgrades is present on the reconciled default branch.
- [x] RB-05 — Market / Contracts / Buyer Relationships is present on the reconciled default branch; older stacked PR #72 was superseded after its work became ancestry of `master`.
- [x] RB-06 — Compliance Experience is present on the reconciled default branch; older stacked PR #74 was superseded after its work became ancestry of `master`.
- [x] RB-07 — City / District / Demand Surface delivered through PR #76.
- [x] RB-08 — Community Feedback delivered through PR #77.
- [x] RB-09 — Policy / Institutional Surface delivered through PR #79 and present in current `master`.
- [x] RB-10 — Archive / Research / Narrative UX delivered through PR #81 and present in current `master`.
- [x] RB-11 — Save / Load / Campaign UX delivered through PR #83 and preserved through the reconciled stack into current `master`.
- [x] RB-12 — Diorama Scene System delivered through PR #85 and preserved through the reconciled visual stack into current `master`.
- [x] RB-13 — Visual Production Pass delivered through PR #86 and preserved in current `master`.
- [x] RB-14 — Campaign Progression Revalidation delivered through PR #88 with PASS/unfreeze preserved in current `master`.
- [x] RB-15 — Resume Finale delivered through PR #89. Final PR head `3e764849bbb81ea9dbe9a0c8b0f40219f2456b40` passed exact-head Validate and Visual acceptance; current `master@dbeacdf09abb76db5e4800c82109750ca9189223` contains that head, passes post-merge Validate and has Vercel SUCCESS.

## Re-baseline closure — 2026-09-25
- RB-01 through RB-15 are delivered in the reconciled default branch.
- The previous provider rate-limit backlog is no longer an active delivery blocker for this re-baseline.
- No post-RB-15 product capability is currently specified in this roadmap. Any new capability must begin with a bounded Spec Kit package before implementation.


## Post re-baseline continuation

- [x] Feature 009 — 365-Day Campaign Calendar & Abstract Plant Lifecycle: delivered and closed through the Feature 009 delivery/closure chain; tasks T001-T021 are complete.


- [x] Feature 010 — All scenes 3D and interactive: runtime delivered through PR #152; final all-scene structural/rendered certification closed by CENA-017 with Validate #818, Visual #369, artifact `11046242559`, Vercel SUCCESS, and closure PR #174 merged into current master.
