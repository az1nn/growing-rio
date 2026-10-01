# Product Revalidation — Multi-Year Progression & Legalization Pivot

**Feature context:** 009-campaign-calendar-lifecycle  
**Date:** 2026-10-01  
**Status:** ACCEPTED PRODUCT DECISIONS — DOCUMENTATION ONLY  
**Runtime impact:** NONE in this record  
**Roadmap fence:** Feature 012 / R04 remains the active delivery gate. No successor implementation or numbered successor spec is opened by this document.

## Purpose

This record formalizes product decisions accepted during a Spec Kit grilling session after Feature 009 had already been delivered.

Feature 009 historically implemented a 365-day campaign that closes after Day 365. The accepted product direction now changes the meaning of that boundary:

> **Day 365 of Year 1 is the legalization transition, not the permanent end of play.**

The game is intended to continue year after year. The existing runtime remains valid historical delivery evidence until a future authorized feature implements the revalidated contract.

## Supersession boundary

The following parts of the delivered Feature 009 contract are now **historical runtime semantics, not the desired future product semantics**:

- User Scenario 1: campaign closes after Day 365;
- FR-002: Day 365 as final playable day with no continuation into Day 366;
- SC-001: campaign closes at the 365-day boundary;
- implementation/test language that treats Day 366 as permanent campaign closure.

Everything else in Feature 009 remains valid unless separately revalidated, including:

- 90-day abstract plant lifecycle;
- stage order and balance ownership;
- deterministic/RNG-free stage derivation;
- no inventory on stage transition;
- persistence discipline;
- multi-room independent lifecycle derivation;
- safety boundary against real cultivation instruction.

No runtime code is changed by this documentation record.

## Accepted product contract

### PR-001 — Multi-year continuity

A campaign is not one 365-day run. Time is organized into consecutive 365-day years.

Day 365 closes a **year**, not the entire player career.

### PR-002 — Year-1 world transition

Year 1 begins in a pre-legalization context.

**Legalization occurs on Day 365 of Year 1.**

This event is a structural world transition and must eventually unlock or alter post-legalization systems rather than acting as a generic game-over boundary.

Exact narrative presentation, advance semantics and save-boundary behavior remain to be specified.

### PR-003 — Starting fantasy

The player begins as a small PC grower with **one plant of mysterious genetics**.

The first major financial objective is improving the grow infrastructure.

The starting plant's origin, recoverability and long-term narrative role remain open LORE questions.

### PR-004 — Core short-session loop

The intended short-session core is cultivation/care + objectives/challenges + consequences/recovery + economic progression.

DA LATA is not primarily a passive business dashboard.

### PR-005 — Failure model

Cultivation and financial failures may be severe. Plants/crops and capital can be meaningfully lost.

The campaign uses **soft failure**, not a hard permanent game-over as the default consequence model.

### PR-006 — Agronomist recovery sink

A paid agronomist consultation is the accepted recovery mechanic for severe cultivation problems.

The consultation charges the player and resolves the diagnosed issue automatically at the current product-concept level. It is a costly recovery path, not a free undo.

### PR-007 — Visible economy

Money is the only primary macro resource explicitly surfaced as a player-facing currency/stat.

Other progression dimensions may exist in domain state, but should primarily communicate themselves through bonuses, event eligibility, opportunities, pricing effects, NPC/world reactions, access and ending/status eligibility. They should not automatically become HUD bars.

### PR-008 — Financing

Loans/financing are part of the economy. Detailed accounting simulation is not the target; financial values should remain game-readable and simplified.

### PR-009 — Multiple sales channels

Production may be sold through multiple variable channels. No single fixed buyer/channel is intended to own the entire economy.

### PR-010 — Dynamic market

The market responds to supply, demand and events. Exact simulation depth and volatility remain balance work, but fixed invariant pricing is not the desired model.

### PR-011 — Genetics as strategic asset

Genetics are more than production inputs. Player-developed genetics may become named commercial assets/brands and attract interest from buyers, partners or companies in ways analogous to real commercial brand/genetics dynamics while remaining fictionalized and game-safe.

### PR-012 — Breeding boundary

Breeding/crossing systems are **post-V1**. The V1 must not depend on breeding to satisfy its core progression fantasy.

### PR-013 — Employees boundary

Employees are not required in V1. Existing historical staff/domain systems do not force employee management into this newly accepted V1 product direction.

### PR-014 — Physical expansion boundary

