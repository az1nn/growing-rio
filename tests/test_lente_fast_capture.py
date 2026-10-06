import json
import unittest
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]


class LenteFastCaptureContractTests(unittest.TestCase):
    def test_media_recorder_replaces_png_frame_video_pipeline(self):
        capture = (ROOT / "tools/visual_lab/capture.cjs").read_text(encoding="utf-8")
        self.assertIn("canvas.captureStream", capture)
        self.assertIn("new MediaRecorder", capture)
        self.assertIn("post_ready_media_recorder", capture)
        self.assertNotIn("page.waitForTimeout", capture)
        self.assertNotIn("spawnSync", capture)
        self.assertNotIn("ffmpeg", capture)
        self.assertNotIn("post_ready_frames", capture)
        self.assertIn("Page.captureScreenshot", capture)
        self.assertIn("optimizeForSpeed", capture)
        self.assertNotIn("page.screenshot", capture)
        self.assertNotIn("canvas.toBlob", capture)

    def test_capture_reads_hard_budgets_from_canonical_contract(self):
        capture = (ROOT / "tools/visual_lab/capture.cjs").read_text(encoding="utf-8")
        self.assertIn("validation_latency_budgets.json", capture)
        self.assertIn("STILL_BUDGET_MS", capture)
        self.assertIn("VIDEO_SCHEDULER_TOLERANCE_MS", capture)
        self.assertIn("VIDEO_FINALIZE_BUDGET_MS", capture)

    def test_workflow_requires_bounded_scope_or_explicit_full(self):
        workflow = (ROOT / ".github/workflows/visual-lab.yml").read_text(encoding="utf-8")
        self.assertIn("scene_scope:", workflow)
        self.assertIn("full_capture:", workflow)
        self.assertIn("explicit LENTE dispatch requires scene_scope", workflow)
        self.assertIn('scope = "operation"', workflow)
        self.assertNotIn("Verify video encoder prerequisites", workflow)
        self.assertNotIn("sleep 1", workflow)

    def test_skill_makes_full_capture_explicit(self):
        skill = (ROOT / ".agents/skills/lente/SKILL.md").read_text(encoding="utf-8")
        self.assertIn("LENTE full", skill)
        self.assertIn("captures exactly that canonical scene/page/video packet", skill)
        self.assertIn("default capture = one active/scoped page", skill)

    def test_manifest_preserves_four_second_evidence_window(self):
        manifest = json.loads(
            (ROOT / "tools/visual_lab/manifest.json").read_text(encoding="utf-8")
        )
        self.assertEqual(manifest["video"]["duration_ms"], 4000)
        self.assertEqual(manifest["video"]["fps"], 8)


if __name__ == "__main__":
    unittest.main()
