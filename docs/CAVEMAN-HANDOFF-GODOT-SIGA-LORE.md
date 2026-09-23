# CAVEMAN HANDOFF v1 — Portable SIGA + LORE for Godot Games

## Mission

Transplant the proven repository-local continuation model used by this Godot project into another Godot game without copying game-specific canon, roadmap state, product rules, or stale repository identity.

Source repository verified for this handoff:

```text
az1nn/growing-rio
master @ 0bccabac3435ca8aef33047fead246e3a5856846
```

Source skills:

```text
.agents/skills/siga/SKILL.md
.agents/skills/lore/SKILL.md
```

Portable templates created with this handoff:

```text
docs/templates/godot-agent-skills/siga/SKILL.md
docs/templates/godot-agent-skills/lore/SKILL.md
```

This handoff is a bootstrap artifact, not runtime project state.

---

## Prime directive

Each target game owns its own continuation state.

```text
REAL TARGET REPOSITORY STATE
  > TARGET REPOSITORY HANDOFF
  > TARGET REPOSITORY CANON / SPECS / ROADMAP
  > CHAT / MODEL MEMORY
```

Never create one global SIGA or LORE state shared by several games.

Never use this source repository's handoff as the target game's live state.

---

## What must be copied into each target Godot repository

```text
.agents/
└── skills/
    ├── siga/
    │   └── SKILL.md
    └── lore/
        └── SKILL.md

docs/
├── SIGA-HANDOFF.md
└── lore/
    ├── README.md
    └── LORE-HANDOFF.md
```

Recommended additional lore files are game-dependent:

```text
docs/lore/
├── LORE-BIBLE.md
├── CHARACTERS.md
├── FACTIONS.md
├── LOCATIONS.md
├── CAMPAIGN.md
├── TIMELINE.md
└── ...
```

Do not create empty ceremonial documents merely to match this list. The target repository decides its real canon structure.

---

# Bootstrap procedure

## 1. REPO PROBE

Before installing either skill, inspect the target repository:

- repository identity;
- default branch;
- exact HEAD;
- `project.godot`;
- Godot major/minor version when discoverable;
- current scenes, autoloads, Resources and tests;
- active branches and pull requests;
- CI workflows and current checks;
- roadmap/spec/handoff documents;
- Web export/deployment state when present.

If no valid Godot project is present, stop with:

```text
GODOT_REPO_MISMATCH
```

Do not force-install a Godot-specific continuation protocol into a non-Godot repository.

## 2. INSTALL SIGA

Copy:

```text
docs/templates/godot-agent-skills/siga/SKILL.md
->
.agents/skills/siga/SKILL.md
```

Then create:

```text
docs/SIGA-HANDOFF.md
```

The first target handoff must record only verified target state. Do not seed it with DA LATA state, commit SHAs, PR numbers, milestones, URLs or boundaries.

## 3. INSTALL LORE

Copy:

```text
docs/templates/godot-agent-skills/lore/SKILL.md
->
.agents/skills/lore/SKILL.md
```

Create the minimum lore index:

```text
docs/lore/README.md
docs/lore/LORE-HANDOFF.md
```

Replace the template placeholders from real target repository evidence:

```text
<GAME_NAME>
<REPOSITORY_IDENTITY>
<LORE_INDEX>
<GAME_SPECIFIC_NARRATIVE_INVARIANTS>
<GAME_SPECIFIC_BOUNDARIES>
```

If the target game has no lore yet, `lore` may bootstrap a minimal canon structure, but it must clearly distinguish newly authored canon from facts already implemented in the game.

## 4. FIRST SIGA RUN

The first standalone `Siga` must perform:

```text
RECONCILE
-> DECIDE
-> EXECUTE only if a real next task exists
-> PERSIST
```

Expected routes:

```text
RESUME
WATCH
ADVANCE
```

The first run must prove that the skill discovers the target game's actual repository state rather than using this source handoff.

## 5. FIRST LORE RUN

The first standalone `lore` must perform:

```text
RECONCILE narrative state
-> DECIDE lore route
-> EXECUTE one coherent lore wave
-> PERSIST docs/lore/LORE-HANDOFF.md
```

Expected routes:

```text
LORE-RESUME
LORE-WATCH
LORE-ADVANCE
LORE-BLOCKED
```

---

# Godot-specific SIGA probes

A portable Godot SIGA should inspect these only when relevant:

### Engine
- `project.godot`;
- required Godot version;
- autoloads;
- main scene;
- input map changes;
- resource/scene parse health.

### Automated verification
- headless import/smoke test;
- GDScript/static validation available in the repo;
- unit/regression tests;
- deterministic simulation tests when the game uses seeded systems;
- save/load migration tests when persistence exists.

### Delivery
- `export_presets.cfg`;
- Web export;
- desktop/mobile export as applicable;
- GitHub Actions;
- deployment provider;
- public/preview playable URL when configured.

### State integrity
- exact commit SHA used by checks;
- stale checks after later commits;
- open PR mergeability;
- post-merge default-branch validation.

Never claim a gate is green unless it applies to the exact relevant HEAD.

---

# Portable behavior contract

## SIGA

`Siga` is the general continuation router.

It may advance engineering, gameplay, content, docs, CI, delivery or other repository-valid work.

Core invariant:

```text
VERIFY-FIRST
REAL STATE > HANDOFF > CHAT
RECONCILE -> DECIDE -> EXECUTE -> PERSIST
NO FALSE COMPLETION
NO STALE GATE CLAIMS
ONE COHERENT WAVE
```

