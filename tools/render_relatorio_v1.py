#!/usr/bin/env python3
"""Deterministic REPORT_V1 SVG renderer for DA LATA SIGA handoffs."""
from __future__ import annotations

import argparse
import html
import json
import re
import textwrap
from pathlib import Path

TEMPLATE_VERSION = "REPORT_V1"
WIDTH = 1080
HEIGHT = 1350
REPOSITORY = "az1nn/growing-rio"
PRODUCT = "DA LATA"
ALLOWED_STATES = {"ADVANCE", "RESUME", "WATCH", "BLOCKED"}
REQUIRED_FIELDS = ("state", "task", "branch", "head", "pr", "done", "gates", "blocker", "next")


def normalize(value: object) -> str:
    return re.sub(r"\s+", " ", str(value)).strip()


def wrapped(value: str, width: int, max_lines: int) -> list[str]:
    value = normalize(value)
    lines = textwrap.wrap(
        value,
        width=width,
        break_long_words=False,
        break_on_hyphens=False,
        replace_whitespace=True,
    ) or ["none"]
    if len(lines) > max_lines:
        lines = lines[:max_lines]
        last = lines[-1]
        lines[-1] = (last[:-1] + "…") if len(last) >= width else (last + "…")
    return lines


def text_lines(lines: list[str], x: int, y: int, *, size: int, weight: int = 400, line_gap: int = 42, klass: str = "body") -> str:
    tspans = []
    for index, line in enumerate(lines):
        dy = 0 if index == 0 else line_gap
        tspans.append(
            f'<tspan x="{x}" dy="{dy}">{html.escape(line)}</tspan>'
        )
    return (
        f'<text x="{x}" y="{y}" class="{klass}" '
        f'font-size="{size}" font-weight="{weight}">' + "".join(tspans) + "</text>"
    )


def load_packet(path: Path) -> dict[str, str]:
    raw = json.loads(path.read_text(encoding="utf-8"))
    missing = [field for field in REQUIRED_FIELDS if field not in raw]
    if missing:
        raise ValueError("missing packet fields: " + ", ".join(missing))
    packet = {field: normalize(raw[field]) for field in REQUIRED_FIELDS}
    packet["state"] = packet["state"].upper()
    if packet["state"] not in ALLOWED_STATES:
        raise ValueError(f"invalid state: {packet['state']}")
    return packet


def render(packet: dict[str, str]) -> str:
    meta = f"{packet['branch']}  ·  {packet['head']}  ·  {packet['pr']}"
    sections = [
        ("EXECUTADO NESTA RODADA", packet["done"], 350),
        ("VALIDADO", packet["gates"], 575),
        ("BLOQUEIO", packet["blocker"], 800),
        ("PRÓXIMO SIGA", packet["next"], 1025),
    ]

    parts = [
        f'<svg xmlns="http://www.w3.org/2000/svg" width="{WIDTH}" height="{HEIGHT}" viewBox="0 0 {WIDTH} {HEIGHT}" role="img" aria-labelledby="title desc">',
        '<title id="title">DA LATA SIGA HANDOFF REPORT_V1</title>',
        '<desc id="desc">Deterministic repository handoff for az1nn/growing-rio</desc>',
        '<rect width="1080" height="1350" fill="#0B0F14"/>',
        '<style>',
        'text{font-family:Inter,Arial,sans-serif;fill:#F2F5F7} .muted{fill:#98A6B3} .accent{fill:#50E3C2} .body{fill:#F2F5F7}',
        '</style>',
        '<rect x="54" y="48" width="972" height="1230" rx="24" fill="#101720" stroke="#26303A" stroke-width="2"/>',
        '<rect x="54" y="48" width="8" height="1230" rx="4" fill="#50E3C2"/>',
        '<text x="94" y="105" font-size="24" font-weight="700" letter-spacing="3" class="accent">DA LATA</text>',
        '<text x="94" y="158" font-size="44" font-weight="800">SIGA HANDOFF</text>',
        f'<text x="936" y="105" text-anchor="end" font-size="20" font-weight="700" class="muted">{TEMPLATE_VERSION}</text>',
        '<text x="94" y="212" font-size="18" font-weight="700" class="muted">STATUS</text>',
        f'<text x="188" y="212" font-size="22" font-weight="800" class="accent">{html.escape(packet["state"])}</text>',
        *([text_lines(wrapped(packet["task"], 64, 2), 94, 258, size=30, weight=700, line_gap=34)]),
        f'<text x="94" y="318" font-size="18" font-weight="500" class="muted">{html.escape(meta)}</text>',
    ]

    for label, value, y in sections:
        parts.extend([
            f'<rect x="94" y="{y}" width="892" height="180" rx="18" fill="#141D27" stroke="#26303A" stroke-width="2"/>',
            f'<text x="126" y="{y + 44}" font-size="17" font-weight="800" letter-spacing="2" class="muted">{label}</text>',
            text_lines(wrapped(value, 70, 3), 126, y + 94, size=25, weight=600, line_gap=34),
        ])

    parts.extend([
        '<line x1="94" y1="1240" x2="986" y2="1240" stroke="#26303A" stroke-width="2"/>',
        f'<text x="94" y="1286" font-size="17" font-weight="600" class="muted">{REPOSITORY} · frozen facts · {TEMPLATE_VERSION}</text>',
        '</svg>',
    ])
    return "".join(parts)


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("--packet", required=True, type=Path)
    parser.add_argument("--output", required=True, type=Path)
    args = parser.parse_args()

    packet = load_packet(args.packet)
    svg = render(packet)
    args.output.parent.mkdir(parents=True, exist_ok=True)
    args.output.write_text(svg, encoding="utf-8")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
