"""R06 source-art production guard: editable SVG candidates, never fake accepted runtime."""
import json
import unittest
import xml.etree.ElementTree as ET
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
FAMILY = ROOT / "assets/city/v1/svg25d/source/upper/candidate-family.json"
SVG = "{http://www.w3.org/2000/svg}"
FORBIDDEN = {"text", "image", "script", "filter", "foreignObject", "animate", "use"}

class R06SVG25DSourceTests(unittest.TestCase):
    def test_source_assets_are_independent_editable_svg_objects(self):
        data = json.loads(FAMILY.read_text(encoding="utf-8"))
        self.assertEqual("ORIGINAL_SPRITE_CANDIDATE", data["status"])
        self.assertEqual("20261004T110406Z/city", data["reference"]["id"])
        self.assertEqual(2, len(data["objects"]))
        self.assertEqual(2, len({v["id"] for v in data["objects"]}))
        for obj in data["objects"]:
            with self.subTest(sprite=obj["id"]):
                source = obj["source"]
                self.assertTrue(source.startswith("res://assets/city/v1/svg25d/source/upper/"))
                xml = (ROOT / source[6:]).read_text(encoding="utf-8")
                root = ET.fromstring(xml)
                self.assertEqual(SVG + "svg", root.tag)
                self.assertEqual("0 0 480 620", root.attrib["viewBox"])
                nodes = list(root.iter())
                self.assertGreaterEqual(sum(n.tag in {SVG+"rect", SVG+"polygon", SVG+"path"} for n in nodes), 150)
                self.assertFalse(any(n.tag.split("}")[-1] in FORBIDDEN for n in nodes))
                groups = {n.attrib.get("id") for n in nodes if n.tag == SVG+"g"}
                for required in ("facade-front", "side-return", "roof-and-parapet"):
                    self.assertIn(required, groups)
                self.assertEqual("UNREVIEWED", obj["status"])
                self.assertEqual(4, len(obj["rect_hint"]))
    def test_sprite_candidates_not_secretly_mounted_as_player_facing_art(self):
        self.assertFalse((ROOT / "assets/city/v1/svg25d/layers.json").exists())
        city = (ROOT / "scenes/visual/city_diorama.gd").read_text(encoding="utf-8")
        self.assertNotIn("city_svg25d_layers.gd", city)
        self.assertIn("_build_r06_pixel_surface_shell()", city)

if __name__ == "__main__":
    unittest.main()
