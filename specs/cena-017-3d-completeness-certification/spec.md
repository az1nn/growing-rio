# CENA-017 — 3D Completeness Certification

## Goal

Establish a hard acceptance contract proving that every player-facing scene/surface in DA LATA presents visible authored 3D and at least one meaningful pointer/touch/click interaction where interaction is part of the surface.

This closes the gap between "3D code exists" and "the player can actually see and use 3D in the shipped game."

## Canonical surface inventory

Certification must cover, at minimum:

1. Operation
2. Market
3. City
4. Institutional
5. Archive
6. Campaign
7. Narrative interruption
8. Finale selection / handoff
9. Coda / recap

If a new player-facing destination or modal is introduced later, it automatically joins this inventory.

## Acceptance rules

A surface is not certified merely because a `SubViewport`, `Node3D`, mesh, or Three.js/Godot 3D asset exists in source.

For each surface, evidence must prove all of the following:

- visible authored 3D geometry is present in the rendered player view;
- the 3D content is not hidden behind another panel, zero-sized, off-screen, or visually indistinguishable from a flat placeholder;
- the scene contains an explicit camera and lighting/environment contract;
- at least one player-relevant 3D object is pointer/touch/click actionable, unless the surface is intentionally read-only;
- any accessibility fallback button invokes the same presentation-only intent;
- 3D interaction cannot silently mutate unrelated canonical domain state;
- portrait Web evidence exists at 540x960 and 1080x1920;
- no browser-console or engine error invalidates the capture;
- the acceptance evidence corresponds to the exact tested commit.

## Interaction semantics

3D objects may focus or reveal the existing canonical controls, but must not bypass domain authority.

Examples:

- Market 3D can focus buyer/contract controls; it must not complete a sale by presentation-side mutation.
- Narrative 3D can focus the canonical narrative choice controls; it must not resolve a choice.
- Finale 3D can focus the canonical ending actions; it must not rank, select, or complete an ending.
- Campaign 3D can focus save/load/new-campaign controls; it must not directly rewrite persistence state.

## Certification matrix

Each row must reach PASS before the global 3D claim is accepted.

| Surface | Visible 3D | Click/touch object | Accessible fallback | State-preserving interaction | 540x960 evidence | 1080x1920 evidence |
| --- | --- | --- | --- | --- | --- | --- |
| Operation | REQUIRED | REQUIRED | REQUIRED | REQUIRED | REQUIRED | REQUIRED |
| Market | REQUIRED | REQUIRED | REQUIRED | REQUIRED | REQUIRED | REQUIRED |
| City | REQUIRED | REQUIRED | REQUIRED | REQUIRED | REQUIRED | REQUIRED |
| Institutional | REQUIRED | REQUIRED | REQUIRED | REQUIRED | REQUIRED | REQUIRED |
| Archive | REQUIRED | REQUIRED | REQUIRED | REQUIRED | REQUIRED | REQUIRED |
| Campaign | REQUIRED | REQUIRED | REQUIRED | REQUIRED | REQUIRED | REQUIRED |
| Narrative | REQUIRED | REQUIRED | REQUIRED | REQUIRED | REQUIRED | REQUIRED |
| Finale | REQUIRED | REQUIRED | REQUIRED | REQUIRED | REQUIRED | REQUIRED |
| Coda/recap | REQUIRED | MAY SHARE FINALE TABLEAU | REQUIRED WHEN ACTIONABLE | REQUIRED | REQUIRED | REQUIRED |

## CI / deployment policy

GitHub Actions rendered evidence is the canonical development acceptance source when an external preview provider is throttled.

A Vercel free-tier deployment-rate limit is classified as an external availability constraint, not a development failure, when all of the following are true:

- exact-head project validation is green;
- exact-head visual acceptance is green;
- exported Web candidate is produced successfully by the repository workflow;
- the failure message is specifically provider rate limiting rather than a build/runtime defect.

Provider throttling must therefore not stop implementation or spec progress. Deployment verification resumes when quota is available.

## Final certification

The project may claim "all scenes are 3D" only after an automated audit and rendered-evidence review both pass for every row in the matrix on one reconciled master commit.

Any missing row, stale evidence, hidden viewport, non-clickable intended object, or 2D-only fallback presented as the primary scene keeps certification open.
