#!/usr/bin/env python3
"""Deterministic, mobile-readable REPORT_V1 SVG renderer for DA LATA SIGA handoffs."""
from __future__ import annotations

import argparse
import html
import json
import re
import textwrap
from pathlib import Path
from urllib.parse import urlparse

TEMPLATE_VERSION = "REPORT_V1"
WIDTH = 1440
HEIGHT = 1920
REPOSITORY = "az1nn/growing-rio"
PRODUCT = "DA LATA"
MIN_FONT_SIZE = 32
BODY_FONT_SIZE = 42
ALLOWED_STATES = {"ADVANCE", "RESUME", "WATCH", "BLOCKED"}
REQUIRED_FIELDS = (
    "state",
    "task_id",
    "task",
    "branch",
    "head",
    "pr",
    "done",
    "gates",
    "blocker",
    "next",
    "timestamp",
)
OPTIONAL_URL_FIELDS = ("preview_url", "preview_immutable_url")


def normalize(value: object) -> str:
    return re.sub(r"\s+", " ", str(value)).strip()


def validate_https_url(value: str, field: str) -> str:
    value = normalize(value)
    if not value:
        return ""
    parsed = urlparse(value)
    if parsed.scheme != "https" or not parsed.netloc:
        raise ValueError(f"{field} must be an absolute https URL")
    return value


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


def text_lines(
    lines: list[str],
    x: int,
    y: int,
    *,
    size: int = BODY_FONT_SIZE,
    weight: int = 600,
    line_gap: int = 52,
    klass: str = "body",
) -> str:
    if size < MIN_FONT_SIZE:
        raise ValueError(f"font size {size} violates minimum {MIN_FONT_SIZE}")
    tspans = []
    for index, line in enumerate(lines):
        dy = 0 if index == 0 else line_gap
        tspans.append(f'<tspan x="{x}" dy="{dy}">{html.escape(line)}</tspan>')
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

    for field in OPTIONAL_URL_FIELDS:
        packet[field] = validate_https_url(raw.get(field, ""), field)
    return packet


def panel(label: str, value: str, x: int, y: int, accent: str) -> str:
    return "".join(
        [
            f'<rect x="{x}" y="{y}" width="630" height="330" rx="28" fill="#111A24" stroke="{accent}" stroke-width="3"/>',
            f'<text x="{x + 34}" y="{y + 64}" font-size="38" font-weight="900" fill="{accent}">{html.escape(label)}</text>',
            text_lines(wrapped(value, 42, 4), x + 34, y + 132, size=BODY_FONT_SIZE, weight=650, line_gap=54),
        ]
    )


