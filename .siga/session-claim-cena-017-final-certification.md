# Session claim — CENA-017 final certification

- task key: `CENA-017:T007-T010`
- purpose: reconcile delivered T003-T006, generate one reconciled exact-head visual/structural certification, record final matrix, and persist CENA/SIGA closure
- base: `master`
- ownership: documentation/spec certification paths only unless exact-head evidence proves a concrete runtime defect
- collision rule: abort or reconcile before mutation if another live session claims CENA-017 final certification
- provider rule: explicit Vercel build-rate-limit is non-blocking for development certification when repository/rendered gates are green