Multiple properties/business locations are post-V1. V1 may establish the economic and narrative foundation for later expansion without implementing a property empire.

### PR-015 — Alternative income: artists

Artist investment is an intended progressive business/culture system that may combine production funding, financial return, sponsorship, cultural reputation and later collective/label-like structures.

Exact mechanics remain future specification work.

### PR-016 — Alternative income: merch

Merch is an intended alternative revenue stream with real production/inventory economics rather than cosmetic-only flavor.

Exact supply, inventory and sales rules remain future specification work.

### PR-017 — Urban culture changes the world

Pixo/graffiti/urban art is not merely visual decoration. Cultural actions and artists may visibly change the world and influence market/reputation/opportunity state.

Exact causality and content boundaries remain future specification work.

### PR-018 — Simplified realism

The game is inspired by real cultivation/business dynamics but intentionally simplified. Gameplay must not require operational real-world cultivation knowledge to succeed.

### PR-019 — Professionalization arc

The player begins small/informal and can progressively professionalize. The Day-365 legalization transition is the key structural point after which formal business systems may become available.

### PR-020 — Multi-axis legitimacy

Long-term recognition as the "rei da planta do RJ" requires success across multiple dimensions rather than wealth alone.

At minimum, the intended recognition axes are business/market success, genetics/grower recognition, street/cultural influence and patients/community/positive social legitimacy.

No single axis alone is sufficient. The exact hidden state model is not yet approved.

### PR-021 — Capital is necessary but insufficient

Money enables scale, resilience and investment, but must not directly purchase the highest-status outcome by itself.

The game should permit economically successful states that are not equivalent to full cultural/community legitimacy.

### PR-022 — Long-form North Star

> Start as a small grower, develop exceptional genetics, survive technical/economic risk, build businesses and cultural influence, and become an important figure in the fictional Rio cannabis culture while helping shift the world's view from historical stigma toward legitimate cultural, medicinal and therapeutic recognition.

This is a product North Star, not a numeric victory formula.

## Explicitly unresolved — do not invent

The following remain open from the grilling session and MUST NOT be silently decided by implementation:

1. origin of the mysterious starting genetics;
2. whether the first plant/genetics can be permanently lost;
3. whether the genetics-origin mystery is a side arc, Year-1 arc or multi-year arc;
4. exact pre-legalization sales representation;
5. exact pre-legalization risk model;
6. whether legalization is known in advance or emerges progressively;
7. exact Day-365 transition UX and state machine;
8. licensing/formalization flow after legalization;
9. player/company/brand naming model;
10. exact Year-2 system introduction order;
11. persistence and simulation depth of competitor companies;
12. whether "rei da planta do RJ" is explicit, implicit or systemic-only;
13. exact hidden stat taxonomy;
14. decay rules for hidden stats;
15. exact alternate ending/state for a rich but culturally disconnected player.

These correspond to Round 3 / Q26-Q40 in docs/SPEC-KIT-GRILLING-2026-10-01.md.

## Future decomposition — names only, no successor feature opened

When the active Feature 012/R04 roadmap fence allows successor specification, the accepted contract should be decomposed into bounded future specs rather than implemented as one monolith.

Candidate slices:

- multi-year calendar + Year-1 legalization transition;
- mysterious-genetics LORE/product contract;
- hidden legitimacy/progression state model;
- dynamic market + variable sales channels;
- loans + agronomist soft-fail recovery;
- genetics commercialization;
- artist investment;
- merch production/inventory;
- post-legalization professionalization;
- post-V1 breeding/property expansion.

These are **decomposition candidates only**. They have no permanent feature numbers, no implementation authorization and no priority over the current strict-sequential roadmap.

## Acceptance constraints for the future implementation feature

A future authorized implementation that replaces the delivered Year-1 closure behavior must prove at minimum:

- Day 365 of Year 1 is handled as the legalization/year-transition boundary;
- the player can continue into a subsequent year;
- the 90-day plant lifecycle remains deterministic and independent of year transition;
- existing save compatibility is either preserved or explicitly migrated;
- the transition is idempotent under save/load;
- no hidden progression dimension is accidentally exposed as a mandatory HUD currency;
- hard game-over is not introduced merely because the player experiences a severe crop/economic failure;
- exact-head validation covers the new year-boundary semantics.

## Traceability

Source checkpoint: docs/SPEC-KIT-GRILLING-2026-10-01.md.

This record formalizes only decisions already accepted in the grilling session. It intentionally leaves Round 3 questions unresolved.
