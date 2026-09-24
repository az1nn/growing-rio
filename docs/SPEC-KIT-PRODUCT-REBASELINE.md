# Spec Kit Product Re-baseline — 2026-09-23

## Status

**CANONICAL PRODUCT-ALIGNMENT RECORD**

This document records the Spec Kit alignment session that reconciled the real player-facing DA LATA application against the existing roadmap, GDD, domain implementation and feature specs.

It exists to prevent future work from treating implemented domain logic as equivalent to a complete player-facing feature.

Trust order for this record:

```text
LIVE REPOSITORY / RUNTIME
> RATIFIED CONSTITUTION
> THIS RE-BASELINE
> ACTIVE FEATURE SPECS
> ROADMAP / GDD
> CHAT OR MODEL MEMORY
```

This document does not delete or invalidate previously completed engineering work. It changes how product maturity and sequencing are interpreted.

---

## 1. Executive finding

The repository is technically ahead of the playable product.

DA LATA already contains substantial domain logic for:

- cultivation;
- economy;
- rooms;
- staff;
- upgrades;
- contracts;
- buyer relationships;
- compliance;
- districts;
- demand;
- community;
- policies;
- narrative events;
- research;
- Act IV campaign progression;
- Act V reconstruction;
- ending eligibility.

However, the player-facing application still concentrates almost the whole experience inside:

```text
scenes/main/main.tscn
```

and currently exposes only a subset of those systems through the UI.

The only implemented 3D environment presentation is:

```text
scenes/visual/operation_diorama.tscn
```

which is intentionally still largely BLOCKOUT quality.

Therefore the historical roadmap checkboxes must not be read as proof that V0.3, V0.4 or V0.5 are complete player experiences.

---

## 2. Real app baseline

### Player-facing surfaces that exist now

The current Main surface lets the player:

- view day / cash / Heat / Reputation / Influence;
- care for the active cultivation room;
- advance the day;
- harvest;
- sell through the licensed channel;
- sell through the abstract parallel channel;
- perform one generic institutional participation action;
- resolve currently available narrative events;
- complete currently available research steps;
- reset the cycle.

### Domain capabilities not yet adequately surfaced

The runtime already implements capabilities for:

- multiple rooms;
- active-room switching;
- hiring staff;
- upgrades;
- contract acceptance and resolution;
- buyer relationships;
- compliance progression;
- district selection;
- district demand;
- community support;
- policy availability and enactment;
- save-state construction and loading;
- later campaign and ending logic.

These capabilities are not yet equivalent to a complete playable or presented product feature.

### Current scene reality

The architecture describes future dedicated surfaces such as:

```text
grow_room/
market/
city/
policy/
```

but the current runtime remains effectively:

```text
Main
 ├─ OperationDiorama
 ├─ management controls
 ├─ narrative panel
 ├─ research panel
 └─ log / reset
```

This is the primary product-architecture gap.

---

## 3. Product maturity model

From this re-baseline forward, a capability must be described using these four stages.

### DOMAIN

The system exists in deterministic/tested code and has a valid state contract.

### PLAYABLE

The player can intentionally use the capability through the actual game flow.

### PRESENTED

The product communicates the capability clearly through appropriate interaction, feedback, information hierarchy and UX.

### POLISHED

The feature is visually and interactively integrated to the product quality bar, including responsive presentation and validated production assets where applicable.

A capability is not simply `DONE` because its domain layer exists.

---

## 4. Current maturity matrix

