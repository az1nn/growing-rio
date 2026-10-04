# R05 — DA LATA UI V1 Plan

**Parent feature:** Feature 012 — ARTIST V1 runtime parity  
**Roadmap item:** R05 — Market V1 + DA LATA UI V1 pilot  
**Status:** COMPLETE — T050-J HUMAN ACCEPT / R05 PASS  
**Authority:** accepted DA LATA ARTIST board + accepted Market concept + Feature 012 FR-031..FR-039  
**Execution fence:** R05 PASS. R06 may now consume the accepted UI baseline; R07+ remain LOCKED.

## Goal

Turn the Market screen into the canonical UI pilot for the game. The result must establish one reusable DA LATA interface language for navigation and actions without changing Market gameplay, economy, persistence, hotspot semantics, or the accepted 2.5D visual substrate.

The UI must feel authored as part of the DA LATA world rather than as generic application chrome.

## Design principles

1. **Scene first, UI second:** controls frame the accepted ARTIST composition; they do not cover or visually compete with it.
2. **Pixel/graffiti, not glossy mobile:** square/chamfered silhouettes, hard borders, restrained stencil marks, no rounded-card SaaS aesthetic.
3. **Semantic color, not decoration:** amber = primary action, cyan/teal = system/navigation, magenta = event/emphasis, red/oxide = destructive/risk, charcoal = substrate.
4. **State is multi-channel:** state changes use border/shape/icon/offset in addition to color.
5. **Portrait-first:** 540×960 is the minimum layout authority; 1080×1920 must preserve hierarchy rather than simply scale everything.
6. **One shared implementation:** later scenes consume the same tokens/components after R05 PASS.

## T050-J human REVISE ALL override — 2026-10-04

Human review rejected the post-`2caac959` UI direction as materially distant from the accepted ARTIST concept. This section is the current runtime authority for Market UI composition and **overrides conflicting T050-H/T050-I Market-shell application notes below**.

Canonical recovery baseline:
- visual/runtime reference: `2caac959bf5a7a6ea3d8f19b620ad28eafb00726` (ARTIST 2.5D Market rebase);
- accepted visible substrate: `artifacts/artist/runs/20261002T091800Z/market/images/concept/concept-v001.webp`;
- recovered implementation chain: `93634c8` -> `c074b1e`;
- `MarketUIScreen` and the opaque `ActionDeck` are rejected for the Market pilot and MUST NOT be mounted;
- `assets/market/v1/market-runtime-backdrop.svg` is a rejected substitute and MUST NOT replace the accepted concept;
- the canonical outer GameShell header/navigation owns screen chrome again; Market-local UI stays limited to semantic actions/fallbacks over the concept;
- touch-to-mouse emulation, keyboard focus, >=48 px targets, semantic hotspot fallbacks and domain behavior remain mandatory;
- future UI refinement is **edge chrome only**: it may improve buttons/navigation without repainting, cropping, replacing or visually dominating the accepted concept.

Every new T050-J visual candidate MUST compare against both the accepted ARTIST concept and the exact `2caac959` runtime capture. “Newer” or “more complete UI” is not evidence of improvement if concept similarity decreases.

## T050-J approved control treatment — 2026-10-04

Human art review approved the recovered `2caac959` composition and the next control-only visual target. Runtime implementation is constrained to **edge chrome**:

- preserve the accepted ARTIST Market substrate and current camera/layout exactly;
- center CTAs use dark teal surfaces, cyan/mint borders, semantic line icons and restrained neon depth;
- bottom navigation uses a 3+2 portrait layout, semantic destination icons and a mint/cyan selected state;
- the active destination is **selected, not disabled**; selection remains non-color-only through border weight and marker rails;
- Campaign uses the same restrained shared-button grammar;
- no local Market shell, opaque action deck, replacement backdrop or scene repaint is authorized;
- touch, keyboard focus, >=48 px targets and semantic routes remain required.

