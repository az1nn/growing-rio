# R06 — City V1 execution plan

**Parent feature:** Feature 012 — ARTIST V1 runtime parity  
**Roadmap item:** R06 — City V1  
**Status:** CURRENT — ARTIST CONCEPT GATE  
**Execution fence:** R06 only. R07+ remain LOCKED.  
**Renderer:** GODOT_NATIVE_V1  
**Shared UI baseline:** DA LATA UI V1 accepted in R05.

## Authority

Global authority remains the approved ARTIST V1 board + `docs/art-direction/ARTIST-V1-STYLE.md` + `docs/art-direction/v1/BASE-PROMPT.md`.

City scene delta is `docs/art-direction/v1/SCENES.json#city`:

- fictional Rio-adjacent dense neighborhood;
- multi-level stacked colorful houses;
- painted rooftop walls, cables, narrow staircases and mural alley;
- streetlamps and small tropical-night color pools;
- reads as one explorable 3D city chunk;
- no postcard skyline and no real map instructions;
- interaction foci: district rooftops, route nodes, local-event hotspot.

Current ARTIST ledger state is `BOARD_APPROVED_ONLY`; therefore runtime implementation is blocked until the isolated City concept receives explicit human `ACCEPT`.

## Ordered execution

1. **T051-A — RECONCILE — COMPLETE**
   - R05 is PASS.
   - PR #205 merged as `f73190b89bafca1e05310f4f816c2cdc788bd03d`.
   - DA LATA UI V1 is the reusable UI baseline.
   - City is the only current scene.

2. **T051-B — ARTIST concept gate — CURRENT**
   - Generate exactly one isolated 9:16 City environment concept from locked base prompt + City delta.
   - Preserve the approved pixel-art × graffiti × urban diorama grammar.
   - No contact sheet, generated UI text, tourist landmark, flat 2D substitute or gameplay implementation.
   - Human decision must be explicit: ACCEPT / REVISE / REJECT.

3. **T051-C — ARTIST ledger**
   - Persist artifact path, provenance/hash and explicit concept acceptance.
   - Update `SCENE-STATUS.json#city` to concept accepted only after human ACCEPT.

4. **T051-D — CENA decomposition**
   - Map architecture, depth layers, materials/decals, lights, three interaction anchors and lower UI-safe region.
   - Produce a build sheet that is implementable in native Godot.

5. **T051-E/F — Runtime + regression**
   - Implement real 3D City V1 in Godot.
   - Reuse DA LATA UI V1; no City-local UI fork.
   - Preserve gameplay/state/persistence.
   - Verify scene load, semantic hotspots, pointer/touch, keyboard/focus, accessible fallback and portrait safe areas.

6. **T051-G — Exact-head evidence**
   - Validate project.
   - Capture 540×960 and 1080×1920 full-page + isolated scene evidence.
   - Run bounded LENTE.
   - Companion report must expose `TEST: <exact-head preview URL>`.
   - If exact-head preview does not exist, report `TEST: UNAVAILABLE — <reason>` and block the human runtime gate.

7. **T051-H/I — Human gate and PASS**
   - Compare board → accepted City concept → exact-head runtime.
   - Human ARTIST/CENA ACCEPT required.
   - Only then persist R06 PASS and unlock R07.

## Acceptance invariants

- Real 3D remains mandatory; concept imagery is reference only.
- The City must remain visually distinct while staying inside the approved DA LATA art grammar.
- UI uses the accepted R05 shared system.
- No R07+ spec, implementation or acceptance work begins before R06 PASS.
- Green CI, deploy success or a screenshot alone never equals visual acceptance.
