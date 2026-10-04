---
name: relatorio
description: Produce the DA LATA SIGA handoff using the approved REPORT_V1 visual reference. Facts are live; composition and art direction are locked.
---

# RELATORIO — approved DA LATA visual handoff

## Purpose

`RELATORIO` is the repository-local handoff reporter for **DA LATA / az1nn/growing-rio**.

Its job is not to invent a dashboard. Its job is to project one frozen live fact packet into the **same approved visual language every time**, so a developer can recognize the report instantly and read only what changed.

Repository/CI state remains factual authority. The approved visual reference is presentation authority only.

## Repository lock

Canonical repository:

```text
az1nn/growing-rio
```

Never import operational facts from another repository.

## Approved REPORT_V1 reference lock

The only approved REPORT_V1 visual reference is:

```text
Library path: /DA-LATA/REPORTS/REPORT_V1_APPROVED_REFERENCE.png
Library file id: libfile_a626ef1fc98081919c4871587ccafa2a
Backing file id: file_0000000096b0820e91fc2f8ef3b0a481
SHA-256: a334c2ac9dc4497a24e46d162f0529b26f191e9b74b7cf4ccee2d9494de8431e
Reference canvas: 1092 x 1440
```

This reference was explicitly human-approved on 2026-10-04.

`REPORT_V1_REFERENCE_LOCK` means:
- load the exact approved reference before composing the final visual;
- preserve its composition, panel geometry, visual density, pixel/graffiti game-art language, dark glass UI, neon semantic accents, numbering system, typography hierarchy and footer rhythm;
- use it as an image/layout reference, not merely a verbal inspiration;
- never fall back to the rejected plain charcoal/card dashboard;
- never create a fresh alternative dashboard style because it seems cleaner or more modern.

If the approved reference cannot be loaded or its identity/hash cannot be resolved, classify `REPORT_OUTPUT_FAILURE` rather than redesigning the report.

## Frozen report packet

After the final live read, freeze exactly one packet:

```text
state: <ADVANCE|RESUME|WATCH|BLOCKED>
task_id: <task key>
task: <active milestone/action>
branch: <current branch>
head: <short exact-head sha>
pr: <#n/state or none>
done: <material work executed in this SIGA invocation>
gates: <current exact-head gates and useful references>
blocker: <actionable blocker or none>
next: <one next SIGA action>
evidence: <0..3 exact-head visual evidence images when available>
timestamp: <current report timestamp>
```

Rules:
- every factual field comes from fresh live repository/CI evidence;
- `done` describes this invocation;
- `next` is one commitment, never a menu;
- visual evidence must belong to the same task/exact head or be clearly labelled reference evidence;
- never invent percentages or gate results.

## Compact text projection

The text projection remains:

```text
RELATORIO <state> — <task_id> <task>
HEAD: <head> | PR: <pr>
FEITO: <done>
GATES: <gates>
BLOCK: <blocker>
NEXT: <next>
```

## REPORT_V1 — fixed approved composition

The user-facing image MUST keep this structure and visual balance:

```text
[TOP GAME-ART BANNER]
DA LATA / GROWING-RIO identity
urban pixel-art / graffiti environment
repo card + SIGA HANDOFF + REPORT_V1 + state + timestamp

[TASK STRIP]
task id + task name/summary | branch | head | PR | CI state

[1 EXECUTADO NESTA RODADA]     [2 VALIDADO]
green semantic accent           blue semantic accent
short verified bullets          exact-head checks / links / refs

[3 BLOQUEIO]                    [4 PRÓXIMO SIGA]
amber semantic accent           violet semantic accent
one blocker or NENHUM BLOQUEIO  one next task/action only

[5 EVIDÊNCIAS VISUAIS — full width]
up to three current images
thumbnail + short caption + factual purpose

[FOOTER]
az1nn/growing-rio | REPORT_V1 | SIGA • EXECUTA • VALIDA • ENTREGA | timestamp
```

Immutable visual traits:
- same 1092×1440 portrait family and dense poster-like information hierarchy;
- top illustrated DA LATA game-art banner, not an empty corporate header;
- graffiti/pixel-art product identity;
- dark translucent/outlined panels;
- green/blue/amber/violet numbered section accents;
- task strip between banner and status panels;
- four numbered operational panels in a 2×2 grid;
- full-width visual-evidence panel;
- footer metadata row;
- no generic SaaS dashboard aesthetic;
- no single-column stack of four identical cards;
- no removal of visual evidence when exact-head evidence exists.

Dynamic content may change only inside those locked zones.

## Rendering method

Preferred method is **reference-guided image editing/composition** using the approved REPORT_V1 image as the visual source of truth.

The renderer/editor MUST be instructed to:
1. preserve the approved layout and art direction;
2. replace factual text with the frozen packet;
3. replace evidence thumbnails with exact-head evidence;
4. preserve labels, numbering, semantic accent roles and overall proportions;
5. avoid hallucinating URLs, task IDs, checks or screenshots.

A deterministic recreation is acceptable only if it is pixel-faithful to the approved reference. The previously merged plain `tools/render_relatorio_v1.py` output is **not** visual acceptance evidence by itself and MUST NOT be emitted if it visually diverges from the approved reference.

## Validation

Before exposure run `REPORT_REFERENCE_MATCH_CHECK`.

The image passes only when:
- DA LATA / growing-rio / REPORT_V1 identity is visible;
- task/head/PR/gates/blocker/next match the frozen packet;
- the top game-art banner exists;
- the task strip exists;
- numbered panels 1..5 exist in the approved order;
- panels 1..4 preserve their green/blue/amber/violet semantic roles;
- panel 5 contains current evidence when evidence is available;
- footer rhythm matches the approved reference;
- composition is recognizably the approved report at first glance.

Any structural/style drift is `REPORT_RENDER_MISMATCH`, even if the facts are correct.

Exactly one accepted visual is exposed.

## Relationship with SIGA

SIGA owns execution. RELATORIO owns the terminal presentation.

A finalized SIGA invocation projects the same frozen packet into:
1. the compact text report; and
2. exactly one reference-locked REPORT_V1 image.

No other visual style may substitute for REPORT_V1.
