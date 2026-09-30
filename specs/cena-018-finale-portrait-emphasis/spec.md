# CENA-018 — Finale distinct phase compositions

## Problem

LENTE evidence and human review showed two separate defects in Finale presentation:

1. The embedded 3D tableau was undersized in portrait layouts.
2. More critically, `selection`, `handoff`, `coda` and `recap` reused the same 3D geometry. `set_phase()` changed only copy, and the real campaign flow did not consistently synchronize the phase into the diorama.

This violates ARTIST-V1, where the four Finale phases have distinct visual briefs.

## Decision

The previous size-only A/B is **REJECTED as sufficient**. Its responsive sizing work is retained, but CENA-018 now requires four genuinely distinct runtime compositions under the locked `ARTIST-V1-PIXEL-GRAFFITI-URBAN` style.

## Required phase identities

- **selection — Três caminhos:** three equally weighted glowing garage-door paths, physical crossroads, no ranked visual treatment.
- **handoff — Travessia:** loading-bay threshold, partially opened metal doors, striped floor light, crates and a clear departure marker.
- **coda — Legado:** urban memorial court, vivid cyan/pink mural planes, warm abstract point lights, legacy symbol.
- **recap — Resultados:** physical dashboard corner, blank display surfaces, timeline object and distinct record/trophy objects.

## Invariants

- Preserve ending eligibility, neutral alphabetical choice order and ending semantics.
- Preserve save/load, campaign state and RNG invariants.
- Preserve pointer/touch interaction and accessible button fallback.
- Use real 3D geometry; no static wallpaper substitution.
- Keep visual language inside ARTIST V1: inky navy, hot pink, cyan, amber, acid green, concrete; orthographic three-quarter diorama.
- Do not invent UI text, numbers or canon inside the 3D art.
- Selection paths remain equal in scale and visibility.
- Human visual acceptance remains required after exact-head LENTE evidence.

## Acceptance

1. Each Finale phase has exactly one visible phase-owned 3D composition.
2. Each phase owns a distinct primary object, camera composition and accessible action.
3. Real campaign transitions synchronize the active diorama phase.
4. 540×960 and 1080×1920 retain the enlarged portrait presentation budget.
5. Canonical project validation, Finale campaign regression and distinct-phase visual regression pass.
6. LENTE exact-head evidence shows four visibly distinct phases at both portrait sizes.
7. Human post-implementation review explicitly ACCEPTS before merge.