Approved implementation chain starts at `687e7b0` (shared chrome) and `3000b0f` (3+2 shell navigation).

## Canonical tokens

### Grid and spacing

Base unit: **4 px** at logical UI resolution.

| Token | Value | Use |
|---|---:|---|
| `space_1` | 4 | icon/text micro-gap |
| `space_2` | 8 | compact internal gap |
| `space_3` | 12 | default component gap |
| `space_4` | 16 | standard padding |
| `space_5` | 20 | large control padding |
| `space_6` | 24 | section gap |
| `space_8` | 32 | major region gap |

Portrait safe margins:
- left/right: **16 px minimum**;
- top content safe zone: **16 px + platform safe area**;
- bottom command band: **76 px minimum**, plus platform safe area.

### Typography

Use the existing project font unless a later ARTIST-approved pixel font is introduced.

| Role | Size | Weight/behavior |
|---|---:|---|
| `display` | 28–32 | scene title / very short |
| `heading` | 22–24 | card/action group title |
| `button_l` | 17–18 | primary / navigation |
| `button_m` | 15–16 | secondary / utility |
| `body` | 15–16 | descriptions |
| `caption` | 12–13 | metadata / locked reason |

Button labels should be concise and action-led. Uppercase is allowed for short navigation/status labels; sentence case is preferred for transactional actions.

### Semantic palette

Exact resources should be centralized under `resources/ui/v1/`; values below are the initial implementation targets and may receive one ARTIST/CENA tuning pass without changing semantic meaning.

- `ink_950`: near-black charcoal substrate.
- `ink_800`: raised neutral surface.
- `text_primary`: warm off-white.
- `text_muted`: desaturated grey-green.
- `amber_primary`: primary/confirm action.
- `cyan_system`: navigation/system/focus.
- `teal_secondary`: secondary/contextual action.
- `magenta_event`: event/emphasis/selected accent.
- `oxide_risk`: danger/destructive/risk.
- `locked_grey`: progression lock / unavailable.

No control may communicate enabled/selected/risk state by color alone.

### Shape and border grammar

- default corner radius: **0–3 px**; prefer square/chamfered edges;
- standard border: **2 px**;
- focus ring: **2 px external cyan/amber alternating or dashed/stencil treatment**;
- pressed state: **2 px visual downward/right offset** or equivalent inset;
- selected nav item: border + accent bar/notch, not fill color alone;
- disabled/locked: reduced contrast plus explicit icon/text marker.

### Motion

- hover/focus: 80–120 ms;
- press/release: 60–90 ms;
- tab/selection transition: 120–160 ms;
- no elastic, glossy, spring, or floating mobile-app motion;
- respect reduced-motion preference by removing nonessential transitions.

## Component contract

### 1. PRIMARY_ACTION

Use for the dominant action in the current decision context.

Visual:
- amber surface or amber leading stripe;
- dark high-contrast label;
- strongest border hierarchy;
- optional action glyph.

Minimum touch target: **48×48 px**, preferred height **52–56 px**.

Examples: `Vender lote`, `Aceitar contrato`, `Confirmar`.

### 2. SECONDARY_ACTION

Use for alternative/context actions.

Visual:
- charcoal/teal substrate;
- teal/cyan border;
- lower salience than primary.

Examples: `Ver detalhes`, `Concluir depois`.

### 3. UTILITY

Compact system controls.

Visual:
- square/chamfered;
- icon first;
- cyan/system accent;
- explicit accessible label/tooltip.

Examples: `Voltar`, `Info`, `Ajuda`.

### 4. DANGER_RISK

Only for destructive, irreversible, or explicitly risky actions.

Visual:
- oxide/red-orange border or stripe;
- warning marker;
- must not look identical to magenta event emphasis.

Examples: `Cancelar contrato`, `Descartar`, future reset/destructive actions.

### 5. NAVIGATION_TAB

Persistent scene/context navigation.