| Area | Real state | Maturity reading |
|---|---|---|
| Basic cultivation loop | Care / day advance / harvest exposed | PLAYABLE |
| Basic selling | Licensed / parallel buttons exposed | PLAYABLE |
| Cash / Heat / Reputation / Influence | Visible in Main | PRESENTED baseline |
| Multiple rooms | Domain APIs exist | DOMAIN |
| Staff | Domain API exists | DOMAIN |
| Upgrades | Domain API exists | DOMAIN |
| Contracts | Domain implementation exists | DOMAIN |
| Buyer relationships | Persisted / simulated | DOMAIN |
| Compliance | Domain progression exists | DOMAIN |
| Districts | Domain selection/catalog exists | DOMAIN |
| Demand | Domain/economy integration exists | DOMAIN |
| Community | District support state exists | DOMAIN |
| Policies | Domain progression exists | DOMAIN |
| Institutional participation | Generic single action exposed | PLAYABLE partial |
| Narrative events | Choice UI exists | PLAYABLE |
| Research | Research UI exists | PLAYABLE |
| Act IV campaign bridge | Runtime progression exists | DOMAIN / PLAYABLE partial |
| Act V reconstruction | Runtime progression exists | DOMAIN / PLAYABLE partial |
| Ending eligibility | Domain service exists | DOMAIN |
| Ending selection | Feature 008 implemented on PR #51 | DOMAIN / WATCH |
| Save data | Versioned domain boundary exists | DOMAIN |
| Save / Load UX | No complete player-facing flow | ABSENT |
| App navigation | No real game-shell navigation | ABSENT |
| Operation surface | Main contains partial operation UI | PLAYABLE partial |
| Market surface | No dedicated surface | ABSENT |
| City surface | No dedicated surface | ABSENT |
| Policy / institution surface | No dedicated surface | ABSENT |
| Archive / research surface | Embedded in Main | PLAYABLE partial |
| 3D environment | One operation diorama | PRESENTED blockout |
| Contextual diorama system | Not implemented | ABSENT |
| Final UI/UX architecture | Main remains a monolithic vertical surface | ABSENT |

---

## 5. Reinterpretation of roadmap state

### V0.1 — Vertical slice

Mostly valid as a playable vertical slice.

The core cultivation and basic selling loop is genuinely exposed to the player.

### V0.2 — Data-driven simulation

Valid primarily as an engineering/domain milestone.

### V0.3 — Business layer

Current interpretation:

```text
DOMAIN     ✅
PLAYABLE   ❌
PRESENTED  ❌
POLISHED   ❌
```

The roadmap must not be read as saying the Business layer is complete as a game feature.

### V0.4 — City systems

Current interpretation:

```text
DOMAIN     ✅
PLAYABLE   ❌
PRESENTED  ❌
POLISHED   ❌
```

### V0.5 — Campaign

Current interpretation:

```text
DOMAIN     advanced
PLAYABLE   partial
PRESENTED  partial
POLISHED   ❌
```

The campaign/finale implementation advanced ahead of several central management surfaces.

---

## 6. Audit of existing Spec Kit features

### 001 — Research Presentation Surface

**KEEP**

Technically valid and player-facing.

Issue: received product priority before several core management surfaces existed.

### 002 — Onda Provenance Gap Research

**KEEP**

Valid canonical research capability.

### 003 — Research Evidence Boundary Synthesis

**KEEP**

Valid research/canon boundary.

### 004 — Research Material Compatibility Review

**KEEP**

Valid bounded research capability.

### 005 — Act IV Evidence Campaign Bridge

**KEEP + REVALIDATE LATER**

The implementation is valid, but campaign pacing and gates must be re-tested once Business, City and Institutional systems become genuinely playable.

The campaign should progress through real player interaction with those systems rather than merely because domain state can satisfy a flag.

### 006 — Act V Reconstruction Opening

**KEEP + FREEZE**

Valid implementation.

Do not deepen this line until the product re-baseline backlog below is materially addressed.

### 007 — Act V Final Form Eligibility

**KEEP + FREEZE**

Valid domain capability.

No further finale expansion should depend on it until the midgame experience catches up.

### 008 — Act V Ending Selection Persistence

**FINISH CURRENT DELIVERY + FREEZE**

Current operational state at the time of this record:

- PR #51 exists;
- exact-head GitHub validation is green;
- Vercel remains blocked by external build-rate limiting;
- do not bypass that gate;
- when the gate recovers, close the feature normally;
- after merge/validation, freeze finale expansion.

### 009+

**DO NOT START YET**

Do not allocate the next feature number to finale handoff/codas until this product re-baseline is converted into the new ordered Spec Kit backlog.

---

## 7. Candidate backlog — attack one by one

These are re-baseline backlog IDs, not permanent Spec Kit feature numbers yet.

Permanent numbers should be assigned only when each bounded feature is specified.

