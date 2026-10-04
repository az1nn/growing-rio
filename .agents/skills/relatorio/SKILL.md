---
name: relatorio
description: Produce the canonical DA LATA SIGA handoff as a fixed REPORT_V1 visual plus its compact fact projection. Layout is deterministic; only verified repository facts may change.
---

# RELATORIO — fixed DA LATA visual handoff

## Purpose

`RELATORIO` is the repository-local handoff reporter for **DA LATA / az1nn/growing-rio**.

Its job is not to design a dashboard. Its job is to project one frozen repository fact packet into one **fixed, versioned handoff format** so every SIGA session is readable without relearning a new visual language.

It MUST prefer live repository state over chat history.

## Repository lock

Canonical repository:

```text
az1nn/growing-rio
```

Before reporting, verify the exact repository identity. Never infer another repository from recent activity.

## Trigger

Treat `relatorio`, `relatório`, equivalent repository-status requests, and SIGA's terminal report gate as RELATORIO invocations.

A deep audit, architecture document, changelog, postmortem, or historical analysis is not automatically a RELATORIO request.

## Frozen report packet

After the last repository mutation/check, freeze exactly one packet with these fields:

```text
state: <ADVANCE|RESUME|WATCH|BLOCKED>
task: <active task/milestone>
branch: <current branch>
head: <short exact-head sha>
pr: <#n/state or none>
done: <material progress executed in this SIGA invocation>
gates: <green/running/failing/soft-rate-limit + only useful exact-head detail>
blocker: <actionable blocker or none>
next: <exactly one action the next SIGA invocation will execute>
```

Rules:

- all fields come from fresh live repository/CI evidence;
- `done` describes this invocation, not historical accomplishments;
- `next` is a handoff commitment: it states the single next execution target, not a menu of suggestions;
- if human input is the real gate, `next` names that decision explicitly;
- never invent progress percentages;
- never use stale/foreign project state.

## Compact text projection

The text projection MUST remain stable and use exactly this shape:

```text
RELATORIO <state> — <task>
HEAD: <head> | PR: <pr>
FEITO: <done>
GATES: <gates>
BLOCK: <blocker>
NEXT: <next>
```

Default maximum: six lines. No introduction, conclusion, table, historical timeline, exhaustive PR list, raw payload, or duplicated repository metadata.

## REPORT_V1 — immutable visual contract

The canonical visual handoff is **REPORT_V1**.

Source renderer:

```text
tools/render_relatorio_v1.py
```

The renderer is deterministic and owns the visual grammar. RELATORIO MUST NOT ask a generative image model to redesign, decorate, reinterpret, or "improve" this report.

Canonical geometry and hierarchy are fixed:

```text
Canvas: 1080 x 1350, portrait 4:5

HEADER
  DA LATA
  SIGA HANDOFF
  REPORT_V1
  STATUS + active task
  branch | head | PR

PANEL 1 — EXECUTADO NESTA RODADA
  done

PANEL 2 — VALIDADO
  gates

PANEL 3 — BLOQUEIO
  blocker

PANEL 4 — PRÓXIMO SIGA
  next

FOOTER
  az1nn/growing-rio · frozen facts · REPORT_V1
```

The following are immutable between runs:

- canvas size and aspect ratio;
- background, panel, border, text, muted and accent colors;
- typography family/fallbacks, sizes and weights;
- panel count, order, coordinates, padding and spacing;
- section names;
- repository/product identity placement;
- information hierarchy;
- footer;
- template version string.

The following may change:

- `state`;
- `task`;
- `branch`;
- `head`;
- `pr`;
- `done`;
- `gates`;
- `blocker`;
- `next`.

No decorative illustration, scene art, generated iconography, alternate dashboard composition, charts, percentages, gradients, background imagery, or per-run stylistic reinterpretation is permitted.

## Rendering rule

Render REPORT_V1 from the frozen packet with:

```bash
python tools/render_relatorio_v1.py --packet <packet.json> --output <report.svg>
```

The SVG is the canonical image. If the host surface requires PNG/WebP, rasterize **that exact SVG** without changing layout or content.

A generative image model is not an acceptable REPORT_V1 renderer.

If the deterministic renderer is unavailable, missing, or cannot render the frozen packet, classify `REPORT_OUTPUT_FAILURE`. Do not silently fall back to a new visual style.

## Validation

Before exposure, validate:

1. visible template marker is exactly `REPORT_V1`;
2. visible product/repository identity resolves to DA LATA / `az1nn/growing-rio`;
3. state, task, branch/head, PR, done, gates, blocker and next match the frozen packet;
4. section order is HEADER -> EXECUTADO -> VALIDADO -> BLOQUEIO -> PRÓXIMO SIGA -> FOOTER;
5. canvas is 1080 x 1350;
6. no foreign identity, invented percentage, extra status card, omitted panel or alternate composition exists.

Any mismatch is `REPORT_RENDER_MISMATCH`.

Exactly one accepted REPORT_V1 image is exposed. Rejected renders are internal only.

## Relationship with SIGA

RELATORIO reports; it does not implement, merge, create tasks, or mutate repository state.

SIGA owns execution/orchestration. RELATORIO owns the terminal handoff projection.

When SIGA reaches its terminal report gate, it MUST project the final frozen packet into:

1. the six-line compact text report; and
2. exactly one validated REPORT_V1 visual.

A finalized SIGA response may not substitute another visual style.

## Expansion rule

If the user asks for a full audit or diagnostics, additional prose may follow the compact text report, but REPORT_V1 itself remains unchanged.
