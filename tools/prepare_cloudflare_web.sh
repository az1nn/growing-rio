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

for required in "${HTML_FILE}" "${WASM_FILE}" "${PCK_FILE}"; do
  if [[ ! -s "${required}" ]]; then
    echo "ERROR: required exact-head Web artifact missing or empty: ${required}" >&2
    exit 1
  fi
done

echo "[cloudflare] validating Godot metadata and compressing WASM"
node <<'NODE'
const fs = require("fs");
const zlib = require("zlib");

const sourceSha = process.env.SOURCE_SHA;
const wasmFile = process.env.WASM_FILE;
const pckFile = process.env.PCK_FILE;
const htmlFile = process.env.HTML_FILE;
const brFile = process.env.BR_FILE;
const gzipFile = process.env.GZIP_FILE;
const versionFile = process.env.VERSION_FILE;
const limit = Number(process.env.STATIC_ASSET_LIMIT_BYTES);

const wasm = fs.readFileSync(wasmFile);
const pck = fs.readFileSync(pckFile);
const html = fs.readFileSync(htmlFile, "utf8");

function declaredSize(name) {
  const token = '"' + name + '":';
  const start = html.indexOf(token);
  if (start < 0) throw new Error("Godot HTML has no fileSizes entry for " + name);
  const rest = html.slice(start + token.length);
  const match = rest.match(/^(\d+)/);
  if (!match) throw new Error("Godot HTML has invalid fileSizes entry for " + name);
  return Number(match[1]);
}

const declaredWasm = declaredSize("index.wasm");
const declaredPck = declaredSize("index.pck");
if (declaredWasm !== wasm.length) {
  throw new Error("index.wasm metadata mismatch: html=" + declaredWasm + ", file=" + wasm.length);
}
if (declaredPck !== pck.length) {
  throw new Error("index.pck metadata mismatch: html=" + declaredPck + ", file=" + pck.length);
}

const br = zlib.brotliCompressSync(wasm, {
  params: {
    [zlib.constants.BROTLI_PARAM_QUALITY]: 8,
    [zlib.constants.BROTLI_PARAM_MODE]: zlib.constants.BROTLI_MODE_GENERIC,
  },
});
if (br.length > limit) {
  throw new Error("Brotli index.wasm exceeds Cloudflare 25 MiB asset limit: " + br.length + " > " + limit);
}
fs.writeFileSync(brFile, br);

const gzip = zlib.gzipSync(wasm, { level: 9 });
let gzipBytes = null;
if (gzip.length <= limit) {
  fs.writeFileSync(gzipFile, gzip);
  gzipBytes = gzip.length;
} else {
  fs.rmSync(gzipFile, { force: true });
  console.warn("gzip fallback exceeds 25 MiB and was removed: " + gzip.length);
}

const manifest = {
  schema: "da-lata-cloudflare-delivery-v1",
  source_commit: sourceSha,
  index_wasm_raw_bytes: wasm.length,
  index_wasm_brotli_bytes: br.length,
  index_wasm_gzip_bytes: gzipBytes,
  index_pck_bytes: pck.length,
};
fs.writeFileSync(versionFile, JSON.stringify(manifest, null, 2) + "\n");

console.log("RAW_WASM_BYTES=" + wasm.length);
console.log("BROTLI_WASM_BYTES=" + br.length);
console.log("GZIP_WASM_BYTES=" + (gzipBytes === null ? "omitted" : gzipBytes));
console.log("PCK_BYTES=" + pck.length);
console.log("SOURCE_COMMIT=" + sourceSha);
NODE

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
