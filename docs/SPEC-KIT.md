# Spec Kit in DA LATA

DA LATA adopts GitHub Spec Kit incrementally for feature delivery.

## Why it fits this repository

The project already uses small reviewable waves, deterministic domain boundaries, exact-head CI gates, repository-local SIGA/LORE handoffs and strong canon constraints. Spec Kit adds a durable feature contract between roadmap intent and implementation without replacing those systems.

The division of responsibility is:

- **Constitution** — non-negotiable engineering rules.
- **Feature spec** — what/why and acceptance behavior.
- **Plan** — technical design for the feature.
- **Tasks** — dependency-ordered implementation work.
- **SIGA** — reconciles real repository state and resumes/watches/advances delivery.
- **LORE** — owns narrative canon work and remains separate from engineering orchestration.

## Repository layout

```text
.specify/
  memory/
    constitution.md

specs/
  NNN-feature-name/
    spec.md
    plan.md
    tasks.md
    checklists/
      requirements.md
```

`.specify/feature.json` is machine-local active-feature state and MUST NOT be committed.

## First Spec Kit feature

The first bounded feature is:

```text
specs/001-research-presentation/
```

It captures the next verified V0.5 milestone: a playable research presentation surface over the existing deterministic research chain.

## Delivery workflow

For normal feature work:

```text
constitution (project-level, infrequent)
-> specify
-> clarify when materially ambiguous
-> plan
-> checklist
-> tasks
-> analyze for cross-artifact consistency when useful
-> implement
-> converge
-> exact-head CI
-> merge
-> SIGA handoff
```

The short path is appropriate for small, low-ambiguity slices; the full quality-gate path is preferred for state/persistence/architecture changes.

## Official CLI bootstrap

The durable project-specific artifacts are committed first so they remain reviewable. To materialize the current Spec Kit-managed templates/scripts and Codex skills on a clean branch, run from the repository root:

```bash
uv tool install specify-cli
specify init --here --force --non-interactive --integration codex --script py
```

Then review the generated diff before merge.

The official initializer is intentionally the source for vendor-managed Spec Kit files. Do not hand-copy generated command/skill/template infrastructure into this repository.

Current Spec Kit behavior preserves an existing `.specify/memory/constitution.md` and does not overwrite `specs/` during initialization/upgrades.

## Codex invocation

With the Codex integration installed, Spec Kit skills are exposed under `.agents/skills/speckit-*/SKILL.md` and are invoked using the Codex skill form, for example:

```text
$speckit-specify
$speckit-plan
$speckit-tasks
$speckit-implement
$speckit-converge
```

SIGA remains the higher-level continuation router for this repository. Spec Kit does not replace SIGA; SIGA uses the active spec artifacts as part of its evidence set.
