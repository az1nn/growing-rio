# Feature 012 — ARTIST V1 runtime parity

**Status:** SPECIFIED / PLAN-ONLY  
**Target maturity:** V1 IMPLEMENTED 1:1  
**Owner route:** SIGA -> ARTIST/CENA -> runtime owner -> LENTE  
**Reference branch:** `feat/artist-isolated-scenes-v1` / PR #190  
**Reference head:** `5ced1c3b7d50f102160eb7f382f0faaf950546e2`

## Problem

DA LATA now has one isolated V1 concept render for each of the 11 canonical player-facing scenes, but the shipped runtime still reflects the previous production-candidate low-poly/primitive visual grammar. Existing Three.js packages were created as isolated reference/parity prototypes, while Godot remains the canonical game runtime and already owns navigation, state, interaction, accessibility, persistence and the shipped Web export.

The product goal is no longer "prove every scene is 3D". It is:

> reproduce the accepted ARTIST V1 scene language in the actual playable game with scene-by-scene visual parity, real 3D geometry and working interactions.

This feature first resolves whether Three.js is useful for that goal, then implements V1 through the smallest architecture that avoids duplicate runtime ownership.

## Canonical V1 references

The 11 generated isolated scene candidates are:

- `assets/art-direction/v1/scenes/operation.webp`
- `assets/art-direction/v1/scenes/market.webp`
- `assets/art-direction/v1/scenes/city.webp`
- `assets/art-direction/v1/scenes/institutional.webp`
- `assets/art-direction/v1/scenes/archive.webp`
- `assets/art-direction/v1/scenes/campaign.webp`
- `assets/art-direction/v1/scenes/narrative.webp`
- `assets/art-direction/v1/scenes/finale-selection.webp`
- `assets/art-direction/v1/scenes/finale-handoff.webp`
- `assets/art-direction/v1/scenes/finale-coda.webp`
- `assets/art-direction/v1/scenes/finale-recap.webp`

**IMPORTANT:** The approved original board `assets/art-direction/v1/da-lata-v1-style-board.png` (SHA-256 `6f19b2e852ee10fcee8b6e7d16852bb1c03501c0be9ffbb551f842a91bf8ee7d`) and `docs/art-direction/v1/README.md` / `docs/art-direction/ARTIST-V1-STYLE.md` are the **locked global visual authority**. The 11 isolated renders in PR #190 are **candidate scene references pending individual human approval**, not eleven automatic overrides of the approved board. The manifest locks their provenance, not their acceptance. See [style-conformance.md](./style-conformance.md).

## Definition of 1:1

"1:1" means runtime parity with the accepted reference at the level a real interactive 3D scene can preserve:

1. camera/framing and portrait composition;
2. major architectural masses and depth layers;
3. location-specific silhouette;
4. the three primary interaction anchors;
5. dominant palette and warm/cool lighting balance;
6. graffiti/pixel-art surface language;
7. prop density and focal hierarchy;
8. lower UI-safe negative space where present;
9. scene-specific atmosphere and distinguishability.

1:1 MUST NOT be satisfied by placing the generated concept image as a flat full-scene wallpaper. The player-visible environment remains real 3D with physical interactive objects.

**User decision (2026-09-30): STRICT STYLE GUIDE.** Reproduce intentional style-compliant DA LATA details (including the approved crown/graffiti identity) faithfully. No agent may arbitrarily restyle, simplify, substitute or remove an intentional guide-compliant detail. Incidental generated material conflicting with the approved guide (including postcard-style real landmarks, photorealistic surfaces, fake UI lettering or unsupported real branding) is NOT production canon even if it appears in a generated isolated render. Preserve its compositional role only through a guide-compliant alternative, document the change, and get ARTIST/CENA scene-concept approval before implementation. A concept/board conflict is a `REVISE` gate, not automatic acceptance of either accidental image detail or unilateral redesign.

## User Scenarios

### US1 — The game looks like V1
When a player opens any canonical destination or finale phase, the runtime reads as the same scene depicted in its V1 isolated concept rather than as the older generic primitive diorama.

### US2 — It remains a game, not a screenshot
The player can identify and activate the scene's physical interaction anchors, with pointer/touch picking and accessible fallback, while the environment preserves real spatial depth.

### US3 — One renderer owns production
The shipped game does not require two independently maintained 3D implementations of the same scene unless a measured product requirement justifies the duplication.

