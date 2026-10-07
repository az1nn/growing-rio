"""Regression tests for deterministic, readable RELATORIO REPORT_V1 rendering."""
import json
import re
import subprocess
import tempfile
import unittest
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
RENDERER = ROOT / "tools/render_relatorio_v1.py"

PACKET = {
    "state": "WATCH",
    "task_id": "012:R06:C17-STAIR-LIFE",
    "task": "Candidate 17 stair-life convergence",
    "branch": "feat/012-r06-city-v1",
    "head": "0a566a1",
    "pr": "#213/draft",
    "done": "Candidate 17 preserved and the bounded stair-life pass was executed.",
    "gates": "Validate SUCCESS; City Visual SUCCESS; Visual Acceptance SUCCESS; LENTE running.",
    "blocker": "LENTE exact-head capture is still running.",
    "next": "Consume LENTE and run ARTIST target-relative review.",
    "timestamp": "2026-10-07 13:46 BRT",
    "preview_url": "https://feat-012-r06-city-v1-growing-rio.alansa015.workers.dev",
    "preview_immutable_url": "https://fda656c5-growing-rio.alansa015.workers.dev",
}


class ReportV1Tests(unittest.TestCase):
    def _render(self, directory: Path, name: str):
        packet = directory / f"{name}.json"
        output = directory / f"{name}.svg"
        packet.write_text(json.dumps(PACKET), encoding="utf-8")
        subprocess.run(
            ["python", str(RENDERER), "--packet", str(packet), "--output", str(output)],
            cwd=ROOT,
            check=True,
        )
        links = output.with_suffix(".links.md")
        return output.read_text(encoding="utf-8"), links.read_text(encoding="utf-8")

    def test_report_v1_is_deterministic(self):
        with tempfile.TemporaryDirectory() as tmp:
            root = Path(tmp)
            first_svg, first_links = self._render(root, "first")
            second_svg, second_links = self._render(root, "second")
            self.assertEqual(first_svg, second_svg)
            self.assertEqual(first_links, second_links)

    def test_report_v1_is_mobile_readable_and_exact(self):
        with tempfile.TemporaryDirectory() as tmp:
            svg, links = self._render(Path(tmp), "report")
        for token in (
            'width="1440"',
            'height="1920"',
            'data-renderer="deterministic"',
            'data-min-font="32"',
            "DA LATA",
            "SIGA HANDOFF / REPORT_V1",
            "1  EXECUTADO",
            "2  GATES",
            "3  BLOQUEIO",
            "4  PRÓXIMO",
            "5  PREVIEW / ACESSO",
            PACKET["preview_url"],
            PACKET["preview_immutable_url"],
        ):
            self.assertIn(token, svg)
        font_sizes = [int(value) for value in re.findall(r'font-size="(\d+)"', svg)]
        self.assertTrue(font_sizes)
        self.assertGreaterEqual(min(font_sizes), 32)
        self.assertIn(f"[Abrir preview]({PACKET['preview_url']})", links)
        self.assertIn(
            f"[Abrir deploy imutável]({PACKET['preview_immutable_url']})",
            links,
        )

    def test_report_v1_rejects_non_https_preview(self):
        with tempfile.TemporaryDirectory() as tmp:
            root = Path(tmp)
            packet = root / "bad-url.json"
            output = root / "bad-url.svg"
            bad = dict(PACKET)
            bad["preview_url"] = "http://example.com"
            packet.write_text(json.dumps(bad), encoding="utf-8")
            proc = subprocess.run(
                ["python", str(RENDERER), "--packet", str(packet), "--output", str(output)],
                cwd=ROOT,
                capture_output=True,
                text=True,
            )
            self.assertNotEqual(0, proc.returncode)
            self.assertFalse(output.exists())

    def test_report_v1_rejects_incomplete_packet(self):
        with tempfile.TemporaryDirectory() as tmp:
            root = Path(tmp)
            packet = root / "bad.json"
            output = root / "bad.svg"
            packet.write_text(json.dumps({"state": "ADVANCE"}), encoding="utf-8")
            proc = subprocess.run(
                ["python", str(RENDERER), "--packet", str(packet), "--output", str(output)],
                cwd=ROOT,
                capture_output=True,
                text=True,
            )
            self.assertNotEqual(0, proc.returncode)
            self.assertFalse(output.exists())


if __name__ == "__main__":
    unittest.main()
