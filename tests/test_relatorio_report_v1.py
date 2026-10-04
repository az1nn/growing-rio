"""Regression tests for deterministic RELATORIO REPORT_V1 rendering."""
import json
import subprocess
import tempfile
import unittest
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
RENDERER = ROOT / "tools/render_relatorio_v1.py"

PACKET = {
    "state": "ADVANCE",
    "task": "R06 — example active milestone",
    "branch": "feat/example",
    "head": "abc1234",
    "pr": "#999/open",
    "done": "Implemented and verified the bounded task.",
    "gates": "green",
    "blocker": "none",
    "next": "Execute the next documented SIGA task.",
}


class ReportV1Tests(unittest.TestCase):
    def _render(self, directory: Path, name: str) -> str:
        packet = directory / f"{name}.json"
        output = directory / f"{name}.svg"
        packet.write_text(json.dumps(PACKET), encoding="utf-8")
        subprocess.run(
            ["python", str(RENDERER), "--packet", str(packet), "--output", str(output)],
            cwd=ROOT,
            check=True,
        )
        return output.read_text(encoding="utf-8")

    def test_report_v1_is_deterministic(self):
        with tempfile.TemporaryDirectory() as tmp:
            root = Path(tmp)
            first = self._render(root, "first")
            second = self._render(root, "second")
            self.assertEqual(first, second)

    def test_report_v1_has_fixed_contract(self):
        with tempfile.TemporaryDirectory() as tmp:
            svg = self._render(Path(tmp), "report")
        for token in (
            'width="1080"',
            'height="1350"',
            "DA LATA",
            "SIGA HANDOFF",
            "REPORT_V1",
            "EXECUTADO NESTA RODADA",
            "VALIDADO",
            "BLOQUEIO",
            "PRÓXIMO SIGA",
            "az1nn/growing-rio · frozen facts · REPORT_V1",
        ):
            self.assertIn(token, svg)
        for value in PACKET.values():
            self.assertIn(str(value), svg)

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
