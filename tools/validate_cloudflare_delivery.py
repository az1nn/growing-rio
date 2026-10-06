#!/usr/bin/env python3
from __future__ import annotations

import json
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]


def _read(path: str) -> str:
    target = ROOT / path
    if not target.is_file():
        raise AssertionError(f"missing required Cloudflare delivery file: {path}")
    return target.read_text(encoding="utf-8")


def _require_order(text: str, first: str, second: str, label: str) -> None:
    first_index = text.find(first)
    second_index = text.find(second)
    if first_index < 0 or second_index < 0 or first_index >= second_index:
        raise AssertionError(f"{label}: expected {first!r} before {second!r}")


def validate() -> None:
    prepare = _read("tools/prepare_cloudflare_web.sh")
    deploy = _read("tools/deploy_cloudflare.sh")
    preview = _read("tools/preview_cloudflare.sh")
    worker = _read("src/cloudflare-worker.js")
    assetsignore = _read("web/.assetsignore")

    _require_order(prepare, "bash tools/ci_validate.sh", "bash tools/build_web.sh", "Cloudflare preparation")
    _require_order(deploy, "bash tools/prepare_cloudflare_web.sh", 'wrangler@${WRANGLER_VERSION}" deploy', "Cloudflare production")
    _require_order(preview, "bash tools/prepare_cloudflare_web.sh", 'wrangler@${WRANGLER_VERSION}" preview', "Cloudflare preview")

    for token in [
        "git rev-parse HEAD",
        "web/version.json",
        "index_wasm_brotli_bytes",
        "STATIC_ASSET_LIMIT_BYTES",
        "index.wasm metadata mismatch",
        "index.pck metadata mismatch",
    ]:
        if token not in prepare:
            raise AssertionError(f"Cloudflare preparation missing contract token: {token}")

    if "index.wasm" not in assetsignore.split():
        raise AssertionError("raw index.wasm must remain excluded from Static Assets")

    for token in [
        'headers.set("content-type", "application/wasm")',
        'headers.set("content-encoding", candidate.encoding)',
        'headers.set("vary", "Accept-Encoding")',
        '/index.wasm.br',
    ]:
        if token not in worker:
            raise AssertionError(f"Worker compressed-WASM contract missing: {token}")

    wrangler = json.loads(_read("wrangler.jsonc"))
    assets = wrangler.get("assets") or {}
    if assets.get("directory") != "./web":
        raise AssertionError("wrangler assets.directory must remain ./web")
    if assets.get("binding") != "ASSETS":
        raise AssertionError("wrangler ASSETS binding missing")
    if "/index.wasm" not in assets.get("run_worker_first", []):
        raise AssertionError("wrangler must route /index.wasm through the Worker")
    if wrangler.get("preview_urls") is not True:
        raise AssertionError("wrangler preview_urls must be explicitly enabled")
    if not isinstance(wrangler.get("previews"), dict):
        raise AssertionError("wrangler previews base configuration must be declared")
    if wrangler.get("r2_buckets"):
        raise AssertionError("Feature 015 must not reintroduce R2")

    vercel = json.loads(_read("vercel.json"))
    if (vercel.get("git") or {}).get("deploymentEnabled") is not False:
        raise AssertionError("Vercel automatic Git deployments must be disabled")

    print("CLOUDFLARE DELIVERY CONTRACT PASSED")


if __name__ == "__main__":
    validate()
