# Feature 015 requirements checklist

## Specification quality

- [x] Exact-head artifact provenance is the primary problem.
- [x] Production and preview behavior are both specified.
- [x] WASM size-limit handling remains fail-closed.
- [x] Public source identity is measurable through version.json.
- [x] Vercel fallback behavior is separated from Cloudflare primary delivery.
- [x] External provider configuration is explicitly identified as a provider gate.
- [x] Worker Previews migration for existing Workers is explicitly modeled.
- [x] Gameplay, art, canon, persistence and R05/R06 runtime are out of scope.
- [x] Acceptance criteria distinguish repository validation from provider evidence.

## Delivery quality

- [x] Shared preparation is repository-owned.
- [x] Canonical validation precedes export.
- [x] Exact-head export precedes compression.
- [x] Production and preview call the same preparation.
- [x] wrangler.jsonc explicitly enables Preview URLs and declares Preview base configuration.
- [x] Vercel automatic Git deployments are disabled in versioned config.
- [x] Structural regression protection is wired into canonical CI.
- [ ] Cloudflare Worker Previews migration completed when the provider offers the one-time switch.
- [ ] Cloudflare Preview Builds enabled.
- [ ] Cloudflare Preview command provider setting applied.
- [ ] Exact-head Cloudflare preview green with Preview URL.
- [ ] Post-merge Cloudflare production/source identity green.
