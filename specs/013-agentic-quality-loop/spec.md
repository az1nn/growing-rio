# Feature 013 — Agentic Quality Loop

**Status:** PLANNED — queued after Feature 012 R16 PASS  
**Owner:** SIGA  
**Execution authority:** `docs/ROADMAP.md` + this Spec Kit package  
**Runtime architecture:** unchanged; `GODOT_NATIVE_V1` remains authoritative until explicitly superseded by a later architecture decision

## Problem

DA LATA already has strong specialist boundaries (SIGA, ARTIST, CENA, GODOT, LENTE, QA, LORE), exact-head delivery rules and visual/runtime evidence. The next engineering maturity gap is not more agents; it is a more adversarial and measurable quality loop.

Current risks include:

- a builder implicitly judging its own work;
- visual review over too few runtime states;
- a green gate that has never been proven to fail on a known-bad mutation;
- regressions hidden by a net visual improvement;
- architecture/ownership knowledge reconstructed manually every session;
- browser/Web interaction coverage lagging behind structural/headless coverage;
- asset/provenance/performance evidence distributed across multiple surfaces.

Feature 013 institutionalizes an engine-agnostic quality loop around the existing DA LATA authority model without replacing SIGA or changing gameplay semantics.

## User scenarios

### US-1 — Builder and critic are independent
As the developer running SIGA, I want implementation and criticism to use separate contexts so that the system can reject plausible-but-wrong work instead of rationalizing its own changes.

### US-2 — Every measurable guard can prove it bites
As the maintainer of QA, I want new quality rules to demonstrate GOOD -> PASS, deliberate BAD MUTANT -> FAIL, RESTORE -> PASS so that green gates are evidence rather than decoration.

### US-3 — A scene is reviewed across relevant states
As ARTIST/CENA/LENTE, I want a deterministic scene-state matrix across the supported portrait targets so that visual acceptance is not based on one flattering screenshot.

### US-4 — Regressions are hunted explicitly
As SIGA, I want a dedicated regression pass comparing baseline and candidate so that improvements cannot hide interaction, framing, accessibility or runtime regressions.

### US-5 — Ownership and impact are queryable
As SIGA, I want a generated architecture/ownership surface so that task routing and concurrency checks are derived from repository state rather than memory.

### US-6 — Real Web interaction is verified
As QA, I want browser E2E against the exact-head Godot Web export so that player-visible navigation/hotspot/overlay behavior is proven through real input.

## Functional requirements

- **FR-001 — SIGA remains master:** Feature 013 MUST NOT create a second master orchestrator. SIGA retains repository identity, roadmap, concurrency, verification, merge and delivery authority.
- **FR-002 — Gauntlet specialist:** the repository MUST gain a bounded engine-agnostic Gauntlet workflow that SIGA may route for quality-sensitive work.
- **FR-003 — context separation:** the builder MUST NOT be the sole authority that scores or accepts its own output. Fresh critic input MUST exclude builder rationale unless the review explicitly requires implementation details after the initial observation.
- **FR-004 — evidence loop:** a quality-sensitive Gauntlet round MUST support baseline -> builder candidate -> runtime capture -> fresh critique -> QA/rules -> A/B comparison -> regression hunter -> acceptance/next action.
- **FR-005 — exact-head identity:** all automated/captured evidence used for completion MUST record repository, branch/ref where applicable and exact commit SHA.
- **FR-006 — scene-state matrix:** player-facing scene review MUST support a deterministic matrix of relevant runtime state × viewport × UI state. The canonical portrait targets are 540×960 and 1080×1920 unless a later product contract changes them.
- **FR-007 — state relevance:** a matrix MUST include only states relevant to the surface contract; it MUST NOT create fake states solely to increase coverage counts.
- **FR-008 — mutation doctrine:** every new blocking measurable QA rule introduced by Feature 013 MUST have a documented mutation proof or an explicit justification for why mutation is technically impossible or disproportionately destructive.
- **FR-009 — fail explicit:** inability to measure MUST NOT silently become PASS. The result MUST distinguish PASS, FAIL, SKIP/UNAVAILABLE or BLOCKED with a reason.
- **FR-010 — regression hunter:** every completed Gauntlet round MUST explicitly report regressions as `NONE` or enumerate them with evidence.
- **FR-011 — human visual authority:** automated scores/diffs MAY flag drift but MUST NOT replace ARTIST/CENA human acceptance for aesthetics or product art direction.
- **FR-012 — generated ownership:** repository architecture/ownership documentation introduced by this feature MUST be generated from repository-observable sources and fail a freshness check when stale.
- **FR-013 — concurrency integration:** generated ownership/impact data MUST complement, not bypass, `siga-concurrency` claim/overlap rules.
- **FR-014 — real Web E2E:** browser E2E introduced by this feature MUST execute against the exact-head Godot Web export rather than a mocked replacement page.
- **FR-015 — real input:** browser E2E MUST prove at least one real player input path for each covered surface, including expected visible/state feedback and console/page-error checks.
- **FR-016 — asset/evidence ledger:** relevant production surfaces MUST be able to record asset source/provenance/license/local path/modifications/quality tier plus measured technical-art/runtime evidence when available.
- **FR-017 — no invented metrics:** technical-art evidence MUST report only measured values. Unknown frame time, memory, asset cost or interaction latency MUST remain unknown until instrumented.
- **FR-018 — Graphify is optional:** a graph-index pilot MAY be evaluated only after canonical generated ownership exists. It MUST remain derived/query assistance, never repository authority.
- **FR-019 — no renderer reversal:** this feature MUST NOT reactivate frozen Three.js production or change `GODOT_NATIVE_V1` merely because external reference workflows use Three.js.
- **FR-020 — no gameplay drift:** the feature MUST NOT change economy, progression, cultivation, policy, narrative, persistence or balance semantics except for a separately specified defect/capability.
- **FR-021 — single roadmap:** no Feature-013-specific SIGA roadmap file will be created. Feature ordering is registered in `docs/ROADMAP.md`; dependency-ordered implementation work lives in `tasks.md`.
- **FR-022 — SIGA execution:** after Feature 012 R16 PASS, SIGA MUST implement Feature 013 in task order, using dedicated claims/PRs and exact-head verification.
- **FR-023 — stop conditions:** a Gauntlet round MUST stop or escalate when acceptance is reached, a human/product decision is required, the same measurable class fails to improve for two consecutive rounds without a new strategy, or continuing would violate an architecture/roadmap fence.
- **FR-024 — bounded artifacts:** large screenshots/contact sheets/logs MUST live as repository/workflow artifacts or bounded files; chat/handoffs should persist paths, hashes, verdicts and next action rather than raw payload dumps.

