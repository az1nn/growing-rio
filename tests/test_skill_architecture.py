"""SPEC-014: enforce eight active skills and preserved safety protocols."""
import unittest
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
SKILLS = ROOT / ".agents" / "skills"
CONCURRENCY = SKILLS / "siga" / "references" / "concurrency.md"
ARCHIVE_3JS = ROOT / "docs" / "archive" / "skills" / "3js" / "SKILL.md"
ROUTER = ROOT / "docs" / "SIGA-MASTER-ROUTER.md"
SIGA = SKILLS / "siga" / "SKILL.md"

class SkillArchitectureTests(unittest.TestCase):
    def test_exact_eight_entrypoints(self):
        actual = {p.parent.name for p in SKILLS.glob("*/SKILL.md")}
        self.assertEqual({"siga", "artist", "cena", "godot", "qa", "lente", "lore", "relatorio"}, actual)
        self.assertFalse((SKILLS / "3js").exists())
        self.assertFalse((SKILLS / "siga-concurrency").exists())

    def test_historical_3js_is_retained_but_not_routed(self):
        self.assertTrue(ARCHIVE_3JS.is_file())
        self.assertIn("REFERENCE/FROZEN", ARCHIVE_3JS.read_text(encoding="utf-8"))
        router = ROUTER.read_text(encoding="utf-8")
        self.assertIn("historical, not routable", router)
        self.assertIn("GODOT", router)
        self.assertNotIn(".agents/skills/3js/SKILL.md", router)

    def test_internal_concurrency_keeps_all_atomic_gates(self):
        protocol = CONCURRENCY.read_text(encoding="utf-8")
        for token in ("POST-CLAIM BARRIER", "writer epoch", "BRANCH_LEASE_LOST",
                      "GATE_FREEZE", "Atomic branch-head rule", "Contents API",
                      "SUPERSEDED", "expected", "exact"):
            self.assertIn(token, protocol)
        siga = SIGA.read_text(encoding="utf-8")
        router = ROUTER.read_text(encoding="utf-8")
        self.assertIn(".agents/skills/siga/references/concurrency.md", siga)
        self.assertIn(".agents/skills/siga/references/concurrency.md", router)
        self.assertNotIn(".agents/skills/siga-concurrency/SKILL.md", siga)
        self.assertNotIn(".agents/skills/siga-concurrency/SKILL.md", router)

    def test_unaffected_domain_gates_remain(self):
        siga = SIGA.read_text(encoding="utf-8")
        for token in ("HUMAN VISUAL GATE ROUTING", "REPORT_V1_REFERENCE_LOCK",
                      "GATE_FREEZE", "exact current head SHA", "BRANCH_LEASE_LOST"):
            self.assertIn(token, siga)

if __name__ == "__main__":
    unittest.main()
