#!/usr/bin/env bash
set -euo pipefail

WRANGLER_VERSION="${WRANGLER_VERSION:-4.147.0}"
R2_BUCKET="${R2_BUCKET:-growing-rio-assets}"
WASM_FILE="${WASM_FILE:-web/index.wasm}"
R2_KEY="${R2_KEY:-index.wasm}"

wrangler() {
  npx --yes "wrangler@${WRANGLER_VERSION}" "$@"
}

if [[ ! -s "${WASM_FILE}" ]]; then
  echo "ERROR: required Godot artifact not found or empty: ${WASM_FILE}" >&2
  exit 1
fi

echo "Cloudflare deploy: preparing R2 bucket ${R2_BUCKET}"
create_log="$(mktemp)"
trap 'rm -f "${create_log}"' EXIT

if wrangler r2 bucket create "${R2_BUCKET}" >"${create_log}" 2>&1; then
  cat "${create_log}"
else
  if grep -Eqi "already exists|already.*bucket|name.*in use" "${create_log}"; then
    echo "R2 bucket already exists: ${R2_BUCKET}"
  else
    cat "${create_log}" >&2
    echo "ERROR: could not create or confirm R2 bucket ${R2_BUCKET}" >&2
    exit 1
  fi
fi

echo "Cloudflare deploy: uploading ${WASM_FILE} to R2"
wrangler r2 object put "${R2_BUCKET}/${R2_KEY}" \
  --file "${WASM_FILE}" \
  --content-type "application/wasm" \
  --cache-control "public, max-age=0, must-revalidate" \
  --remote \
  --force

echo "Cloudflare deploy: deploying Worker + static assets"
wrangler deploy

echo "Cloudflare deploy: complete"
