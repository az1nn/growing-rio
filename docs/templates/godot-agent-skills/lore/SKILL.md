---
name: lore
description: Resume or advance narrative work in the Godot repository that contains this skill when the user invokes the standalone magic word `lore`.
---

# LORE — Godot narrative continuation protocol

## Purpose

`lore` is the narrative-only continuation command for the game that owns this repository.

It uses the same verify-first operating model as SIGA, but with intentionally narrower authority.

```text
REAL REPOSITORY STATE
  > docs/lore/LORE-HANDOFF.md
  > canonical lore documents
  > implemented narrative data
  > chat/model memory
```

Standalone `lore` never means "invent random worldbuilding".

It means:

1. reconstruct current narrative state from the repository;
2. detect unfinished, gated or contradictory lore work;
3. choose the correct narrative continuation route;
4. perform only narrative/lore work;
5. persist the new state back into this repository.

---

## Target-game configuration

Before first use, replace or resolve these values from the target repository:

```text
<GAME_NAME>
<REPOSITORY_IDENTITY>
<LORE_INDEX>
<GAME_SPECIFIC_NARRATIVE_INVARIANTS>
<GAME_SPECIFIC_BOUNDARIES>
```

Do not copy another game's identity, canon, characters, factions, locations, roadmap, commit SHAs, PR numbers or handoff state.

If the repository is renamed, discover the live identity from Git/GitHub state.

---

## Trigger

Treat `lore` as the magic continuation command when used standalone, ignoring case, surrounding whitespace and terminal punctuation.

Examples:

```text
lore
Lore
LORE
lore!
```

Prose that merely contains the word is not automatically a continuation invocation.

---

# Canonical narrative sources

Minimum required sources:

```text
docs/lore/README.md
docs/lore/LORE-HANDOFF.md
```

`docs/lore/README.md` must identify the target game's actual canon files.

Possible canon documents include:

```text
docs/lore/LORE-BIBLE.md
docs/lore/CHARACTERS.md
docs/lore/FACTIONS.md
docs/lore/LOCATIONS.md
docs/lore/CAMPAIGN.md
docs/lore/TIMELINE.md
docs/lore/HISTORICAL-INSPIRATION.md
```

This list is optional. Read only files that actually exist and are relevant.

Also inspect live repository state when relevant:

- latest commits touching lore/narrative data;
- open lore branches and PRs;
- CI/check state for active lore work;
- unresolved review threads;
- lore-labelled issues/TODOs that are canonical;
- dialogue, quest, event, codex or narrative Resource data already implemented.

Lore documents are semantic authority for intended canon. Implemented content is evidence of what players can currently experience.

---

# Canon-state model

Use a three-state model for important narrative assertions:

```text
CANON
RUMOR
OPEN
```

The target game may localize these labels, but the semantics must remain explicit.

## CANON

Stable fictional-world fact. New work preserves it unless the task explicitly revises canon.

## RUMOR

Diegetic claim that may be false, partial, contradictory or exaggerated.

Never silently promote rumor to canon.

## OPEN

Deliberately unresolved narrative space.

Never close an open question merely to make the lore look complete.

Any mutation between these states must be explicit in the diff and in `docs/lore/LORE-HANDOFF.md`.

---

# LORE start protocol

Every standalone `lore` begins VERIFY-FIRST.

## 1. RECONCILE

Reconstruct the actual narrative state.

### RepoProbe
- repository identity;
- default branch;
- exact HEAD;
- recent narrative/lore commits.

### LoreHandoffProbe
- `docs/lore/LORE-HANDOFF.md`;
- active lore branch/PR;
- previous route;
- unresolved narrative threads;
- declared next lore action.

### CanonProbe
- relevant canon documents;
- contradictions between world, characters, factions, locations, campaign and timeline;
- CANON/RUMOR/OPEN classifications;
- game-specific narrative invariants defined by the target repository.

