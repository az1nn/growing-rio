# Implementation Plan: Cloudflare Canonical Delivery

## Scope

Make repository-owned Cloudflare production and preview delivery reproducible from the exact checkout, while stopping automatic Vercel Git deployments and using Cloudflare's current Worker Previews model for branch testing.

## Design

1. Add tools/prepare_cloudflare_web.sh as the sole artifact-preparation entrypoint.
2. Preparation fails on a dirty tracked checkout, records git HEAD, runs canonical validation, rebuilds the Godot Web export, verifies Godot file-size metadata, compresses WASM, enforces the 25 MiB limit and writes web/version.json.
3. Reduce tools/deploy_cloudflare.sh to shared preparation plus pinned wrangler deploy.
4. Add tools/preview_cloudflare.sh as shared preparation plus pinned wrangler preview.
5. Explicitly enable `preview_urls` and declare the `previews` base configuration in wrangler.jsonc.
6. Add tools/validate_cloudflare_delivery.py and unit regression coverage for both artifact delivery and Preview configuration.
7. Wire the delivery validator into tools/ci_validate.sh.
8. Set git.deploymentEnabled=false in vercel.json so Vercel remains manual fallback instead of automatic.
9. Keep web/.assetsignore and src/cloudflare-worker.js as the compressed-WASM/static-asset contract unless validation proves a defect.

## Concurrency

- Task key: 015:CLOUDFLARE-CANONICAL-DELIVERY.
- PR #224 is path/semantic disjoint.
- PR #213 owns R06 and also changes docs/SIGA-HANDOFF.md; Feature 015 deliberately does not mutate that handoff.
- No R05/R06 runtime, ARTIST/CENA/LENTE evidence or gameplay path is in this change set.

## Provider Commands

Production: bash tools/deploy_cloudflare.sh
Preview: bash tools/preview_cloudflare.sh

Workers Builds keeps these provider commands outside Wrangler custom-build configuration. For Workers that predate the current Worker Previews model, provider activation includes Cloudflare's one-time **Switch to Worker Previews** flow, followed by **Enable Preview Builds** and the repository-owned Preview command above.

## Verification

1. python3 tools/validate_cloudflare_delivery.py
2. python3 -m unittest tests.test_cloudflare_delivery -v
3. bash -n tools/prepare_cloudflare_web.sh tools/deploy_cloudflare.sh tools/preview_cloudflare.sh
4. canonical exact-head Validate project
5. Cloudflare provider gate: Worker Previews active when migration is offered, Preview Builds enabled, Preview command set to bash tools/preview_cloudflare.sh
6. exact-head Cloudflare Preview URL green
7. post-merge Cloudflare production plus version.json source identity

## Rollback

Revert Feature 015. The Worker compression model is retained; this feature changes artifact provenance and provider triggering, not runtime gameplay.
