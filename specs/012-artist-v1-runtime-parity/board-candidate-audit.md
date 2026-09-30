# T007 — V1 board ↔ isolated-candidate conformance audit

**Audit date:** 2026-09-30  
**Board authority:** `assets/art-direction/v1/da-lata-v1-style-board.png` — SHA-256 `6f19b2e852ee10fcee8b6e7d16852bb1c03501c0be9ffbb551f842a91bf8ee7d`  
**Candidate set:** PR #190 / master `a96334107da56ff48d57b987b6177359e890716d`  
**Written contract:** `docs/art-direction/v1/README.md`, `ARTIST-V1-STYLE.md`, `BASE-PROMPT.md`, `SCENES.json`  
**Scope:** visual conformance only. This audit does **not** grant human concept acceptance and does not prove runtime 3D.

## Decision vocabulary

- `PASS_TO_HUMAN_REVIEW`: candidate is materially consistent with the board + written V1 contract; human concept ACCEPT/REVISE remains required.
- `REVISE_REQUIRED`: concrete divergence from a higher-authority V1 rule exists; do not use as the locked runtime target until a new isolated ARTIST round is generated and reviewed.

## Scene audit

| Scene | Camera / silhouette | Pixel / graffiti / palette | Geometry & interaction foci | Unapproved or conflicting detail | Audit |
| --- | --- | --- | --- | --- | --- |
| operation | Strong portrait three-quarter workshop; compact upper/mid staging with lower UI-safe void. More open-rooftop than board room, but same first-read workshop silhouette. | Chunky pixel language and navy / amber / cyan / magenta balance are coherent; crown wall mark is strong. | Workbench, abstract plant cluster and inventory shelving are physically distinct and readable. | Plants are more naturalistic than the board, but still stylized and non-instructional; no postcard landmark or baked UI text observed. | **PASS_TO_HUMAN_REVIEW** |
| market | Kiosk reads immediately, but the composition expands into a scenic hillside-city vista instead of staying as tightly staged as the board kiosk. | Good warm-stall / cool-night palette and graffiti energy; texel density becomes much finer in the background. | Counter / crates / sign-board roles are readable. | Distant Rio-postcard-style hill/landmark silhouette conflicts with “no postcard monuments”; background realism pulls focus from the fictional booth. | **REVISE_REQUIRED** |
| city | Strong vertical neighborhood chunk, but dominated by a scenic bay/hills horizon rather than the board’s compact invented city mass. | Graffiti and crown vocabulary are present; fine background detail weakens the board’s chunky apparent texel scale. | Multi-level rooftops / routes are legible. | Explicit postcard-Rio cues (bay + landmark silhouette / tourist framing) violate the fictional no-postcard rule. | **REVISE_REQUIRED** |
| institutional | Office function is readable, but the open scenic exterior competes with the compact satirical-office silhouette. | Palette is compatible, but graffiti/crown identity is too restrained versus the board and shared V1 grammar. | Desk / forms-board / service area are physically separable. | Postcard-style Rio hill/landmark appears outside; overall scene drifts toward generic realistic office rather than strongly DA LATA-authored institutional space. | **REVISE_REQUIRED** |
| archive | Good narrow archive/workroom and strong crown; shelves / desk / terminal read clearly. | Pixel palette is coherent, though texture detail is finer and more naturalistic than the board. | Drawer / evidence board / terminal affordances are present. | Prominent plant-leaf iconography and a real-map-like evidence panel are not part of the archive brief and risk shifting the scene away from collective-memory/document identity. | **REVISE_REQUIRED** |
| campaign | Planning-table silhouette is immediate and physically staged. | Warm practical light and graffiti are coherent; background detail again becomes finer than the board. | Table map / timeline-board / mission-board roles are recognizable. | Oversized plant-leaf mural and plant-diagram side board add unsupported/operational visual semantics; distant landmark/postcard cue conflicts with the fictional-world contract. | **REVISE_REQUIRED** |
| narrative | Rooftop conversation space, sunset and bench-like staging are readable, with useful portrait depth. | Strong hot magenta-orange / navy mood; pixel treatment is attractive but more scenic/realistic than the board. | Story mural / memory props / event-space zones can be separated. | Giant plant-leaf mural dominates the story signal; coastal/postcard Rio silhouette creates unsupported real-place specificity. | **REVISE_REQUIRED** |
| finale-selection | Three physical doorway choices are strongly separated and phone-readable; central axis matches the board’s theatrical choice staging. | Crown/graffiti language and tri-color lighting are coherent with V1. | Left / center / right choices have materially different physical contents, so meaning is not color-only. | Exterior skyline should remain fictional in runtime; no baked labels or explicit real landmark dominate the candidate. | **PASS_TO_HUMAN_REVIEW** |
| finale-handoff | Passage/gate silhouette is strong and distinct from the other finale phases. | Palette and crown treatment fit V1; geometry is clear. | Transition door and crate-like equipment are readable; departure marker can be strengthened. | Clear Rio-postcard landmark silhouette in the distant opening violates the no-postcard rule and should be replaced with invented urban depth. | **REVISE_REQUIRED** |
| finale-coda | Distinct quiet memorial-court composition with strong empty approach space and central mural. | Crown mural, candlelike warm points and teal/pink accents align well with the board. | Legacy symbol / timeline-object zone / continue path can be mapped physically. | Waterfront/horizon must remain fictional when modeled; candidate does not rely on baked text or obvious real branding. | **PASS_TO_HUMAN_REVIEW** |
| finale-recap | Physical recap corner is readable and compositionally distinct from selection/handoff/coda. | Strong crown identity and compatible palette; board-like desk/screen/object cluster is present. | Results monitor and multiple physical record/trophy objects are clear. | Distant postcard-Rio landmark silhouette conflicts with the fictional-world rule; retain blank displays but replace the real-place horizon. | **REVISE_REQUIRED** |

## Result

- `PASS_TO_HUMAN_REVIEW`: **operation, finale-selection, finale-coda**.
- `REVISE_REQUIRED`: **market, city, institutional, archive, campaign, narrative, finale-handoff, finale-recap**.
- Human concept decision remains **pending for all 11 scenes**.
- No candidate is promoted to `SCENE_CONCEPT_ACCEPTED` by this audit.

## Operation-first gate

Operation is the first candidate that can now be shown for an explicit human `ACCEPT` or `REVISE` without another generation. Its accepted SHA, if approved, remains candidate SHA-256 `3ae82a5638e60666de27b7d8deec37cadda2e86e031d88b0dda72658171036ce`.

The other eight divergent candidates enter T008 as isolated regeneration work. Their revision prompts must preserve the approved board grammar and remove the concrete divergences above rather than inventing a new look.
