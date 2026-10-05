#!/usr/bin/env bash
# Cloudflare Workers Builds entrypoint. Keep this script idempotent.
set -euo pipefail

WRANGLER_VERSION="${WRANGLER_VERSION:-4.147.0}"
WASM_FILE="${WASM_FILE:-web/index.wasm}"
BR_FILE="${BR_FILE:-web/index.wasm.br}"
GZIP_FILE="${GZIP_FILE:-web/index.wasm.gz}"
STATIC_ASSET_LIMIT_BYTES=$((25 * 1024 * 1024))

wrangler() {
  npx --yes "wrangler@${WRANGLER_VERSION}" "$@"
}

if [[ ! -s "${WASM_FILE}" ]]; then
  echo "ERROR: required Godot artifact not found or empty: ${WASM_FILE}" >&2
  exit 1
fi

echo "Cloudflare deploy: compressing oversized Godot WASM"
node <<'NODE'
const fs = require("fs");
const zlib = require("zlib");

const source = process.env.WASM_FILE || "web/index.wasm";
const brTarget = process.env.BR_FILE || "web/index.wasm.br";
const gzipTarget = process.env.GZIP_FILE || "web/index.wasm.gz";
const limit = 25 * 1024 * 1024;

const input = fs.readFileSync(source);

const br = zlib.brotliCompressSync(input, {
  params: {
    [zlib.constants.BROTLI_PARAM_QUALITY]: 8,
    [zlib.constants.BROTLI_PARAM_MODE]: zlib.constants.BROTLI_MODE_GENERIC,
  },
});
fs.writeFileSync(brTarget, br);

const gzip = zlib.gzipSync(input, { level: 9 });
fs.writeFileSync(gzipTarget, gzip);

console.log(`RAW_BYTES=${input.length}`);
console.log(`BROTLI_BYTES=${br.length}`);
console.log(`GZIP_BYTES=${gzip.length}`);
console.log(`STATIC_ASSET_LIMIT_BYTES=${limit}`);

if (br.length > limit) {
  console.error("ERROR: Brotli-compressed index.wasm still exceeds Cloudflare's 25 MiB asset limit.");
  process.exit(2);
}

if (gzip.length > limit) {
  console.warn("WARN: gzip variant exceeds 25 MiB; removing gzip fallback.");
  fs.rmSync(gzipTarget, { force: true });
}
NODE

if [[ ! -s "${BR_FILE}" ]]; then
  echo "ERROR: Brotli WASM was not generated." >&2
  exit 1
fi

br_size="$(wc -c < "${BR_FILE}")"
if (( br_size > STATIC_ASSET_LIMIT_BYTES )); then
  echo "ERROR: ${BR_FILE} exceeds the 25 MiB Static Assets limit." >&2
  exit 1
fi

echo "Cloudflare deploy: Brotli WASM fits Static Assets (${br_size} bytes)"
echo "Cloudflare deploy: deploying Worker + static assets"
wrangler deploy

echo "Cloudflare deploy: complete"
