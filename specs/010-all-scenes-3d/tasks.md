# Feature 010 tasks

- [x] [T001] inventory all Godot scenes and identify Control-only gaps
- [x] [T002] define reusable interactive 3D context component
- [x] [T003] integrate context-distinct 3D presentation into all Control-only surfaces
- [x] [T004] add click/touch object interaction and button fallback to OperationDiorama
- [x] [T005] add exhaustive runtime scene audit
- [x] [T006] add structural dependency-graph enforcement
- [x] [T007] run canonical headless regression suite
- [x] [T008] export Web and capture all five destinations at 540x960 and 1080x1920
- [x] [T009] reconcile CENA handoff, remove session claim and obtain exact-head CI evidence
- [x] [T010] merge with expected-head guard after all required gates pass


## Closure evidence — 2026-09-29

T007-T010 are closed by the stronger post-delivery CENA-017 certification already present in current master:

- Feature 010 runtime delivery: PR #152 -> `9619999fce37f50ad823e4c7cb88da50465c9546`.
- Certified runtime master: `33f97bcd8e5fb0e48e36ea67b501631f9290a797`.
- Validate project #818 / `36596189406`: SUCCESS.
- Visual acceptance #369 / `36596189548`: SUCCESS.
- Artifact `11046242559`: 22 PNGs with empty browser-console/page-error output.
- Vercel: SUCCESS.
- CENA-017 final session claim: released.
- CENA-017 closure PR #174 merged into current master `64ca2c2be3fd11ae682691f923b04e7c96bc68be`.

Feature 010 is COMPLETE. Do not reopen it absent new regression evidence.
