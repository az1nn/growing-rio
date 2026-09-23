# DA LATA Engineering Constitution

**Version:** 1.0.0  
**Ratified:** 2026-09-23  
**Project:** DA LATA (`az1nn/growing-rio`)

This constitution governs Spec-Driven Development in this repository. It records rules already enforced by the project and makes them explicit inputs to future specifications, plans, tasks and implementation.

## I. Repository Reality Is Authoritative

Every engineering session MUST reconcile the live repository before mutation: repository identity, default branch, exact working/base state, open pull requests, CI/checks, relevant specs, architecture docs and repo-local handoffs.

Trust order for engineering work:

```text
LIVE REPOSITORY / CI
> RATIFIED CONSTITUTION
> ACTIVE FEATURE SPEC + PLAN + TASKS
> REPOSITORY HANDOFFS / ARCHITECTURE / CANON
> CHAT OR MODEL MEMORY
```

Stale handoffs or conversation context MUST never override live GitHub/Git state.

## II. Feature Work Is Spec-First

A new product capability MUST have a bounded feature specification before implementation begins. The specification defines user value, functional requirements, acceptance scenarios, success criteria and explicit out-of-scope boundaries.

Implementation planning MUST then define the technical approach and concrete file-level task graph. Code changes MUST map back to those tasks.

Defect fixes may use a smaller bug-fix path when they restore already-specified behavior and do not introduce a new capability.

## III. Domain Logic Stays Deterministic and UI-Independent

Game rules belong behind domain services and `GameState` orchestration, not scene-specific UI code.

UI MAY render state and submit commands, but MUST NOT duplicate availability, progression, consequence, pricing, research, narrative, policy or persistence rules.

Existing deterministic systems MUST remain RNG-stable unless a specification explicitly introduces randomness and adds deterministic test coverage for it.

## IV. Persistence Changes Are Explicitly Versioned

Persistent canonical state changes MUST cross the versioned save boundary deliberately.

A feature that changes persisted shape MUST:
- justify a schema version change;
- provide migration behavior for supported older schemas;
- preserve stable content IDs rather than serializing Resource objects;
- add round-trip and migration regression coverage.

A feature that does not require new canonical state SHOULD reuse the existing schema.

## V. Canon, Fiction and Safety Boundaries Are Architectural Constraints

Narrative implementation MUST preserve the repository's `CÂNONE`, `RUMOR` and `ABERTO` distinctions and MUST NOT silently resolve protected uncertainty.

Cultivation remains abstract and non-operational. Parallel-market activity remains abstract risk/reward. Institutional/political gameplay remains fictional and systemic; no real politicians, parties, elections or targeted persuasion are modeled.

Historical inspiration MUST remain distinguishable from fictional canon.

## VI. Tests and Exact-Head Evidence Gate Completion

A feature is not complete because code exists. Completion requires repository-defined validation on the exact final implementation head.

At minimum:
- structural validation passes;
- relevant Godot headless regressions pass;
- new behavior has regression coverage;
- save migrations are tested when persistence changes;
- Web export/deployment is green when it is part of that feature's acceptance criteria.

If a PR head changes after a green run, evidence MUST be refreshed for the new head before merge.

## VII. Small Coherent Waves Over Broad Refactors

Prefer the smallest independently reviewable capability that moves the roadmap forward.

A feature wave SHOULD avoid unrelated refactors. Refactors are acceptable when they are necessary to satisfy the active spec and are covered by tests.

Spec, plan and task artifacts MUST be updated when scope materially changes rather than allowing implementation to drift silently.

## Governance

- Amendments require an explicit repository change with rationale.
- Breaking changes to these principles increment the major constitution version.
- New binding principles or materially expanded requirements increment the minor version.
- Clarifications that do not change obligations increment the patch version.
- SIGA MUST reconcile this constitution and active feature specs when choosing RESUME, WATCH or ADVANCE.
- `docs/lore/*` remains the semantic authority for DA LATA lore; this constitution governs engineering delivery, not narrative authorship.