### RB-01 — Product Experience Map

Define the complete player-facing surface map before adding more endgame behavior.

Must answer:

- what are the major game surfaces;
- what belongs in each surface;
- how the player moves between them;
- what remains overlay vs full-screen;
- how campaign events interrupt or coexist with management;
- how mobile/Web portrait presentation constrains navigation.

### RB-02 — Game Shell / Navigation

Replace the current monolithic Main experience with a stable shell/navigation model.

Candidate destinations:

- Operação;
- Mercado;
- Cidade;
- Institucional;
- Arquivo / Pesquisa;
- campaign/system overlays as required.

### RB-03 — Operation Management Surface

Give the cultivation/operation domain a coherent dedicated player surface.

Should include the already-playable core loop without duplicating domain rules in UI.

### RB-04 — Rooms / Staff / Upgrades

Materialize the existing business-domain capabilities:

- multiple rooms;
- room switching;
- staff;
- upgrades;
- operating-cost feedback.

### RB-05 — Market / Contracts / Buyer Relationships

Materialize:

- buyer choices;
- contracts;
- relationship state;
- market consequences;
- readable risk/reward feedback.

### RB-06 — Compliance Experience

Turn compliance from hidden progression into an understandable playable system.

### RB-07 — City / District / Demand Surface

Materialize:

- district selection;
- district demand;
- market interaction with demand;
- readable city-state consequences.

### RB-08 — Community Feedback

Expose community support and its relationship to Reputation / campaign state without converting it into opaque numbers only.

### RB-09 — Policy / Institutional Surface

Materialize:

- available fictional policies;
- institution progression;
- policy enactment;
- consequences;
- civic participation.

Keep all institutional content fictional/systemic and non-persuasive.

### RB-10 — Archive / Research / Narrative UX

Refactor existing narrative/research presentation out of the Main monolith into the product surface architecture.

Preserve existing domain ownership and canon constraints.

### RB-11 — Save / Load / Campaign UX

The repository has a mature save-state contract but lacks equivalent player UX.

Specify:

- save slots / persistence entry points;
- load / continue behavior;
- corruption/error feedback;
- campaign reset boundaries;
- Web/mobile constraints.

### RB-12 — Diorama Scene System

Move from one decorative operation diorama toward a reusable contextual scene grammar where justified.

Define:

- reusable camera language;
- scene transition model;
- environment ownership;
- performance boundaries;
- how much UI becomes diegetic vs overlay.

### RB-13 — Visual Production Pass

Promote the highest-impact blockout assets/materials to production-candidate quality after the scene architecture is stable.

Do not polish temporary layout architecture.

### RB-14 — Campaign Progression Revalidation

After Business/City/Institution systems become genuinely playable:

- replay Ato I -> V progression;
- validate pacing;
- validate campaign gates;
- remove artificial flag-only shortcuts if they no longer reflect player experience;
- confirm specs 005–008 still produce natural progression.

### RB-15 — Resume Finale

Only after the re-baseline product loop is coherent:

- re-evaluate finale handoff;
- ending codas;
- explicit `arc_da_lata` completion semantics;
- post-ending campaign state.

---

## 8. Open questions that must not be lost

### Q01 — What is the canonical game-shell navigation model?

Candidate answer to validate: persistent portrait-oriented shell with dedicated product surfaces rather than one long vertical Main.

### Q02 — What exactly belongs to Operação?

Need a boundary between:

- cultivation;
- rooms;
- staff;
- upgrades;
- local operating feedback.

### Q03 — Should Market and Compliance share one surface?

Must decide whether compliance is:

- part of market/business management;
- a separate institutional/legal surface;
- or a cross-surface status system.

### Q04 — What is the playable city model?

Need to determine how district choice, demand and community feedback become decisions rather than passive domain variables.

### Q05 — What is the institutional gameplay loop?

The current generic `civic_engagement()` action is not enough as a final product representation.

Need an explicit loop around fictional policies, access, Influence and consequences.

### Q06 — How do narrative events appear?

Need to decide whether narrative:

- interrupts the current surface;
- lives in Archive;
- appears as modal/callout;
- uses contextual scenes;
- or combines these approaches.

### Q07 — How does research relate to ordinary management?

