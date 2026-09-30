# R01 — Operation renderer evidence spike

**Roadmap item:** R01  
**State:** PASS candidate package  
**Purpose:** bounded evidence for the renderer decision only. This is **not** Operation V1 runtime acceptance.

## Accepted target

- Global ARTIST V1 board SHA-256: `6f19b2e852ee10fcee8b6e7d16852bb1c03501c0be9ffbb551f842a91bf8ee7d`
- Human-accepted Operation concept SHA-256: `3ae82a5638e60666de27b7d8deec37cadda2e86e031d88b0dda72658171036ce`
- Canonical ARTIST state: `CONCEPT_ACCEPTED` via run `20260930T103636Z/operation`.

## Canonical baseline — same-head Godot + Three.js

**Exact head:** `ad66752650461676a621bbbf45e57daabe5ac67a`  
**Workflow:** `Feature 012 Operation renderer evidence`  
**Run:** `36761814609` — **SUCCESS**

The workflow built both renderer candidates from the same checkout and captured both at:

- 540×960
- 1080×1920

Capture bytes were produced as GitHub Actions artifact **11119236628** from run `36761814609` (14-day workflow retention). The repository does not contain the previously claimed `artifacts/feature012/...` directory; durable measurements, exact commit/run identifiers and review conclusions are persisted in this document. Do not cite a nonexistent repository evidence path.

### Baseline Godot facts

- Canvas exactly fills both requested viewports.
- Browser/page error list: empty.
- Exact Web export sizes:
  - `index.pck`: **8,308,868 bytes**
  - `index.wasm`: **39,514,754 bytes**
  - `index.js`: **279,815 bytes**
- Existing authored full-resolution UI, canonical state/navigation and Operation 3D remain integrated in one Godot runtime.

Visual observation: the existing Operation is a functional 3D blockout, but it is materially below the accepted ARTIST V1 target in pixel/graffiti identity, prop density, lighting and authored environmental detail.

### Baseline Three.js facts

At both portrait targets:

- `three@0.186.1`
- draw calls: **49**
- triangles: **1,932**
- geometries: **4**
- authored scene textures: **0**
- renderer textures: **1**
- materials: **8**
- DPR: **1**
- shadows: **false**

Visual observation: the isolated Three.js reference reproduces the existing primitive Operation massing, but it is also materially below the accepted ARTIST V1 target and is not part of the shipped game/runtime.

## Bounded T013 spike

**Branch / PR:** `spike/012-operation-v1-renderer` / PR #193  
**Exact evidence head:** `c6801a0829f72c620c7d9344d8033bcb496f5e91`

Exact-head gates:

- `Validate project` run `36760974637`: **SUCCESS**
- `Three.js visual acceptance` run `36760974583`: **SUCCESS**
- `Visual acceptance capture` (Godot) run `36760974674`: **SUCCESS**

The same bounded visual questions were applied to both candidates:

1. scene-only 2× lower internal 3D resolution / nearest-looking upscale;
2. V1 hot-pink / amber accent treatment;
3. one simple physical crown/graffiti wall motif;
4. existing camera and core scene massing preserved.

### Spike Three.js measurements

At 540×960 and 1080×1920:

- draw calls: **54** (+5 vs baseline)
- triangles: **1,992** (+60)
- geometries: **4** (unchanged)
- authored scene textures: **0** (unchanged)
- renderer textures: **1** (unchanged)
- materials: **8** (unchanged)
- DPR: **1**
- `pixelScale`: **2**
- framebuffer:
  - 540×960 CSS → **270×480**
  - 1080×1920 CSS → **540×960**
- shadows: **false**

The spike visibly adds chunky sampling, V1 hot-pink/amber and crown identity, but remains a primitive low-poly reference. It does not remove the dominant V1 content-production work.

### Spike Godot observation

The exact-head captures show the same V1 treatment applied inside the existing Godot scene while the authored Control UI stays visually full resolution. The crown/accent change is visible and the Web export/capture gates remain green.

The spike is still a blockout rather than a 1:1 ARTIST implementation. That is expected: T013 was designed to test renderer fit, not complete Operation.

## Integration-cost evidence

### Godot

Already owns:

- canonical GameState and persistence;
- navigation;
- authored UI;
- pointer/touch 3D picking;
- semantic hotspot routing;
- accessible fallback buttons;
- Web export and current Vercel packaging;
- exact-head LENTE/visual capture path.

The spike required presentation-layer changes only and did not introduce a new runtime boundary.

### Three.js

The current reference lane owns only isolated WebGL rendering/lifecycle. Production use would still require new supported bridges for:

- canonical Godot state → Three.js presentation;
- Three.js hotspot event → canonical Godot/UI behavior;
- pointer/touch ownership arbitration;
- accessible fallback synchronization;
- route lifecycle;
- combined build/deploy packaging;
- cross-runtime visual and interaction regression.

No evidence in R01 demonstrates a compensating visual or performance advantage large enough to erase those additional boundaries. Final architecture choice belongs to R02/T015.

## R01 conclusion

R01 has enough bounded evidence for a deterministic renderer decision:

- exact-head baseline exists for **both** renderers at both portrait sizes;
- the minimal V1 treatment was implemented for **both** paths;
- exact-head structural/render gates are green;
- Three.js metrics and Godot Web-export sizes are persisted;
- visual review confirms both can express the treatment, while neither spike is falsely represented as final V1;
- integration ownership/cost is documented.

Therefore **R01 = PASS**.

Next roadmap item: **R02 — persist renderer decision and architecture lock**. No R02 decision is made by this file.