### ImplementationProbe
When lore is already materialized into game content:
- narrative Resource IDs;
- quest/event IDs;
- dialogue/codex data;
- flags and state transitions;
- naming consistency;
- drift between docs and implemented content.

### EvidenceProbe
If lore work is in a PR:
- exact head SHA;
- CI/check status;
- review state;
- mergeability;
- stale evidence after later commits.

### ResearchProbe
Only when the narrative uses real historical/cultural/scientific material:
- verify source notes when needed;
- distinguish sourced fact from fictionalization;
- avoid inventing factual claims about real people/events;
- keep target-game research boundaries in its own canon docs.

Chat/model memory may help locate material but cannot override repository evidence.

---

## 2. DECIDE

Choose exactly one route:

```text
LORE-RESUME
LORE-WATCH
LORE-ADVANCE
LORE-BLOCKED
```

### LORE-RESUME

Use when a narrative task is unfinished and safe work remains.

Examples:
- incomplete faction pass;
- character arc started but not integrated;
- unresolved canon contradiction;
- lore PR requires revisions;
- handoff names an unfinished coherent wave.

Action:

```text
LORE-RESUME
-> continue the same narrative task
-> do not switch initiatives
-> persist updated lore handoff
```

### LORE-WATCH

Use when lore work has been dispatched and only an active external gate remains.

Examples:
- PR checks running;
- review requested;
- merge/deployment gate pending.

Action:

```text
LORE-WATCH
-> inspect the gate
-> do not create duplicate lore work
-> merge only when repository policy and exact-head gates permit
```

### LORE-ADVANCE

Use when previous lore work is verifiably complete.

Select the next smallest coherent narrative capability from:

1. explicit NEXT in `docs/lore/LORE-HANDOFF.md`;
2. unresolved contradiction or dependency;
3. campaign beat required by existing canon;
4. character/faction/location depth required by a campaign beat;
5. reusable event/dialogue/codex content;
6. chronology/research consistency;
7. new worldbuilding only when it serves the game.

Do not expand the universe merely for volume.

### LORE-BLOCKED

Use when safe continuation requires a genuine human creative decision or information unavailable in the repository.

Record:

- exact decision required;
- affected canon files;
- alternatives already identified;
- what can safely remain OPEN.

Do not fabricate the player's/developer's creative decision.

---

## 3. EXECUTE

A standalone `lore` invocation may perform only work that is primarily narrative.

Allowed work includes:

- worldbuilding;
- canon reconciliation;
- chronology;
- myths and rumors;
- character biographies and arcs;
- factions and relationships;
- locations and cultural geography;
- campaign structure;
- quests and narrative events;
- dialogue;
- codex/archive entries;
- fictional brands/institutions;
- narrative collectibles;
- lore-facing Resources, IDs and content data;
- narrative art briefs;
- historical/cultural research needed to support canon;
- consistency audits;
- lore documentation;
- lore-specific validators/tests whose primary purpose is protecting narrative data.

Not allowed under standalone `lore`:

- unrelated engine refactors;
- generic UI work;
- save-system implementation not driven by a narrative requirement;
- unrelated CI/infrastructure;
- broad balancing;
- generic roadmap work;
- gameplay features whose primary purpose is mechanical.

If lore discovers a necessary non-lore engineering task:

```text
document dependency
-> preserve lore handoff
-> route engineering through SIGA later
```

---

# Narrative invariants

The target repository owns its narrative invariants.

Examples of invariants a game may define:

- tone;
- setting constraints;
- supernatural certainty/ambiguity;
- chronology rules;
- character agency;
- faction morality;
- naming conventions;
- world-scale limits;
- real-history separation;
- themes that every major addition should reinforce.

Do not import invariants from another game.

If `<GAME_SPECIFIC_NARRATIVE_INVARIANTS>` has not yet been defined, derive only what is already evidenced by canon and record unresolved creative questions as OPEN.

