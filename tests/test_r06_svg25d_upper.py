"""R06 source-object approvals do not authorize family, City renderer or runtime acceptance."""
import hashlib
import json
import unittest
import xml.etree.ElementTree as ET
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
FAMILY = ROOT / "assets/city/v1/svg25d/source/upper/candidate-family.json"
PREVIEW = FAMILY.parent / "REVIEW.md"
SCENE_STATUS = ROOT / "docs/art-direction/v1/SCENE-STATUS.json"
SVG = "{http://www.w3.org/2000/svg}"
FORBIDDEN = {"text", "image", "script", "filter", "foreignObject", "animate", "use"}

class R06SVG25DSourceTests(unittest.TestCase):
    def test_approved_objects_are_editable_and_individually_provenanced(self):
        data = json.loads(FAMILY.read_text(encoding="utf-8"))
        self.assertEqual("ORIGINAL_SPRITE_CANDIDATE", data["status"])
        self.assertEqual("TWO_SOURCE_OBJECTS_APPROVED_ONLY", data["object_art_gate"])
        self.assertEqual("RUNTIME_REJECT_ALL__UNCHANGED", data["scene_gate"])
        self.assertEqual("GODOT_IMPORT_RENDER_QA_PENDING", data["qa_gate"])
        self.assertEqual("20261004T110406Z/city", data["reference"]["id"])
        self.assertEqual(2, len(data["objects"]))
        self.assertEqual(2, len({o["id"] for o in data["objects"]}))
        preview = PREVIEW.read_text(encoding="utf-8")
        for obj in data["objects"]:
            with self.subTest(sprite=obj["id"]):
                source = obj["source"]
                self.assertTrue(source.startswith("res://assets/city/v1/svg25d/source/upper/"))
                content = (ROOT / source[6:]).read_bytes()
                svg_root = ET.fromstring(content)
                self.assertEqual(SVG + "svg", svg_root.tag)
                self.assertEqual("0 0 480 620", svg_root.attrib["viewBox"])
                nodes = list(svg_root.iter())
                self.assertGreaterEqual(sum(n.tag in {SVG+"rect", SVG+"polygon", SVG+"path"} for n in nodes), 150)
                self.assertFalse(any(n.tag.split("}")[-1] in FORBIDDEN for n in nodes))
                groups = {n.attrib.get("id") for n in nodes if n.tag == SVG+"g"}
                for group in ("facade-front", "side-return", "roof-and-parapet"):
                    self.assertIn(group, groups)
                approval = obj["art_review"]
                self.assertEqual("OBJECT_ART_ACCEPTED", obj["status"])
                self.assertEqual("ACCEPT", approval["decision"])
                self.assertEqual("ISOLATED_SVG_OBJECT_ONLY", approval["scope"])
                self.assertEqual("human", approval["reviewer"])
                self.assertEqual("INLINE_BROWSER_RENDERED_SOURCE_SVG", approval["evidence"])
                self.assertEqual("PENDING", approval["godot_render_import_qa"])
                self.assertEqual("NOT_GRANTED", approval["composite_scene_approval"])
                self.assertEqual("2026-10-09", approval["reviewed_on"])
                immutable_url = (
                    "https://raw.githubusercontent.com/az1nn/growing-rio/"
                    + approval["source_commit_sha"]
                    + "/assets/city/v1/svg25d/source/upper/" + obj["id"] + ".svg"
                )
                self.assertEqual(immutable_url, approval["preview_url"])
                self.assertIn("![" + obj["id"].split("-")[0].capitalize(), preview)
                self.assertIn(immutable_url, preview)
                expected_blob = hashlib.sha1(
                    b"blob " + str(len(content)).encode("ascii") + bytes([0]) + content
                ).hexdigest()
                self.assertEqual(expected_blob, approval["source_blob_sha"])
                self.assertEqual(4, len(obj["rect_hint"]))

    def test_item_accept_does_not_mutate_scene_or_mount_svg_renderer(self):
        state = json.loads(SCENE_STATUS.read_text(encoding="utf-8"))["scenes"]["city"]
        self.assertEqual("CONCEPT_ACCEPTED", state["state"])
        self.assertIsNone(state["accepted_runtime_run"])
        self.assertFalse((ROOT / "assets/city/v1/svg25d/layers.json").exists())
        city = (ROOT / "scenes/visual/city_diorama.gd").read_text(encoding="utf-8")
        self.assertNotIn("city_svg25d_layers.gd", city)
        self.assertIn("_build_r06_pixel_surface_shell()", city)

if __name__ == "__main__":
    unittest.main()
