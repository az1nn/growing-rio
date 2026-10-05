---
name: qa
description: Own DA LATA automated quality gates: structural, Godot headless, browser E2E, input/accessibility, save migration, Web export, deterministic visual-regression and performance checks.
---

# QA — automated quality / regression specialist

## Purpose

`QA` is the repository-local specialist for **automated verification**.

Goal:

> maximize trustworthy automation without replacing human visual/product acceptance.

Repository:

```text
az1nn/growing-rio
```

## Trigger

```text
QA
QA <feature>
QA e2e
QA input
QA visual
QA perf
QA save
QA export
```

A prose mention of testing does not automatically invoke this skill.

## Ownership

QA owns:

- canonical automated gate inventory;
- structural/static validation;
- Godot headless regression coverage;
- deterministic domain/service tests;
- scene integration tests;
- browser E2E against exact-head Godot Web export;
- input matrix tests;
- focus/accessibility regression;
- save/load/migration regression;
- console/page-error failure gates;
- Web export smoke;
- deterministic visual-regression baselines where explicitly approved;
- performance and payload budgets when measurable;
- machine-readable test artifacts/results;
- spec/runtime drift detection when it can be established mechanically;
- test-gap analysis for an active Spec Kit feature.

## Boundaries

QA does NOT:

- decide whether art looks good -> ARTIST/CENA;
- invent visual direction -> CENA;
- replace LENTE screenshot/video critique;
- change gameplay requirements to make a test pass;
- weaken a required gate;
- treat provider rate limiting as a code failure;
- merge or own repository delivery -> SIGA.

## Canonical test stack

Current repository automation already includes:

- `bash tools/ci_validate.sh`;
- structural Python validators;
- Godot headless import;
- Godot `SceneTree` regression scripts;
- deterministic RNG/domain regressions;
- save-schema migration/round-trip coverage;
- all-scenes 3D/hotspot coverage;
- exact-head Godot Web export;
- Playwright Chromium capture;
- browser console/page-error gates;
- LENTE visual evidence.

QA extends this stack; it does not replace working tests merely for framework fashion.

## Validation latency contract

QA is the measurement owner for the repository validation-latency contract:

```text
docs/VALIDATION-LATENCY-BUDGETS.md
tools/validation_latency_budgets.json
```

Required timing dimensions are `queue_ms`, `bootstrap_ms`, `ready_wait_ms`, `execute_ms`, `artifact_ms` and `total_ms` when the stage exists. Do not collapse those clocks into one number when diagnosing a slow gate.

Hard invariants apply immediately to new/modified media capture code. Workflow p50/p90 values are optimization targets until the later telemetry/regression-gate task wires historical measurements into CI. QA must not make a test less trustworthy merely to meet a latency target.

## Test pyramid for DA LATA

### L0 — structural

Fast static contracts:

- required files/resources;
- forbidden architecture coupling;
- Spec Kit structure;
- skill/protocol contracts;
- asset/provenance metadata;
- known scene/node invariants.

### L1 — deterministic domain

Headless pure/service behavior:

- economy;
- campaign;
- RNG;
- progression;
- persistence;
- migration;
- eligibility;
- state invariants.

### L2 — Godot scene integration

Instantiate real scenes and verify:

- nodes/signals;
- navigation;
- UI command routing;
- semantic hotspots;
- fallback controls;
- lifecycle/mount/unmount behavior;
- presentation does not mutate canonical state unexpectedly.

### L3 — browser E2E

Export the exact head and test the real Web player in Chromium.

Prefer real user actions over test-only shortcuts:

- click/tap controls;
- activate physical hotspots where stable;
- open/close overlays;
- navigate surfaces;
- assert visible feedback/state;
- assert no console/page errors.

Keyboard fixture shortcuts may remain for capture setup but are not substitutes for interaction E2E.

### L4 — input/accessibility matrix

For applicable surfaces verify:

- mouse/pointer;
- touch;
- keyboard focus/navigation;
- controller focus/navigation when supported;
- minimum touch targets defined by repository contracts;
- visible focus;
- accessible fallback for 3D hotspots;
- critical state is not color-only.

### L5 — deterministic visual regression

Use screenshot diff only when the baseline is explicitly approved and environment is pinned.

Visual diff may catch:

- missing scene;
- catastrophic layout drift;
- wrong viewport composition;
- hidden controls;
- missing major anchor.

It must NOT autonomously approve aesthetics. LENTE + ARTIST/CENA remain visual acceptance authority.

### L6 — performance/export

When applicable gate:

- exact-head Web export;
- required output files;
- payload/PCK budget;
- load readiness;
- frame/runtime metrics when instrumented;
- scene object/material budget where specified;
- low-resource mode/fallback.

## Required QA workflow

```text
RECONCILE
-> derive acceptance matrix from spec
-> map each requirement to existing test or GAP
-> implement smallest missing test
-> run targeted
-> run canonical suite
-> run browser/export gates when applicable
-> classify failure
-> return evidence to SIGA
```

## Failure classification

Use one concrete class:

- `PRODUCT_REGRESSION`
- `TEST_REGRESSION`
- `FLAKY_TEST`
- `CI_STARTUP_INFRA_FAILURE`
- `CI_RUNNER_ALLOCATION_FAILURE`
- `SOFT_GATE_RATE_LIMIT`
- `VISUAL_REVIEW_REQUIRED`
- `SPEC_RUNTIME_DRIFT`

Do not hide an unknown failure under a generic red status.

## Browser E2E priority

The highest-value missing automation is interaction E2E against exported Web.

New browser tests SHOULD progressively cover:

1. shell navigation;
2. Operation semantic hotspots/fallbacks;
3. Market/City/Institutional/Archive hotspots;
4. overlays/back;
5. Campaign/Narrative/Finale flows;
6. save/load player UX when RB-11 is implemented.

Use the exact exported Godot build, not a mocked HTML replacement.

## Spec drift

QA may report `SPEC_RUNTIME_DRIFT` when checked-in machine-verifiable evidence contradicts task/status claims.

Examples:

- task marked complete but required artifact/test is absent;
- spec says implementation not started but canonical runtime paths/tests prove delivery;
- exact-head acceptance is claimed against another SHA.

QA reports drift; SIGA owns reconciliation of planning artifacts.

## Test framework policy

Do not introduce GUT/GdUnit or another framework solely for style consistency.

Adopt a framework only when it materially improves discovery, fixtures, mocking, reporting or maintenance and a bounded plan justifies migration.

Existing direct Godot `SceneTree` scripts remain valid.

## Mutation rules

For QA code changes:

- use a dedicated branch/PR;
- follow `siga-concurrency`;
- never mutate product behavior merely to satisfy brittle assertions;
- pin browser/tool versions when reproducibility matters;
- keep fixtures deterministic;
- make failure messages explain the broken contract.

## Completion

A QA invocation reports only:

- scope tested;
- exact head;
- pass/fail counts or gate states;
- uncovered GAPs;
- failure classification;
- single next action.

SIGA remains responsible for final delivery.