---

# Safety/reality boundary

The target repository may define game-specific content boundaries in its lore docs.

Generic requirements:

- clearly distinguish fiction from real factual claims when the game uses real-world material;
- do not invent allegations about real people;
- do not turn narrative research into operational real-world instructions for harmful or illegal activity;
- preserve platform/project safety constraints already documented by the game.

Do not blindly copy another game's domain-specific boundaries.

---

# Lore continuity tree

Before substantial work, expose a compact state tree:

```text
<GAME_NAME> LORE TREE
<repo> @ <head>
└─ LoreRouter
   ├─ RepoProbe ............. PASS | BLOCKED
   ├─ HandoffProbe .......... PASS | MISSING | STALE | BLOCKED
   ├─ CanonProbe ............ CONSISTENT | CONFLICT | PARTIAL
   ├─ ImplementationProbe ... PASS | NOT_REQUIRED | DRIFT
   ├─ EvidenceProbe ......... PASS | RUNNING | FAIL | NOT_REQUIRED
   ├─ Active lore ........... <task / PR / none>
   ├─ Open threads .......... <short narrative gaps>
   └─ Route ................. LORE-RESUME | LORE-WATCH | LORE-ADVANCE | LORE-BLOCKED
```

Then state:

```text
LORE SESSION: <route>
TASK: <one coherent narrative task>
WHY: <canonical evidence>
ACTION: <resume | watch | advance | request creative decision>
```

Keep the tree concise.

---

## 4. PERSIST

Persistent narrative continuation state lives only in:

```text
docs/lore/LORE-HANDOFF.md
```

Do not create a competing lore state in chat memory, an external note or another repository.

After meaningful lore work, update the handoff with:

- verified repository and HEAD/PR;
- route outcome;
- files changed;
- canon additions;
- canon revisions;
- rumors added/changed;
- OPEN questions deliberately preserved;
- implementation dependencies;
- exact next lore action;
- applicable narrative/reality boundaries.

The handoff never overrides live repository state.

---

# Lore handoff format

Use:

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

# Branch and PR discipline

Prefer one coherent lore branch when the repository uses PR-based work.

Examples:

```text
docs/lore-chronology
docs/lore-character-arcs
docs/lore-event-library
```

Before merge:

1. verify the diff is primarily lore-related;
2. verify no accidental canon contradiction;
3. run repository-required gates;
4. inspect exact-head results;
5. merge only when repository policy permits;
6. verify resulting default-branch state;
7. persist final lore handoff.

Documentation-only does not mean verification-free.

---

# One-wave rule

A standalone `lore` invocation should complete or materially advance one coherent narrative wave.

Examples:

- establish chronology;
- deepen one act's character arcs;
- create a first event library;
- reconcile real-history references;
- define a collectible/codex set.

Do not simultaneously start unrelated lore initiatives.

---

# Relationship to SIGA

`siga` is the general operational continuation protocol.

`lore` is its narrative-specialized sibling.

Shared principles:

```text
VERIFY-FIRST
REAL STATE > HANDOFF > CHAT
RECONCILE -> DECIDE -> EXECUTE -> PERSIST
NO FALSE COMPLETION
NO STALE GATE CLAIMS
ONE COHERENT WAVE
```

Difference:

```text
siga  -> may advance any valid repository work
lore  -> may advance only narrative/lore work
```

If the user invokes standalone `lore`, this narrower skill owns that invocation.

If there is no safe narrative work, return `LORE-BLOCKED` or identify the next evidenced lore gap. Do not fall through into generic engineering work.

---

# Repository boundary

This skill is valid only inside the repository that contains it.

If the resolved repository does not match the target game, does not contain the target lore index, or is not a valid Godot project:

```text
LORE_REPO_MISMATCH
-> stop
-> show the resolved repository
-> perform no lore mutation
```

One game must never read or write another game's lore handoff as canonical state.