### US4 — V1 stays coherent on mobile Web
At 540x960 and 1080x1920, the scene composition, UI readability, interaction targets and frame-time remain viable in the existing Web/mobile delivery path.

## Functional Requirements

- **FR-001:** Perform and persist a renderer decision for V1 before broad runtime implementation.
- **FR-002:** The renderer decision MUST compare current Godot and Three.js architecture against V1 fidelity, integration cost, interaction ownership, build/deploy path, performance, asset pipeline, testability and maintenance duplication.
- **FR-003:** Godot remains canonical gameplay/domain/persistence owner unless a later explicit architecture specification changes it.
- **FR-004:** Preserve the presentation-only hotspot boundary for all V1 scenes. Human-authorized R06 City exception: modular original SVG sprites in Godot 2.5D with controlled depth/parallax may replace visible architectural 3D; existing Godot 3D collision/hotspot adapters can remain hidden. No change to other scenes.
- **FR-005:** Each scene MUST map its ARTIST interaction foci to physical 3D anchors and accessible fallback controls.
- **FR-006:** The runtime MUST support a pixel-art/graffiti material pipeline suitable for nearest-neighbor authored textures/atlases and/or a bounded scene-only pixelation/palette treatment without degrading the full-resolution UI.
- **FR-007:** Runtime art MUST use repository-owned/generated/licensed assets with provenance recorded; no unknown-license asset is allowed.
- **FR-008:** No generated reference image may be treated as proof of implementation.
- **FR-009:** Each scene requires exact-head LENTE before/after evidence at 540x960 and 1080x1920.
- **FR-010:** Each scene requires an ARTIST/CENA visual decision of `ACCEPT` or `REVISE` against its locked V1 reference.
- **FR-011:** Acceptance MUST evaluate composition, silhouette, depth, palette, graffiti/pixel treatment, lighting, focal objects, safe area and interaction affordance.
- **FR-012:** Existing gameplay, save data, economy, campaign, research, narrative rules and domain determinism MUST remain unchanged unless separately specified.
- **FR-013:** Feature 011 semantic hotspot behavior MUST remain compatible; V1 art may reposition hotspots visually but not change their domain semantics.
- **FR-014:** Finale selection, handoff, coda and recap MUST remain visually distinct even if they share reusable implementation primitives.
- **FR-015:** The implementation MUST preserve current Godot Web export and Vercel delivery unless the renderer decision explicitly selects and specifies a replacement.
- **FR-016:** A single vertical slice (Operation) MUST reach V1 parity before the remaining ten scenes are authorized as a batch implementation.
- **FR-017:** If Three.js is not selected for shipped V1, existing Three.js packages are frozen as reference/prototype assets; deletion is out of scope for this feature.
- **FR-018:** The original approved V1 board and written ARTIST V1 style guide MUST remain global authority over all independently generated scene concepts, implementation convenience, old Godot/Three.js look or model proposals.
- **FR-019:** No isolated scene is an implementation baseline until its board/style conformity has been reviewed and its concept status explicitly recorded as `ACCEPT`; mismatches remain `REVISE`, including tourism-style skylines, incorrect camera, softened pixels or inconsistent graffiti.
- **FR-020:** V1 implementation MUST retain approved DA LATA crown/graffiti identity, readable three-quarter isometric 3D cutaways, consistent chunky pixel scale, limited dark structural palette and controlled magenta/cyan/amber accents; individual scenes remain distinct without departing from the shared art grammar.
- **FR-021:** Runtime review MUST include a board→approved-isolated-concept→runtime trace for each scene, not only a direct comparison against the isolated generated image. Automated checks provide evidence; ARTIST/CENA human style review is the visual acceptance authority.
- **FR-022:** The approved board is a multi-scene moodboard, not a literal UI screen or a license to paste panel crops as runtime backgrounds. Full-resolution in-engine UI text and touch accessibility stay independently authored.

