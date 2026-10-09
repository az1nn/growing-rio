# DA LATA V1 — Lean Scene Art Budget / R06 City application

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

### City R06 — canonical minimal production inventory

| Slot | Visual responsibility | Current evidence | Status |
| --- | --- | --- | --- |
| **BG** (outside 5–6 budget) | Complete sky + cloud + hills + far fictional neighborhood as one coherent background, without baked HUD/interactive street | SKY/01 PNG concept approved; revised SKY/FAR/01 landscape concept approved | **CONCEPT_ONLY — production composite pending** |
| **01** | Coral terrace house (left architectural anchor; authored side/roof read) | `assets/city/v1/svg25d/source/upper/coral-terrace-house.svg` | **OBJECT_ART_ACCEPTED — Godot QA pending** |
| **02** | Ochre shop terrace (right architectural anchor) | `assets/city/v1/svg25d/source/upper/ochre-shop-terrace.svg` | **OBJECT_ART_ACCEPTED — Godot QA pending** |
| **03** | Terrace and rooftop water tank, coherent single module | Isolated UPPER/03 PNG concept | **CONCEPT_OBJECT_ACCEPTED — production asset pending** |
| **04** | Complete descending stairs, turning landing, both rails and stair wear *in one primary asset* | Accepted City concept reference | **NOT PRODUCED** |
| **05** | Inhabited commercial landing / plaza: readable shop/stall, awnings and integrated residents *in one primary asset* | Accepted City concept reference | **NOT PRODUCED** |
| **06** (optional) | Foreground human / near-life focal when composition actually needs it | Accepted City concept reference | **OPTIONAL / NOT PRODUCED** |

**Scope accounting:** five planned core primary slots 01–05, one optional 06, one composed BG. This is an **art budget, not a claim that five production-ready assets exist**. Existing older City raster/card/rebase assets are retained as historical rejection evidence, not counted as accepted principal art.

### Depth and acceptance with full 2D

The frame must read clearly **foreground stairs → inhabited mid commerce → staggered upper homes → cool bright far skyline**. Keep the approved daylight choice `LIGHT-01=A`. Depth can be entirely authored in a static 2D arrangement; optional subtle Godot parallax may enrich it, but does not justify multiplying layers. The background cannot swallow the stairs, commerce, semantic interaction targets or HUD. No wallpaper-only scene or generic low-poly look.

### Binding preservation / scope fence

- Preserve global `ARTIST-V1-PIXEL-GRAFFITI-URBAN`, approved City concept `20261004T110406Z/city` (SHA-256 `385dfc7ee29cee1a3255036e7bf48f049399a20922623579637d3fea28768123`), G1–G25 and earlier R1 D/R2 D/R3 D/R4 D/R5 B as **historical signed decisions**, with this newer user simplification governing conflicting *construction granularity / mandatory parallax / SVG-only* requirements.
- Do not change the two approved SVG source bytes or treat isolated PNG concepts as repository-committed production sources. Keep evidence/provenance and independent review gates.
- **Documentation decision only:** no new art, asset import, `layers.json`, compositor activation, runtime candidate, visual accept, CI-pass assertion or PR merge is authorized here.
- **R05 PASS; R06 CURRENT / implementation plan pending; R07+ LOCKED; old City runtime REJECT_ALL persists**. Next: ARTIST applies this budget to the existing R06 plan and brings one BG + five-primary composition proposal before engineering authorization.
