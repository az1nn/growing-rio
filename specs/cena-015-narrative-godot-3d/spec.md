# CENA-015 — Narrative Interruption Godot 3D

## Intent

Promote mandatory narrative interruptions from a text-only shell card to a dedicated, visible and interactive Godot 3D presentation while preserving the existing narrative service and Archive resolver as the only authorities for choices and canon mutation.

This wave is deliberately limited to `narrative:*` overlays. Finale/coda presentation remains a separate follow-up surface.

## Player-visible contract

- A narrative interruption renders a dedicated 3D evidence/memory table inside the overlay before the canonical choice buttons.
- Portrait Web/mobile must keep both the 3D scene and every required narrative choice reachable in the same interruption flow.
- The composition may react to presentation-safe metadata supplied by the shell (title/context label), but must not query GameState directly.
- At least one authored 3D object is pointer/touch interactive through Area3D + CollisionShape3D.
- An accessible Button fallback triggers the same presentation-only activation.

## Behavioral boundary

The 3D scene is presentation-only.

It MUST NOT:
- resolve a narrative choice;
- set narrative flags;
- complete research, arcs, endings or campaign state;
- read or write save data;
- advance time;
- mutate economy, inventory, lifecycle or RNG state.

Activation may only emit a semantic signal such as:
`object_activated("narrative", "evidence_table")`.

The shell may use that signal to focus existing canonical choice buttons or update local explanatory copy. Choice mutation remains exclusively in the existing `_on_narrative_choice_pressed` flow.

## Integration target

Primary runtime paths:
- `scenes/shell/game_shell.gd`
- `scenes/shell/game_shell.tscn`
- new `scenes/visual/narrative_diorama.gd/.tscn`
- dedicated regression
- portrait visual acceptance evidence

Do not combine this wave with finale/coda redesign.

## Acceptance gates

1. A live `narrative:*` overlay visibly includes Camera3D, WorldEnvironment, Light3D and authored MeshInstance3D geometry.
2. Pointer/touch picking and accessible fallback are both live.
3. 3D activation alone leaves canonical save data byte-for-byte equivalent.
4. Existing narrative choices remain authoritative and non-dismissible until resolved.
5. Portrait visual acceptance captures the narrative 3D interruption at 540×960 and 1080×1920.
6. Canonical validation and Vercel exact-head deployment pass before guarded merge.
