# R06 City V1 — Human REJECT ALL / approved-concept visual reconstruction

**Recorded:** 2026-10-08  
**Review authority:** human decision, exact text: **“Reject completo, nada parece com o art concept.”**  
**Rejected player-facing candidate:** `1f799128d9efe33cfdcb8365119fc2eb2371166e`, PR [#213](https://github.com/az1nn/growing-rio/pull/213)  
**Explicit human decision:** `REJECT_ALL / FULL_VISUAL_REBASE_REQUIRED / CONCEPT_PARITY_ZERO`  
**Approved artistic target (unchanged):** `20261004T110406Z/city`, manifest `docs/art-direction/v1/runs/20261004T110406Z-city/MANIFEST.md`  
**Roadmap:** R06 CURRENT; R07+ LOCKED; PR #213 remains Draft, never merge this rejected render.  
**Provenance:** [rejection comment](https://github.com/az1nn/growing-rio/pull/213#issuecomment-6062919224)

## Authority and scope of the rejection

The entire **visible City implementation**, not the previously approved concept, is rejected. This overrides prior `IMPLEMENTATION_REVISE` and all inherited `LOW_POLY_VETO_CLEARED`, `RECOMMEND_ACCEPT` or green-CI optimism on the Rebase A/B/C candidate family. Tests prove health of source/runtime/delivery, **not visual parity**.

The A/B/C raster architecture with large cutout facades, repeated stamped details and thin billboard planes is **not a visual construction baseline**. C1 z-index fix passed structural checks but still failed real portrait full-page readability, so it cannot be accepted as a solved UI issue. Do not launch C2/C3 as densification/polish of these same large cards. Historical files remain for audit and rollback only, not renewed artistic authority.

## Non-negotiable unchanged references

- **Do not generate another concept or change the accepted City image.** Extract the design from that existing target: 9:16 stair-spine urban district with dense irregular multi-story painted homes, roof depth, layered masonry, worn pixel textures, nearby shops and residents, plants/cables, warm points of street light against inky cool night, foreground/mid/upper/far continuity.
- Preserve global approved DA LATA V1 pixel art × graffiti × urban isometric 3D visual grammar.
- Keep Godot native, current functional screen navigation, runtime mobile delivery, interaction semantics and hotspot IDs `city/district_overlook`, `city/route_nodes`, `city/community_cluster`; preserve gameplay, save schema, economy, existing Cloudflare bootstrap and shared DA LATA UI V1 roles.
- Existing physical collision / Godot scaffolding may be reused if **not visible** and if it does not constrain the rebuilt approved composition.

## ARTIST → CENA rebuilt-scene contract

1. **Reference-led reconstruction plan.** Decompose actual accepted target into measured portrait composition regions and spatial placements; build material/shape/scale inventory and scene-to-semantic-anchor mapping. Name the player-visible parts that must be removed/disabled from A/B/C. Draw no new concept and request no second human concept vote.
2. **Real urban form, authored pixel material.** Build an integrated 3D staircase neighborhood with noncoplanar facade faces, buildings/roofs that have irregular recognizable silhouettes and depth, proper pixel-scale authored wear/tiles/shutters/murals; give shops, plants, cables and residents human-scale, meaningful placement. Avoid broad frontal color cards, loose disconnected parallax cutouts, repetitive single-asset stamps, and toy-like boxes as the final visual authority.
3. **Frame and UI.** Maintain visual activity while reserving clear lower portrait space for the **actual** existing game actions/state controls. Solve band geometry, clipping and contrast, not merely z-index. Confirm the screenshot at both 540×960 and 1080×1920; test keyboard and touch navigation.
4. **3D rotation evidence.** Visual completeness must survive several orbit angles: convincing surfaces/silhouettes and occlusion at oblique views, no exposed paper-thin card edges or black void wedges. Preserve real Godot 3D placement/hit areas.
5. **Quality comparison before sending to human.** After one exact-head Validate + Cloudflare/mobile delivery + City Visual + Visual Acceptance + LENTE isolated & page captures (540×960, 1080×1920) + orbit and interaction regression, ARTIST performs pixel-by-pixel concept-relative review. A new user gate is forbidden unless ARTIST explicitly declares `TARGET_PARITY_MET / READY_FOR_HUMAN_RUNTIME_GATE` on **that** exact HEAD. Human retains final ACCEPT/REVISE/REJECT authority.

## Next task

**Owner:** ARTIST reference decomposition complete in [R06-CITY-V1-ARTIST-RECONSTRUCTION-SHEET.md](./R06-CITY-V1-ARTIST-RECONSTRUCTION-SHEET.md); next owner **CENA** executes `R06-REJECT-02` for genuine visual rebuild under SIGA claim and CAS coordination, with `R06-REJECT-03` UI geometry. R06 remains blocked, no merge of #213.
