---
name: relatorio
description: Generate a live repository status report in strict CAVEMAN mode: short, decision-oriented, and limited to active work, gates, blockers, and the next action.
---

# RELATORIO — CAVEMAN repository status

## Purpose

`RELATORIO` is the repository-local status-report skill for **DA LATA / az1nn/growing-rio**.

Its only job is to answer repository-status questions with the minimum verified information needed to continue development.

It MUST prefer live repository state over chat history.

## Trigger

Treat these as RELATORIO requests, case-insensitive:

- `relatorio`
- `relatório`
- `relatorio do repositorio`
- `relatório do repositório`
- `gere um relatório do repositório`
- equivalent requests whose primary intent is repository status

A request for a deep audit, architecture document, changelog, postmortem, or historical analysis is not automatically a RELATORIO request.

## Repository lock

Canonical repository:

```text
az1nn/growing-rio
```

Before reporting, verify the exact repository identity. Never infer another repository from recent activity.

## Required live reads

Read only what is needed to establish:

1. default-branch HEAD;
2. active/current Spec Kit or SIGA roadmap item when present;
3. open PRs relevant to current work;
4. exact-head required checks/workflows for that work;
5. actionable blockers;
6. the single next action.

Inspect detailed logs, diffs, file lists, old issues, historical commits, or unrelated PRs only when needed to explain a current failure or ambiguity.

## CAVEMAN output contract

Default output MUST fit roughly one mobile screen.

Hard default: **6 lines maximum**.

Use this shape:

```text
RELATORIO <ADVANCE|RESUME|WATCH|BLOCKED> — <active task/milestone>
HEAD: <short-sha> | PR: <#n/state or none>
FEITO: <latest material verified progress>
GATES: <green/running/failing/soft-rate-limit>
BLOCK: <actionable blocker or none>
NEXT: <single next action>
```

Rules:

- no introduction;
- no conclusion paragraph;
- no tables;
- no historical timeline;
- no exhaustive issue/PR list;
- no raw GitHub payloads;
- no long SHA unless needed to disambiguate;
- no repeated repository name;
- collapse multiple green checks into `green`;
- provider quota/rate-limit must be written as `soft-rate-limit` when repository policy says it is non-blocking;
- mention only the PR that owns current work unless another PR is an actual collision/blocker;
- if there are several debts, show only the one that changes the next action;
- prefer verbs and concrete nouns over explanation.

## State classification

- `ADVANCE`: current milestone passed and the next one may start.
- `RESUME`: current work exists and needs implementation/fix/reconciliation.
- `WATCH`: work is complete enough that a real external/CI gate is the only current dependency.
- `BLOCKED`: no safe next action exists without an unresolved external or human decision.

Do not classify a provider rate limit as `BLOCKED` when repository law marks it as a soft gate.

## Active-work selection

When a `STRICT_SEQUENTIAL` roadmap exists, report only its earliest non-`PASS` item as current.

Do not elevate later PRs/issues into the main report merely because they are open.

When no strict roadmap exists, prefer:
1. active unmerged implementation;
2. failing required gate;
3. next documented task.

## Relationship with SIGA

RELATORIO reports; it does not implement, merge, create tasks, or mutate repository state.

SIGA remains the execution/orchestration authority.

When SIGA needs a user-facing repository status summary, it SHOULD use this CAVEMAN format rather than emitting a long repository narrative.

## Expansion rule

Only exceed the six-line default when the user explicitly asks for:
- details;
- all PRs/issues;
- a full audit;
- architecture/history;
- exact failure diagnostics.

Even then, start with the six-line CAVEMAN summary before optional detail.
