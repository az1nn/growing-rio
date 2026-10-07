# R06 — City V1 execution plan

**Parent feature:** Feature 012 — ARTIST V1 runtime parity  
**Roadmap item:** R06 — City V1  
**Status:** CURRENT — VISUAL CONSTRUCTION REBASE / CANDIDATE 13  
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

2. **T051-B — ARTIST concept gate — COMPLETE**
   - Generate exactly one isolated 9:16 City environment concept from locked base prompt + City delta.
   - Preserve the approved pixel-art × graffiti × urban diorama grammar.
   - No contact sheet, generated UI text, tourist landmark, flat 2D substitute or gameplay implementation.
   - Human decision must be explicit: ACCEPT / REVISE / REJECT.

3. **T051-C — ARTIST ledger — COMPLETE**
   - Persist artifact path, provenance/hash and explicit concept acceptance.
   - Update `SCENE-STATUS.json#city` to concept accepted only after human ACCEPT.

4. **T051-D — CENA decomposition — COMPLETE**
   - Map architecture, depth layers, materials/decals, lights, three interaction anchors and lower UI-safe region.
   - Produce a build sheet that is implementable in native Godot.

5. **T051-E/F — Runtime + regression — CURRENT**
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


## Candidate 1 review / Candidate 2 structural rebase

Candidate 1 exact head `02ea25ea35544dafa870b378e4f1f3d10eb6a706` passed repository, visual-capture and LENTE automation, but target-relative review is `REVISE / STRUCTURAL_REBASE_REQUIRED`.

Material deltas versus the accepted City concept:
- composition still reads as a detached miniature rather than a lived-in descending neighborhood;
- painted masonry/facade texture and graffiti rhythm are under-authored;
- activity/people/vegetation/utility detail is too sparse;
- neon-flat materials suppress the warm painted-wall language;
- depth exists structurally but is visually compressed by shadowless lighting and sparse far/mid dressing.

Candidate 2 therefore replaces the presentation layer structurally rather than adding another cosmetic pass: modeled shadows, warmer painted masonry palette, denser facade dressing, rooftop utility silhouettes, people/planters/practicals, stair-edge graffiti rhythm, deeper far-city band, and a larger portrait scene field. Gameplay/state/persistence, semantic hotspot IDs and DA LATA UI V1 remain fenced.


## Candidate 3 target-relative review / Candidate 4 directive — 2026-10-04

Candidate 3 exact head `07c5256689fa171290de9c9b07c28eb8af4e8797` passed Validate `37202418611`, Visual Acceptance `37202418673`, LENTE `37202418725` and Vercel, but actual-pixel review at 540×960 and 1080×1920 remains `REVISE / STRUCTURAL_REBASE_REQUIRED`.

Observed against accepted City concept `20261004T110406Z/city`:
- cool-night/value hierarchy improved and the stair spine/three semantic anchors remain legible;
- architecture still reads as simplified box primitives rather than dense patched masonry/facade language;
- neighborhood activity is materially under-authored: people, vegetation, awnings, shopfront clutter and utility detail are sparse;
- large graffiti/mural identity from the accepted target is still absent or too weak to function as a focal system;
- background depth collapses into dark empty space instead of layered fictional urban density;
- the result therefore remains visually closer to a stylized low-poly blockout than the accepted pixel × graffiti urban target.

**Candidate 4 bounded directive:** preserve camera, semantic IDs, gameplay/state/persistence and DA LATA UI V1, but structurally replace the remaining primitive facade presentation with authored masonry/facade dressing; add readable mural/graffiti planes, lived-in people/planter/awning/utility clusters, and a denser far-city depth band. Keep cyan/magenta/amber as accents on worn surfaces rather than full-object neon. Return through exact-head Validate → Visual Acceptance → LENTE before any human runtime ACCEPT request.

R07+ remain LOCKED.


## Candidate 4 review / Candidate 5 convergence — 2026-10-04

Candidate 4 exact head `374bc8a7befc62aeb77fbdf6d7fdeeda447ade9a` passed Validate `37236151542`, Visual Acceptance `37236151511` and LENTE `37236151577`. Exact 540×960 and 1080×1920 page/isolated evidence was compared to accepted City concept `20261004T110406Z/city`.

Decision: `REVISE / COMPOSITION_DENSITY_CONVERGENCE_REQUIRED`.

