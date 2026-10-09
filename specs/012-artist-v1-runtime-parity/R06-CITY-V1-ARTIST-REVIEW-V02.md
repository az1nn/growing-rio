# R06 City V1 — ARTIST Review v0.2 (human-approved specification intent)

**Date:** 2026-10-09. **Owner:** Feature 012 / R06, SIGA PR #213 (`feat/012-r06-city-v1`).
**State:** `SPEC_APPROVED / ARCHITECTURE_DECISION_PENDING / RUNTIME_REJECTED`. This document does not authorize execution, art/runtime acceptance, or a merge.
**Authorities:** original approved ARTIST V1 board and style guide; accepted City concept `20261004T110406Z/city` (SHA256 `385dfc7ee29cee1a3255036e7bf48f049399a20922623579637d3fea28768123`).

## Preserved G1–G25 decisions

| Gate | Choice | Meaning |
|---|---|---|
| G1 | **D** | layered living neighborhood |
| G2 | **D** | dynamic-camera diorama |
| G3 | **D** | hybrid dusk urban palette |
| G4 | **B** | balanced visual density |
| G5 | **B** | floating icons |
| G6 | **D** | functional graffiti icons |
| G7 | **D** | intelligent contextual camera focus |
| G8 | **B** | environmental microanimations |
| G9 | **B** | depth by lighting |
| G10 | **D** | hybrid contextual panel |
| G11 | **D** | urban artistic hierarchy |
| G12 | **D** | contextual combined identity |
| G13 | **D** | short interactive reveal |
| G14 | **B** | fluid composition |
| G15 | **D** | suggested urban continuity |
| G16 | **A** | chunky block pixel art |
| G17 | **C** | exaggerated touch affordances |
| G18 | **D** | controlled mixed interaction feedback |
| G19 | **D** | decorative human/street silhouettes, no complex NPCs |
| G20 | **D** | contextual navigation and recenter, no permanent minimap |
| G21 | **C** | short artistic transition |
| G22 | **D** | sticker and pixel spray reveal |
| G23 | **D** | combined accessible interaction states |
| G24 | **D** | neighborhood-integrated events |
| G25 | **A** | fidelity to the accepted visual concept |

## Preserved ARTIST R1–R5 decisions

| Gate | Choice | Binding intent |
|---|---|---|
| R1 | **D** | Verifiable visual contract: original board/style and actual Godot LENTE frames; pixel density, textures, palette, lights and silhouettes; generic low-poly rejected. |
| R2 | **D** | Constrained hybrid camera, hotspot focus, recenter and safe UI regions across mobile portrait/landscape and desktop. |
| R3 | **D** | Accessible hybrid hotspot interaction: tap or destinations menu, immediate non-color-only feedback, contextual panel, complex actions in own screens, meaningful disabled states and return. |
| R4 | **D** | Adaptive, recoverable and skippable sticker/pixel-spray transition; reduced motion; truthful loading/ready/error/retry; no unlocking broken gameplay. |
| R5 | **B** | Objective **visual checklist** with individual PASS/FAIL. R5 is NOT D; ARTIST opinion and technical/runtime release stay separate. |

## Scope and implementation requirements

Locked visual direction: Pixel Art × Graffiti × Urban Diorama; a fictional, lived-in, layered Rio-adjacent hillside neighborhood with rooftops, stair corridors, shops, cables, painted masonry, murals, warm windows and cyan/magenta against navy dusk. Balanced density, readable architectural volumes and composition, expressive silhouettes, accessible mobile-first controls. The approved Draft v0.2 asks for **real Godot 3D architecture**, not a flat image, wallpaper, primitive low-poly scene or paper-card shell. The separate 2026-10-08 approved SVG 2.5D exception conflicts with this demand: see human gate below.

- **CITY-01:** layered multi-height neighborhood, controlled density and fictional urban continuity (G1/G4/G15).
- **CITY-02:** constrained dynamic camera, contextual focus/recenter; UI-safe mobile/desktop framing (G2/G7/G14/G20/R2).
- **CITY-03:** dusk, lighting-led depth, urban/graffiti palette and strong visual hierarchy (G3/G9/G11).
- **CITY-04:** block pixel art with appropriate materials and explicit rejection of generic low-poly (G16/R1).
- **CITY-05:** City foci: district rooftops, urban routes and local events, maintaining existing canonical semantic hotspot IDs (G12/R3).
- **CITY-06:** graffiti icons, visual feedback not dependent on color alone, touch-friendly hotspots, accessible blocked-state reasons (G5/G6/G17/G18/G23).
- **CITY-07:** tap or menu -> camera focus -> contextual action panel; dedicated screens for complex actions; clear return, recenter and state preservation (G10/R3).
- **CITY-08:** short environmental animation and decorative people/street activity, no NPC simulation (G8/G19).
- **CITY-09:** neighborhood-integrated local event art and accessible contextual navigation (G20/G24).
- **CITY-10:** short interactive transition with sticker + pixel spray; skip, reduced motion, honest loading, retry and interaction only when ready (G13/G21/G22/R4).
- **CITY-11:** original visually authored assets with provenance; no unsupported branding, real-place reproduction or flat reference wallpaper (R1).
- **CITY-12:** R5 B checklist plus independent exact-head technical, accessibility, performance, functional and human runtime gates (G25/R5).

