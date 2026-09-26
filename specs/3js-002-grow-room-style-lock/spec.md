# 3JS-002 — Grow Room Style Lock

Status: **ACTIVE**
Maturity target: **PRESENTED**
Renderer: **Three.js**
Canonical runtime: **Godot**
Visual authority: **CENA**

## Purpose

Establish the grow room as the definitive Three.js visual reference for DA LATA before expanding the same language to other player-facing surfaces.

The scene is a visual/style-lock capability, not a gameplay rewrite or runtime migration.

## User value

As a player, I can immediately read the grow room as DA LATA's primary operation space: compact, tactile, stylized, atmospheric and legible under a portrait-first management interface.

## Reference contract

The five user-provided visual references are consultation material only. They inform composition, stylization, lighting and scene density. No source image, brand, mesh, texture or distinctive third-party asset is copied into runtime content.

The repository reference ledger is:

`docs/references/3js-002-grow-room/README.md`

## Required visual grammar

The grow room MUST combine the accepted DA LATA baseline with the reference synthesis:

- orthographic / isometric three-quarter cutaway composition;
- low-poly miniature / toy-diorama read rather than photorealism;
- strong silhouette and modular object grouping before micro-detail;
- cool dark architectural envelope with localized warm practical light;
- warm plaster / concrete / dark metal / teal / terracotta / restrained foliage vocabulary;
- compact, layered interior density without asset-store collage;
- portrait-first framing at 540x960 and 1080x1920;
- 2D UI remains readable over or around the scene;
- original/procedural runtime geometry in this wave.

## Functional requirements

- **FR-001** — The scene MUST be a separate additive Three.js surface and MUST NOT replace the Godot boot/runtime path.
- **FR-002** — The scene MUST use an orthographic camera with deterministic portrait framing.
- **FR-003** — The room MUST read as a cutaway interior with at least two architectural planes and a clear floor/base.
- **FR-004** — The scene MUST include original modular furniture/storage/fixture silhouettes sufficient to make the room feel inhabited and operational.
- **FR-005** — Repeated vegetation/planter presentation MUST use efficient shared or instanced geometry where practical.
- **FR-006** — Cultivation depiction MUST remain abstract and non-operational: no measurements, schedules, chemical recipes, equipment settings or instructional labels.
- **FR-007** — No user reference image may be loaded as a runtime texture or copied as a runtime asset.
- **FR-008** — No external runtime asset with unknown provenance may be introduced.
- **FR-009** — Rendering MUST expose deterministic readiness and performance metrics for automated acceptance.
- **FR-010** — Scene teardown MUST remove listeners and dispose renderer/geometry/material resources.
- **FR-011** — 540x960 and 1080x1920 rendered captures MUST complete without browser/page errors.
- **FR-012** — The first style-lock pass MUST stay within the budget defined by the technical plan.

## Acceptance scenarios

### A — Portrait style lock
Given the scene at 540x960, when the grow room renders, then the room is the dominant visual subject, major fixture/plant groups remain distinguishable, and no important mass is clipped or obscured by the presentation chrome.

### B — Tall portrait continuity
Given the scene at 1080x1920, when the grow room renders, then it preserves the same camera grammar, color family, hierarchy and miniature read without turning the lower viewport into featureless dead space.

### C — Reference synthesis, not imitation
Given the five source references, when the runtime is inspected, then all production geometry/materials are repository-authored and the references are used only to justify high-level composition/stylization decisions.

### D — Safe abstraction
Given player-visible vegetation and fixtures, when the room is inspected, then the scene communicates fiction/atmosphere without actionable real-world cultivation instructions.

### E — Web/mobile discipline
Given exact-head acceptance, when automated metrics are collected, then the scene stays inside the defined draw-call, triangle, material, texture, DPR and shadow budgets and produces no browser errors.

## Success criteria

- both target resolutions produce reviewable exact-head captures;
- browser/page-error artifact is empty;
- visual hierarchy is recognizably consistent across both portrait sizes;
- CENA-style baseline is preserved while the miniature/isometric reference synthesis is clearly visible;
- no copied/embedded reference art or third-party runtime asset is present;
- performance budgets pass;
- Godot runtime, gameplay, persistence and canon remain unchanged.

## Out of scope

- renderer/runtime migration;
- gameplay/economy/progression changes;
- save-schema changes;
- free-roaming camera;
- realistic cultivation simulation;
- photorealism;
- broad third-party asset packs;
- other screens before the grow-room style is accepted;
- lore/canon changes.
