# Requirements Checklist — Feature 009

- [x] Scope is bounded to campaign calendar and abstract plant lifecycle.
- [x] Campaign duration is exactly 365 in-game days.
- [x] Individual plant-cycle duration is exactly 90 in-game days.
- [x] Lifecycle order is fixed to `seedling → Vega → flora → late flowering → pronta`.
- [x] `pronta` is the terminal pre-harvest state.
- [x] Exact pre-ready stage day splits remain balance-owned rather than silently canonized.
- [x] No real cultivation parameters, recipes or operational horticultural advice are introduced.
- [x] Lifecycle stage is intended to be deterministic and RNG-free.
- [x] Stage transitions cannot independently create inventory or extra harvests.
- [x] Existing persisted `day` and per-room `grow_day` are reused where possible.
- [x] A save-schema bump is not planned unless implementation introduces genuinely new canonical state.
- [x] Multi-room state remains independent.
- [x] Day-365 and 90-day off-by-one behavior are explicit acceptance targets.
- [x] Existing supported save migrations remain part of acceptance.
- [x] Exact-head validation and guarded merge remain mandatory.
- [x] Lore PR #123 is delivered/reconciled; the abstract balance split and automated invariant validation are complete, so runtime implementation may proceed from T006.
