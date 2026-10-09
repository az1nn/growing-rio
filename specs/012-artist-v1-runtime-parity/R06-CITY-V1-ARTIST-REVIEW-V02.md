# R06 City V1 — ARTIST Review v0.2 (human-approved specification intent)

**Date:** 2026-10-09. **Owner:** Feature 012 / R06, SIGA PR #213 (`feat/012-r06-city-v1`).
**State:** `SPEC_APPROVED / ARCHITECTURE_B_SVG25D_SELECTED / IMPLEMENTATION_PLAN_APPROVAL_PENDING / RUNTIME_REJECTED`. This document does not authorize execution, art/runtime acceptance, or a merge.
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

Locked visual direction: Pixel Art × Graffiti × Urban Diorama; a fictional, lived-in, layered Rio-adjacent hillside neighborhood with rooftops, stair corridors, shops, cables, painted masonry, murals, warm windows and cyan/magenta against navy dusk. Balanced density, readable architectural volumes and composition, expressive silhouettes, accessible mobile-first controls. The originally approved Draft v0.2 requested real Godot 3D architecture. The later explicit human **R06 architecture B** decision supersedes that construction-only requirement for City: use authored modular SVG 2.5D in Godot with illustrated apparent volume, parallax and real gameplay interaction anchors. No flat full-scene wallpaper, primitive low-poly or paper-card shell.

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
| VIS-01 | **SVG 2.5D architectural volume:** original independent front/side/roof sprite illustrations, coherent apparent thickness and occlusion under bounded 2-axis pan, no giant flat facade cards, black holes, generic low-poly or visual depth gaps; actual mesh/orbit is not required for R06. |
| VIS-02 | Pixel treatment: chunky coherent texture/detail; no smooth plastic fills. |
| VIS-03 | Graffiti identity: integrated murals, patina and non-repetitive signature. |
| VIS-04 | Lighting: readable cool dusk / warm localized practicals; no central void. |
| VIS-05 | Composition: inhabited near/mid/far, portrait-safe UI/touch areas, no clipping. |
| VIS-06 | Hotspots: three distinctive functional graffiti indicators, non-color-only states. |
| VIS-07 | Finish: no old rejected billboard/card renderer, random placeholder people or incorrect scale. |
| VIS-08 | Transition visual: concise sticker + pixel spray, accessible reduced-motion alternative. |

**Independent verification:** SIGA/ARCH/CENA must separately prove Godot Web boot, City→Market→City, touch/keyboard/focus, exact semantic IDs, 540×960 and 1080×1920 LENTE page/isolated captures, loading/error/retry, export/Cloudflare, and correct runtime candidate TEST URL. Green CI/LENTE does not imply ARTIST PASS; ARTIST PASS does not imply human runtime ACCEPT.

## ARCHITECTURE_DECISION_RESOLVED — human selected B / SVG 2.5D

- **2026-10-08 human direction:** Godot City R06 uses original independently authored SVG object sprites as **2.5D** layers with illustrated faces, z-order and subtle parallax, not heavyweight volumetric facades. See `spec.md` R06 SVG amendment, R06 plan, tasks and SVG handoff. Upper-building SVGs are `UNREVIEWED` candidate assets, not player-facing accepted art.
- **2026-10-09 human direction:** ARTIST Review Draft v0.2 approved with real Godot 3D geometry as the visual construction criterion. Same concept and style identity; this does **not** constitute approval of any runtime candidate.

**Decision history (closed):** the two earlier user directions were reconciled by the explicit human selection of **B** on 2026-10-09. The following A/B/C options are preserved for audit only; B is selected:
A. **Native Godot 3D:** actual architectural volumes required; existing SVGs optionally reused as original texture/decal sources; orbit/backface visual evidence.
B. **Godot authored SVG 2.5D:** explicit human amendment to the v0.2 geometric requirement and VIS-01, keeping robust parallax/pan evidence.
C. **Godot hybrid 3D+SVG:** real geometry and interactive anchors plus independently authored sprite/texture surfaces; confirm depth with suitable orbit/pan evidence.

**STOP:** Architecture B is now selected and the documentary contracts are aligned, but the user has **not authorized implementation**. Do not start/restart City visual construction, scale sprite assets, mount the compositor, claim ARTIST/RUNTIME ACCEPT or merge. Existing user `REJECT ALL` of implementation head `1f799128d9efe33cfdcb8365119fc2eb2371166e` remains binding; City concept `20261004T110406Z/city` is still approved. R05 PASS, R06 sole current item with blocked execution, R07+ LOCKED.

## R05/R06 provenance and handoff

R05 Market exact-head human acceptance `c6ebed7dc7319df435d2a6ade8ebf09d6fcea68e`; PR #205 was merged 2026-10-04 as `f73190b89bafca1e05310f4f816c2cdc788bd03d`. Do not roll it back. City original PR #190 asset hash is historical and must not be conflated with the 2026-10-04 accepted scene concept run. R06 existing PR #213 remains Draft and the sole work branch. Human A/B/C decision is the next gate. After that and separate implementation authorization, reconcile visual-contract requirements and continue same-head SIGA/LENTE/ARTIST/RELATORIO with `TEST:` exact-head URL or explicit unavailable reason.

## R06 ARCH-GATE-01 — HUMAN DECISION B / SVG 2.5D (2026-10-09)

