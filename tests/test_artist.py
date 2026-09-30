"""Pure Python tests for ARTIST's append-only 11-scene review contract."""
import importlib.util
import json
import tempfile
import unittest
from pathlib import Path

CODE = Path(__file__).resolve().parents[1] / "tools/artist/artist.py"
spec = importlib.util.spec_from_file_location("artist", CODE)
a = importlib.util.module_from_spec(spec)
spec.loader.exec_module(a)


class ArtistTests(unittest.TestCase):
    def setUp(self):
        self.work = tempfile.TemporaryDirectory()
        self.addCleanup(self.work.cleanup)
        self.old_runs = a.RUNS
        a.RUNS = Path(self.work.name) / "runs"
        self.addCleanup(setattr, a, "RUNS", self.old_runs)
        self.old_status = a.STATUS_FILE
        a.STATUS_FILE = Path(self.work.name) / "SCENE-STATUS.json"
        a.STATUS_FILE.write_text(self.old_status.read_text(encoding="utf-8"), encoding="utf-8")
        self.addCleanup(setattr, a, "STATUS_FILE", self.old_status)

    def test_roster_exact_eleven_and_style_reference_hash(self):
        cat = a.load_catalog()
        self.assertEqual(11, len(cat["scene_order"]))
        self.assertEqual(set(cat["scene_order"]), set(cat["scenes"]))
        self.assertEqual([], a.validate())
        for slug in cat["scene_order"]:
            p = a.generate_prompt(slug, cat)
            self.assertIn("ONE", p)
            self.assertIn(cat["scenes"][slug]["diorama"], p)
            self.assertIn("PIXEL ART", p)

    def test_new_unique_session_no_overwrite(self):
        path = a.new_scene("operation", "20260930T130000Z")
        m = json.loads((path / "manifest.json").read_text())
        self.assertEqual("BRIEFED", m["state"])
        self.assertEqual("operation", m["scene"])
        self.assertTrue((path / "generation-request.json").exists())
        self.assertEqual(1, json.loads((path / "generation-request.json").read_text())["count"])
        with self.assertRaises(FileExistsError):
            a.new_scene("operation", "20260930T130000Z")
        a.new_scene("market", "20260930T130000Z")
        with self.assertRaises(ValueError):
            a.new_scene("bad-scene", "20260930T130000Z")

    def test_accept_concept_requires_artifact_and_meaningful_human_review(self):
        path = a.new_scene("city", "20260930T130001Z")
        with self.assertRaises(ValueError):
            a.review(str(path), "concept", "ACCEPT", "Alan", "Approved composition")
        image = Path(self.work.name) / "concept.png"
        image.write_bytes(b"test-image-fake-bytes")
        a.record_artifact(str(path), "concept", str(image), None, None)
        state = a.review(str(path), "concept", "ACCEPT", "Human", "Composition and V1 style approved.")
        self.assertEqual("CONCEPT_ACCEPTED", state)
        with self.assertRaises(ValueError):
            a.review(str(path), "implementation", "ACCEPT", "Human", "Everything is ready.")
        with self.assertRaises(ValueError):
            a.record_artifact(str(path), "after", str(image), "bad_sha", "mobile-web")

    def test_isolated_object_round_has_distinct_prompt_and_no_overwrite(self):
        path = a.new_scene("operation", "20260930T130003Z", "inventory-shelf")
        self.assertIn("ONE isolated 3D pixel-art prop", (path / "PROMPT.md").read_text())
        self.assertEqual("1:1", json.loads((path / "generation-request.json").read_text())["ratio"])
        self.assertEqual("inventory-shelf", json.loads((path / "manifest.json").read_text())["object_id"])
        with self.assertRaises(ValueError):
            a.new_scene("operation", "20260930T130004Z", "../unsafe")

    def test_object_acceptance_never_approves_entire_scene(self):
        baseline = json.loads(a.STATUS_FILE.read_text())["scenes"]["operation"].copy()
        path = a.new_scene("operation", "20260930T130010Z", "inventory-shelf")
        image = Path(self.work.name) / "prop.png"
        image.write_bytes(b"fake-prop-image-bytes")
        a.record_artifact(str(path), "concept", str(image), None, None)
        a.review(str(path), "concept", "ACCEPT", "Human", "Approved prop only, not scene.")
        ledger = json.loads(a.STATUS_FILE.read_text())
        self.assertEqual(baseline, ledger["scenes"]["operation"])
        with self.assertRaises(ValueError):
            a.record_artifact(str(path), "concept", str(image), None, None)
        with self.assertRaises(ValueError):
            a.review(str(path), "concept", "ACCEPT", "Human", "No reapproval in same run.")

    def test_after_capture_does_not_grant_automatic_runtime_acceptance(self):
        path = a.new_scene("narrative", "20260930T130002Z")
        image = Path(self.work.name) / "image.png"
        image.write_bytes(b"test-image-fake-bytes")
        a.record_artifact(str(path), "concept", str(image), None, None)
        a.review(str(path), "concept", "ACCEPT", "Human", "Approved pixel-art environment.")
        sha = "a" * 40
        a.record_artifact(str(path), "before", str(image), sha, "mobile-web")
        a.record_artifact(str(path), "after", str(image), sha, "mobile-web")
        with self.assertRaises(ValueError):
            a.review(str(path), "implementation", "ACCEPT", "Human", "Great runtime visuals.")


if __name__ == "__main__":
    unittest.main()
