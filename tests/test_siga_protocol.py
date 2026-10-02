"""Regression tests for the repository-local SIGA orchestration contract."""
import re
import unittest
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
SIGA = ROOT / ".agents/skills/siga/SKILL.md"
ACTIVE_SKILLS = ROOT / ".agents/skills"


class SigaProtocolTests(unittest.TestCase):
    def test_siga_is_growing_rio_only_master_orchestrator(self):
        text = SIGA.read_text(encoding="utf-8")

        self.assertIn("az1nn/growing-rio", text)
        self.assertIn("MASTER ORCHESTRATOR", text)
        self.assertIn("Repository scope law", text)
        self.assertIn("PROTOCOL_DRIFT", text)
        self.assertNotIn("Cross-repository reads are allowed", text)
        self.assertNotIn("During **DECIDE**:", text)

    def test_orchestration_phase_order_is_complete(self):
        text = SIGA.read_text(encoding="utf-8")
        phases = [
            "**RECONCILE**",
            "**CLASSIFY**",
            "**ROUTE**",
            "**CLAIM**",
            "**EXECUTE**",
            "**VERIFY**",
            "**MERGE**",
            "**PERSIST**",
            "**CONTINUE**",
        ]
        positions = [text.index(phase) for phase in phases]
        self.assertEqual(sorted(positions), positions)

    def test_active_specialists_cannot_relocate_canonical_siga(self):
        problems = []
        for path in sorted(ACTIVE_SKILLS.glob("*/SKILL.md")):
            if path == SIGA:
                continue
            text = path.read_text(encoding="utf-8")
            for match in re.finditer(
                r"canonical\s+SIGA[^\n.]{0,220}",
                text,
                flags=re.IGNORECASE,
            ):
                claim = match.group(0)
                if (
                    "az1nn/growing-rio" not in claim
                    and ".agents/skills/siga/SKILL.md" not in claim
                ):
                    problems.append(f"{path.relative_to(ROOT)}: {claim}")
        self.assertEqual([], problems)

    def test_orchestrator_does_not_embed_moving_r04_revision_state(self):
        text = SIGA.read_text(encoding="utf-8")
        self.assertNotIn("Rev13", text)
        self.assertNotIn("PR #202", text)
        self.assertNotIn("while r04 is current", text.lower())


if __name__ == "__main__":
    unittest.main()
