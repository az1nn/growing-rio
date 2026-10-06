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
- [x] [T011] Verify prior exact head through required repository checks; superseded by the Worker Previews contract correction in T012.
- [ ] [T012] Correct Worker Previews repository contract, then human/provider gate: complete Switch to Worker Previews when offered, enable Preview Builds, and set Preview command to bash tools/preview_cloudflare.sh.
- [ ] [T013] Verify the new exact-head Cloudflare preview succeeds and exposes a Preview URL.
- [ ] [T014] Remove temporary claim, refresh exact-head gates and merge with expected-head guard.
- [ ] [T015] Verify post-merge Cloudflare production and deployed source identity.