**Human decision:** `B — Godot authored modular SVG 2.5D`. This explicitly amends the **City R06-only** geometric-construction requirement of ARTIST Review v0.2 and resolves the prior conflict in favor of the 2026-10-08 SVG/2.5D exception. All **G1–G25**, **R1 D, R2 D, R3 D, R4 D, R5 B**, global ARTIST style authority and accepted City concept `20261004T110406Z/city` remain binding. This is **SPEC / ARCHITECTURE APPROVAL ONLY**, not runtime, asset or implementation approval.

**R06 visual production contract:** individually authored transparent editable SVG objects (building faces/roof silhouettes, stairs, storefronts, residents, vegetation, cables and murals), placed in Godot with meaningful near/mid/far z-order, occlusion, controlled parallax and responsive camera/framing. The existing hidden Godot 3D interaction anchors and three semantic IDs may remain; **player-visible heavy 3D meshes are not required** for City R06. No whole-scene wallpaper, giant facade cards, generic repeated stamps, primitive low-poly or empty visual shells. Keep native full-resolution UI and semantic keyboard/touch navigation.

**R1 D / VIS-01 amendment:** "real 3D geometry" and "orbit/backface architectural thickness" in the earlier City Draft v0.2 are superseded **only as R06 visual construction / art-evidence requirements**. VIS-01 now checks *authored architectural front/side/roof depiction, coherent apparent volume, near/mid/far separation, credible occlusion, no paper-card edges/black holes during supported pan, and no generic low-poly*. A 3D orbit/backface test is **not** an R06 art gate; use a bounded horizontal + vertical 2.5D pan/parallax diagnostic. R2 D camera is constrained 2.5D focus/recenter/pan, not free 3D orbit. R5 B remains the objective PASS/FAIL checklist.

**Required evidence:** LENTE exact-head page and isolated City captures at `540×960` and `1080×1920`, bounded two-axis parallax/pan video, responsive touch/keyboard focus and hotspot panel interactions, loading/skip/reduced-motion/error/retry proof, City→Market→City, Godot Web/Cloudflare boot, regression checks and real preview URL from the same commit. ARTIST compares **actual runtime** to accepted City concept and records VIS-01..VIS-08 PASS/FAIL. Human runtime `ACCEPT` is still required for R06 PASS; CI green does not override visual rejection.

**Implementation freeze:** This decision authorizes **documentary reconciliation only**. The two existing upper-building SVG sources remain `UNREVIEWED`; the old player-facing City remains `REJECT ALL`. Do not generate more sprites, activate compositor, change scenes/assets/tests, publish a new visual candidate, merge PR #213 or unlock R07+ until the user approves the next bounded implementation plan. R05 `PASS`, R06 sole current item / `WATCH / IMPLEMENTATION_PLAN_APPROVAL_PENDING`, R07+ `LOCKED`.


## 2026-10-09 — two individual City source SVG ACCEPT decisions

The human inspected actual inline browser-rendered original SVG previews and explicitly approved two **separate assets**: `coral-terrace-house.svg` and `ochre-shop-terrace.svg`. Source-object `OBJECT_ART_ACCEPTED` is recorded with immutable SHA/provenance in [upper REVIEW.md](../../assets/city/v1/svg25d/source/upper/REVIEW.md) and `candidate-family.json`. This does not mark City VIS-01–VIS-08, assembled upper composition, import/render QA, full City scene or runtime accepted. `R06-B-01B` pending; R06-B-02 onward unauthorized. Prior City `REJECT_ALL`, R05 PASS, R07+ LOCKED preserved.

## ARTIST LIGHT-01 — HUMAN APPROVED A / original luminous City reference (2026-10-09)

**Human decision:** "ARTIST Growing-Rio City V1 — escolha de iluminação: A." The approved original concept `20261004T110406Z/city` (SHA-256 `385dfc7ee29cee1a3255036e7bf48f049399a20922623579637d3fea28768123`) is authoritative for the **City R06 lighting and color read**: **bright blue luminous sky, warm painted facades, strong vibrant color contrast and localized practical warmth**. The darker navy-dusk wording previously present in this review is a historical earlier interpretation and **does not override the explicit LIGHT-01=A decision** for City V1. Do not relabel this as a nighttime/near-black City. No new reference image or style version is created.

**ARTIST reading:** retain the original vertical stair spine, dense near/mid/far stacked buildings, vibrant graffiti, colorful shop/street activity, vegetation, cables, patched masonry and legible silhouettes. Warm windows/shop lighting may coexist with a bright blue sky, but broad nighttime navy ambient lighting is not the target. The locked global style board and G1–G25, R1 D/R2 D/R3 D/R4 D/R5 B remain preserved; G3 D is interpreted through the actual human-approved City concept and LIGHT-01=A, not silently changed.

**Next ARTIST review (no execution):** composition continuity between the individually approved upper sprites (`coral-terrace-house.svg`, `ochre-shop-terrace.svg`) and the original central stair spine; check architectural scale, front/side/roof coherence, sightlines, spatial rhythm, foreground–midground–background occlusion, graffiti placement and whether the sprites can occupy the upper zone without making the city read as a pair of disconnected facade cards. Any missing context is **NOT YET VERIFIED**, not approval to generate it.

**Acceptance boundaries:** the two SVG objects remain `OBJECT_ART_ACCEPTED` individually; the family and full City composition remain **NOT ACCEPTED**, City player-facing runtime retains **REJECT ALL**, Godot SVG import/render QA remains **PENDING**, R05 **PASS**, R06 current PR #213 **DRAFT**, R07+ **LOCKED**. This documentary decision **does not authorize** asset generation/modification, compositor activation, runtime edits, tests, deployment or merge. ARTIST only.
