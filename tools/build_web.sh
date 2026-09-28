#!/usr/bin/env bash
set -euo pipefail

GODOT_VERSION="${GODOT_VERSION:-4.7.2}"
GODOT_DIR="${GODOT_DIR:-/tmp/godot}"
GODOT_BIN="${GODOT_BIN:-${GODOT_DIR}/Godot_v${GODOT_VERSION}-stable_linux.x86_64}"
TEMPLATE_DIR="${HOME}/.local/share/godot/export_templates/${GODOT_VERSION}.stable"
TEMPLATE_TPZ="/tmp/godot-${GODOT_VERSION}-export-templates.tpz"
TEMPLATE_URL="https://github.com/godotengine/godot/releases/download/${GODOT_VERSION}-stable/Godot_v${GODOT_VERSION}-stable_export_templates.tpz"

if [[ ! -x "${GODOT_BIN}" ]]; then
  echo "[web-export] ERROR: Godot binary missing: ${GODOT_BIN}" >&2
  echo "[web-export] Run tools/ci_validate.sh first so the exact same engine version is installed." >&2
  exit 1
fi

if [[ ! -f "${TEMPLATE_DIR}/web_release.zip" ]]; then
  echo "[web-export] installing Godot ${GODOT_VERSION} export templates"
  rm -rf "${TEMPLATE_DIR}"
  mkdir -p "${TEMPLATE_DIR}"
  curl -L --fail --retry 3 -o "${TEMPLATE_TPZ}" "${TEMPLATE_URL}"
  python3 - "${TEMPLATE_TPZ}" "${TEMPLATE_DIR}" <<'PY'
import sys, zipfile
archive, target = sys.argv[1], sys.argv[2]
with zipfile.ZipFile(archive) as zf:
    prefix = "templates/"
    for member in zf.infolist():
        if member.filename.startswith(prefix) and not member.is_dir():
            member.filename = member.filename[len(prefix):]
            zf.extract(member, target)
PY
fi

echo "[web-export] exporting exact checkout -> web/index.html"
rm -f web/index.html web/index.js web/index.pck web/index.wasm web/index.icon.png web/index.apple-touch-icon.png
"${GODOT_BIN}" --headless --path . --export-release "Web" web/index.html

python3 <<'PY'
from pathlib import Path
import re, sys

required = [
    Path("web/index.html"),
    Path("web/index.js"),
    Path("web/index.pck"),
    Path("web/index.wasm"),
]
missing = [str(path) for path in required if not path.is_file() or path.stat().st_size == 0]
if missing:
    raise SystemExit("[web-export] ERROR: missing/empty Web artifacts: " + ", ".join(missing))

html = Path("web/index.html").read_text(encoding="utf-8")
match = re.search(r'"fileSizes":\{[^}]*"index\.pck":(\d+)', html)
if not match:
    raise SystemExit("[web-export] ERROR: web/index.html has no index.pck fileSizes entry")
declared = int(match.group(1))
actual = Path("web/index.pck").stat().st_size
if declared != actual:
    raise SystemExit(f"[web-export] ERROR: index.pck size mismatch: html={declared}, file={actual}")
print(f"[web-export] PASS: index.pck={actual} bytes and HTML metadata matches")
PY
