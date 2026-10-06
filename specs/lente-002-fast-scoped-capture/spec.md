# LENTE-002 — Fast Scoped Capture

**Status:** IMPLEMENTING — approved optimization item 2  
**Owner:** LENTE / QA  
**Depends on:** Feature 014 validation latency contract  
**Runtime architecture:** unchanged; capture tooling only

## Problem

The current LENTE video path turns a four-second scene observation into 32 sequential PNG screenshots and a later FFmpeg encode. It also uses fixed waits after runtime readiness and defaults to broad capture in situations where one scene is sufficient.

## User Scenarios

### US-1 — One scene means one scene
As the developer invoking `LENTE city`, I want only City page/scene/video evidence so that unrelated scenes do not add latency.

### US-2 — Four seconds of video costs four seconds of acquisition
As the developer reviewing motion, I want the canvas recorded directly after READY so that video acquisition duration follows media duration instead of screenshot-encoding cost.

### US-3 — Screenshot capture is immediate after readiness
As the developer requesting a still, I want frame synchronization/readiness signals rather than arbitrary sleeps and a hard one-second ready-to-file budget.

### US-4 — Full capture remains available
As the maintainer performing certification, I want `LENTE full` to remain an explicit way to capture all canonical scenes.

## Functional Requirements

- **FR-001:** Video capture MUST use browser canvas stream recording, not PNG frame accumulation.
- **FR-002:** Video active acquisition MUST enforce the canonical requested-duration tolerance.
- **FR-003:** Video finalization MUST be measured separately.
- **FR-004:** Still capture MUST use the Chromium compositor capture path directly, avoiding Playwright page screenshot and JavaScript canvas PNG encoding overhead, and MUST enforce the canonical 1000 ms ready-to-file limit.
- **FR-005:** Capture code MUST NOT use fixed `page.waitForTimeout` readiness sleeps.
- **FR-006:** `LENTE <scene>` MUST reduce the manifest to exactly one page + isolated scene + video.
- **FR-007:** Bare LENTE MUST prefer the active bounded scene; full canonical capture MUST require `LENTE full`.
- **FR-008:** Explicit workflow dispatch MUST require a scene or `full_capture=true`.
- **FR-009:** Tooling PR validation MAY use one deterministic smoke scene instead of full capture.
- **FR-010:** Exact-head identity, immutable run folders, CAVEMAN output and history archiving MUST remain unchanged.

## Acceptance Scenarios

1. Structural tests prove the PNG-frame/FFmpeg pipeline is absent.
2. A tooling PR runs LENTE against one smoke scene.
3. Capture metadata identifies MediaRecorder mode and per-media timing.
4. A four-second video exceeding duration plus canonical scheduler tolerance fails.
5. A screenshot exceeding one second after ready fails.
6. `LENTE full` still resolves all canonical manifest entries.

## Success Criteria

- **SC-001:** No `page.waitForTimeout`, Playwright `page.screenshot`, PNG video staging, `spawnSync` or FFmpeg encode remains in the capture harness; stills use direct compositor PNG capture.
- **SC-002:** Scoped manifest contains one page and one isolated scene.
- **SC-003:** MediaRecorder timing is persisted in `capture-metadata.json`.
- **SC-004:** Exact-head LENTE workflow passes on the feature PR using bounded smoke scope.
- **SC-005:** Canonical validation remains green.

## Out of Scope

- toolchain/browser/Godot caching;
- deleting Three.js workflows;
- QA suite sharding;
- fast/full routing outside LENTE;
- progressive polling cadence;
- visual/art acceptance changes;
- gameplay or renderer behavior changes.
