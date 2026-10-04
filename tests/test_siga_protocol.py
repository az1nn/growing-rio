"""Regression tests for the repository-local SIGA orchestration contract."""
import re
import unittest
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
SIGA = ROOT / ".agents/skills/siga/SKILL.md"
ACTIVE_SKILLS = ROOT / ".agents/skills"
RELATORIO = ROOT / ".agents/skills/relatorio/SKILL.md"


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
                r"canonical\s+SIGA[^\n]{0,300}",
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

    def test_feature012_visual_parity_is_p0_and_target_relative(self):
        text = SIGA.read_text(encoding="utf-8")

        for token in (
            "VISUAL PARITY P0",
            "target-relative",
            "Technical green is necessary but never sufficient",
            "Asset-production duty",
            "R15 final V1 certification",
            "previous runtime build is regression evidence only",
        ):
            self.assertIn(token, text)

        self.assertIn("Feature 013 implementation does not", text)
        self.assertIn("structural-rebase", text.lower())

    def test_visual_reports_fail_closed_before_and_after_render(self):
        text = SIGA.read_text(encoding="utf-8")

        for token in (
            "REPORT_TEMPLATE_PREFLIGHT",
            "RENDER_REPORT_V1",
            "REPORT_RENDER_IDENTITY_CHECK",
            "REPORT_RENDER_MISMATCH",
            "REPORT_V1",
            "tools/render_relatorio_v1.py",
            "DA LATA",
            "az1nn/growing-rio",
            "Maricá",
            "marica-game",
        ):
            self.assertIn(token, text)

        preflight_pos = text.index("REPORT_TEMPLATE_PREFLIGHT")
        render_check_pos = text.index("REPORT_RENDER_IDENTITY_CHECK")
        self.assertLess(preflight_pos, render_check_pos)
        self.assertIn("deterministic renderer", text)
        self.assertIn("generative image model", text)


    def test_siga_requires_one_validated_visual_to_finalize(self):
        text = SIGA.read_text(encoding="utf-8")

        self.assertIn("exactly one validated REPORT_V1 visual report image", text)
        self.assertIn("REPORT_OUTPUT_FAILURE", text)
        self.assertIn("One finalized SIGA invocation = exactly one visible validated REPORT_V1 image", text)
        self.assertIn("A SIGA run without one validated final REPORT_V1 visual report is not finalized", text)
        self.assertNotIn("A visual report is optional presentation", text)
        self.assertNotIn("One SIGA invocation = zero or one visible report image", text)

    def test_relatorio_is_terminal_visual_projection_for_siga(self):
        text = RELATORIO.read_text(encoding="utf-8")

        self.assertIn("## REPORT_V1 — immutable visual contract", text)
        self.assertIn("tools/render_relatorio_v1.py", text)
        self.assertIn("deterministic", text)
        self.assertIn("A generative image model is not an acceptable REPORT_V1 renderer", text)
        self.assertIn("A finalized SIGA response may not substitute another visual style", text)


if __name__ == "__main__":
    unittest.main()
