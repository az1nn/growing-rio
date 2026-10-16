# DA LATA V1 — Lean Scene Art Budget / R06 City application

> **2026-10-12 HUMAN-APPROVED V2 DISTRIBUTION:** the five principal slots are **01 Coral house+integrated already-approved water-tank/terrace concept, 02 Ochre shop house, 03 inhabited commercial plaza (revised historical CITY/05 concept human-approved), 04 continuous stairs, 05 REQUIRED foreground player**. One BG is outside the five; sixth optional only if necessary. See [ratified V2 decision](./R06-CITY-V2-HUMAN-APPROVED-COMPOSITION.md). Original art decisions remain valid, separate import/production and runtime gates CLOSED. This newer inventory supersedes the previous table below where inconsistent.


**Decision:** `HUMAN_APPROVED / DOCUMENTARY_RECONCILIATION` — 2026-10-09.
**Repository:** `az1nn/growing-rio`; **PR:** #213 (Draft); **current roadmap:** R06 only.
**Authority:** current user instruction to reduce ARTIST production to **5–6 principal scene assets, plus one composited background and optional reusable generic details**. This dated rule supersedes older R06 source-module inventories requiring separately authored houses, awnings, rails, residents, vegetation, cables and mural variants. Historical provenance and human decisions remain intact.

## Scene-level production policy (V1 planning baseline)

1. **One BG layer:** composed atmosphere / sky / far neighborhood. The background may contain many painted details but is managed as **one scene asset**. It is not an accepted entire-scene wallpaper, HUD bake, or replacement for interactive foreground elements.
2. **Five principal scene assets by default; six maximum.** A principal asset is a coherent visual unit (e.g. a whole stair corridor with rails and wear, a commerce landing with stall and residents). Do not split internal decor into independent sprites merely to count more art tasks.
3. **Generic dressing is included** in the BG/principal artwork or drawn from a shared reusable library (foliage, cables, shutters, graffiti accents, signs). Repeated generic details are not automatically additional scene-specific review gates.
4. **No speculative variant churn.** Create a new variant only for a demonstrated visual mismatch, legibility failure, interaction requirement or explicit human request. Do not turn the old 23-item granular inventory into a production queue.
5. **Godot remains canonical; full 2D OR shallow 2.5D is acceptable** if the finished frame makes near/mid/far depth obvious through scale, overlap, perspective, atmospheric values/shadow and visual hierarchy. Parallax is OPTIONAL, not compulsory. SVG is an acceptable editable authoring format, not a mandate for each new element; use appropriate SVG/PNG and retain provenance. No player-facing low-poly box scaffold or broken card seams.
6. **ARTIST acceptance remains substantive:** visual quality and concept fidelity are assessed on the assembled frame, not by counting layers. Individual human object/concept acceptances remain narrowly scoped; they do not approve composites, import QA or the runtime.
7. **No engineering gate is weakened:** preserve original Godot gameplay/persistence, City IDs `city/district_overlook`, `city/route_nodes`, `city/community_cluster`, R05 shared DA LATA UI and accessible touch/keyboard actions. Require same-head real browser/Cloudflare Web, LENTE full-page + isolated City 540x960 and 1080x1920, UI non-overlap, navigation/input tests, VIS-01..VIS-08 target-relative review and explicit human runtime ACCEPT. Test bounded pan only when parallax/pan exists; never require a fake 3D orbit or parallax solely to pass an old gate.

### City R06 — current five visual slots (ratified 2026-10-12)

| Current slot | Coherent responsibility | Decision / production gate |
| --- | --- | --- |
| **BG** (outside count) | One composed sky/cloud/hills/far neighborhood | Approved SKY/01 + revised SKY/FAR/01 concept refs; production BG PENDING |
| **01** | Coral house **including** rooftop water tank/terrace in one coherent visual unit | Coral SVG individually ACCEPTED; UPPER/03 PNG concept separately ACCEPTED; combined production + import QA PENDING |
| **02** | Ochre shop house on right, native silhouette | Ochre SVG individually ACCEPTED; Godot import QA PENDING |
| **03** | Inhabited plaza/commerce with awnings/residents integrated | Revised historical CITY/05 concept independently ACCEPTED; [review](./R06-CITY-COM-05-CONCEPT-REVIEW.md); exact approved conversation PNG SHA-256 VERIFIED (`a69f5758…48c262`); GitHub binary archive PENDING, no revised SVG |
| **04** | Continuous worn stair corridor, landing, both rails | Second STAIR/01 PNG concept ACCEPTED; production sprite/import QA PENDING |
| **05** | **Required** visible foreground player/protagonist, establishes scale and focus | Composition ROLE ACCEPTED; isolated asset/source art PENDING |
| **06** optional | Only when assembled visual evidence justifies one further unit | NOT REQUIRED/NOT AUTHORIZED |

Older names `UPPER/03` and `CITY/05` are *original approved concept IDs*, not the revised slot numbers. Do not silently erase approvals or treat design references as new committed Godot production art. Scope and gates are defined in [V2 composition](./R06-CITY-V2-HUMAN-APPROVED-COMPOSITION.md).

### Depth and acceptance with full 2D

The frame must read clearly **foreground stairs → inhabited mid commerce → staggered upper homes → cool bright far skyline**. Keep the approved daylight choice `LIGHT-01=A`. Depth can be entirely authored in a static 2D arrangement; optional subtle Godot parallax may enrich it, but does not justify multiplying layers. The background cannot swallow the stairs, commerce, semantic interaction targets or HUD. No wallpaper-only scene or generic low-poly look.

### Binding preservation / scope fence

- Preserve global `ARTIST-V1-PIXEL-GRAFFITI-URBAN`, approved City concept `20261004T110406Z/city` (SHA-256 `385dfc7ee29cee1a3255036e7bf48f049399a20922623579637d3fea28768123`), G1–G25 and earlier R1 D/R2 D/R3 D/R4 D/R5 B as **historical signed decisions**, with this newer user simplification governing conflicting *construction granularity / mandatory parallax / SVG-only* requirements.
- Do not change the two approved SVG source bytes or treat isolated PNG concepts as repository-committed production sources. Keep evidence/provenance and independent review gates.
- **Documentation decision only:** no new art, asset import, `layers.json`, compositor activation, runtime candidate, visual accept, CI-pass assertion or PR merge is authorized here.
- **R05 PASS; R06 CURRENT / implementation plan pending; R07+ LOCKED; old City runtime REJECT_ALL persists**. Next: human approved the V2 five-slot composition; archive the recovered/verified exact revised CITY/05 PNG in immutable GitHub evidence (SHA-256 `a69f5758f1c463615e33a6372fd6393b8422a49b00cf007cf8239b8dcb48c262`); keep separate R06-B-PLAN-GATE for implementation. No additional asset generation is authorized.

### 2026-10-10 STAIR/01 production boundary

User **accepted** the latest STAIR/01 visual concept. This approval does not add a sixth compulsory asset or permit slicing every decor item into variants. The image depicts a rich environment containing structures and commerce adjacent to the stairs. Keep it as an immutable visual reference while producing only **one** core staircase module later; avoid double-counting or double-drawing buildings and BG already owned elsewhere. The [STAIR/01 review](./R06-CITY-STAIR-01-CONCEPT-REVIEW.md) records exact image provenance and human decision. `04` remains non-production until separated and verified in the Godot composition. R06 gameplay/runtime/human gates remain unchanged.
