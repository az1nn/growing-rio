# SIGA session claim — CENA-017 Finale visual acceptance

SIGA-TASK-KEY: `CENA-017:FINALE-VISUAL-ACCEPTANCE`

## Ownership

This stacked branch owns T006 rendered-evidence plumbing only.

Reserved paths:
- `scenes/shell/game_shell.gd`
- `scenes/shell/game_shell.tscn`
- `.github/workflows/visual-acceptance.yml`
- `.siga/session-claim-cena-017-finale-visual.md`

It must not mutate domain ending selection, persistence, inventory, campaign progression, or T004/T005 audit files.

## Stack

Base head: `a9163ecc6a6de268869b8eae386bdbb2772f5a47` (T005 / PR #170).

Acceptance requires exact-head screenshots for Finale phases `selection`, `handoff`, `coda`, and `recap` at 540x960 and 1080x1920 with no browser console errors.