## Acceptance scenarios

1. A bounded historical scene fixture is run through the Gauntlet with separate builder and fresh critic roles; the final report proves exact-head identity and contains an explicit regression verdict.
2. A new QA invariant passes on known-good state, fails after a deliberate mutation, and passes again after restoration.
3. A player-facing scene produces a deterministic state matrix for both portrait targets and can identify which exact state/viewport regressed.
4. A candidate that improves visual fidelity but breaks an existing hotspot or safe area is not accepted because the regression hunter reports the regression.
5. Generated ownership documentation changes when its source contracts change, and the freshness check fails when the generated file is stale.
6. Browser E2E boots the exact-head Godot Web export, performs real input on a semantic hotspot/fallback, observes the expected UI effect, returns/backs out and records no unexpected page/console error.
7. A surface ledger can trace production assets and measured runtime evidence without inventing unavailable performance data.
8. The Graphify pilot, if executed, can be removed with no loss of canonical authority or required evidence.

## Success criteria

- **SC-001:** one complete Gauntlet pilot closes with baseline, candidate, fresh critique, A/B and explicit regression verdict.
- **SC-002:** at least three representative QA rules have mutation proofs: one interaction/accessibility rule, one structural rule and one Web/export rule.
- **SC-003:** at least one production scene has a repeatable multi-state × two-viewport evidence matrix.
- **SC-004:** generated architecture/ownership data covers all canonical player-facing surfaces and participating specialist ownership needed by SIGA.
- **SC-005:** Web E2E proves one real interaction path for Operation, Market, City, Institutional and Archive, or records a specific repository-backed blocker for any surface not yet automatable.
- **SC-006:** all Feature 013 changes pass canonical exact-head validation; no product/save/canon semantics change as an incidental side effect.
- **SC-007:** completion documentation identifies whether the Graphify pilot is ADOPTED or REJECTED based on measured workflow value, with no ambiguous permanent dependency.

## Dependencies

- Feature 012 R16 MUST be PASS before Feature 013 implementation starts.
- Existing SIGA, `siga-concurrency`, QA, LENTE, ARTIST/CENA and Godot Web export flows remain inputs.
- Existing semantic hotspot identifiers from Feature 011 are reused; Feature 013 does not redefine their product semantics.

## Out of scope

- changing the V1 art direction;
- switching production renderer/engine;
- copying FPS/viewmodel-specific tooling from external references;
- making automated visual scores an art-acceptance authority;
- introducing gameplay, economy, narrative, political or cultivation mechanics;
- save schema changes;
- requiring paid/external generators for completion;
- broad repository refactors unrelated to evidence, orchestration or quality automation.
