# Feature 011 — Semantic 3D hotspots

**Status:** ACTIVE — specification and first Archive slice in progress  
**Target maturity:** POLISHED interaction semantics on the delivered 3D shell

## User Scenarios

DA LATA already presents every canonical destination as a visible interactive 3D scene. The next interaction pass makes the authored objects semantically useful: distinct 3D hotspots should lead the player to the corresponding existing UI region instead of every scene exposing only one generic interaction.

## Functional Requirements

- **FR-001:** Operação, Mercado, Cidade, Institucional and Arquivo MUST expose at least two semantically distinct 3D hotspots when the surface already contains at least two meaningful UI regions.
- **FR-002:** Each hotspot MUST emit a stable presentation identifier and map to an existing surface-owned UI region.
- **FR-003:** Each 3D hotspot MUST have a visible accessible Button fallback that dispatches the same presentation action.
- **FR-004:** Hotspot activation MAY focus/scroll/highlight presentation state but MUST NOT directly mutate canonical gameplay, economy, cultivation, campaign, research, narrative, policy, lore or save state.
- **FR-005:** Surface scripts MAY translate a presentation identifier into navigation/focus behavior but MUST continue to submit canonical gameplay actions only through existing controls and GameState/domain boundaries.
- **FR-006:** Pointer/touch picking, keyboard/fallback access and the existing portrait 3D composition MUST remain available at 540x960 and 1080x1920.
- **FR-007:** Regression coverage MUST lock hotspot identifiers, accessible fallbacks and the presentation-only boundary.

## Acceptance scenarios

1. In Arquivo, selecting the evidence desk focuses available research; selecting the archive wall focuses resolved narrative history.
2. In Cidade, distinct scene objects can focus district selection versus community feedback.
3. In Institucional, distinct scene objects can focus compliance versus policy/participation UI without visually preferring a proposal.
4. In Mercado, distinct scene objects can focus sale/buyer versus contract information.
5. In Operação, distinct scene objects can focus cultivation versus management/staff/upgrades.
6. Triggering any hotspot repeatedly leaves canonical game state unchanged until the player uses an existing gameplay control.

## Success Criteria

- all five canonical destination scenes expose the bounded hotspot contract;
- every added hotspot has pointer/touch picking plus accessible fallback;
- exact-head repository validation and relevant rendered acceptance are green;
- existing campaign/save/domain regressions remain green;
- no new save schema or canonical state is introduced.

## Out of Scope

- new gameplay actions or balance changes;
- new saved state;
- new lore/canon;
- Three.js reference-surface expansion;
- engine migration or external 3D assets;
- redesigning accepted CENA compositions beyond the minimum interaction affordance needed for hotspot clarity.
