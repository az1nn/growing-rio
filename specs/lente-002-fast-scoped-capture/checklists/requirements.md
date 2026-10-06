# LENTE-002 requirements checklist

## Scope

- [x] Optimization is limited to LENTE capture behavior.
- [x] Full capture remains available explicitly.
- [x] Exact-head and immutable evidence rules remain intact.
- [x] No caching, Three.js cleanup, QA sharding or polling optimization is included.

## Latency

- [x] Still capture reads the canonical 1000 ms budget.
- [x] Video acquisition reads requested duration and scheduler tolerance.
- [x] Video finalization is a separate timing.
- [x] Fixed Playwright timeout sleeps are removed.
- [x] Playwright `page.screenshot()` is removed from the still path; PNGs come directly from the runtime canvas.
- [x] PNG-frame video assembly is removed.
- [x] FFmpeg encoder bootstrap is removed because the capture path no longer uses it.

## Routing

- [x] `LENTE <scene>` maps to one scene.
- [x] Bare LENTE prefers active bounded scene state.
- [x] `LENTE full` is explicit.
- [x] Explicit workflow dispatch without scene/full intent fails closed.
- [x] Tooling PR smoke validation is bounded to Operation.
