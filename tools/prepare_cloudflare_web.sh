#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "${ROOT_DIR}"

WASM_FILE="${WASM_FILE:-web/index.wasm}"
PCK_FILE="${PCK_FILE:-web/index.pck}"
HTML_FILE="${HTML_FILE:-web/index.html}"
BR_FILE="${BR_FILE:-web/index.wasm.br}"
GZIP_FILE="${GZIP_FILE:-web/index.wasm.gz}"
VERSION_FILE="${VERSION_FILE:-web/version.json}"
STATIC_ASSET_LIMIT_BYTES=$((25 * 1024 * 1024))

if ! git diff --quiet || ! git diff --cached --quiet; then
  echo "ERROR: Cloudflare preparation requires a clean tracked checkout." >&2
  git status --short >&2
  exit 1
fi

SOURCE_SHA="$(git rev-parse HEAD)"
export SOURCE_SHA WASM_FILE PCK_FILE HTML_FILE BR_FILE GZIP_FILE VERSION_FILE STATIC_ASSET_LIMIT_BYTES

echo "[cloudflare] source head: ${SOURCE_SHA}"
echo "[cloudflare] canonical validation"
bash tools/ci_validate.sh

echo "[cloudflare] rebuilding exact-head Godot Web export"
rm -f "${BR_FILE}" "${GZIP_FILE}" "${VERSION_FILE}"
bash tools/build_web.sh

echo "[cloudflare] preparing compressed WebAssembly representations"
node tools/prepare_cloudflare_assets.js

python3 - <<'PY'
import json
import os
from pathlib import Path

data = json.loads(Path(os.environ["VERSION_FILE"]).read_text(encoding="utf-8"))
if data["source_commit"] != os.environ["SOURCE_SHA"]:
    raise SystemExit("ERROR: version.json source commit does not match exact checkout HEAD")
if data["index_wasm_brotli_bytes"] > int(os.environ["STATIC_ASSET_LIMIT_BYTES"]):
    raise SystemExit("ERROR: version.json records an oversized Brotli asset")
print("[cloudflare] exact-head artifact preparation PASS")
PY
