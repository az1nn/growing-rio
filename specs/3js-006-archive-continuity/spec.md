# 3JS-006 — Archive visual continuity

**Status:** SPECIFIED / CANDIDATE  
**Owner route:** SIGA -> CENA-023 -> 3JS-006  
**Base:** `master@8d60d7255bcd34cf824f04f4a1e692a52981eb0f`  
**Target:** isolated Three.js Archive reference scene; no Godot runtime replacement

## User value

DA LATA's five canonical top-level destinations already have distinct Godot 3D presentation, while the repository's Three.js reference set covers Operação/Grow Room, Mercado, Cidade and Institucional but not Arquivo. This wave closes that reference-continuity gap with a bounded Archive scene that can be visually compared, reviewed and reused without changing gameplay.

## Canonical source

The existing Godot Archive is authoritative for scene meaning:
- `scenes/archive/archive_surface.gd`;
- `scenes/visual/archive_diorama.gd`;
- `scenes/visual/archive_diorama.tscn`.

The accepted 3JS-002 Grow Room style lock remains authoritative for reusable Three.js camera/material/render discipline. CENA owns the final visual `ACCEPT` / `REVISE` decision.

## User scenarios

### US1 — Recognizable Archive miniature
At 540x960 and 1080x1920, the scene reads immediately as an evidence/archive workspace rather than another market, grow room, city or civic forum.

### US2 — Canon-safe evidence focus
The visual foreground emphasizes an evidence desk/tray and archival material while communicating uncertainty and documentation. Merely viewing the Three.js scene cannot resolve research, authenticate provenance, mutate evidence, choose narrative outcomes or change canon.

### US3 — DA LATA visual continuity
The scene inherits the accepted dark orthographic miniature grammar, concrete/plaster, teal, dark metal, warm wood and restrained warm practical lighting while remaining compositionally distinct.

## Functional requirements

1. Provide an isolated `threejs/archive/` package with exact `three@0.186.1`.
2. Use a fixed orthographic camera and deterministic resize behavior.
3. Include a distinct Archive composition with, at minimum:
   - archive floor/back/side shell;
   - shelf/storage rhythm;
   - evidence desk as the primary focal object;
   - evidence tray/documents;
   - one uncertainty/evidence rail motif;
   - side storage;
   - one restrained warm desk practical against a cooler structural light.
4. Keep scene data presentation-only and read-only.
5. Expose deterministic browser readiness, scene identity and renderer metrics for automated capture.
6. Use static/on-demand rendering; no perpetual animation loop is required.
7. Dispose renderer, geometry and materials explicitly.
8. Use repository-authored procedural geometry only for the first candidate.
9. Use zero authored runtime textures and no dynamic shadows.
10. Rendered acceptance must capture 540x960 and 1080x1920 and fail on browser/page errors.

## Canon and safety invariants

- No Three.js code may call or reproduce GameState/domain mutation.
- The scene must not claim that a visual document, container, symbol, artifact or arrangement proves historical/genetic lineage or provenance.
- No real-world cultivation parameters or operational instructions are represented.
- No real archive, institution, brand, person, address, route or proprietary collection is reproduced.
- Reference material is translation guidance only; runtime assets remain original/repository-authored.

## Performance envelope

The first candidate targets:
- <= 60 draw calls;
- <= 20,000 triangles;
- <= 9 material families;
- 0 authored scene textures;
- DPR <= 1.5;
- dynamic shadows disabled.

A lower-cost result is preferred when visual readability is preserved.

## Acceptance

3JS-006 is visually accepted only when:
- structural validation passes on the exact PR head;
- both portrait captures are produced from that same head;
- browser-console/page-error evidence is empty;
- renderer metrics stay inside the declared envelope;
- CENA records exactly `ACCEPT` or `REVISE` after inspecting the rendered artifact.

Source/CI success alone does not imply visual acceptance.

## Out of scope

- changing Godot Archive runtime behavior;
- replacing `archive_diorama.tscn`;
- changing research or narrative rules;
- changing save schema, campaign progression, economy, RNG or canon;
- importing external meshes/textures;
- engine migration or embedding Three.js into the shipped Godot Web export.
