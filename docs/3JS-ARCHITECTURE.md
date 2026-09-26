# DA LATA — 3JS Architecture & Visual Contract

Status: **initial contract**
Renderer target: **Three.js**
Current canonical runtime: **Godot**
Primary visual authority: **CENA**

## Intent

3JS provides a controlled path for building and refining DA LATA 3D scenes with Three.js without discarding the visual language already established in the playable game.

The architecture is deliberately **additive first**:

```text
existing accepted Godot presentation
        |
        v
Three.js parity prototype
        |
        v
measured visual + performance evidence
        |
        v
bounded integration decision
```

A successful prototype does not by itself authorize a runtime migration.

## Authority boundaries

| Concern | Authority |
| --- | --- |
| Repository state, Spec Kit, CI, merge, architecture boundary | SIGA |
| Visual direction, composition, assets, screenshot acceptance | CENA |
| Narrative facts and canon states | LORE |
| Three.js renderer implementation | 3JS |
| Gameplay/domain/persistence | Existing game/domain architecture |

When authorities disagree, 3JS does not choose a new truth. It records the dependency and routes it to the owning authority.

## Accepted visual language to translate

The Three.js renderer should initially translate, not reinterpret, the current presentation:

- orthographic diorama framing;
- portrait-first layout;
- readable depth behind 2D UI;
- concrete and warm plaster structural surfaces;
- dark-metal trim/reveals/joints;
- teal architectural accents;
- terracotta planter family;
- restrained low-poly foliage;
- cool/warm light pairing;
- clean architectural rhythm rather than texture noise;
- production-candidate primitive geometry where it already reads well;
- translucent informational overlays where scene visibility matters.

The current style is explicitly considered **good enough to be the baseline**. Initial Three.js work should invest in fidelity, stability and performance before seeking a new art direction.

## 3JS scene architecture principles

### Scene modules

Production Three.js scenes should separate:

1. renderer/bootstrap;
2. scene graph construction;
3. camera/framing;
4. lighting/environment;
5. materials;
6. geometry/assets;
7. state-to-presentation adapter;
8. resize/device-density handling;
9. lifecycle/disposal;
10. visual acceptance hooks.

Scene code must not become a second domain model.

### State boundary

Three.js receives presentation-ready state or a read-only adapter derived from canonical game state.

It must not independently decide:

- economic rules;
- progression;
- availability;
- policy consequences;
- narrative branching;
- save behavior.

### Dependency policy

When Three.js enters runtime code:

- use the repository's package/lockfile mechanism;
- pin the exact Three.js version;
- avoid an unpinned production CDN dependency;
- document any addon/import-map/bundler decision in the active feature plan;
- treat loaders/postprocessing packages as separate dependencies with explicit need.

### Asset policy

Prefer, in order:

1. repository-authored procedural/primitive geometry;
2. repository-authored GLB/glTF;
3. approved external assets with known license/provenance.

Do not copy distinctive assets from other games or import unknown-license content.

### Web/mobile budget

Every production scene plan should set explicit budgets for the target hardware/browser class. At minimum track:

- draw calls;
- triangles/vertices;
- material count;
- dynamic lights/shadow-casting lights;
- texture memory/dimensions;
- loaded asset size;
- render resolution/device-pixel-ratio policy;
- frame-time evidence on the repository's accepted Web targets.

The budget belongs in the active spec/plan because the correct numbers depend on the scene and delivery target.

### Lifecycle discipline

Every 3JS scene must have a clear teardown path:

- cancel its animation/render loop;
- remove listeners/observers;
- dispose geometries;
- dispose materials;
- dispose textures/render targets;
- release loader-owned resources when applicable;
- detach DOM/canvas ownership cleanly.

A visually correct scene that leaks GPU/DOM resources is not accepted.

## Visual parity matrix for 3JS-001

| Contract | Baseline expectation |
| --- | --- |
| Camera | Orthographic diorama read |
| Targets | 540x960 and 1080x1920 |
| Room | Existing shell proportions and readable wall/floor masses |
| Floor | Concrete slab with restrained joint rhythm |
| Walls | Warm-plaster family with dark-metal reveal rhythm |
| Window | Existing pane/mullion rhythm |
| Props | Terracotta planter family + restrained foliage |
| Lighting | Cool/warm two-light grammar |
| Palette | Charcoal / dark metal / teal / warm neutral / terracotta |
| UI relationship | 3D remains legible behind the 2D shell |
| Fidelity priority | silhouette -> composition -> lighting -> material response -> detail |
| Runtime impact | additive/reversible proof; no silent Godot replacement |

## Improvement rule after parity

Once a scene has accepted parity evidence, 3JS may propose refinements such as:

- smoother camera interpolation;
- subtle non-mechanical ambient animation;
- improved PBR material response while retaining the palette;
- better light falloff and shadow discipline;
- more efficient instancing;
- improved depth cues;
- cleaner responsive framing;
- lightweight atmosphere/post effects when justified by Web performance.

Any refinement that materially changes the visual identity must be accepted through CENA first.

## Initial roadmap

### 3JS-000 — workflow bootstrap
- repository-local skill;
- architecture/visual contract;
- handoff;
- no runtime change.

### 3JS-001 — OperationDiorama parity proof
- Spec Kit feature first;
- isolated/additive Three.js scene;
- read-only presentation model;
- minimum geometry/material/light set;
- portrait/wide captures;
- performance evidence.

### 3JS-002+ — evidence-driven refinement
Only after 3JS-001 is accepted. Select the next smallest player-visible scene or refinement from live evidence and CENA priority.

No broad migration roadmap is pre-authorized.
