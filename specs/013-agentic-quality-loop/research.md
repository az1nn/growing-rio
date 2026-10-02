# Feature 013 — research synthesis

## Research question

Which agentic-game-development practices from the external CSBR/CORO SOLTO material are useful for DA LATA without importing its FPS-specific architecture or overriding DA LATA's existing authorities?

## Adopt

### 1. Builder != judge

The strongest reusable pattern is structural separation between implementation and criticism. A fresh critic should first see the runtime evidence/reference/contract, not the builder's explanation.

DA LATA mapping:
- builder: owning specialist (GODOT/CENA/etc.);
- observation: LENTE;
- measurable verification: QA;
- visual acceptance: ARTIST/CENA/human;
- orchestration/delivery: SIGA.

### 2. Baseline -> candidate -> A/B -> regression hunter

A candidate can improve the primary target while making something else worse. Therefore target conformance and regression detection are separate review questions.

### 3. Mutation-test the ruler

A green quality rule is trustworthy only if a known-bad mutation can turn it red and restoration returns it green. Mutation must also prove that the mutation actually applied.

### 4. Review rendered states, not only a beauty frame

The external viewmodel contact-sheet idea generalizes well to DA LATA scene states. For DA LATA the dimensions are scene/surface × semantic runtime state × portrait viewport × relevant UI state.

### 5. Generated architecture/ownership

Hand-maintained architecture indices drift. DA LATA should generate routing/ownership information from repository-observable contracts and fail freshness checks when stale.

### 6. Real browser/export E2E

Structural/headless tests are necessary but cannot replace real player interaction against the exported Web runtime.

### 7. Asset/provenance/technical-art ledgers

A normalized evidence ledger is useful when it records provenance and measured constraints. It must not become an automatic art-quality authority.

## Adapt, do not copy

- use an engine-agnostic `gauntlet`, not an FPS-specific loop;
- use DA LATA's existing exact-head/CENA/LENTE/ARTIST/SIGA contracts;
- prefer Godot/runtime concepts and canonical semantic hotspots;
- keep expensive visual/browser evidence outside the fastest gate where necessary;
- use explicit stop conditions to avoid autonomous quality loops that churn without movement.

## Reject

- replacing SIGA with an imported “game director” master;
- switching to Three.js because the reference repository uses it;
- copying weapon/viewmodel-specific tools;
- importing numerical visual scores as final art acceptance;
- requiring external asset generators or API keys for completion;
- copying large tool directories without a DA LATA acceptance need;
- allowing generated graph/index state to outrank live Git/repository authority.

## Graphify position

Graphify is interesting only after a deterministic generated ownership baseline exists. The pilot must answer whether persistent semantic queries materially reduce SIGA reconciliation/impact-analysis cost. If not, it should be removed.

## Result

The recommended sequence is intentionally incremental:

```text
Gauntlet contract
-> mutation doctrine
-> state matrix
-> fresh critic + regression hunter
-> generated ownership
-> browser E2E
-> evidence ledger
-> optional graph pilot
-> SIGA certification
```

This sequence is encoded in `tasks.md` and registered in the single product roadmap.
