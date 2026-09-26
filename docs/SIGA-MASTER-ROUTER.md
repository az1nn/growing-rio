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

- **CENA** owns visual direction and rendered acceptance.
- **3JS** owns Three.js scene implementation and renderer discipline.
- **LORE** owns narrative canon.
- **siga-concurrency** is a mandatory mutation/merge helper.

Specialists remain directly invocable, but SIGA owns cross-skill orchestration and repository delivery.

## Merge authority

SIGA may correct merge conflicts and merge automatically without another confirmation when required tests, checks and acceptance evidence are green for the exact current head, dependency order is valid and no unresolved semantic collision remains.

A merge must use expected-head protection when available and must be followed by default-branch verification. Real required gate failures block delivery. Provider rate limiting follows the repository's existing `SOFT_GATE_RATE_LIMIT` policy.

## Concurrency

Open PRs are not global locks. SIGA must scan for file/contract overlap, classify drift using `.agents/skills/siga-concurrency/SKILL.md`, and preserve concurrent compatible work. Competing implementations must be reconciled before delivery; green CI alone is not permission to merge two semantically competing candidates.

## User-facing command model

The normal command surface is now simply:

```text
Siga
```

SIGA reconstructs reality and chooses the required specialist(s). Users may still invoke `Cena`, `3js` or `Lore` directly when they intentionally want to enter that expert workflow.
