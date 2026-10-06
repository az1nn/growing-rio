# LENTE-002 implementation plan

## Design

1. Add explicit `scene_scope` and `full_capture` workflow inputs.
2. Resolve PR/product scope before export/capture.
3. Replace screenshot-frame video assembly with canvas `captureStream()` + `MediaRecorder`.
4. Replace fixed Playwright waits with readiness conditions/render-frame synchronization and replace `page.screenshot()`/canvas PNG encoding with direct Chromium CDP compositor capture (`Page.captureScreenshot`, `optimizeForSpeed`).
5. Read hard limits directly from the Feature 014 machine contract.
6. Persist still/video timing in capture metadata.
7. Keep exact-head evidence, CAVEMAN and immutable archive behavior intact.
8. Add structural regressions protecting the new capture architecture.

## Delivery

Feature 014 is merged on master. This PR is based directly on that canonical latency contract.
