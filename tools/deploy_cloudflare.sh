#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "${ROOT_DIR}"

WRANGLER_VERSION="${WRANGLER_VERSION:-4.147.0}"

bash tools/prepare_cloudflare_web.sh

echo "[cloudflare] deploying production Worker + exact-head static assets"
npx --yes "wrangler@${WRANGLER_VERSION}" deploy

echo "[cloudflare] production deploy complete"
