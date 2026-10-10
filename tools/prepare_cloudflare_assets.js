#!/usr/bin/env node
"use strict";

const fs = require("fs");
const zlib = require("zlib");
const { execFileSync } = require("child_process");

const wasmFile = process.env.WASM_FILE || "web/index.wasm";
const pckFile = process.env.PCK_FILE || "web/index.pck";
const htmlFile = process.env.HTML_FILE || "web/index.html";
const brFile = process.env.BR_FILE || "web/index.wasm.br";
const gzipFile = process.env.GZIP_FILE || "web/index.wasm.gz";
const versionFile = process.env.VERSION_FILE || "web/version.json";
const limit = Number(process.env.STATIC_ASSET_LIMIT_BYTES || 25 * 1024 * 1024);

function requireFile(path) {
  if (!fs.existsSync(path) || fs.statSync(path).size === 0) {
    throw new Error("required Cloudflare Web artifact missing or empty: " + path);
  }
}

function declaredSize(html, name) {
  const token = '"' + name + '":';
  const start = html.indexOf(token);
  if (start < 0) throw new Error("Godot HTML has no fileSizes entry for " + name);
  const match = html.slice(start + token.length).match(/^(\d+)/);
  if (!match) throw new Error("Godot HTML has invalid fileSizes entry for " + name);
  return Number(match[1]);
}

for (const path of [htmlFile, wasmFile, pckFile]) requireFile(path);

const sourceSha =
  process.env.SOURCE_SHA ||
  execFileSync("git", ["rev-parse", "HEAD"], { encoding: "utf8" }).trim();

const wasm = fs.readFileSync(wasmFile);
const pck = fs.readFileSync(pckFile);
const html = fs.readFileSync(htmlFile, "utf8");

const declaredWasm = declaredSize(html, "index.wasm");
const declaredPck = declaredSize(html, "index.pck");
if (declaredWasm !== wasm.length) {
  throw new Error("index.wasm metadata mismatch: html=" + declaredWasm + ", file=" + wasm.length);
}
if (declaredPck !== pck.length) {
  throw new Error("index.pck metadata mismatch: html=" + declaredPck + ", file=" + pck.length);
}

fs.rmSync(brFile, { force: true });
fs.rmSync(gzipFile, { force: true });
fs.rmSync(versionFile, { force: true });

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
  console.warn("[cloudflare] gzip fallback exceeds 25 MiB and was omitted: " + gzip.length);
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

console.log("[cloudflare] compressed WASM prepared for Wrangler Static Assets");
console.log("RAW_WASM_BYTES=" + wasm.length);
console.log("BROTLI_WASM_BYTES=" + br.length);
console.log("GZIP_WASM_BYTES=" + (gzipBytes === null ? "omitted" : gzipBytes));
console.log("PCK_BYTES=" + pck.length);
console.log("SOURCE_COMMIT=" + sourceSha);
