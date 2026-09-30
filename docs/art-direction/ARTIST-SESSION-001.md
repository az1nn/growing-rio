# ARTIST — session 001 / accepted V1 style; scene delivery pending

Date: 2026-09-30. Repository: `az1nn/growing-rio`. PR: #186.

## Verified creative decisions
The original `TROPICAL NOIR MINIATURE` proposal (semi-realistic handcrafted low-poly) was **rejected as too realistic**. The user requested **pixel art + graffiti + urban style**, then explicitly welcomed the complete V1 composition ("Amazing, that's our V1") and asked to save it and implement a one-scene-at-a-time generation/review system. Therefore the **V1 aesthetic grammar is accepted**. This does **not** mean all 11 individual scene concepts, implementation assets, or production renders have been accepted.

### Archived original V1 artwork
The original 1672×941 generated reference has now been recovered, SHA-256 verified and committed at `assets/art-direction/v1/da-lata-v1-style-board.png` (SHA-256 `6f19b2e852ee10fcee8b6e7d16852bb1c03501c0be9ffbb551f842a91bf8ee7d`). `docs/art-direction/v1/README.md` and `SCENES.json` are the approved V1 source of truth. No individual scene is visually implemented merely because this board is accepted.

## Base V1 direction
Hand-authored chunky pixel-art surfaces and graphic graffiti/street-art silhouettes in a fictional Brazilian urban environment; bold limited palette, improvised layered architecture, playful yet atmospheric high-contrast lighting; strong silhouettes; unmistakable 3D room/prop geometry with consistent pixel/texel treatment; portrait UI-safe composition and clickable/touchable foreground objects. **Do not** revert to the realistic, premium-diorama marketing image style.

## Isolated delivery sequence
`operation → market → city → institutional → archive → campaign → narrative → finale-selection → finale-handoff → finale-coda → finale-recap`. Each has its own `concept → human gate → CENA/3JS implementation → new LENTE capture → before/after acceptance` chain. Finale phases share runtime infrastructure but need separately distinguishable illustrations and reviews.

## Immediate target
**OPERATION**, status `STYLE_ACCEPTED / SCENE_CONCEPT_PENDING`. First create a new versioned round with a fresh isolated Operation screenshot and V1 prompt delta. The user approves or revises *that isolated scene* before moving to Market. The accepted montage is a **style anchor**, not a substitute for per-scene approvals.

## Gates
- Visual: individual scene-specific human acceptance remains.
- Asset: original V1 bytes and SHA verified and archived in this ARTIST branch; scene-by-scene implementation still pending.
- Integration: CENA/3JS and exact-head LENTE evidence; no concept illustration counts as shipped 3D.
- Engineering: ARTIST skill and round scaffolder changes must pass exact-head repository CI on this PR.
