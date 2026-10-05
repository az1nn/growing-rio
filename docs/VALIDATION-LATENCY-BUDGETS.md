# DA LATA validation latency budgets

Status: **ACTIVE / canonical timing contract**  
Repository: `az1nn/growing-rio`  
Approved plan slice: **Item 1 — formal latency budgets**  
Machine source: `tools/validation_latency_budgets.json`

## Why this exists

Validation is part of the developer feedback loop. A correct gate that takes minutes for a seconds-long observation creates avoidable iteration debt and encourages stale evidence.

This contract defines how validation time is measured before any workflow optimization is attempted. It intentionally does **not** implement LENTE recording changes, Three.js cleanup, caching, QA sharding, fast/full routing or polling changes. Those are separate approved plan items.

## Clock model

Every measured operation must separate these clocks when applicable:

| Clock | Meaning |
| --- | --- |
| `queue_ms` | Provider/runner scheduling before execution starts. |
| `bootstrap_ms` | Checkout, tool download/install, cache restore, browser/engine setup. |
| `ready_wait_ms` | Waiting for the exact-head runtime to become observably ready. |
| `execute_ms` | The actual validation, screenshot or video acquisition work. |
| `artifact_ms` | Encoding, packaging and artifact upload after the observation exists. |
| `total_ms` | End-to-end wall time. Never use this alone to diagnose capture cost. |

Use a monotonic clock inside scripts. Provider timestamps are acceptable for workflow-level historical analysis.

A **timeout is a safety ceiling, not a latency budget**.

## Non-negotiable media invariants

1. **Still image:** after an observable runtime READY condition, ready-to-file must complete in **<= 1000 ms**.
2. **Video:** the active acquisition target must be **<= requested media duration**. A maximum **250 ms scheduler tolerance** is allowed only for runtime scheduling jitter; it is not a license for deliberate sleeps.
3. **Post-processing:** encoding/post-processing is measured separately from acquisition and targets **<= 1000 ms per video**.
4. **Observable readiness beats sleep:** when a signal, DOM condition, runtime flag or process condition can prove readiness, fixed sleeps must not be used as the readiness mechanism.
5. Queue, bootstrap and artifact transfer must never be described as image/video capture duration.

## Workflow optimization targets

These values are the target operating envelope for the optimization work that follows. They are not yet historical CI blockers; item 9 will add regression enforcement after the pipeline is instrumented.

| Lane | p50 | p90 | hard target | Measurement |
| --- | ---: | ---: | ---: | --- |
| L0 structural contract | 0.25s | 1s | 2s | execution |
| Targeted QA | 3s | 7s | 12s | execution |
| Targeted Godot scene/integration | 5s | 10s | 15s | execution |
| Exact-head full validation | 20s | 30s | 45s | workflow execution |
| Warm exact-head Web export | 10s | 20s | 30s | workflow execution |
| Warm single-scene visual overhead | 3s | 6s | 10s | excludes requested video duration |
| Warm full LENTE canonical pass | 45s | 60s | 90s | total execution, including requested media |

"Warm" means required versioned toolchains are already available via image/cache. Cold bootstrap is measured and reported separately.

## Baseline observed before optimization — 2026-10-05

Recent GitHub Actions history sampled **298 completed runs**. Values below are evidence for improvement, not acceptable targets.

| Workflow | sample | p50 | p90 | max observed |
| --- | ---: | ---: | ---: | ---: |
| `validate.yml` | 40 | 38s | 64s | 84s |
| `visual-acceptance.yml` | 37 | 128s | 382s | 455s |
| `visual-lab.yml` | 29 | 107s | 503s | 926s |
| `export-web.yml` | 15 | 45s | 51s | 57s |
| Three.js scene acceptance family | recent sample | ~42–45s | ~54–94s | up to 299s |

One successful LENTE run on 2026-10-05 spent roughly **827 seconds** inside `Capture exact-head multimodal evidence` alone. This is the primary known latency outlier, but correcting it belongs to plan item 2.

## Severity

- `LATENCY_HARD_INVARIANT_BREACH`: a new/modified capture implementation violates still/video hard media rules. Block the change.
- `LATENCY_BUDGET_BREACH`: an operation exceeds a declared workflow target. Record the responsible stage and optimize; until telemetry enforcement is introduced, this is not by itself permission to fail unrelated product delivery.
- `LATENCY_MEASUREMENT_MISSING`: a workflow is being optimized but does not expose enough stage timing to attribute the delay.
- `LATENCY_PROVIDER_QUEUE`: runner/provider queue time is elevated; report separately and do not misclassify as repository execution time.

## Ownership

- **SIGA:** chooses the correct validation lane and preserves exact-head correctness.
- **QA:** owns timing measurement, classification and later regression enforcement.
- **LENTE:** owns media observation timing and must respect hard still/video invariants.
- **ARTIST/CENA/GODOT:** consume evidence and must not bypass gates to improve timing.
- **RELATORIO:** reports latency only when it affects current delivery; it is not a timing authority.
- **3JS:** frozen/reference for V1; its legacy latency is baseline evidence only until the dedicated cleanup item.

## Change policy

Changing a hard media invariant requires explicit human approval. Changing p50/p90 workflow targets requires an evidence-backed repository change explaining the new workload or architecture. Never relax a budget solely because the implementation is slow.

