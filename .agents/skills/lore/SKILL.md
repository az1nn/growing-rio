---
name: lore
description: Resume or advance DA LATA lore work from canonical repository state when the user invokes the standalone magic word `lore`.
---

# DA LATA Lore Continuation Skill

## Purpose

`lore` is the narrative continuation command for **DA LATA**.

It uses the same verify-first operating philosophy as SIGA, but its authority is intentionally narrower:

```text
REAL REPOSITORY STATE > LORE HANDOFF > CANON DOCS > CHAT / MODEL MEMORY
```

A standalone `lore` never means "invent something random about the game".

It means:

1. reconstruct the current narrative state from the repository;
2. detect unfinished or gated lore work;
3. choose the correct lore continuation route;
4. perform only lore-related work;
5. persist the new narrative state back into the repository.

The skill must never use chat memory as the canonical source of DA LATA lore.

---

## Repository boundary

This skill is valid only inside the repository that contains this file and whose canonical game identity is **DA LATA**.

Current repository identity at the time this skill was created:

```text
az1nn/growing-rio
```

If the repository is later renamed, verify the rename from live GitHub/Git state and then continue in the renamed repository. Do not keep using a stale repository name merely because it appears in an old chat or handoff.

If the resolved repository does not contain the DA LATA lore canon:

```text
LORE_REPO_MISMATCH
-> stop
-> show the resolved repository
-> perform no lore mutation
```

---

## Trigger

Treat `lore` as the magic continuation command when it is used standalone, ignoring:

- case;
- surrounding whitespace;
- terminal punctuation.

Examples that trigger:

```text
lore
Lore
LORE
lore!
```

Prose that merely contains the word "lore" is not automatically a continuation command.

---

# Canonical narrative sources

Before doing new lore work, read the smallest sufficient set of canonical sources.

Minimum index:

```text
docs/lore/README.md
docs/lore/LORE-HANDOFF.md
```

Load additional canon according to impact:

```text
docs/lore/LORE-BIBLE.md
docs/lore/FACTIONS.md
docs/lore/CHARACTERS.md
docs/lore/DISTRICTS.md
docs/lore/CAMPAIGN.md
docs/lore/HISTORICAL-INSPIRATION.md
```

Also inspect live GitHub state when relevant:

- latest commits touching `docs/lore/`;
- open lore branches and PRs;
- CI/check state for active lore PRs;
- unresolved review threads;
- lore-labelled issues or narrative TODOs;
- narrative Resources or event data already implemented.

Do not assume the lore index alone represents delivery state.

---

# Canon states

Every important narrative assertion belongs to one of three states already defined by the project:

```text
CÂNONE
RUMOR
ABERTO
```

## CÂNONE

Stable fact of the fictional world. New work must preserve it unless the task explicitly revises canon.

## RUMOR

Diegetic claim that may be false, incomplete, contradictory or exaggerated.

Do not silently convert rumor into canon.

## ABERTO

Deliberately unresolved narrative space.

Do not close it merely to make the lore feel more complete.

A lore mutation that changes one of these states must be explicit in the diff and in the lore handoff.

---

# LORE start protocol

Every standalone `lore` begins in **VERIFY-FIRST** mode.

## 1. RECONCILE

Reconstruct the actual narrative state.

Check, as applicable:

### RepoProbe
- repository identity;
- default branch;
- exact HEAD;
- recent lore commits.

### LoreHandoffProbe
- `docs/lore/LORE-HANDOFF.md`;
- active lore branch/PR;
- previous route;
- unresolved narrative threads;
- declared next lore action.

### CanonProbe
- relevant canon documents;
- contradictions across world bible, characters, factions, districts and campaign;
- canon/rumor/open classifications.

### ImplementationProbe
When lore has already been materialized into game content:
- narrative Resource IDs;
- event IDs;
- dialogue/codex data;
- implemented quest flags;
- naming consistency.

Lore documents remain the semantic authority, but implemented content is evidence of what players can currently experience.

### EvidenceProbe
If lore work is already in a PR:
- exact head SHA;
- CI/check status;
- review state;
- mergeability;
- stale evidence after subsequent commits.

### HistoricalProbe
Only when the lore task uses real historical/cultural material:
- verify current source notes;
- separate fact from game fiction;
- avoid inventing details about real people;
- keep real-world claims sourced in the historical-inspiration document.

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

Use when a lore task is unfinished and safe work remains.

Examples:
- an incomplete faction pass;
- a character arc started but not integrated into campaign;
- unresolved canon contradictions;
- an open lore PR requiring revisions;
- a lore handoff that names an unfinished coherent wave.

Action:

```text
LORE-RESUME
-> continue the same lore task
-> do not switch to a different narrative initiative
-> persist updated handoff
```

### LORE-WATCH

Use when lore work has already been dispatched and the only remaining state is an active external gate.

Examples:
- PR checks running;
- review requested;
- merge queued but not yet verified.

Action:

```text
LORE-WATCH
-> inspect the gate
-> merge only when repository policy and green gates permit
-> do not invent a second lore task while the same task is still active
```

### LORE-ADVANCE

Use when previous lore work is verifiably complete.

Select the next smallest coherent lore capability from canonical gaps.

Preferred discovery order:

1. explicit `NEXT` in `LORE-HANDOFF.md`;
2. unresolved contradiction or open narrative dependency;
3. campaign beat required by already-defined canon;
4. character/faction/district depth required by a campaign beat;
5. reusable event/dialogue/codex content;
6. chronology and historical consistency;
7. new worldbuilding only when it serves the existing game.

Do not expand the universe merely for volume.

### LORE-BLOCKED

Use when safe lore continuation requires information the repository cannot provide or a genuine human creative decision.

Record:
- exact decision required;
- affected canon files;
- alternatives already identified;
- what can safely remain open.

Do not fabricate the user's creative decision.

---

## 3. EXECUTE

A `lore` invocation may perform only work that is primarily narrative.

Allowed work includes:

- worldbuilding;
- canon reconciliation;
- chronology;
- myths and rumors;
- character biographies and arcs;
- factions and relationships;
- districts and cultural geography;
- campaign structure;
- quests and narrative events;
- dialogue;
- codex/archive entries;
- fictional brands and institutions;
- narrative collectible concepts;
- lore-facing Resource/event IDs and content data;
- narrative art briefs;
- historical/cultural research needed to support canon;
- consistency audits;
- lore documentation;
- lore-specific tests or validators when their sole purpose is protecting narrative data.

Not allowed under standalone `lore`:

- unrelated engine refactors;
- generic UI work;
- save-system implementation;
- unrelated CI/infrastructure;
- economy/cultivation balancing that does not directly serve a narrative task;
- broad product roadmap work;
- gameplay features whose primary purpose is mechanical rather than narrative.

If lore discovers a necessary non-lore engineering task:

```text
-> document the dependency
-> create or update the appropriate handoff/issue if authorized
-> do not silently turn the lore session into an engineering session
```

---

# Narrative design invariants

Every major lore addition should connect to at least two established DA LATA axes:

- money;
- memory;
- legitimacy;
- risk;
- community;
- reputation;
- institutionalization;
- research;
- identity.

Prefer consequences and tensions over encyclopedic exposition.

## Existing thematic invariants

Preserve unless explicitly revised:

- Rio is recognizable but fictionalized;
- nobody controls the whole city;
- formal and parallel markets are not simple good/evil binaries;
- memory is an active narrative resource;
- DA LATA is myth before it is cultivar;
- institutional politics remains fictional and systemic;
- cultivation remains abstract;
- parallel-market activity remains abstract;
- the supernatural is never conclusively confirmed;
- no ending is labelled the morally correct ending.

---

# Safety and reality boundary

Lore may depict fictional cannabis markets, institutional conflict and historical memory, but it must remain narrative rather than operational.

Do not add:

- real cultivation recipes, target parameters, dosages or optimization procedures;
- real trafficking routes, concealment methods, sourcing procedures or evasion tactics;
- real political targeting or persuasion strategy;
- invented allegations about real people;
- claims that the fictional DA LATA cultivar is a proven historical lineage.

Real historical references must stay clearly separated from fictional canon.

---

# Lore continuity tree

Every standalone `lore` should expose a compact state tree before substantial work:

```text
DA LATA LORE TREE
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

# Persistence

Persistent lore continuation state lives only in:

```text
docs/lore/LORE-HANDOFF.md
```

Do not create a competing lore state in chat memory, external notes or another repository.

At the end of a meaningful lore mutation, update the handoff with:

- verified repository and HEAD/PR state;
- route outcome;
- files changed;
- canon additions;
- canon revisions;
- rumors added or changed;
- open questions deliberately preserved;
- implementation dependencies discovered;
- exact next lore action.

The handoff never overrides live repository state.

---

# Lore handoff format

Use this structure:

```markdown
# LORE HANDOFF — DA LATA

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
- Districts:
- Campaign:
- Historical boundary:
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

Prefer a dedicated lore branch for a coherent narrative wave.

Examples:

```text
docs/lore-chronology
docs/lore-character-arcs
docs/lore-event-library
```

Before merge:

1. verify the diff is primarily lore-related;
2. verify no canon contradiction was introduced accidentally;
3. run repository-required gates;
4. inspect exact-head results;
5. merge only when permitted by repository policy;
6. verify the resulting default-branch state;
7. persist the final lore handoff.

Documentation-only does not mean verification-free.

---

# One-wave rule

A single `lore` continuation should complete or materially advance **one coherent narrative wave**.

Examples of one wave:

- establish the city chronology;
- deepen all Act I character arcs;
- create the first 30 event concepts;
- reconcile DA LATA historical references;
- define collectible archive entries for the four symbols.

Do not simultaneously start unrelated lore initiatives just because they are all narrative.

---

# Relationship to SIGA

`siga` is the general operational continuation protocol.

`lore` is its narrative-specialized sibling.

Shared principles:

```text
VERIFY-FIRST
REAL STATE > HANDOFF > MEMORY > CHAT
RECONCILE -> DECIDE -> EXECUTE -> PERSIST
NO FALSE COMPLETION
NO STALE GATE CLAIMS
```

Difference:

```text
siga  -> may advance any valid project work
lore  -> may advance only narrative/lore work
```

If the user invokes `lore`, this narrower skill wins for that invocation.

If there is no safe lore work to perform, return `LORE-BLOCKED` or identify the next lore gap. Do not fall through into generic SIGA engineering work.