## R5 B — objective visual checklist

Each row requires **PASS or FAIL with evidence**, comparing the accepted global board, accepted City concept and **actual** Godot exact-head screenshots; missing evidence means `PENDING/BLOCKED`, not PASS.

| Item | Criterion / FAIL conditions |
|---|---|
| VIS-01 | Architecture/volume: reject paper-thin architecture, generic low-poly and depth gaps; production geometry method awaits ARCH-GATE. |
| VIS-02 | Pixel treatment: chunky coherent texture/detail; no smooth plastic fills. |
| VIS-03 | Graffiti identity: integrated murals, patina and non-repetitive signature. |
| VIS-04 | Lighting: readable cool dusk / warm localized practicals; no central void. |
| VIS-05 | Composition: inhabited near/mid/far, portrait-safe UI/touch areas, no clipping. |
| VIS-06 | Hotspots: three distinctive functional graffiti indicators, non-color-only states. |
| VIS-07 | Finish: no old rejected billboard/card renderer, random placeholder people or incorrect scale. |
| VIS-08 | Transition visual: concise sticker + pixel spray, accessible reduced-motion alternative. |

**Independent verification:** SIGA/ARCH/CENA must separately prove Godot Web boot, City→Market→City, touch/keyboard/focus, exact semantic IDs, 540×960 and 1080×1920 LENTE page/isolated captures, loading/error/retry, export/Cloudflare, and correct runtime candidate TEST URL. Green CI/LENTE does not imply ARTIST PASS; ARTIST PASS does not imply human runtime ACCEPT.

## ARCHITECTURE_DECISION_PENDING — conflicting approved user decisions

- **2026-10-08 human direction:** Godot City R06 uses original independently authored SVG object sprites as **2.5D** layers with illustrated faces, z-order and subtle parallax, not heavyweight volumetric facades. See `spec.md` R06 SVG amendment, R06 plan, tasks and SVG handoff. Upper-building SVGs are `UNREVIEWED` candidate assets, not player-facing accepted art.
- **2026-10-09 human direction:** ARTIST Review Draft v0.2 approved with real Godot 3D geometry as the visual construction criterion. Same concept and style identity; this does **not** constitute approval of any runtime candidate.

No agent should silently declare the earlier exception revoked or the newer geometric requirement inapplicable. **Human choice required**:
A. **Native Godot 3D:** actual architectural volumes required; existing SVGs optionally reused as original texture/decal sources; orbit/backface visual evidence.
B. **Godot authored SVG 2.5D:** explicit human amendment to the v0.2 geometric requirement and VIS-01, keeping robust parallax/pan evidence.
C. **Godot hybrid 3D+SVG:** real geometry and interactive anchors plus independently authored sprite/texture surfaces; confirm depth with suitable orbit/pan evidence.

**STOP:** Until human A/B/C choice is recorded AND Spec Kit spec/plan/tasks/evidence contracts agree, do not start/restart City visual construction, scale sprite assets, mount the compositor, claim ARTIST/RUNTIME ACCEPT or merge. Existing user `REJECT ALL` of implementation head `1f799128d9efe33cfdcb8365119fc2eb2371166e` remains binding; City concept `20261004T110406Z/city` is still approved. R05 PASS, R06 sole current item with blocked execution, R07+ LOCKED.

## R05/R06 provenance and handoff

R05 Market exact-head human acceptance `c6ebed7dc7319df435d2a6ade8ebf09d6fcea68e`; PR #205 was merged 2026-10-04 as `f73190b89bafca1e05310f4f816c2cdc788bd03d`. Do not roll it back. City original PR #190 asset hash is historical and must not be conflated with the 2026-10-04 accepted scene concept run. R06 existing PR #213 remains Draft and the sole work branch. Human A/B/C decision is the next gate. After that and separate implementation authorization, reconcile visual-contract requirements and continue same-head SIGA/LENTE/ARTIST/RELATORIO with `TEST:` exact-head URL or explicit unavailable reason.
