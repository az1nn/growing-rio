# Feature 012 / R05 — Market V1 preflight

**State:** `PREP_ONLY_BLOCKED_BY_R04`  
**Task:** T050 preparation only  
**Renderer:** `GODOT_NATIVE_V1`  
**Prepared against current R04 snapshot:** Operation Rev13 exact head `dd56f04e3099676f6d9bac51c72d7f30b52152b4`

This document advances the next SIGA item while R04 Rev13 exact-head evidence is still running. It does **not** unlock Market implementation and must not be treated as ARTIST/CENA acceptance.

The first preflight branch was based on the active R04 worktree and therefore carried unrelated Operation commits. This clean version is rebuilt directly from `master` and is intentionally spec-only.

## Unlock gate

R05/T050 implementation remains blocked until all of the following are true:

1. R04/T040 has exact-head Validate + Visual Acceptance + LENTE evidence complete.
2. Operation receives final ARTIST/CENA runtime `ACCEPT`.
3. R04 state is persisted `PASS` and PR #199 is merge-ready/merged according to SIGA.
4. Market completes its own just-in-time ARTIST concept round and receives human concept `ACCEPT`.
5. The accepted Market concept SHA-256 is persisted in the ARTIST ledger before production geometry changes begin.

Current Market ARTIST state is `BOARD_APPROVED_ONLY`; there is no accepted per-scene concept and no accepted runtime.

## Current R04 dependency snapshot

Latest reconciled snapshot:
- Operation Rev13 exact head is `dd56f04e3099676f6d9bac51c72d7f30b52152b4`.
- Validate project #1040 / run `36872214957`: **SUCCESS**.
- Visual Acceptance #534 / run `36872214900`: **IN PROGRESS**.
- LENTE #70 / run `36872215029`: **IN PROGRESS**.
- PR #199 remains Draft.
- R05 implementation is therefore still locked.

This snapshot is evidence only. The unlock gate above remains authoritative if R04 advances again.

## Immutable V1 direction

Market title: **Market / Banca de rua**.

Locked global direction:
- Pixel Art × Graffiti × Urban Diorama.
- Godot 4.7.2 / GL Compatibility is the single production renderer.
- Dense improvised night street kiosk; corrugated awning; handmade graffiti; colorful abstract packages/crates; pixel-tiled pavement; warm stall light plus cool neon spill.
- Commercial choices are represented through abstract fictional props only; no real-world illicit transaction instructions.
- UI remains full-resolution outside the reduced-resolution scene SubViewport.
- Reuse the shared V1 material/pixel/graffiti infrastructure from R03 and the production lessons from R04; do not clone Operation composition.

## Existing runtime ownership that must survive T050

Current scene:
- `scenes/visual/market_diorama.tscn`
- `scenes/visual/market_diorama.gd`
- `scenes/market/market_surface.tscn`

Canonical semantic interactions:
- primary: `market/deal_counter`;
- secondary: `market/contract_tray`;
- pointer/touch picking is required for both;
- accessible button fallback is required for both.

Current regression also requires the visual layer to remain presentation-only. Market scene code must not gain direct domain ownership such as `/root/GameState`, `sell_`, `accept_contract(` or `resolve_active_contract(`.

## Composition preflight

Shared V1 composition registry currently defines three visual foci:

| V1 focus | Provisional zone | Runtime ownership |
| --- | --- | --- |
| vendor counter | `left_focus` | align with existing `deal_counter` semantic hotspot |
| fictional inventory crates | `center_focus` | presentation cluster unless accepted concept proves a safe semantic mapping |
| market channel sign | `right_focus` | presentation/signage anchor unless an existing canonical action is explicitly reconciled |

The existing `contract_tray` semantic hotspot is canonical even though it is not one of the three registry foci. T050 must preserve it and reconcile its physical placement against the accepted Market concept rather than deleting or silently remapping it.

No third gameplay action is authorized by this preflight.

## ARTIST round required before implementation

When R04 passes, ARTIST should generate/revise **Market only**, using the accepted global V1 board as the visual authority and the Market scene description above.

Human review should explicitly judge:
- compact portrait-first kiosk silhouette at 540×960 and 1080×1920;
- dense layered corrugated/painted urban shell rather than a clean low-poly booth;
- clear vendor counter, crate/inventory and sign hierarchy;
- contract-tray placement that remains visible and semantically distinct;
- handmade graffiti/crown language without vector-clean signage;
- warm stall practicals plus restrained cyan/magenta night spill;
- patchy pixel pavement and short threshold, not a long empty runway;
- fictional inventory only;
- no baked UI text pretending to be functional interface.

On `ACCEPT`, persist the concept file/run/hash before T050 production work begins.

## T050 implementation decomposition after concept ACCEPT

Only after the unlock gate:

1. **T050-A — shell/camera:** bind Market to the shared V1 pixel/material system and tune portrait cutaway/kiosk framing.
2. **T050-B — vendor counter:** densify the counter/work surface while preserving `deal_counter` ownership.
3. **T050-C — crates/inventory:** build abstract fictional crate/package layers using V1 material roles.
4. **T050-D — sign/awning:** author the corrugated awning, physical market sign/graffiti identity and night silhouette.
5. **T050-E — contract tray:** preserve `contract_tray` pointer/touch + accessible fallback and keep its hitbox spatially distinct.
6. **T050-F — lighting/pavement:** add warm kiosk practicals, cool spill and irregular pixel pavement/threshold.
7. **T050-G — regression:** add Market-specific V1 structural/semantic tests without weakening CENA-010 / Feature 011 contracts.
8. **T050-H — evidence:** exact-head Validate + Visual Acceptance + LENTE at 540×960 and 1080×1920.
9. **T050-I — ARTIST/CENA runtime decision:** `ACCEPT` or bounded `REVISE`; R06 remains locked until `ACCEPT`.

## Non-goals

- no Market production code changes before R04 PASS + Market concept ACCEPT;
- no new gameplay/economy API;
- no real-world illicit sales instructions;
- no Three.js production ownership or Godot↔Three.js bridge;
- no batch implementation of later scenes.

This preflight is intentionally spec-only and exists so SIGA makes forward progress while R04 waits on an external/long-running evidence gate.
