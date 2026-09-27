# Feature 009 — Abstract Lifecycle Balance Contract

This file owns the shipped **game-pacing** split for the 90-day lifecycle. It is not a horticultural model and MUST NOT be used as real cultivation guidance.

## Canonical thresholds

Lifecycle derivation uses `grow_day` with end-exclusive pre-ready ranges:

| Stage | Game-only range | Span |
| --- | ---: | ---: |
| `seedling` | `0 <= grow_day < 22` | 22 days |
| `Vega` | `22 <= grow_day < 45` | 23 days |
| `flora` | `45 <= grow_day < 68` | 23 days |
| `late flowering` | `68 <= grow_day < 90` | 22 days |
| `pronta` | `grow_day >= 90` | terminal/readiness |

The four pre-`pronta` spans total exactly **90** growth days: `22 + 23 + 23 + 22 = 90`.

## Balance rationale

The split is deliberately near-even around four abstract pacing quarters. The only purpose is readable game progression across a 90-day cycle while keeping the middle two bands one day longer to absorb integer rounding.

It is intentionally **not** derived from real plant biology, environmental parameters, feeding schedules, lighting, irrigation, chemistry, or cultivation practice.

## Invariants

1. Thresholds are strictly monotonic: `0 < 22 < 45 < 68 < 90`.
2. Every integer `grow_day` from 0 through 89 maps to exactly one pre-ready stage.
3. `pronta` begins only at `grow_day >= 90`.
4. Stage derivation is pure and deterministic.
5. Stage transitions do not award inventory or yield.
6. Changing this split is a balance change and requires an explicit repository update; it is not inferred from external cultivation information.

## Automated validation

The same thresholds are mirrored in `balance.json`, whose purpose marker is `game_pacing_only`. `tools/validate_lifecycle_balance.py` validates ordering, contiguity, complete 0–89 coverage, the day-90 readiness boundary, and this file's explicit non-cultivation disclaimer in CI.