Research currently works, but the product must define when and where the player sees it.

### Q08 — What is the real Save / Continue experience?

Domain persistence is ahead of UX.

### Q09 — How many contextual dioramas are justified?

Do not assume every surface needs unique 3D content.

Validate reuse, performance and visual value first.

### Q10 — When does an Act advance?

Campaign gates must ultimately correspond to meaningful player achievements in surfaced systems, not only implementation flags.

### Q11 — How is DONE measured?

Every new spec must identify its target maturity:

- DOMAIN;
- PLAYABLE;
- PRESENTED;
- POLISHED.

A spec that only reaches DOMAIN cannot silently close a roadmap item whose wording implies a player-facing experience.

### Q12 — What is the minimum product-quality bar before finale work resumes?

This must be explicit before RB-15.

---

## 9. Sequencing rule

Until this re-baseline is superseded by a later verified product decision:

```text
CURRENT APP
    ↓
RB-01 PRODUCT EXPERIENCE MAP
    ↓
RB-02 GAME SHELL
    ↓
RB-03 OPERATION
    ↓
RB-04 ROOMS / STAFF / UPGRADES
    ↓
RB-05 MARKET / CONTRACTS / BUYERS
    ↓
RB-06 COMPLIANCE
    ↓
RB-07 CITY / DISTRICTS / DEMAND
    ↓
RB-08 COMMUNITY
    ↓
RB-09 POLICY / INSTITUTION
    ↓
RB-10 ARCHIVE / RESEARCH / NARRATIVE UX
    ↓
RB-11 SAVE / LOAD UX
    ↓
RB-12 DIORAMA SYSTEM
    ↓
RB-13 VISUAL PRODUCTION
    ↓
RB-14 CAMPAIGN REVALIDATION
    ↓
RB-15 RESUME FINALE
```

This is a product-priority sequence, not a rule that every line must become exactly one spec.

Features may be split when a bounded spec would otherwise become too large.

---

## 10. Freeze rules

Until RB-14 is complete enough to justify reopening the finale:

- do not create new ending-family logic;
- do not deepen Ato V solely because the next implementation is technically obvious;
- do not delete specs 001–008;
- do not rewrite valid domain behavior without evidence from the surfaced product;
- do not polish the monolithic Main as if its current information architecture were final;
- do not treat roadmap checkboxes as player-facing completion without maturity classification.

Feature 008 is exempt only to complete its already-dispatched delivery cycle.

---

## 11. Concurrency state at session registration

At the moment this formal record was prepared:

- canonical repository: `az1nn/growing-rio`;
- base branch: `master`;
- master HEAD used for the session record: `043b8f6e412d362208d3cf7d832c998f2ebb1e06`;
- PR #51: ending-selection persistence, active and Vercel-gated;
- PR #52: LORE Codex Archive Set 04, active;
- neither PR touches this re-baseline document, `docs/ROADMAP.md` or `docs/SPEC-KIT.md`;
- the re-baseline work is therefore classified `PARALLEL_SAFE` with respect to those two active PRs at this snapshot.

Any later merge must still re-read live state.

---

## 12. Session decisions

Accepted during the Spec Kit alignment session:

- the app must be re-baselined against the real player-facing runtime;
- Domain implementation and playable completion are no longer synonymous;
- the current monolithic Main is a product-architecture bottleneck;
- V0.3 Business and V0.4 City require player-facing materialization;
- existing specs 001–008 are not discarded;
- specs 006–008 are frozen after current delivery obligations;
- no 009 finale spec should be created yet;
- the immediate next planning target is the **Product Experience Map**;
- the backlog in this document must be attacked explicitly so gaps are not lost between future SIGA runs.

---

## 13. Next Spec Kit session

The next session should address only **RB-01 — Product Experience Map**.

Required output:

1. canonical surface inventory;
2. system-to-surface ownership matrix;
3. navigation model;
4. campaign/narrative interruption model;
5. portrait Web/mobile interaction constraints;
6. minimum shell architecture;
7. resulting bounded feature decomposition;
8. permanent Spec Kit numbering only after that decomposition is accepted.

Do not jump directly from this document to implementation without first completing that product map.
