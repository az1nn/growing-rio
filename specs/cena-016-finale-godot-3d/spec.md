# CENA-016 — Finale / Coda Godot 3D

## Intent

Promote the existing finale flow from text-only shell overlays to a dedicated Godot 3D presentation without changing finale eligibility, ending choice authority, campaign completion, save semantics, canon state or post-campaign navigation.

This wave covers the current shell phases:
- `finale:selection`;
- `finale:handoff`;
- `finale:coda`;
- `finale:recap`.

## Canonical behavioral authority

The current shell and campaign flow remain authoritative:
- `game_state.eligible_ending_ids()` determines which endings may be shown;
- `game_state.ending_presentation(...)` supplies canonical presentation copy;
- `campaign_flow.choose_finale_path(...)` is the only finale-path selection mutation;
- `campaign_flow.finish_finale()` is the only completion mutation.

The 3D layer must never call those mutation APIs directly.

## Player-visible contract

- Finale overlays render a dedicated 3D tableau before the canonical text/actions.
- The tableau may switch presentation state for selection, handoff and coda/recap.
- Portrait Web/mobile keeps authored 3D visible while every required canonical action remains reachable.
- At least one authored 3D object supports pointer/touch interaction through `Area3D + CollisionShape3D`.
- An accessible Button fallback triggers the same presentation-only activation.
- During `finale:selection`, eligible endings retain equal visual weight. 3D geometry, scale, lighting, ordering and animation must not rank or preselect an ending.
- Canonical ending actions remain the existing shell buttons, sorted by the existing alphabetical rule.

## Behavioral boundary

The 3D scene is presentation-only.

It MUST NOT:
- choose an ending;
- complete the finale;
- alter eligible ending IDs;
- change ending presentation data;
- set narrative flags or canon state;
- read or write save data;
- advance time;
- mutate economy, inventory, lifecycle or RNG state.

Presentation activation may only emit a semantic signal such as:
`object_activated("finale", "tableau")`.

The shell may use that signal to focus the existing canonical actions or update local explanatory copy. It may not translate a 3D click into an ending decision.

## Phase-specific behavior

### finale:selection
- `overlay_requires_resolution = true`;
- no close affordance;
- all eligible canonical actions remain visible and reachable;
- equal visual treatment across alternatives is mandatory.

### finale:handoff
- `overlay_requires_resolution = true`;
- the selected ending may affect presentation-safe title/copy/tableau state;
- the only completion action remains the canonical “Concluir campanha” button.

### finale:coda / finale:recap
- `overlay_requires_resolution = false`;
- close remains available;
- the completed world stays navigable after dismissal;
- recap reuses presentation without re-running completion mutation.

## Integration target

Primary runtime paths for the later implementation wave:
- `scenes/shell/game_shell.gd`;
- `scenes/shell/game_shell.tscn`;
- new `scenes/visual/finale_diorama.gd/.tscn`;
- dedicated finale 3D regression;
- shell regression proving mutation boundaries;
- deterministic portrait visual acceptance.

Do not combine this wave with ending eligibility, balance, lore/canon rewrite or campaign-flow redesign.

## Acceptance gates

1. Each shipped finale phase visibly renders Camera3D, WorldEnvironment, Light3D and authored MeshInstance3D geometry.
2. Pointer/touch picking and accessible fallback are both live.
3. 3D activation during selection leaves selected ending empty and canonical save data byte-for-byte equivalent.
4. 3D activation during handoff cannot complete the campaign.
5. Coda/recap presentation cannot re-run finale mutation or change save data.
6. Eligible ending buttons remain alphabetically ordered and visually non-ranked.
7. Portrait visual acceptance captures finale selection and coda/recap at 540×960 and 1080×1920.
8. Canonical validation and Vercel exact-head deployment pass before guarded merge.
