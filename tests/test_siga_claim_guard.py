"""SIGA claim-owner and branch-head race regressions (offline)."""
import sys
import unittest
from pathlib import Path
sys.path.insert(0, str(Path(__file__).resolve().parents[1] / "tools"))
from siga_claim_guard import decide, parse, overlap, split_paths, collides

def pr(n, key="", paths="", created="", sha=""):
    return {
        "number": n, "created_at": created or f"2026-10-14T{n % 24:02d}:00:00Z",
        "body": f"SIGA-TASK-KEY: {key}\nIntended paths: {paths}" if key else "",
        "head": {"sha": sha or f"head-{n}"}
    }

class OwnershipGuardTests(unittest.TestCase):
    def test_earliest_claim_owns_even_if_snapshot_is_reordered(self):
        a = pr(10, "012:R06", "scenes/city/**", "2026-10-14T10:00:00Z")
        b = pr(11, "012:R06", "scenes/city/**", "2026-10-14T11:00:00Z")
        for snapshot in ([a, b], [b, a]):
            self.assertEqual("OWNER", decide(snapshot, 10)["decision"])
            loss = decide(snapshot, 11)
            self.assertEqual("SUPERSEDED", loss["decision"])
            self.assertEqual(10, loss["owner_pr"])

    def test_tie_breaks_on_pr_number(self):
        a = pr(17, "A:T001", created="2026-10-14T10:00:00Z")
        b = pr(18, "A:T001", created="2026-10-14T10:00:00Z")
        self.assertEqual(17, decide([b, a], 18)["owner_pr"])

    def test_same_task_even_with_disjoint_paths(self):
        self.assertTrue(collides(parse(pr(1, "009:T004", "docs/a.md")),
                                 parse(pr(2, "009:T004", "scenes/b.tscn"))))

    def test_different_tasks_without_path_overlap_are_parallel(self):
        a = pr(1, "012:R06", "scenes/city/**")
        b = pr(2, "LENTE:CAPTURE", "tools/visual_lab/**")
        self.assertEqual("PARALLEL_SAFE", decide([a, b], 2)["decision"])

    def test_same_file_or_glob_is_collision(self):
        a = pr(1, "FIRST", "tools/siga_claim_guard.py")
        b = pr(2, "SECOND", "tools/*.py")
        self.assertEqual("SUPERSEDED", decide([a, b], 2)["decision"])

    def test_braces_do_not_split_scope(self):
        a = pr(1, "SKILLS-8", ".agents/skills/{siga,godot}/**")
        b = pr(2, "EDIT-SIGA", ".agents/skills/siga/SKILL.md")
        self.assertEqual([".agents/skills/{siga,godot}/**"], parse(a)["paths"])
        self.assertTrue(overlap(parse(a)["paths"][0], parse(b)["paths"][0]))
        self.assertEqual("SUPERSEDED", decide([a, b], 2)["decision"])

    def test_live_head_movement_stops_old_writer(self):
        x = pr(1, "SOME:T1", "tools/x.py", sha="new")
        self.assertEqual("BRANCH_LEASE_LOST", decide([x], 1, "old")["decision"])
        self.assertEqual("PARALLEL_SAFE", decide([x], 1, "new")["decision"])

    def test_legacy_claims_do_not_break_existing_prs(self):
        legacy = pr(1)
        claimed = pr(2, "A:T1", "tools/x.py")
        self.assertEqual("UNCLAIMED_LEGACY", decide([legacy, claimed], 1)["decision"])
        self.assertEqual("PARALLEL_SAFE", decide([legacy, claimed], 2)["decision"])

    def test_absent_pr_is_fail_closed(self):
        with self.assertRaises(ValueError):
            decide([pr(1, "A:T1")], 5)

    def test_paths_split_without_cutting_braces(self):
        self.assertEqual(["docs/a.md", "src/{one,two}/**"],
                         split_paths("docs/a.md, src/{one,two}/**"))

if __name__ == "__main__":
    unittest.main()
