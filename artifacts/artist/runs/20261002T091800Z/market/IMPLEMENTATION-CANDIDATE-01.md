# R05 Market — implementation Candidate 1 visual review

Decision: **IMPLEMENTATION_REVISE / STRUCTURAL**

Repository: `az1nn/growing-rio`  
Branch: `feat/012-r05-market-v1`  
Exact reviewed head: `164746808577bb0ea3a080ddc283da557bf4b471`  
Accepted concept run: `20261002T091800Z/market`

## Exact-head evidence consumed

- Validate project run `37072634586`: **SUCCESS**
- Visual acceptance capture run `37072634711`: **SUCCESS**
- Vercel exact-head status: **SUCCESS**
- browser console errors: **0**
- 540×960 capture SHA-256: `704e8919caeb92be15b929de5f879fe78abe261de912e29f50e919a6808b8f0d`
- 1080×1920 capture SHA-256: `d657b893d9e812d5f0d87cf3a6b45e90d223f6da62748bb5f2582d7b74037d99`
- GitHub artifact: `11255716547`

## Target-relative review

Technical delivery is green, but technical green is not visual acceptance.

Observed runtime versus the approved Market concept:

- **composition:** runtime remains too zoomed-out and leaves a large empty lower field; accepted target is a dense, close market interior;
- **vendor presence:** accepted target has a strong human/vendor silhouette behind the counter; runtime has none;
- **merchandise density:** accepted target uses layered shelf inventory and authored clutter; runtime shelves are largely empty;
- **channel sign:** accepted target has a dominant physical channel/menu board; runtime only exposes thin accent geometry;
- **graffiti/crown:** authored V1 identity exists in geometry but is mostly occluded/weak in the actual portrait render;
- **pixel treatment:** runtime is still visually smooth/flat rather than using the shared scene-only nearest-neighbor V1 pixel policy;
- **material/depth language:** the scene still reads as a clean primitive blockout rather than the approved chunky graffiti urban diorama.

## Decision

`REVISE` — structural, not cosmetic.

Candidate 2 must close those classes of mismatch before any runtime ACCEPT can be considered. Gameplay/economy/persistence and the canonical Market hotspots remain frozen.
