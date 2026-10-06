# Feature 015 — Cloudflare Canonical Delivery

**Status:** IMPLEMENTING — direct operator instruction
**Owner:** SIGA / GODOT / QA
**Runtime architecture:** unchanged; Godot 4.7.2 / GODOT_NATIVE_V1 remains authoritative

## Problem

Cloudflare production can publish the committed web directory, including the oversized Godot WASM through pre-compression, but the delivery path does not first prove that web was rebuilt from the exact source HEAD being deployed. Cloudflare preview builds also use a separate provider command and currently bypass the repository-owned preparation path. Vercel still attempts automatic Git deployments even though Cloudflare is now the primary host.

A green provider deploy is not sufficient unless the deployed artifact is reproducibly derived from the exact repository HEAD.

## User Scenarios

### US-1 — Production always represents the exact commit
As the developer merging a source change, I want Cloudflare production to validate and rebuild the Godot Web export from that exact checkout before publishing so stale committed web files cannot become production.

### US-2 — Preview and production use the same preparation
As the developer reviewing a pull request, I want Cloudflare preview to run the same validation, export and compression preparation as production so preview evidence is representative.

### US-3 — Oversized WASM remains deployable without R2
As the operator, I want raw index.wasm excluded from Static Assets and compressed representations generated only after the exact-head export so the 25 MiB per-asset limit remains fail-closed.

### US-4 — Published builds expose source identity
As SIGA/QA, I want deployed version.json to contain the exact Git commit and payload sizes so public delivery can be compared with repository state.

### US-5 — Vercel no longer competes with Cloudflare
As the operator, I want automatic Git-triggered Vercel deployments disabled while preserving the existing Vercel configuration as a manual fallback path.

## Functional Requirements

- **FR-001:** Every Cloudflare production publish MUST run canonical repository validation before export.
- **FR-002:** Every Cloudflare production publish MUST rebuild the Godot Web export from current Git HEAD before compression or Wrangler upload.
- **FR-003:** Cloudflare preview MUST use the same preparation function as production and differ only in the terminal Wrangler command.
- **FR-004:** Raw web/index.wasm MUST remain excluded from Cloudflare Static Assets.
- **FR-005:** Preparation MUST generate Brotli and fail when it exceeds 25 MiB.
- **FR-006:** Gzip MAY be generated as fallback but MUST be removed when it exceeds the same limit.
- **FR-007:** Preparation MUST verify index.html declared index.wasm and index.pck sizes against generated files.
- **FR-008:** Preparation MUST generate web/version.json with exact Git SHA and generated payload sizes.
- **FR-009:** Worker MUST keep application/wasm plus negotiated br/gzip and Vary: Accept-Encoding.
- **FR-010:** Vercel automatic Git deployments MUST be disabled in versioned repository configuration.
- **FR-011:** Canonical repository validation MUST include a structural Cloudflare delivery contract.
- **FR-012:** No gameplay, scene composition, art/canon, persistence or R05/R06 runtime behavior may change.

## Acceptance Scenarios

1. Static validation proves production calls shared preparation before wrangler deploy.
2. Static validation proves preview calls the same preparation before wrangler preview.
3. Static validation proves canonical validation precedes exact-head export.
4. Static validation proves Vercel Git auto-deployment is disabled.
5. Canonical Validate project passes on the exact final PR head.
6. Cloudflare preview succeeds after the external Preview command is set to bash tools/preview_cloudflare.sh.
7. After merge, Cloudflare production succeeds and version.json identifies the merged master SHA.

## Success Criteria

- **SC-001:** python3 tools/validate_cloudflare_delivery.py passes.
- **SC-002:** python3 -m unittest tests.test_cloudflare_delivery -v passes.
- **SC-003:** canonical Validate project passes on exact final PR head.
- **SC-004:** Cloudflare preview succeeds on exact final PR head after the one-time provider setting gate.
- **SC-005:** Cloudflare production succeeds for the merge commit.
- **SC-006:** Vercel stops automatic Git deployments for later commits.
- **SC-007:** Feature 012 runtime/visual paths remain untouched.

## External Configuration Gate

Workers Builds stores the Preview command in provider settings rather than wrangler.jsonc. Repository code can provide and validate the command but cannot mutate the account setting without authenticated Cloudflare control-plane access.

Required one-time setting:
Preview command = bash tools/preview_cloudflare.sh

Existing production setting:
Deploy command = bash tools/deploy_cloudflare.sh

## Out of Scope

- renderer or gameplay changes;
- art/canon/persistence changes;
- R2 storage;
- DNS/custom-domain migration;
- Cloudflare plan changes;
- deletion of the Vercel project/GitHub app;
- Feature 012 R06 implementation or acceptance;
- LENTE capture optimization.
