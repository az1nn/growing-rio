# ARTIST-V1 — Pixel Graffiti Urban (APPROVED)

Human approval: **2026-09-30**. This V1 supersedes the earlier exploratory 'Tropical Noir Miniature' proposal in ARTIST-SESSION-001. Existing shipping scenes and visuals remain **NOT YET CONVERTED** until CENA/3JS implementation and screenshot-based acceptance.

## Canonical original artwork

- Original approved board: `assets/art-direction/v1/da-lata-v1-style-board.png` (1672×941; SHA-256 `6f19b2e852ee10fcee8b6e7d16852bb1c03501c0be9ffbb551f842a91bf8ee7d`).
- Full-resolution WebP browsing derivative: `assets/art-direction/v1/da-lata-v1-style-board.webp` (1672×941; SHA-256 `63d91ff2eeecb42de8ab7a5e0da2f8c57f1423ad1f1232e6be074a122138f8b1`). Derivative is not an additional V1 approval.
- Approved game areas: `archive`, `campaign`, `city`, `finale-coda`, `finale-handoff`, `finale-recap`, `finale-selection`, `institutional`, `market`, `narrative`, `operation`.
- These board panels are **directional style reference**, NOT isolated production designs and NOT rendered acceptance evidence. All must be generated and reviewed alone.

## Visual invariant

**Pixel art graffiti urban isometric 3D**: pixel cluster shading, dense but readable physical sets, tagged crown iconography, cracked tile/concrete, modular dark metal and warm workbench materials, playful vivid cyan/hot-pink/orange against inky navy. Strong depth and tactile interactive silhouettes while staying mobile/Web friendly. Graffiti is handmade expressive texture, never a mandate to copy real artists' protected murals. Keep all generated signage generic and author exact in-game text with font assets.

## Palette starting swatches (directional, not measured production calibration)

| Role | Suggested hex |
|---|---|
| Night void | `#080D19` |
| Navy structure | `#172238` |
| Hot pink graffiti | `#F20B75` |
| Electric cyan | `#05BDC9` |
| Spray amber | `#FF9B1A` |
| Accent foliage | `#82D642` |
| Concrete / tile | `#625F66` |

## Concept → implementation gates

`APPROVED V1 BOARD` → `SCENE ISOLATED BRIEF` → `ONE IMAGE GENERATION` → `USER CONCEPT APPROVAL` → `CENA/3JS IMPLEMENTATION` → `LENTE CURRENT/AFTER CAPTURES` → `VISUAL DIFF + CAVEMAN REVIEW` → `RUNTIME INTERACTION / PERFORMANCE GATES` → `USER POST-IMPLEMENTATION ACCEPTANCE` → `NEXT SCENE`.

**Important:** Approved BOARD means approved global style only. No individual scene has been approved, implemented, or visually certified just by this acceptance.

## Start an isolated scene run

From project root:

```bash
python3 tools/artist/artist.py start --scene operation
python3 tools/artist/artist.py start-all --session 20260930T120000Z
python3 tools/artist/artist.py list
python3 tools/artist/artist.py validate
```

`start` writes a fresh immutable-by-default versioned review folder under `artifacts/artist/runs/<session>/<scene>/`, plus `generation-request.json`, scene prompt, CAVEMAN checklist and evidence directories. `start-all` builds a queue with one distinct brief per scene; it does NOT falsely claim that the images were generated. Invoke an image model **once per scene** with that isolated prompt and the V1 board supplied as visual reference; save output then `record` it. Review/approval occurs between scenes. Use `ARTIST operation`, `ARTIST market`, etc. in an agent chat to drive the actual generation. `LENTE` supplies fresh before/after screenshots where its workflow is available.

```bash
python3 tools/artist/artist.py record --run artifacts/artist/runs/<session>/operation --kind concept --file <model-output.png>
python3 tools/artist/artist.py review --run artifacts/artist/runs/<session>/operation --stage concept --decision ACCEPT --reviewer '<human>' --notes 'Approved art silhouette.'
# After CENA/3JS implements and screenshots are captured:
python3 tools/artist/artist.py record --run artifacts/artist/runs/<session>/operation --kind before --file <before.png> --commit <40-hex-base>
python3 tools/artist/artist.py record --run artifacts/artist/runs/<session>/operation --kind after --file <after.png> --commit <40-hex-exact-head>
python3 tools/artist/artist.py compare --run artifacts/artist/runs/<session>/operation
python3 tools/artist/artist.py review --run artifacts/artist/runs/<session>/operation --stage implementation --decision ACCEPT --reviewer '<human>' --notes 'Touch targets, visuals, and rendered exact-head evidence checked.'
```

No runtime acceptance without exact-head **after** evidence, signed-off CAVEMAN analysis and a recorded comparison. Structural/CI tests and an actual touch-interaction test still belong to CENA/SIGA and are not replaced by a concept image.
