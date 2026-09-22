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

Trust order: **REAL STATE > repository handoff > conversation context**.

Do not use chat memory as canonical project state. Do not create a second global SIGA state outside this repository.