Candidate 4 materially adds facade relief, mural primitives, shopfront/utility dressing and a second far-city band, but the portrait read remains too miniature/blocky and dark relative to the accepted composition. The stair/neighborhood field is undersized in frame; lived-in people/vegetation/shopfront activity and mural identity remain secondary; far depth remains visually compressed.

**Candidate 5 bounded directive:** retain native Godot 3D, gameplay/state/persistence, all three semantic IDs and DA LATA UI V1. Increase scene occupancy/readability, add larger authored facade/mural planes, denser mid-field activity, rooftop utilities and a third far-depth silhouette band, and lift cool-night readability without converting the scene to neon/daylight. Re-run exact-head Validate → Visual Acceptance → LENTE before any human runtime `ACCEPT`.

R07+ remain LOCKED.


## Candidate 5 review / Candidate 6 target recompose — 2026-10-04

Candidate 5 exact head `8e860843f74209cad8da62f67333ff3d2760d426` passed Validate `37237100452`, Visual Acceptance `37237100475`, LENTE `37237100411` and Vercel READY. Exact 540×960 and 1080×1920 page/isolated evidence was inspected against accepted City concept `20261004T110406Z/city`.

Decision: `REVISE / TARGET_COMPOSITION_RECOMPOSE_REQUIRED`.

Candidate 5 improved density but still reads as a small dark low-poly diorama: the accepted descending-stair neighborhood is undersized in-frame, mural/graffiti remains secondary, lived-in figures/vegetation/shopfront activity are weak, and far depth lacks the target's layered urban read. LENTE measured 81–87% dark-pixel share across the four captures, matching the observed legibility loss but not serving as the decision by itself.

**Candidate 6 bounded directive/execution:** keep native Godot 3D, gameplay/state/persistence, all three semantic IDs and DA LATA UI V1; move the camera closer, lift cool-night ambient/key light, add a large mid-field mural gateway, foreground player + street-life/planter/awning cluster, stronger stair framing and a higher far-depth silhouette band. Re-run exact-head Validate → Visual Acceptance → LENTE before any human runtime `ACCEPT`.

R07+ remain LOCKED.


## Candidate 8 hard rejection / Candidate 9 authored-surface rebase — 2026-10-05

Candidate 8 exact head `df5a05ee4f7fe2ee549311f4f7ee8b393680b6c4` is technically green but visually `REJECT / LOW_POLY_FORBIDDEN` after inspection of the real 540×960 and 1080×1920 captures. Candidate 9 is the required construction-strategy rebase: nearest-filtered authored pixel surfaces for masonry/paint/tile/metal, mural/graffiti facade skins, irregular ArrayMesh roof silhouettes and layered textured urban depth. Candidate 9 must not add BoxMesh geometry in its corrective function.

T051-E/F remain CURRENT. T051-G requires exact-head Candidate 9 evidence. T051-H/I remain blocked until explicit human ARTIST/CENA runtime ACCEPT. R07+ remain LOCKED.


## Candidate 9 hard rejection / Candidate 10 presentation rebase — 2026-10-05

Candidate 9 exact head `56bfd8426b2dea1393c1338c94b93736bf2eac42` passed Validate and Visual Acceptance, but its real portrait captures remain `REJECT / LOW_POLY_FORBIDDEN`: authored texture breakup did not remove primitive-box architectural massing.

Candidate 10 is the second construction-strategy rebase. Player-visible primitive architecture and Candidate4–9 presentation layers are demoted; authored transparent pixel-art facades, murals, street-life clusters and far-city strips occupy multiple native-Godot 3D planes around the preserved physical stair corridor and semantic interactions. Candidate 10 corrective code must contain no BoxMesh generation.

T051-E/F remain CURRENT. T051-G now requires exact-head Candidate 10 evidence. T051-H/I and R07 remain blocked pending explicit human runtime ACCEPT.


## Candidate 11 review / production-asset gate — 2026-10-05

Candidate 11 exact head `e9e5b9aed409f8c790d93141de8a980bf80a3e11` passed Validate `37311118312`, Visual Acceptance `37311118411` and Vercel. Exact portrait artifact `11345487303` confirms the low-poly construction failure is cleared, but the runtime remains materially below accepted concept `20261004T110406Z/city` in authored facade detail, residents, vegetation, commerce clutter and environmental depth.

Decision: `IMPLEMENTATION_REVISE / AUTHORED_ASSET_PIPELINE_REQUIRED`.

