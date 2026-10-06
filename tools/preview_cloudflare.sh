#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "${ROOT_DIR}"

WRANGLER_VERSION="${WRANGLER_VERSION:-4.147.0}"

bash tools/prepare_cloudflare_web.sh

echo "[cloudflare] deploying exact-head Worker Preview"
npx --yes "wrangler@${WRANGLER_VERSION}" preview

echo "[cloudflare] preview deploy complete"
