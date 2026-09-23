# SIGA — repository continuation protocol

This skill is local to the repository that contains it. The repository is the source of truth.

When the user says `Siga`:

1. **RECONCILE** — inspect the real repository state first: repository identity, default branch, HEAD, working branches, PRs, Actions/checks, specs/docs and the handoff file.
2. **DECIDE** — classify the continuation as:
   - `RESUME`: unfinished work exists.
   - `WATCH`: work is dispatched and active gates/checks remain.
   - `ADVANCE`: previous work is verifiably complete; start the next documented milestone.
3. **EXECUTE** — make the smallest coherent change, run available automated checks, commit/push and use a PR when appropriate.
4. **PERSIST** — update `docs/SIGA-HANDOFF.md` with verified state, decisions, gates and the next action.

## WEB DELIVERY — playable browser build

When this Godot repository has a browser export or deployment path configured, the playable Web build is part of the real operational state that SIGA must reconcile.

During **RECONCILE**, inspect when applicable:

- Godot Web export configuration (for example `export_presets.cfg`);
- CI workflow(s) that build/test/export the Web target;
- deployment configuration for the selected provider (for example Vercel or GitHub Pages);
- the latest relevant Actions/deployment result;
- the current public playable URL, when one is configured.

During **DECIDE**:

- classify as `RESUME` when the current milestone requires Web delivery and export/deploy is missing or broken;
- classify as `WATCH` when the Web build/deployment is already dispatched and its gate is still running;
- classify as `ADVANCE` only after the required code/tests plus Web export/deployment gates are green for milestones where browser delivery is part of the acceptance criteria.

During **EXECUTE**:

- keep Web export/deployment reproducible from repository configuration and CI;
- prefer automated promotion from the validated default branch rather than manual uploads;
- do not publish a failing or unvalidated build as the stable public playable version;
- preview deployments may be used for branches/PRs when the provider supports them, without replacing the stable build.

During **PERSIST**, record Web delivery state in `docs/SIGA-HANDOFF.md` when relevant: provider, public/preview URL, workflow/run or deployment reference, last verified commit, gate result and next action.

If Web delivery is not configured yet and is not required by the current milestone, its absence is not by itself a failure. Once Web delivery becomes an accepted project capability or milestone, SIGA must preserve and verify it on subsequent continuations.

Trust order: **REAL STATE > repository handoff > conversation context**.

Do not use chat memory as canonical project state. Do not create a second global SIGA state outside this repository.
