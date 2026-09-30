#!/usr/bin/env bash
set -euo pipefail

PYTHON="${PYTHON:-python3}"
GODOT_VERSION="4.7.2"
GODOT_DIR="${GODOT_DIR:-/tmp/godot}"
GODOT_BIN="${GODOT_DIR}/Godot_v${GODOT_VERSION}-stable_linux.x86_64"
GODOT_ZIP="/tmp/godot-${GODOT_VERSION}.zip"
GODOT_SHA256="cadd3204e728a35d3f13adb7fd0d7902636b79f6b95c40c265eb73b6c35329e4"

echo "[ci] structural validation"
"${PYTHON}" tools/validate_project.py
"${PYTHON}" tools/validate_spec_009_balance.py
"${PYTHON}" tools/validate_archive_threejs.py

if [[ ! -x "${GODOT_BIN}" ]]; then
  echo "[ci] installing Godot ${GODOT_VERSION}"
  curl -L --fail --retry 3 -o "${GODOT_ZIP}" \
    "https://github.com/godotengine/godot/releases/download/${GODOT_VERSION}-stable/Godot_v${GODOT_VERSION}-stable_linux.x86_64.zip"
  echo "${GODOT_SHA256}  ${GODOT_ZIP}" | sha256sum -c -
  rm -rf "${GODOT_DIR}"
  mkdir -p "${GODOT_DIR}"
  "${PYTHON}" - "${GODOT_ZIP}" "${GODOT_DIR}" <<'PY'
import sys, zipfile
archive, target = sys.argv[1], sys.argv[2]
with zipfile.ZipFile(archive) as zf:
    zf.extractall(target)
PY
  chmod +x "${GODOT_BIN}"
fi

echo "[ci] Godot headless import smoke"
"${GODOT_BIN}" --headless --path . --editor --quit

tests=(
  "res://tests/game_shell_navigation_test.gd"
  "res://tests/visual_production_pass_test.gd"
  "res://tests/operation_surface_test.gd"
  "res://tests/diorama_scene_system_test.gd"
  "res://tests/all_scenes_3d_interaction_test.gd"
  "res://tests/market_3d_diorama_test.gd"
  "res://tests/city_3d_diorama_test.gd"
  "res://tests/institutional_3d_diorama_test.gd"
  "res://tests/archive_3d_diorama_test.gd"
  "res://tests/semantic_3d_hotspots_test.gd"
  "res://tests/campaign_3d_diorama_test.gd"
  "res://tests/narrative_3d_diorama_test.gd"
  "res://tests/three_d_completeness_audit_test.gd"
  "res://tests/simulation_seed_test.gd"
  "res://tests/economy_service_test.gd"
  "res://tests/business_service_test.gd"
  "res://tests/room_cultivation_state_test.gd"
  "res://tests/cultivation_lifecycle_stage_test.gd"
  "res://tests/lifecycle_stage_presentation_test.gd"
  "res://tests/lifecycle_harvest_invariant_test.gd"
  "res://tests/lifecycle_stage_persistence_test.gd"
  "res://tests/campaign_lifecycle_core_regression_test.gd"
  "res://tests/lifecycle_rng_inventory_invariant_test.gd"
  "res://tests/campaign_annual_cycle_margin_test.gd"
  "res://tests/lifecycle_multi_room_derivation_test.gd"
  "res://tests/staff_upgrades_test.gd"
  "res://tests/management_surface_test.gd"
  "res://tests/contracts_relationships_test.gd"
  "res://tests/market_surface_test.gd"
  "res://tests/compliance_progression_test.gd"
  "res://tests/compliance_surface_test.gd"
  "res://tests/district_demand_test.gd"
  "res://tests/city_surface_test.gd"
  "res://tests/policy_progression_test.gd"
  "res://tests/community_feedback_test.gd"
  "res://tests/narrative_event_service_test.gd"
  "res://tests/campaign_state_test.gd"
  "res://tests/campaign_progression_test.gd"
  "res://tests/campaign_calendar_boundary_test.gd"
  "res://tests/campaign_revalidation_test.gd"
  "res://tests/act_iv_evidence_bridge_test.gd"
  "res://tests/act_v_reconstruction_opening_test.gd"
  "res://tests/act_v_final_form_eligibility_test.gd"
  "res://tests/act_v_ending_selection_test.gd"
  "res://tests/finale_completion_test.gd"
  "res://tests/research_chain_test.gd"
  "res://tests/narrative_presentation_test.gd"
  "res://tests/research_presentation_test.gd"
  "res://tests/save_schema_test.gd"
  "res://tests/campaign_persistence_test.gd"
)

for test_script in "${tests[@]}"; do
  echo "[ci] ${test_script}"
  "${GODOT_BIN}" --headless --path . --script "${test_script}"
done

echo "[ci] PASS: structural validators + ${#tests[@]} Godot regressions"