Visual:
- compact horizontal or icon+label;
- active item uses fill/border/notch + text/icon state;
- inactive remains readable but subordinate;
- locked tab shows explicit lock marker and reason.

## Canonical states

Every shared button role supports:

- `DEFAULT`
- `HOVER_FOCUS`
- `PRESSED`
- `DISABLED`
- `ACTIVE_SELECTED`
- `LOCKED` when progression-gated

Rules:
- `DISABLED` = temporarily unavailable due to current state.
- `LOCKED` = progression/system gate; always expose reason.
- focus must remain visible on keyboard/controller navigation.
- pressed must provide immediate physical response.
- selected must not be confused with pressed.

## Shared portrait shell

### Top status/title region

Purpose:
- scene identity;
- compact player state;
- utility/back affordance when required.

Constraints:
- never obscure the dominant ARTIST focal object;
- one line of scene title + one compact status line by default;
- avoid large permanent headers.

### Scene action region

Purpose:
- contextual actions/cards;
- scrollable when content exceeds portrait space.

Market pilot:
- buyer cards;
- sale/contract actions;
- feedback/status;
- city-detail bridge.

### Bottom command/navigation band

Purpose:
- persistent game destinations and current-location awareness.

Initial structure:
- 4 or 5 visible slots maximum;
- current destination visibly selected;
- later locked destinations may render as locked without becoming implemented;
- no horizontal scroll in canonical portrait sizes.

## Godot implementation architecture

Create reusable resources/components rather than styling scene-local buttons independently.

Recommended structure:

```text
resources/ui/v1/
  dalata_ui_tokens.gd
  dalata_ui_theme.tres
  styles/
    button_primary_*.tres
    button_secondary_*.tres
    button_utility_*.tres
    button_risk_*.tres
    nav_tab_*.tres

scenes/ui/v1/
  dalata_button.gd
  dalata_button.tscn
  dalata_nav_tab.gd
  dalata_nav_tab.tscn
  dalata_screen_shell.gd
  dalata_screen_shell.tscn
```

Preferred API:
- semantic role enum rather than per-node theme overrides;
- state derived from normal Godot focus/disabled/toggle behavior plus explicit progression lock;
- controls expose accessible text, tooltip/reason and semantic action IDs;
- no domain mutation inside shared UI components.

## Market migration plan

### Step 1 — Tokens/theme foundation
Create `resources/ui/v1` and encode spacing, palette, border, font and focus-state tokens.

### Step 2 — Reusable controls
Implement the five roles in a single reusable button component plus the navigation-tab component.

### Step 3 — Shared shell
Implement the three-region portrait shell and mount it in Market without modifying the accepted 2.5D scene substrate.

### Step 4 — Market actions
Migrate:
- `CityDetailButton` → SECONDARY_ACTION;
- dynamically created `Vender lote` → PRIMARY_ACTION;
- `Aceitar contrato` / `Concluir contrato` → PRIMARY or SECONDARY according to the current contract state;
- unavailable sale/contract actions → DISABLED with reason;
- destination/navigation controls → NAVIGATION_TAB.

### Step 5 — Feedback and state
Give selected/locked/disabled/focus states explicit visual and textual treatment. Preserve the current buyer/contract data and action callbacks.

### Step 6 — Persistent navigation
Introduce the bottom command band in Market as the pilot. Do not implement City or other later scenes; navigation targets may be present only as route hooks or LOCKED placeholders where appropriate.

## Acceptance and regression

### Structural tests
Must verify:
- Market uses shared UI components, not ad-hoc styled `Button` controls for migrated actions;
- minimum 48 px touch targets;
- canonical role/state mapping;
- bottom navigation max 5 slots;
- 540×960 layout has no overlap with the accepted scene focal region;
- 1080×1920 preserves the same hierarchy.

