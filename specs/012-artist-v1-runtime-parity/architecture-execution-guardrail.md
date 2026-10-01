# Feature 012 — Architecture execution guardrail

**State:** ACTIVE  
**Decision inherited from:** `renderer-decision.md` / `GODOT_NATIVE_V1`  
**Execution mode inherited from:** `SIGA-ROADMAP.md` / `STRICT_SEQUENTIAL`  
**Effective:** 2026-10-01

## Why this exists

Feature 012 correctly selected Godot as the single V1 production renderer, but later Operation iterations exposed a process drift: implementation was technically being written in Godot while the visual construction model still behaved like the older low-poly/Three.js prototype lineage — preserve broad primitive staging, then add neon, graffiti, lights and props until it resembles ARTIST V1.

That is not the intended migration.

The selected renderer decision is both a **runtime ownership lock** and an **implementation-source lock**.

## Production source of truth

For V1 scene production the allowed derivation is:

```text
approved ARTIST board + accepted isolated scene
                |
                v
CENA scene decomposition
(shell / masses / materials / authored pixel surfaces /
 focal props / lights / interaction anchors / UI-safe area)
                |
                v
native Godot scene/resources
                |
                v
existing gameplay + semantic hotspot contracts
                |
                v
LENTE exact-head evidence
                |
                v
ARTIST/CENA ACCEPT or REVISE
```

The forbidden derivation is:

```text
old Three.js / old generic low-poly blockout
                |
                v
keep its visual structure
                |
                v
add neon + graffiti + lights + extra props
                |
                v
call the result "Godot migration"
```

A scene being implemented in GDScript does not by itself satisfy `GODOT_NATIVE_V1`.

## Reuse policy

### Reuse by default

These contracts survive the visual rebuild unless a separate spec changes them:

- canonical `GameState` and persistence;
- route/navigation ownership;
- semantic hotspot IDs and domain meaning;
- pointer/touch interaction behavior;
- accessible fallback controls;
- full-resolution UI behavior;
- validated shared V1 Godot material/pixel/decal utilities;
- tests that protect gameplay and accessibility contracts.

### Non-authoritative by default

These may be consulted as evidence but must not define new production composition:

- `threejs/**` scene geometry, camera composition and material structure;
- R01/PR #193 renderer-spike visual staging;
- pre-V1 generic Godot low-poly scene composition;
- superseded visual-revision geometry retained only for rollback/history.

Reusing one of these visual structures requires an explicit current-scene build-sheet justification proving it matches the accepted ARTIST target. Existing code or sunk cost is not justification.

## Structural REVISE rule

ARTIST/CENA must distinguish cosmetic debt from structural mismatch.

If a runtime review says the scene still has a structural mismatch in composition, geometry language, focal hierarchy, density or pixel-surface language, the next implementation step must replace/recompose the offending structure. It must not add another cosmetic layer over the same rejected scaffold.

If the same structural mismatch survives two consecutive runtime `REVISE` decisions, state becomes:

`STRUCTURAL_REBASE_REQUIRED`

No further additive visual revision is allowed until the scene is decomposed again from the accepted ARTIST target and a clean Godot-native build boundary is documented.

## R04 correction boundary

Operation remains the only CURRENT scene.

- PR #199 / Rev13 may finish its already-running exact-head evidence.
- If Rev13 receives runtime `ACCEPT`, R04 may proceed through its normal closeout gates.
- If Rev13 receives runtime `REVISE` for a structural mismatch, **do not create an additive Rev14**. R04 enters `STRUCTURAL_REBASE_REQUIRED`; the next implementation must reconstruct the rejected visual layer from the accepted Operation concept using a native Godot decomposition while preserving semantic/gameplay contracts.
- Three.js and historical Operation revisions remain evidence only.

This rule does not pre-judge the Rev13 visual result; it defines the only legal continuation after another structural rejection.

## Strict roadmap write fence

While `SIGA-ROADMAP.md` says `Current item: R04`:

- no R05+ implementation;
- no R05+ ARTIST acceptance;
- no R05+ branch, PR, preflight, task decomposition or spec-only preparation;
- no “safe parallel” successor work while CI/LENTE/review is running;
- all useful waiting-time work must remain inside R04.

PR #202 (`R05 Market preflight`) was closed unmerged on 2026-10-01 because it violated this rule. Its intent is not lost; Market is recreated/reconciled only after R04 is canonically `PASS`.

## SIGA mandatory pre-mutation check

Every standalone `Siga` in this workstream must answer these four questions from repository state before writing:

1. What is the earliest non-`PASS` roadmap item?
2. Does the proposed mutation belong to that item?
3. What final architecture/renderer ownership decision constrains it?
4. Is the proposed implementation derived from the accepted current target, or from a frozen/superseded prototype?

Any unsafe answer means **do not mutate**. Correct the current item instead.

## Mechanical enforcement

`tools/validate_feature012_guardrails.py` is part of canonical validation.

For pull requests it additionally enforces:

- an R05+ Feature 012 branch cannot run while the roadmap is still R04;
- `threejs/**` cannot be changed as V1 production work before R16 cleanup;
- known later-scene implementation paths cannot be modified while their roadmap item is locked.

The validator is intentionally conservative. If a legitimate exception exists, amend the canonical roadmap/architecture decision first rather than bypassing the validator.

## Completion

This guardrail remains active through R16. R16 may archive/delete historical Three.js assets only after R01–R15 are PASS.
