---
name: relatorio
description: Produce the DA LATA SIGA handoff as a deterministic, mobile-readable REPORT_V1 visual with exact text and access links.
---

# RELATORIO — approved DA LATA visual handoff

## Purpose

`RELATORIO` is the repository-local handoff reporter for **DA LATA / az1nn/growing-rio**.

Its job is to project one frozen live fact packet into the same recognizable REPORT_V1 visual language every time, while keeping **all factual text, hashes, task ids and URLs exact and readable**.

Repository/CI state remains factual authority. The approved visual reference remains art-direction authority. The deterministic renderer is text/layout authority.

## Repository lock

Canonical repository:

```text
az1nn/growing-rio
```

Never import operational facts from another repository.

## Approved REPORT_V1 reference lock

The approved REPORT_V1 visual reference is:

```text
Library path: /DA-LATA/REPORTS/REPORT_V1_APPROVED_REFERENCE.png
Library file id: libfile_a626ef1fc98081919c4871587ccafa2a
Backing file id: file_0000000096b0820e91fc2f8ef3b0a481
SHA-256: a334c2ac9dc4497a24e46d162f0529b26f191e9b74b7cf4ccee2d9494de8431e
Reference canvas: 1092 x 1440
```

This reference was explicitly human-approved on 2026-10-04.

`REPORT_V1_REFERENCE_LOCK` preserves the DA LATA identity: dark glass/pixel-graffiti presentation, semantic green/blue/amber/violet accents, numbered operational panels, preview/evidence area and footer rhythm.

The human-approved readability correction from 2026-10-07 **supersedes the old dense text layout**. Reference identity must be preserved, but factual typography must use the deterministic mobile-first layout below.

## Deterministic readability contract — mandatory

The terminal report pipeline is:

```text
FROZEN FACT PACKET
  -> tools/render_relatorio_v1.py
  -> REPORT_V1.svg
  -> REPORT_V1.links.md
  -> optional raster derivative
```

Hard rules:

1. **Generative image tools MUST NOT render factual report text.** This includes repository names, task ids, branch names, commit SHAs, PR numbers, gate states, blocker text, next actions and URLs.
2. Image generation MUST NOT be used to redraw, reinterpret, spell or place preview URLs.
3. Runtime/LENTE screenshots may be used as evidence, but they remain source pixels; facts are overlaid only by the deterministic renderer.
4. Primary visual output is **SVG, 1440 x 1920 portrait**. It is vector and zoom-safe.
5. No factual SVG font size may be smaller than **32 px**. Main body copy targets **42 px**.
6. A raster derivative, when required by a client, must be at least **2160 x 2880** and must come from the deterministic SVG. A generative re-render is forbidden.
7. The terminal report must be portrait/mobile-first. Wide desktop dashboards are not valid REPORT_V1 terminal output.
8. If a valid preview exists, `preview_url` must be preserved byte-for-byte as an HTTPS URL and projected into both:
   - the SVG as a real hyperlink; and
   - the companion `.links.md` as a normal clickable Markdown link.
9. Missing external link projection when `preview_url` exists is `PREVIEW_LINK_REQUIRED`.
10. Text below the minimum size, clipped/truncated required facts, or a raster-only URL is `REPORT_TEXT_LEGIBILITY_FAILURE`.

The image model may still be used elsewhere in the project for art production, but not to typeset the terminal REPORT_V1 facts.

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
timestamp: <report timestamp>
preview_url: <exact current preview URL or empty>
preview_immutable_url: <exact immutable deployment URL or empty>
evidence: <0..3 exact-head visual evidence images when available>
```

Rules:
- every factual field comes from fresh live repository/CI evidence;
- `done` describes this invocation;
- `next` is one commitment, never a menu;
- never invent percentages, CI results, branches, PRs, URLs or milestones;
- URLs must be copied from provider/repository evidence, never reconstructed from naming conventions.

## Compact text projection

The text projection remains mandatory and must be readable without opening the image:

```text
RELATORIO <state> — <task_id> <task>
HEAD: <head> | PR: <pr>
FEITO: <done>
GATES: <gates>
BLOCK: <blocker>
NEXT: <next>
PREVIEW: <clickable preview_url when available>
```

## REPORT_V1 — fixed readable composition

The accepted mobile-first structure is:

```text
[TOP DA LATA BANNER]
SIGA HANDOFF / REPORT_V1
state + timestamp

[TASK STRIP]
task id + short task name
branch + head + PR

[1 EXECUTADO]                  [2 GATES]
green semantic accent          blue semantic accent
short, large text              exact-head status only

[3 BLOQUEIO]                   [4 PRÓXIMO]
amber semantic accent          violet semantic accent
one blocker                    one next action

[5 PREVIEW / ACESSO — full width]
large "ABRIR PREVIEW" action
exact preview URL
optional immutable deployment URL
current runtime evidence when available

[FOOTER]
az1nn/growing-rio | DA LATA | REPORT_V1
```

Compatibility note: the former **5 EVIDÊNCIAS VISUAIS** zone is now the larger **5 PREVIEW / ACESSO** zone so the runtime is directly accessible while still allowing current evidence.

Immutable traits:
- portrait 3:4 family, optimized for phone viewing;
- large high-contrast typography;
- dark DA LATA pixel/graffiti identity;
- numbered semantic panels;
- no dense desktop table grid;
- no tiny status rows;
- no link that exists only as pixels.

## Rendering method

The factual report MUST be rendered with:

```bash
python3 tools/render_relatorio_v1.py \
  --packet <frozen-report-packet.json> \
  --output <report-v1.svg>
```

The renderer automatically creates a sibling `report-v1.links.md`. `--links-output` may be supplied to choose another path.

The approved reference may guide decorative identity, but **reference-guided generative image editing is not a valid factual renderer**.

No other visual style may substitute for REPORT_V1.

## Validation

Before exposure, run all of these logical checks:

- `REPORT_RENDER_IDENTITY_CHECK`: DA LATA, growing-rio, task/head/PR and state match the packet.
- `REPORT_REFERENCE_MATCH_CHECK`: recognizable approved DA LATA color/numbering/panel identity remains.
- `REPORT_TEXT_LEGIBILITY_CHECK`:
  - SVG is 1440 x 1920;
  - no factual font is below 32 px;
  - main operational body text is approximately 42 px;
  - required facts are not clipped.
- `REPORT_PREVIEW_LINK_CHECK`:
  - if `preview_url` exists, SVG contains an HTTPS hyperlink to the exact URL;
  - companion `.links.md` contains the same exact clickable URL.
- `REPORT_CONTEXT_MISMATCH`: fail if foreign project identity appears.
- `REPORT_RENDER_MISMATCH`: fail on factual mismatch or meaningful identity drift.

Any failure discards the output. Do not repair failed text with an image model.

Exactly one accepted visual report is exposed. The companion text/link projection is not a second visual; it is required accessibility/navigation output.

## Relationship with SIGA

SIGA owns execution. RELATORIO owns terminal presentation.

A finalized SIGA invocation projects the same frozen packet into:
1. compact readable text with a clickable preview link when available;
2. exactly one deterministic REPORT_V1 SVG visual; and
3. a companion exact-link projection generated by the renderer.

Repository/CI remains canonical. The visual is observability, not authority.
