# SIGA session claim — RELATORIO deterministic readability

SIGA-TASK-KEY: RELATORIO:DETERMINISTIC-READABILITY
Base: ffbac4cff4509b207140e8522f61c7ce978b2b38
Branch: fix/relatorio-deterministic-readable

Scope:
- .agents/skills/relatorio/SKILL.md
- .agents/skills/siga/SKILL.md
- tools/render_relatorio_v1.py
- tests/test_relatorio_report_v1.py
- tests/test_siga_protocol.py

Semantic contract:
- factual text and URLs are rendered deterministically, never by image generation;
- REPORT_V1 must remain readable on mobile;
- preview URLs must remain exact and clickable outside raster output;
- R06 runtime branch PR #213 remains untouched.
