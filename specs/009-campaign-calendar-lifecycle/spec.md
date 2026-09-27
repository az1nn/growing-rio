# Feature Specification: 365-Day Campaign Calendar & Abstract Plant Lifecycle

**Feature:** 009-campaign-calendar-lifecycle  
**Status:** SPECIFIED — lore dependency delivered; balance contract is the next implementation prerequisite  
**Roadmap:** Post re-baseline capability  
**Created:** 2026-09-27  
**Canonical dependency:** `docs/lore/CAMPAIGN-CALENDAR.md`, delivered to `master` by PR #123

## Overview

Replace the prototype's 30-day campaign / 8-day crop timing with the canonical DA LATA time model: one campaign spans exactly **365 in-game days**, while each individual plant cycle spans exactly **90 in-game days** and progresses through the abstract game states:

`seedling → Vega → flora → late flowering → pronta`.

This feature makes that temporal contract executable while preserving DA LATA's safety boundary: lifecycle states are game abstractions, not real cultivation instructions.

The feature also protects balance: reaching intermediate lifecycle states does not create extra harvests or multiply final yield. A batch becomes harvestable only when it reaches `pronta`.

## User Scenarios

### Scenario 1 — A campaign uses the full 365-day year

**Given** a new campaign starts on Day 1  
**When** the player advances time normally  
**Then** Day 365 remains part of the playable campaign  
**And** attempting to advance beyond the end of Day 365 closes/locks the campaign under the existing game-over boundary.

### Scenario 2 — A plant cycle lasts 90 in-game days

**Given** an active room starts a fresh plant cycle at `grow_day = 0`  
**When** fewer than 90 growth-day advances have completed  
**Then** the plant is not `pronta`  
**And** harvest remains unavailable.

**When** the 90th growth-day advance completes  
**Then** the lifecycle state becomes `pronta`  
**And** harvest may become available subject to the existing inventory/game-state rules.

### Scenario 3 — Lifecycle stages are deterministic and ordered

**Given** a plant cycle is active  
**When** the game derives its current lifecycle stage  
**Then** the result is exactly one of `seedling`, `Vega`, `flora`, `late flowering`, or `pronta`  
**And** stage progression never moves backward during the same uninterrupted cycle  
**And** `pronta` is terminal until harvest/reset.

The exact internal day boundaries of the four pre-`pronta` stages are balance-owned configuration. This feature MUST NOT derive those boundaries from real-world horticultural guidance.

### Scenario 4 — Yield remains cycle-normalized

**Given** two otherwise equivalent completed cycles both reach `pronta`  
**When** their abstract stage boundary configuration differs while preserving a 90-day total  
**Then** stage timing alone does not grant extra harvest events or multiplicative yield.

### Scenario 5 — Four serial cycles fit the year, with five closure days

**Given** a cycle begins at the start of the campaign  
**And** each next cycle starts immediately after the previous one closes  
**When** four complete 90-day cycles are executed serially  
**Then** they consume 360 in-game days  
**And** five campaign days remain before the Day-365 boundary.

### Scenario 6 — Existing saves remain structurally loadable

**Given** an existing supported save already persists campaign `day` and per-room `grow_day`  
**When** this feature is introduced  
**Then** no new canonical persisted field is required solely to derive lifecycle stage  
**And** existing supported schema migration behavior remains intact.

## Functional Requirements

- **FR-001** The campaign day limit MUST change from the prototype value 30 to exactly 365.
- **FR-002** Day 365 MUST be the final playable in-game day; the campaign MUST NOT silently continue to Day 366.
- **FR-003** The canonical plant cycle duration MUST be exactly 90 in-game growth days.
- **FR-004** The shipped `Quarto Clássica` definition MUST conform to the 90-day cycle.
- **FR-005** Runtime lifecycle state MUST use exactly these stable IDs/labels in order: `seedling`, `Vega`, `flora`, `late flowering`, `pronta`.
- **FR-006** `pronta` MUST be reached only at completion of the 90-day cycle and MUST remain the terminal pre-harvest state.
- **FR-007** Harvest MUST remain unavailable before `pronta`.
- **FR-008** Lifecycle-stage derivation MUST be deterministic and RNG-free.
- **FR-009** The four pre-`pronta` stage boundaries MUST be represented as explicit game-balance configuration and MUST preserve monotonic order plus a 90-day total.
- **FR-010** This specification does NOT choose the exact pre-`pronta` day split; that balance decision must be made explicitly in repository state before implementation closes.
- **FR-011** Stage boundaries MUST NOT be justified using real cultivation instructions, recipes, environmental parameters, feeding schedules or other operational horticultural guidance.
- **FR-012** Stage transitions MUST NOT independently award inventory or additional harvest yield.
- **FR-013** Existing health/quality/yield systems MAY still affect the one final harvest according to their existing abstract mechanics, but stage timing alone MUST NOT multiply output.
- **FR-014** Lifecycle state SHOULD be derived from existing per-room `grow_day` plus balance configuration rather than adding redundant canonical persisted state.
- **FR-015** Changing the campaign/calendar duration alone MUST NOT introduce a save-schema bump if no persisted shape changes.
- **FR-016** Existing v1-v11 save support and deterministic simulation behavior MUST remain covered by regression tests.
- **FR-017** Multi-room cultivation MUST derive lifecycle stage independently per room from that room's canonical cultivation state.
- **FR-018** A new regression MUST cover Day 365 closure, 90-day readiness, stage-order invariants, early-harvest rejection, serial 4×90 arithmetic, RNG stability and supported save loading.
- **FR-019** Structural validation and Godot headless tests MUST pass on the exact final implementation head.
- **FR-020** Web/Vercel delivery MUST be green for the exact final head when required by repository policy.
- **FR-021** UI redesign, new crop-science mechanics, real cultivation simulation and exact act-to-day scheduling are out of scope.

## Success Criteria

- **SC-001** A fresh campaign no longer ends after 30 days and closes at the 365-day boundary.
- **SC-002** `Quarto Clássica` cannot become harvest-ready before 90 growth-day advances.
- **SC-003** The lifecycle API always returns one valid ordered stage and reaches `pronta` at cycle completion.
- **SC-004** Early harvest requests remain rejected.
- **SC-005** Stage transitions consume no RNG and create no inventory by themselves.
- **SC-006** Four serial complete cycles account for exactly 360 growth days, leaving five campaign days in the 365-day year.
- **SC-007** Existing save schemas remain loadable without introducing redundant persisted lifecycle-stage state.
- **SC-008** Existing economy, business, city, narrative, ending and save regressions remain green.
- **SC-009** Exact-head CI and required deployment evidence are green before guarded merge.

## Out of Scope

- Exact day allocation among `seedling`, `Vega`, `flora` and `late flowering`.
- Real-world cultivation parameters or recommendations.
- New environmental simulation, feeding, lighting, irrigation or chemistry systems.
- New yield formulas unrelated to preserving cycle normalization.
- New plant genetics systems.
- Exact calendar placement of Acts II–V.
- UI/Three.js visual redesign for lifecycle states.
