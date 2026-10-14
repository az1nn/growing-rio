# SIGA Master Orchestrator Contract

This repository treats `SIGA` as the default continuation command and repository-level delivery authority.

## Operating pipeline

```text
RECONCILE
  -> CLASSIFY (exactly RESUME, WATCH or ADVANCE)
  -> ROUTE
  -> EXECUTE
  -> VERIFY
  -> MERGE
  -> PERSIST
```

The canonical trust order remains:

```text
REAL / LIVE REPOSITORY STATE
> RATIFIED CONSTITUTION + ACTIVE SPEC
> REPOSITORY-LOCAL HANDOFFS / CANON / DOCS
> CHAT / MODEL MEMORY
```

## Specialist routing

SIGA selects repository-local skills from live evidence and the bounded task.

- **SIGA** owns orchestration, claims, internal concurrency, merge and delivery.
- **ARTIST** owns approved visual intent and human concept/runtime gates.
- **CENA** owns scene production, composition, provenance and asset integration.
- **GODOT** owns production renderer, runtime, export and engine integrity.
- **QA** owns automated structural/runtime regressions and test coverage.
- **LENTE** owns exact-head rendered screenshots, videos and visual observations.
- **LORE** owns narrative canon.
- **RELATORIO** owns deterministic REPORT_V1 presentation from verified facts.

The **only eight active entrypoints** are `.agents/skills/{siga,artist,cena,godot,qa,lente,lore,relatorio}/SKILL.md`. `docs/archive/skills/3js/SKILL.md` is historical, not routable. The SIGA concurrency protocol is an internal mandatory reference: `.agents/skills/siga/references/concurrency.md`.

Specialists remain directly invocable, but SIGA owns cross-skill orchestration and repository delivery.

## Merge authority

SIGA may correct merge conflicts and merge automatically without another confirmation when required tests, checks and acceptance evidence are green for the exact current head, dependency order is valid and no unresolved semantic collision remains.

A merge must use expected-head protection when available and must be followed by default-branch verification. Real required gate failures block delivery. Provider rate limiting follows the repository's existing `SOFT_GATE_RATE_LIMIT` policy.

## Concurrency

Open PRs are not global locks. SIGA must scan for file/contract overlap, classify drift using `.agents/skills/siga/references/concurrency.md`, and preserve concurrent compatible work. Competing implementations must be reconciled before delivery; green CI alone is not permission to merge two semantically competing candidates.

## User-facing command model

The normal command surface is now simply:

```text
Siga
```

SIGA reconstructs reality and chooses the required specialist(s). Users may still invoke active specialists (`Artist`, `Cena`, `Godot`, `QA`, `Lente`, `Lore`, `Relatorio`) directly. Historical `3js` commands are retired for V1 and route to GODOT only after SIGA verifies the current approved runtime.
