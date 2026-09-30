# CENA-018 — Finale portrait emphasis

## Problem

LENTE exact-head evidence from run `36706228439` / artifact `11094785029` shows the four Finale phases (`selection`, `handoff`, `coda`, `recap`) with a much smaller embedded 3D tableau than the same scene rendered in isolation at both 540×960 and 1080×1920.

The scene is already real 3D and interactive. This slice changes **presentation hierarchy only**.

## Decision

Hypothesis `SCENE-finale-01`: **ACCEPT** for a bounded A/B implementation that increases the embedded Finale tableau's portrait width/height budget.

## Invariants

- Keep ending eligibility, alphabetical ordering and ending semantics unchanged.
- Keep save/load and canonical campaign state unchanged.
- Keep all existing 3D geometry, phases, Area3D hotspots and accessible button fallback unchanged.
- Do not alter LORE/canon.
- Do not change global background dimming in this slice; isolate the effect of tableau scale first.
- Keep campaign and narrative overlays at their existing density.

## Acceptance

1. When a `finale:*` overlay owns the shell at 540×960, the Finale card receives at least 480 px minimum width and the 3D diorama at least 340 px minimum height.
2. At 1080×1920, the Finale card receives at least 720 px minimum width and the diorama at least 440 px minimum height.
3. Non-Finale overlays retain the pre-existing 420 px card / 230 px Finale fallback contract.
4. Existing interaction and campaign-state tests remain green.
5. A fresh exact-head LENTE run captures all four Finale phases at both portrait sizes before merge acceptance.
6. Human post-implementation review may ACCEPT, REVISE or REJECT the result; structural CI alone is not visual acceptance.
