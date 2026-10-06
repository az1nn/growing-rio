# Feature 015 — Cloudflare Canonical Delivery tasks

**Execution:** SIGA / GODOT / QA
**Rule:** infrastructure-only wave; Feature 012 runtime and visual paths are fenced.

- [x] [T001] Reconcile live repository/provider evidence and claim dedicated SIGA branch/PR.
- [x] [T002] Create Spec Kit spec/plan/tasks/requirements.
- [x] [T003] Add shared exact-head Cloudflare Web preparation entrypoint.
- [x] [T004] Make production call shared preparation before Wrangler deploy.
- [x] [T005] Add preview entrypoint using same preparation before Wrangler preview.
- [x] [T006] Generate and validate exact-head web/version.json plus payload metadata.
- [x] [T007] Preserve fail-closed Brotli/gzip Static Assets limit handling.
- [x] [T008] Disable automatic Vercel Git deployments in vercel.json.
- [x] [T009] Add structural delivery validator and QA regression tests.
- [x] [T010] Wire delivery validation into canonical CI.
- [ ] [T011] Verify exact final PR head through required repository checks.
- [ ] [T012] Human/provider gate: set Cloudflare Preview command to bash tools/preview_cloudflare.sh.
- [ ] [T013] Verify exact-head Cloudflare preview succeeds.
- [ ] [T014] Remove temporary claim, refresh exact-head gates and merge with expected-head guard.
- [ ] [T015] Verify post-merge Cloudflare production and deployed source identity.
