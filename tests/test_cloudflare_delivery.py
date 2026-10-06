from __future__ import annotations

import json
import subprocess
import sys
import unittest
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]


class CloudflareDeliveryContractTest(unittest.TestCase):
    def test_repository_validator_passes(self) -> None:
        result = subprocess.run(
            [sys.executable, "tools/validate_cloudflare_delivery.py"],
            cwd=ROOT,
            text=True,
            capture_output=True,
        )
        self.assertEqual(result.returncode, 0, result.stdout + result.stderr)
        self.assertIn("CLOUDFLARE DELIVERY CONTRACT PASSED", result.stdout)

    def test_production_and_preview_share_prepare_step(self) -> None:
        deploy = (ROOT / "tools/deploy_cloudflare.sh").read_text(encoding="utf-8")
        preview = (ROOT / "tools/preview_cloudflare.sh").read_text(encoding="utf-8")
        self.assertIn("bash tools/prepare_cloudflare_web.sh", deploy)
        self.assertIn("bash tools/prepare_cloudflare_web.sh", preview)
        self.assertIn('"wrangler@${WRANGLER_VERSION}" deploy', deploy)
        self.assertIn('"wrangler@${WRANGLER_VERSION}" preview', preview)

    def test_wrangler_declares_worker_preview_contract(self) -> None:
        config = json.loads((ROOT / "wrangler.jsonc").read_text(encoding="utf-8"))
        self.assertIs(config.get("preview_urls"), True)
        self.assertIsInstance(config.get("previews"), dict)

    def test_vercel_is_fallback_only(self) -> None:
        config = json.loads((ROOT / "vercel.json").read_text(encoding="utf-8"))
        self.assertIs((config.get("git") or {}).get("deploymentEnabled"), False)


if __name__ == "__main__":
    unittest.main()
