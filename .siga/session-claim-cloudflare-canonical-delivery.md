# SIGA session claim — Feature 015 Cloudflare Canonical Delivery

SIGA-TASK-KEY: 015:CLOUDFLARE-CANONICAL-DELIVERY

Base SHA: a1403d102f3fe4beb8d794043193ebacae18bc30

Scope: exact-head Cloudflare Godot Web preparation; production and preview entrypoints; compressed-WASM/static-asset contract; Vercel automatic Git deployment disablement; Feature 015 Spec Kit and QA regression. Intended paths: specs/015-cloudflare-canonical-delivery/**, tools/prepare_cloudflare_web.sh, tools/deploy_cloudflare.sh, tools/preview_cloudflare.sh, tools/validate_cloudflare_delivery.py, tools/ci_validate.sh, tests/test_cloudflare_delivery.py, vercel.json. Existing wrangler.jsonc/Worker/static-asset files are validation inputs unless a defect requires change.

Post-claim barrier: PR #224 is disjoint. PR #213 overlaps only docs/SIGA-HANDOFF.md; Feature 015 excludes that shared handoff to avoid collision.

Temporary coordination file. Remove before merge.