### Interaction tests
Must verify:
- keyboard focus order;
- pointer/touch activation;
- disabled actions do not fire;
- locked actions expose reason;
- selected navigation is distinguishable without color-only dependence;
- existing `market/deal_counter` and `market/contract_tray` flows remain unchanged.

### Visual gate
Exact-head captures at:
- 540×960;
- 1080×1920.

Human review checks:
1. buttons look like DA LATA, not stock Godot/mobile UI;
2. hierarchy is obvious without reading every label;
3. bottom navigation feels reusable across scenes;
4. controls do not obscure the accepted Market concept;
5. focus/disabled/selected states are visually coherent;
6. no return to low-poly/Three.js-like chrome.

## Delivery sequence

```text
TOKENS
  -> SHARED BUTTONS
  -> STATES
  -> GLOBAL SHELL EDGE CHROME
  -> MARKET CONCEPT-PRESERVING MIGRATION
  -> ACCESSIBILITY/INPUT TESTS
  -> PORTRAIT CAPTURES
  -> HUMAN ACCEPT
  -> R05 PASS
  -> UI V1 becomes reusable baseline for R06+
```

## Non-goals for R05

- redesigning City/Archive/Institutional screens;
- implementing later-scene navigation behavior;
- changing Market economy or contract rules;
- replacing the accepted Market art concept;
- adding a second renderer;
- broad animation system;
- controller-specific UX beyond preserving navigable focus contracts.

## R05 completion consequence

Only after the shared UI pilot and Market runtime receive explicit human `ACCEPT` may:
- R05 become `PASS`;
- DA LATA UI V1 be treated as the shared baseline;
- R06 City unlock and consume the shared UI system.


## T050-H implementation — Market shared-shell integration (HISTORICAL / SUPERSEDED FOR MARKET)

Delivered inside the active R05 branch:

- Market now instantiates the reusable `DalataScreenShell` as its player-facing UI frame.
- The accepted Market visual substrate remains behind the shell; the owner-local Market action Scroll is geometrically bounded to the shared action region so scene ownership and `%UniqueName` contracts remain intact.
- The shared bottom command band owns exactly five route hooks: Operation, Market, City, Institutional and Archive; Market exposes selected state explicitly.
- Legacy outer header/portrait/wide navigation are suppressed only while Market is active, preventing duplicate chrome while later scenes remain untouched.
- Campaign remains reachable through a shared `UTILITY` control inside the Market action surface, preserving pointer/touch access when legacy header chrome is hidden.
- Existing Market sale/contract/city-detail callbacks, economy, persistence and semantic 3D hotspots are unchanged.
- Structural regression coverage now proves shell mounting, five-slot command ownership, canonical route handoff, owner-boundary preservation, bottom-band non-overlap and campaign utility preservation.

T050-I is next: strengthen keyboard/focus, pointer/touch, state-legibility and portrait-safe-area regression before exact-head visual capture.


## T050-I implementation — accessibility/input/state regression (FUNCTIONAL GATES RETAINED; COMPOSITION SUPERSEDED)

Validated on exact implementation head `2d875d55be8c277f9d52e62cb16faeedb9a21b8f` by Validate project #1189 / run `37137886181`: **SUCCESS**.

Delivered:
- shared buttons remain keyboard-focusable and pointer/touch interactive;
- the focus ring has an explicit external shape, independent of color;
- disabled controls now change silhouette with a heavier lower rail, so disabled state is not color-only;
- locked state remains explicitly textual with a persisted lock reason;
- bottom command destinations receive explicit left/right + previous/next focus neighbors;
- command and transactional controls retain >=48 px touch targets;
- compact portrait shell now enforces the canonical 16 px vertical safe margin as well as the existing 16 px side margin;
- Market action surface remains owner-local and is constrained above the shared command band with a structural non-overlap assertion.

T050-J complete: exact-head `c6ebed7dc7319df435d2a6ade8ebf09d6fcea68e` received explicit human ARTIST/CENA runtime ACCEPT.