def render(packet: dict[str, str]) -> str:
    esc = lambda value: html.escape(value, quote=True)
    state_color = {
        "ADVANCE": "#53F2B1",
        "RESUME": "#53F2B1",
        "WATCH": "#FFD34E",
        "BLOCKED": "#FF6B5F",
    }[packet["state"]]
    task_label = f'{packet["task_id"]} — {packet["task"]}'
    meta = f'{packet["branch"]}  ·  {packet["head"]}  ·  {packet["pr"]}'

    parts = [
        f'<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="{WIDTH}" height="{HEIGHT}" viewBox="0 0 {WIDTH} {HEIGHT}" role="img" aria-labelledby="title desc" data-renderer="deterministic" data-min-font="{MIN_FONT_SIZE}">',
        '<title id="title">DA LATA SIGA HANDOFF REPORT_V1</title>',
        '<desc id="desc">Deterministic mobile-readable repository handoff for az1nn/growing-rio</desc>',
        '<rect width="1440" height="1920" fill="#071019"/>',
        '<style>text{font-family:Inter,Arial,sans-serif;fill:#F4F8FB}.muted{fill:#A7B6C4}.body{fill:#F4F8FB}</style>',
        '<rect x="44" y="42" width="1352" height="1836" rx="34" fill="#0B141E" stroke="#203447" stroke-width="3"/>',
        '<rect x="44" y="42" width="12" height="1836" rx="6" fill="#42E8B4"/>',
        '<text x="92" y="116" font-size="44" font-weight="900" fill="#42E8B4">SIGA</text>',
        '<text x="92" y="184" font-size="68" font-weight="900">SIGA HANDOFF / REPORT_V1</text>',
        f'<text x="1348" y="116" text-anchor="end" font-size="34" font-weight="800" class="muted">{esc(packet["timestamp"])}</text>',
        f'<rect x="92" y="230" width="290" height="112" rx="22" fill="#111A24" stroke="{state_color}" stroke-width="3"/>',
        '<text x="122" y="274" font-size="32" font-weight="800" class="muted">STATE</text>',
        f'<text x="122" y="322" font-size="44" font-weight="900" fill="{state_color}">{esc(packet["state"])}</text>',
        '<rect x="404" y="230" width="944" height="112" rx="22" fill="#111A24" stroke="#2B4C67" stroke-width="3"/>',
        '<text x="436" y="274" font-size="32" font-weight="800" class="muted">TASK</text>',
        text_lines(wrapped(task_label, 54, 1), 436, 322, size=40, weight=800, line_gap=46),
        f'<text x="92" y="398" font-size="34" font-weight="700" class="muted">{esc(meta)}</text>',
        panel("1  EXECUTADO", packet["done"], 92, 448, "#42E8B4"),
        panel("2  GATES", packet["gates"], 718, 448, "#45B9FF"),
        panel("3  BLOQUEIO", packet["blocker"], 92, 804, "#FFD34E"),
        panel("4  PRÓXIMO", packet["next"], 718, 804, "#D35CFF"),
        '<rect x="92" y="1160" width="1256" height="500" rx="28" fill="#0C1C25" stroke="#38D5F5" stroke-width="3"/>',
        '<text x="126" y="1226" font-size="40" font-weight="900" fill="#38D5F5">5  PREVIEW / ACESSO</text>',
    ]

    if packet["preview_url"]:
        display_lines = wrapped(packet["preview_url"], 58, 3)
        parts.extend(
            [
                f'<a href="{esc(packet["preview_url"])}" xlink:href="{esc(packet["preview_url"])}" target="_blank">',
                '<rect x="126" y="1270" width="520" height="116" rx="24" fill="#123549" stroke="#38D5F5" stroke-width="3"/>',
                '<text x="386" y="1342" text-anchor="middle" font-size="42" font-weight="900" fill="#71E8FF">ABRIR PREVIEW</text>',
                '</a>',
                text_lines(display_lines, 126, 1446, size=38, weight=750, line_gap=48, klass="body"),
            ]
        )
    else:
        parts.append(text_lines(["Preview indisponível para este head."], 126, 1338, size=42, weight=750))

    if packet["preview_immutable_url"]:
        immutable_lines = wrapped("Deploy imutável: " + packet["preview_immutable_url"], 70, 2)
        parts.extend(
            [
                f'<a href="{esc(packet["preview_immutable_url"])}" xlink:href="{esc(packet["preview_immutable_url"])}" target="_blank">',
                text_lines(immutable_lines, 126, 1578, size=34, weight=650, line_gap=42, klass="muted"),
                '</a>',
            ]
        )

    parts.extend(
        [
            '<line x1="92" y1="1718" x2="1348" y2="1718" stroke="#203447" stroke-width="3"/>',
            f'<text x="92" y="1776" font-size="34" font-weight="800">{REPOSITORY}</text>',
            f'<text x="1348" y="1776" text-anchor="end" font-size="34" font-weight="800" class="muted">{PRODUCT} · {TEMPLATE_VERSION}</text>',
            '<text x="92" y="1838" font-size="32" font-weight="700" class="muted">Texto e URLs renderizados deterministicamente · sem geração de imagem para fatos</text>',
            '</svg>',
        ]
    )
    return "".join(parts)


def render_links(packet: dict[str, str]) -> str:
    lines = [
        "# REPORT_V1 access links",
        "",
        f"- Repository: `{REPOSITORY}`",
        f"- Head: `{packet['head']}`",
    ]
    if packet["preview_url"]:
        lines.append(f"- [Abrir preview]({packet['preview_url']})")
    else:
        lines.append("- Preview: indisponível para este head")
    if packet["preview_immutable_url"]:
        lines.append(f"- [Abrir deploy imutável]({packet['preview_immutable_url']})")
    return "\n".join(lines) + "\n"


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("--packet", required=True, type=Path)
    parser.add_argument("--output", required=True, type=Path)
    parser.add_argument("--links-output", type=Path)
    args = parser.parse_args()

    packet = load_packet(args.packet)
    svg = render(packet)
    args.output.parent.mkdir(parents=True, exist_ok=True)
    args.output.write_text(svg, encoding="utf-8")

    links_output = args.links_output or args.output.with_suffix(".links.md")
    links_output.parent.mkdir(parents=True, exist_ok=True)
    links_output.write_text(render_links(packet), encoding="utf-8")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