## LORE

`lore` is the narrative-only sibling.

It may advance:

- worldbuilding;
- canon;
- chronology;
- characters;
- factions;
- locations;
- campaign beats;
- quests;
- dialogue;
- codex/archive material;
- narrative Resources and event IDs;
- narrative consistency validators.

It must not silently turn into a generic engineering session.

If narrative work exposes an engineering dependency:

```text
record dependency
-> preserve lore handoff
-> route engineering through SIGA later
```

---

# What must NOT be transplanted from DA LATA

The following belong to this game only unless the target game independently needs them:

- DA LATA product/game identity;
- `az1nn/growing-rio` repository identity;
- DA LATA roadmap/version numbers;
- Rio-specific world assumptions;
- characters, factions, districts, symbols and campaign canon;
- money/memory/legitimacy/etc. thematic axes;
- cannabis-market abstractions;
- DA LATA historical-research boundaries;
- existing PR numbers, workflow run IDs, commit SHAs and deployment status;
- current `docs/SIGA-HANDOFF.md` or `docs/lore/LORE-HANDOFF.md` state.

Portable rule: copy the protocol, never the project's facts.

---

# Target handoff schemas

## docs/SIGA-HANDOFF.md

```markdown
# SIGA HANDOFF — <GAME_NAME>

## Verified repository
- Repository:
- Default branch:
- Verified HEAD:
- Active PR:

## Current milestone
- ...

## Verified gates
- ...

## Decision
RESUME | WATCH | ADVANCE

## Completed this wave
- ...

## Active gate
- ...

## Delivery
- Web/export status:
- Playable URL:
- Verified deployment commit:

## Next action
1. ...

## Boundaries
- ...
```

## docs/lore/LORE-HANDOFF.md

```markdown
# LORE HANDOFF — <GAME_NAME>

## Verified repository
- Repository:
- Default branch:
- Verified lore HEAD:
- Active lore PR:

## Route
LORE-RESUME | LORE-WATCH | LORE-ADVANCE | LORE-BLOCKED

## Completed this wave
- ...

## Canon delta
### Added
- ...

### Revised
- ...

### Preserved open
- ...

## Continuity checks
- Characters:
- Factions:
- Locations:
- Campaign:
- Timeline:
- Implemented narrative data:

## Active gate
- ...

## Next lore action
1. ...

## Boundaries
- ...
```

---

# Acceptance checklist for a new game

The transplant is complete only when all applicable checks pass:

- [ ] Target repository is verified as a Godot project.
- [ ] `.agents/skills/siga/SKILL.md` exists in the target repository.
- [ ] `.agents/skills/lore/SKILL.md` exists in the target repository.
- [ ] `docs/SIGA-HANDOFF.md` contains only target-game state.
- [ ] `docs/lore/LORE-HANDOFF.md` contains only target-game narrative state.
- [ ] `docs/lore/README.md` identifies the target game's canonical lore sources.
- [ ] Standalone `Siga` performs verify-first reconciliation.
- [ ] Standalone `lore` stays narrative-only.
- [ ] Neither skill treats chat memory as canonical state.
- [ ] Both skills use exact-head evidence for active gates.
- [ ] Godot tests/checks are discovered from the target repo rather than invented.
- [ ] Web/export delivery is reconciled if it is an active capability.
- [ ] No DA LATA-specific canon or operational state leaked into the target.
- [ ] First meaningful run persists a new target-local handoff.

---

# Recommended implementation commit

For a new Godot game, use one small bootstrap wave:

```text
chore(agent): bootstrap repository-local SIGA and lore skills
```

The bootstrap commit should contain only:

- the two target-local skill files;
- minimal handoff/index documents;
- no unrelated gameplay refactor.

After that commit, run the target game's normal repository gates and verify the exact resulting HEAD.

---

# CAVEMAN transfer packet

Use this minimal instruction when handing the work to another agent/session:

```text
CAVEMAN HANDOFF v1 — GODOT SIGA/LORE

Goal:
Install repository-local SIGA and LORE continuation skills in this Godot game.

Authority:
REAL REPO > repo handoffs/canon > chat memory.

Source protocol:
Use the generic templates from the DA LATA source handoff, but copy protocol only.
Do not copy DA LATA canon, repo identity, roadmap state, SHAs, PRs, URLs, or game-specific boundaries.

Required target files:
.agents/skills/siga/SKILL.md
.agents/skills/lore/SKILL.md
docs/SIGA-HANDOFF.md
docs/lore/README.md
docs/lore/LORE-HANDOFF.md

SIGA:
RECONCILE -> DECIDE(RESUME/WATCH/ADVANCE) -> EXECUTE -> PERSIST.

LORE:
RECONCILE -> DECIDE(LORE-RESUME/LORE-WATCH/LORE-ADVANCE/LORE-BLOCKED)
-> EXECUTE one narrative wave -> PERSIST.

Godot:
Verify project.godot, engine/test setup, CI, export presets and playable Web delivery when applicable.

State:
All persistent state stays inside the target repository.
Never create a global cross-game SIGA/LORE state.

Finish:
Run applicable checks against the exact target HEAD and persist the first verified target handoffs.
```

---

## Final invariant

```text
ONE GAME = ONE REPOSITORY = ONE SIGA STATE = ONE LORE STATE
```

The portable asset is the operating protocol. The game's facts always remain local.