- **FR-023:** Once a production renderer/architecture decision is final, implementation MUST be derived from the accepted ARTIST target and the selected native architecture; frozen/reference renderer prototypes and superseded low-poly blockouts are evidence only and MUST NOT remain the default visual scaffold through cosmetic restyling.
- **FR-024:** A `STRICT_SEQUENTIAL` SIGA roadmap is a hard write fence: no branch, PR, preflight, spec-only successor preparation, implementation or acceptance work may begin for a locked later item until the current item is canonically `PASS`.
- **FR-025:** Repeated ARTIST/CENA structural `REVISE` findings MUST trigger structural replacement/recomposition rather than indefinite additive styling; after two consecutive reviews citing the same structural class of mismatch, the scene enters `STRUCTURAL_REBASE_REQUIRED` before another visual revision.
- **FR-026:** Scene acceptance MUST be target-relative. The review authority compares the global ARTIST board + individually accepted scene concept + exact-head runtime; comparison against the previous runtime build may detect regressions but MUST NOT establish parity by itself.
- **FR-027:** "Improved", "production-candidate", green CI, successful capture, clean console, preserved hotspots or successful deployment are necessary evidence where applicable but MUST NOT be interpreted as visual `ACCEPT` while a material target delta remains.
- **FR-028:** When target parity depends on visual information absent from the current scaffold, implementation MUST perform the necessary asset-production work (for example authored/rebuilt meshes, materials/textures/decals, props, vegetation, signage, dressing, lighting or atmosphere) rather than preserve primitive/blockout geometry solely for reuse convenience.
- **FR-029:** Legacy RB-13/blockout maturity labels are non-authoritative for V1 parity. A scene becomes V1 production-accepted only through the Feature 012 board→accepted concept→exact-head runtime acceptance chain.
- **FR-030:** Until R15 final V1 certification is `PASS`, Feature 012 visual convergence is SIGA's P0 product-delivery stream. Queued later-feature implementation and unrelated optional work MUST NOT preempt the earliest non-`PASS` Feature 012 item.


## Shared interface requirements — DA LATA UI V1

- **FR-031:** Feature 012 MUST define one reusable DA LATA UI V1 visual/interaction system during R05 Market rather than allowing per-scene button styling.
- **FR-032:** The shared system MUST provide semantic Primary, Secondary, Utility, Danger/Risk and Navigation/Tab controls.
- **FR-033:** Shared actionable controls MUST support default, hover/focus, pressed, disabled and active/selected states; progression-gated controls MUST additionally support locked.
- **FR-034:** UI state MUST remain distinguishable through more than color alone and MUST preserve pointer, touch, keyboard/focus and accessible fallback behavior.
- **FR-035:** The shared portrait shell MUST define top status/title, scene-local action and persistent bottom navigation/command regions without obscuring the accepted scene focal composition.
- **FR-036:** DA LATA UI V1 MUST inherit the accepted pixel-art/graffiti/stencil visual language and semantic palette while rejecting generic glossy/mobile and legacy Three.js/low-poly control grammar.
- **FR-037:** Market MUST be the implementation/acceptance pilot. R06+ MUST reuse the accepted shared system and MUST NOT create independent scene-local UI forks without an explicit shared-system revision.
- **FR-038:** Strict sequential execution remains in force: specifying or implementing DA LATA UI V1 inside R05 does not authorize implementation of City or any later roadmap scene.
- **FR-039:** R05 MUST NOT become `PASS` until the shared UI pilot is implemented, regression-tested, captured at both canonical portrait sizes and explicitly human-accepted with the Market runtime.

## Renderer decision acceptance

Three.js is selected for shipped V1 only if the evidence shows a material advantage that outweighs duplicated runtime integration. At minimum it must prove:

- equal or better visual parity to the Operation V1 reference;
- a safe bridge to canonical Godot state without duplicating domain rules;
- equivalent pointer/touch/accessibility behavior;
- a production build/deploy path that is not hand-authored inside generated `web/`;
- acceptable Web/mobile performance;
- lower total implementation/maintenance cost than the Godot-native V1 path.

Absent that evidence, the default decision is Godot-native V1 implementation and Three.js remains a non-production reference lane.

## Scene acceptance contract

For every scene:

1. audit the candidate against the original approved V1 board and written guide, resolving any conflicts through an ARTIST/CENA `ACCEPT` or `REVISE` concept decision;
2. lock the SHA of the individually accepted reference image and the global board/style version;
3. capture current exact-head BEFORE;
4. record a decomposition map: architecture, materials/decals, lights, primary props, interaction anchors, UI-safe area;
5. implement real 3D without guide drift;
6. capture exact-head AFTER at both portrait sizes;
7. compare original board + approved isolated reference vs AFTER with LENTE/model review;
8. record ARTIST/CENA implementation `ACCEPT` or `REVISE`;
9. verify hotspot/fallback behavior;
10. verify browser/page console is clean;
11. merge only with exact-head repository gates green.

## Success Criteria