T051-E/F remain CURRENT. The next implementation is an ARTIST/CENA append-only production-asset session with provenance-tracked City assets integrated into the existing 3D interaction/depth scaffold. Further primitive/procedural-box convergence is forbidden. T051-H/I and R07 remain locked until exact-head evidence plus explicit human implementation ACCEPT.


## Candidate 12 human rejection / Candidate 13 volumetric construction rebase — 2026-10-05

Candidate 12 exact runtime head `984967cb8f3448ba6d26309a0f6f0d665acae14c` received authoritative human `REJECT / LOW_POLY_FORBIDDEN`. The persisted rejection on `0a5ee01c0cb39bb70078ebc68e3dc4253989aa1c` supersedes Candidate 11/12 provisional baselines. Exact-head Validate, Visual Acceptance, Vercel and LENTE are terminal green; those technical gates do not override the visual veto.

Candidate 13 is a construction-strategy rebase, not a polish pass. It demotes the dominant Candidate 10–12 flat facade/mural cards, replaces player-facing near/mid architecture with lit nearest-filtered extruded ArrayMesh volumes using the authored City pixel-surface vocabulary, replaces the visible box-step staircase with textured custom volumes, and switches the City presentation to perspective depth. Gameplay/state/persistence, three semantic hotspot IDs, DA LATA UI V1 and native Godot interaction remain fenced.

T051-E/F remain CURRENT until exact-head Candidate 13 pixels are reviewed. T051-G must now produce Validate + Visual Acceptance + LENTE at 540×960 and 1080×1920. Any remaining material low-poly read is an immediate `REJECT / LOW_POLY_FORBIDDEN`; only explicit human `ACCEPT` may complete T051-H/I and unlock R07.

## Candidate 17 post-polish review / portrait convergence — 2026-10-07

Exact-head `99aea15c92fac2db053dd65613b2d5b106a08806` passed Validate `37636666525`, Visual Acceptance `37636666492`, City visual acceptance `37636666775`, Cloudflare preview and LENTE `37636666631` (artifact `11489904244`). ARTIST consumed the real 540×960 + 1080×1920 page/isolated evidence against accepted City concept `20261004T110406Z/city`.

Decision: `IMPLEMENTATION_REVISE / LOW_POLY_VETO_CLEARED / PORTRAIT_DENSITY_GAP`.

The authored Candidate 17 construction remains valid and must be preserved. The remaining target-relative deltas are the large lower portrait void, repeated stamped crown/mural identity and insufficient lived-in foreground density. This bounded continuation tightens/repositions the orthographic framing, extends the authored stair/forecourt toward camera with non-primitive ArrayMesh geometry, diversifies dominant facade murals and adds foreground residents/vegetation. Gameplay/state/persistence, three semantic hotspots, DA LATA UI V1 and R07+ lock remain unchanged.

Next gate: exact-head Validate → Visual Acceptance → LENTE → ARTIST target-relative review. Human runtime ACCEPT remains blocked until ARTIST marks the resulting exact head eligible.

## Candidate 17 exact-head review / stair-life convergence — 2026-10-07

Exact-head `6ca0ac6493cd3152dcc314512ac375e3fd5d0210` completed Validate `37639750448`, City visual acceptance `37639750880`, Visual Acceptance `37639750606`, LENTE `37639750521` / artifact `11492931874`, and Cloudflare preview delivery. ARTIST consumed the real 540×960 + 1080×1920 page/isolated evidence against accepted City concept `20261004T110406Z/city`.

Decision: `IMPLEMENTATION_REVISE / LOW_POLY_VETO_CLEARED / STAIR_LIFE_DENSITY_GAP`.

Candidate 17 remains the accepted construction strategy. The remaining target-relative delta is narrower: the 22-step central corridor still reads too uniformly tiled, lived-in activity is sparse through the middle field, the crown should remain one signature rather than a repeated facade stamp, and mid-depth separation can be improved without changing the night grammar.

**Bounded continuation:** alternate authored tile/masonry/paint-wear materials through the existing ArrayMesh stair spine; add two authored side shop/awning pockets, four residents and two plants along the stair corridor; keep only the central crown gateway as the signature mural; add one restrained cool mid-depth light. Preserve camera grammar, gameplay/state/persistence, semantic City hotspots, DA LATA UI V1, native Godot ownership and R07+ lock.

Next gate: freeze one new exact head and run Validate → City Visual Acceptance → Visual Acceptance → LENTE → ARTIST. Human runtime ACCEPT remains blocked until ARTIST marks that exact head eligible.