- **SC-001:** Renderer decision is explicit and evidence-backed.
- **SC-002:** Operation reaches accepted V1 runtime parity without gameplay/persistence changes.
- **SC-003:** All 11 scene/phase references eventually reach `IMPLEMENTATION_ACCEPTED`.
- **SC-004:** No accepted scene is a flat-image substitute for 3D.
- **SC-005:** 540x960 and 1080x1920 exact-head captures remain readable and interactive.
- **SC-006:** Existing semantic hotspot and regression suites remain green.
- **SC-007:** Runtime asset provenance is complete.
- **SC-008:** Production architecture has one primary renderer owner for the shipped scene layer.
- **SC-009:** All 11 accepted scenes pass the shared board/style guide checklist without unresolved style divergences; runtime screenshots are compared against both global board and accepted per-scene concept.

## Out of Scope

- new gameplay systems;
- balance changes;
- save schema changes;
- canon expansion;
- real-world operational cultivation/logistics instruction;
- replacing V1 with V2 art direction;
- literal pixel-perfect reproduction of generated text or accidental reference artifacts;
- deleting historical Three.js work during the decision wave;
- broad engine migration before the Operation vertical slice proves the selected path.


## R04 Candidate 6 bounded acceptance contract

This section specifies the current Operation-only correction authorized after Candidate 5 exact-head `IMPLEMENTATION_REVISE (bounded)`.

Candidate 6 MUST:
- preserve `V1_CAMERA_SIZE = 4.70`, camera Y `6.95`, the compact accepted floor footprint and the three exact semantic hotspot positions;
- keep `OperationV1AcceptedRebuild` as the single visible production root and MUST NOT restore additive Rev1–13 dressing;
- expose the existing shutter / cyan-magenta graffiti / amber crown cluster as a readable center-right back-wall focal element below the HUD interaction stack;
- preserve the canonical `foliage_muted` hue while increasing local garden separation from the petrol wall through presentation-only treatment;
- restore a cool-night counter-tone and concentrate amber energy in local garden, crown, workbench, supply and pendant pools rather than broad global warm flattening;
- preserve gameplay, persistence, economy, cultivation rules, pointer/touch behavior and accessible fallback semantics unchanged.

Candidate 6 acceptance requires:
- structural regression for shutter/crown prominence and exact framing/hotspot invariants;
- structural regression for garden local separation and cool-vs-local-warm hierarchy;
- exact-head Validate project;
- exact-head Visual Acceptance at 540×960 and 1080×1920;
- exact-head LENTE evidence;
- ARTIST/CENA `IMPLEMENTATION_ACCEPTED`.

Until those gates pass, R04 remains CURRENT and no R05+ or successor feature preparation is authorized.


## R06 user amendment — SVG modular 2.5D (2026-10-08)

**Binding decision:** The user authorized a simpler SVG-sprite approach for *City R06 only*, replacing the previous heavy 3D architecture mandate. The existing accepted concept `20261004T110406Z/city`, global ARTIST V1 pixel/graffiti style, current Godot gameplay runtime, semantic actions, persistence, HUD and human REJECT of A/B/C remain binding. In this scene the phrases "real 3D geometry" and "physical 3D architecture" above are superseded **only as visual construction requirements**.

- **R06-SVG-01:** Assemble individually authored transparent SVGs (distinct buildings, side/roof faces, stairs, shops, residents, rails, foliage, wires) as overlapping object sprites with z-order, perspective illustrated in source art and shallow parallax. Neither an entire reference as wallpaper nor five giant façade cards meets parity.
- **R06-SVG-02:** Maintain full-resolution Godot UI, the three exact City hotspot semantic IDs and active touch/keyboard accessibility. Retain hidden 3D interaction anchors if convenient.
- **R06-SVG-03:** Every sprite is an editable repository-owned original with prompt/provenance and ARTIST review; Godot imports/rasterizes SVG for runtime as appropriate; no generated UI text or unsupported vector filters.
- **R06-SVG-04:** Exact-head 540×960 and 1080×1920 page/isolated captures and a **small 2.5D pan/parallax** diagnostic replace *3D backface/orbit* as artistic evidence for City. Interaction/boot and Cloudflare remain real hard gates.
- **R06-SVG-05:** Only target-relative ARTIST review followed by explicit human approval can PASS R06. Old REJECT remains in force meanwhile.

**Implementation handoff:** [R06-CITY-V1-SVG-25D-SPRITE-HANDOFF.md](./R06-CITY-V1-SVG-25D-SPRITE-HANDOFF.md). R07+ remain LOCKED.
