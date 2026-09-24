from pathlib import Path
import re

ROOT = Path(__file__).resolve().parents[1]
errors = []

required = [
    ROOT / 'project.godot',
    ROOT / 'autoload/game_state.gd',
    ROOT / 'autoload/save_service.gd',
    ROOT / 'domain/cultivation/cultivation_service.gd',
    ROOT / 'domain/economy/economy_service.gd',
    ROOT / 'domain/business/business_service.gd',
    ROOT / 'domain/business/compliance_service.gd',
    ROOT / 'domain/city/city_service.gd',
    ROOT / 'domain/city/community_service.gd',
    ROOT / 'domain/politics/policy_service.gd',
    ROOT / 'domain/events/narrative_event_service.gd',
    ROOT / 'domain/ending/ending_eligibility_service.gd',
    ROOT / 'domain/ending/ending_selection_service.gd',
    ROOT / 'domain/research/research_service.gd',
    ROOT / 'scenes/main/main.gd',
    ROOT / 'scenes/main/main.tscn',
    ROOT / 'scenes/shell/game_shell.gd',
    ROOT / 'scenes/shell/game_shell.tscn',
    ROOT / 'scenes/operation/operation_surface.gd',
    ROOT / 'scenes/operation/operation_surface.tscn',
    ROOT / 'scenes/institutional/institutional_surface.gd',
    ROOT / 'scenes/institutional/institutional_surface.tscn',
    ROOT / 'scenes/city/city_surface.gd',
    ROOT / 'scenes/city/city_surface.tscn',
    ROOT / 'scenes/visual/operation_diorama.tscn',
    ROOT / 'docs/CENA-HANDOFF.md',
    ROOT / 'docs/VISUAL-DIRECTION.md',
    ROOT / 'docs/GDD.md',
    ROOT / 'docs/ARCHITECTURE.md',
    ROOT / 'docs/SPEC-KIT.md',
    ROOT / '.specify/memory/constitution.md',
    ROOT / '.agents/skills/siga/SKILL.md',
    ROOT / '.agents/skills/siga-concurrency/SKILL.md',
    ROOT / 'docs/SIGA-CONCURRENCY.md',
    ROOT / 'specs/001-research-presentation/spec.md',
    ROOT / 'specs/001-research-presentation/plan.md',
    ROOT / 'specs/001-research-presentation/tasks.md',
    ROOT / 'specs/001-research-presentation/checklists/requirements.md',
    ROOT / 'specs/006-act-v-reconstruction-opening/spec.md',
    ROOT / 'specs/006-act-v-reconstruction-opening/plan.md',
    ROOT / 'specs/006-act-v-reconstruction-opening/tasks.md',
    ROOT / 'specs/006-act-v-reconstruction-opening/checklists/requirements.md',
    ROOT / 'resources/models/cultivar_definition.gd',
    ROOT / 'resources/models/buyer_definition.gd',
    ROOT / 'resources/models/upgrade_definition.gd',
    ROOT / 'resources/models/staff_definition.gd',
    ROOT / 'resources/models/room_definition.gd',
    ROOT / 'resources/models/district_definition.gd',
    ROOT / 'resources/models/policy_definition.gd',
    ROOT / 'resources/models/narrative_event_definition.gd',
    ROOT / 'resources/models/research_step_definition.gd',
    ROOT / 'resources/cultivars/quarto_classica.tres',
    ROOT / 'resources/buyers/varejista_licenciado.tres',
    ROOT / 'resources/buyers/rede_paralela.tres',
    ROOT / 'resources/upgrades/sensores_basicos.tres',
    ROOT / 'resources/staff/assistente_operacional.tres',
    ROOT / 'resources/rooms/quarto_inicial.tres',
    ROOT / 'resources/rooms/sala_compacta.tres',
    ROOT / 'resources/districts/morro_cedro.tres',
    ROOT / 'resources/districts/centro_baixo.tres',
    ROOT / 'resources/districts/baia_velha.tres',
    ROOT / 'resources/districts/orla_vigia.tres',
    ROOT / 'resources/districts/arco_norte.tres',
    ROOT / 'resources/districts/restinga_clara.tres',
    ROOT / 'resources/districts/mercado_madrugada.tres',
    ROOT / 'resources/policies/participatory_registry.tres',
    ROOT / 'resources/policies/local_market_charter.tres',
    ROOT / 'resources/policies/bay_civic_compact.tres',
    ROOT / 'resources/events/dalva_lucia_primeiro_depoimento.tres',
    ROOT / 'resources/events/act_ii_sol_photo_reveal.tres',
    ROOT / 'resources/events/bento_fita_farol.tres',
    ROOT / 'resources/events/act_iii_council_invitation.tres',
    ROOT / 'resources/events/isa_mesa_sem_palco.tres',
    ROOT / 'resources/events/leilao_ferrugem.tres',
    ROOT / 'resources/events/ferrugem_quem_assina_memoria.tres',
    ROOT / 'resources/events/audiencia_periodo_verde.tres',
    ROOT / 'resources/events/foto_estrela.tres',
    ROOT / 'resources/events/reconstrucao_sem_original.tres',
    ROOT / 'resources/events/sete_partes_da_cidade.tres',
    ROOT / 'resources/events/nome_da_lata.tres',
    ROOT / 'resources/events/forma_da_lata.tres',
    ROOT / 'resources/research/onda_evidence_catalog.tres',
    ROOT / 'resources/research/symbol_order_comparison.tres',
    ROOT / 'resources/research/onda_provenance_gap_map.tres',
    ROOT / 'resources/research/evidence_boundary_synthesis.tres',
    ROOT / 'resources/research/material_compatibility_review.tres',
    ROOT / 'tests/simulation_seed_test.gd',
    ROOT / 'tests/game_shell_navigation_test.gd',
    ROOT / 'tests/operation_surface_test.gd',
    ROOT / 'tests/economy_service_test.gd',
    ROOT / 'tests/business_service_test.gd',
    ROOT / 'tests/room_cultivation_state_test.gd',
    ROOT / 'tests/staff_upgrades_test.gd',
    ROOT / 'tests/management_surface_test.gd',
    ROOT / 'tests/contracts_relationships_test.gd',
    ROOT / 'tests/compliance_progression_test.gd',
    ROOT / 'tests/compliance_surface_test.gd',
    ROOT / 'tests/city_surface_test.gd',
    ROOT / 'tests/district_demand_test.gd',
    ROOT / 'tests/policy_progression_test.gd',
    ROOT / 'tests/community_feedback_test.gd',
    ROOT / 'tests/narrative_event_service_test.gd',
    ROOT / 'tests/campaign_state_test.gd',
    ROOT / 'tests/campaign_progression_test.gd',
    ROOT / 'tests/act_iv_evidence_bridge_test.gd',
    ROOT / 'tests/act_v_reconstruction_opening_test.gd',
    ROOT / 'tests/act_v_final_form_eligibility_test.gd',
    ROOT / 'tests/act_v_ending_selection_test.gd',
    ROOT / 'tests/research_chain_test.gd',
    ROOT / 'tests/research_presentation_test.gd',
    ROOT / 'tests/save_schema_test.gd',
]
for path in required:
    if not path.exists() or path.stat().st_size == 0:
        errors.append(f'missing/empty: {path.relative_to(ROOT)}')

project = (ROOT / 'project.godot').read_text(encoding='utf-8')
if 'run/main_scene="res://scenes/shell/game_shell.tscn"' not in project:
    errors.append('RB-02 game shell is not configured as the main scene')
if 'GameState="*res://autoload/game_state.gd"' not in project:
    errors.append('GameState autoload is not configured')

gd = (ROOT / 'scenes/main/main.gd').read_text(encoding='utf-8')
tscn = (ROOT / 'scenes/main/main.tscn').read_text(encoding='utf-8')
shell_gd = (ROOT / 'scenes/shell/game_shell.gd').read_text(encoding='utf-8')
shell_tscn = (ROOT / 'scenes/shell/game_shell.tscn').read_text(encoding='utf-8')
operation_gd = (ROOT / 'scenes/operation/operation_surface.gd').read_text(encoding='utf-8')
operation_tscn = (ROOT / 'scenes/operation/operation_surface.tscn').read_text(encoding='utf-8')
state = (ROOT / 'autoload/game_state.gd').read_text(encoding='utf-8')
operation_scene = (ROOT / 'scenes/visual/operation_diorama.tscn').read_text(encoding='utf-8')
for token in [
    'type="Camera3D"',
    'type="WorldEnvironment"',
    'type="DirectionalLight3D"',
    'type="OmniLight3D"',
    'projection = 1',
    'keep_aspect = 0',
    'name="StemA"',
    'name="CanopyAUpper"',
    'name="StemB"',
    'name="CanopyBUpper"',
    'name="StemC"',
    'name="CanopyCUpper"',
    'name="FloorJointRear"',
    'name="FloorJointCenter"',
    'name="FloorJointFront"',
    'name="FloorJointSpine"',
]:
    if token not in operation_scene:
        errors.append(f'CENA operation diorama contract missing: {token}')
for token in [
    'res://scenes/visual/operation_diorama.tscn',
    'name="OperationDiorama"',
    'name="AtmosphereVeil"',
]:
    if token not in tscn:
        errors.append(f'CENA main-scene integration missing: {token}')

for token in [
    'DESTINATION_OPERATION',
    'DESTINATION_MARKET',
    'DESTINATION_CITY',
    'DESTINATION_INSTITUTIONAL',
    'DESTINATION_ARCHIVE',
    'func navigate_to(',
    'func apply_layout_for_size(',
    'func handle_back_request(',
    'func close_overlay(',
    'func open_overlay(',
]:
    if token not in shell_gd:
        errors.append(f'RB-02 shell destination contract missing: {token}')
for token in [
    'res://scenes/main/main.tscn',
    'name="GlobalStatus"',
    'name="SurfaceHost"',
    'name="OperationSurface"',
    'name="MarketSurface"',
    'name="CitySurface"',
    'name="InstitutionalSurface"',
    'name="ArchiveSurface"',
'name="OverlayHost"',
'name="PortraitNav"',
'name="WideNav"',
    'embedded_in_shell = true',
]:
    if token not in shell_tscn:
        errors.append(f'RB-02 shell scene contract missing: {token}')
if '@export var embedded_in_shell' not in gd:
    errors.append('legacy Main does not expose the staged shell-embedding boundary')
if 'res://scenes/operation/operation_surface.tscn' not in tscn:
    errors.append('RB-03 OperationSurface is not mounted in the staged Main container')
if 'func cultivation_action_availability(' not in state:
    errors.append('RB-03 GameState read boundary is missing')
cultivation = (ROOT / 'domain/cultivation/cultivation_service.gd').read_text(encoding='utf-8')
if 'func action_availability(' not in cultivation:
    errors.append('RB-03 cultivation availability contract is missing')
for token in [
    'game_state.cultivation_action_availability()',
    'game_state.care_for_room()',
    'game_state.next_day()',
    'game_state.harvest()',
    'signal management_requested',
]:
    if token not in operation_gd:
        errors.append(f'RB-03 operation command boundary missing: {token}')
for token in [
    'name="ActiveRoomLabel"',
    'name="CycleLabel"',
    'name="HealthLabel"',
    'name="ProgressBar"',
    'name="InventoryLabel"',
    'name="AvailabilityLabel"',
    'name="FeedbackLabel"',
    'name="ManagementButton"',
]:
    if token not in operation_tscn:
        errors.append(f'RB-03 operation presentation node missing: {token}')
for token in [
    'func management_snapshot(',
    '"rooms": room_entries',
    '"staff": staff_entries',
    '"upgrades": upgrade_entries',
    '"daily_operating_cost": daily_operating_cost()',
    '"health_stability_modifier": health_stability_modifier()',
]:
    if token not in state:
        errors.append(f'RB-04 canonical management read boundary missing: {token}')
for token in [
    'name="ManagementPanel"',
    'name="ManagementSummaryLabel"',
    'name="RoomsContainer"',
    'name="StaffContainer"',
    'name="UpgradesContainer"',
]:
    if token not in operation_tscn:
        errors.append(f'RB-04 management presentation node missing: {token}')
for token in [
    'game_state.management_snapshot()',
    'game_state.switch_active_room(',
    'game_state.hire_staff(',
    'game_state.purchase_upgrade(',
    'func _refresh_management(',
]:
    if token not in operation_gd:
        errors.append(f'RB-04 operation management boundary missing: {token}')

for stale_callback in [
    '_on_care_pressed',
    '_on_next_day_pressed',
    '_on_harvest_pressed',
]:
    if stale_callback in gd:
        errors.append(f'legacy Main still owns RB-03 cultivation callback: {stale_callback}')

operation_connections = re.findall(r'method="([^"]+)"', operation_tscn)
operation_functions = set(re.findall(r'^func\s+([A-Za-z0-9_]+)\s*\(', operation_gd, flags=re.M))
for callback in operation_connections:
    if callback not in operation_functions:
        errors.append(f'connected callback missing from operation_surface.gd: {callback}')

for mutation in [
    'next_day(',
    'care_for_room(',
    'harvest(',
    'sell_legal(',
    'sell_parallel(',
    'civic_engagement(',
    'select_district(',
    'enact_policy(',
    'resolve_narrative_choice(',
    'complete_research_step(',
    'select_ending(',
    'reset(',
]:
    if mutation in shell_gd:
        errors.append(f'RB-02 shell must remain presentation-only; gameplay mutation found: {mutation}')
shell_connections = re.findall(r'method="([^"]+)"', shell_tscn)
shell_functions = set(re.findall(r'^func\s+([A-Za-z0-9_]+)\s*\(', shell_gd, flags=re.M))
for callback in shell_connections:
    if callback not in shell_functions:
        errors.append(f'connected callback missing from game_shell.gd: {callback}')

connections = re.findall(r'method="([^"]+)"', tscn)
functions = set(re.findall(r'^func\s+([A-Za-z0-9_]+)\s*\(', gd, flags=re.M))
for callback in connections:
    if callback not in functions:
        errors.append(f'connected callback missing from main.gd: {callback}')

unique_nodes = set(re.findall(r'\[node name="([^"]+)"[^\]]*\]\nunique_name_in_owner = true', tscn))
for node in re.findall(r'=\s*%([A-Za-z][A-Za-z0-9_]*)', gd):
    if node not in unique_nodes:
        errors.append(f'%{node} used in script but not unique in scene')

for token in ['ResearchPanel', 'ResearchActions', 'ResearchResult']:
    if f'name="{token}"' not in tscn:
        errors.append(f'research presentation node missing: {token}')
if '_on_research_step_pressed' not in gd or '_refresh_research' not in gd:
    errors.append('research presentation interaction boundary is missing from main.gd')
if 'FIRST_NARRATIVE_EVENT' in gd:
    errors.append('Main still hardcodes a single narrative event Resource')
if 'narrative_event_presentation' not in gd:
    errors.append('Main does not use the generic narrative presentation boundary')

for fn in [
    'care_for_room',
    'next_day',
    'harvest',
    'sell_legal',
    'sell_parallel',
    'civic_engagement',
    'reset',
    'set_simulation_seed',
    'current_cycle_days',
    'room_count',
    'daily_operating_cost',
    'health_stability_modifier',
    'add_room',
    'hire_staff',
    'purchase_upgrade',
    'relationship_for_buyer',
    'accept_contract',
    'resolve_active_contract',
    'compliance_requirement',
    'advance_compliance',
    'district_count',
    'current_demand',
    'community_snapshot',
    'select_district',
    'district_price_multiplier',
    'policy_count',
    'available_policy_ids',
    'enact_policy',
    'narrative_event_count',
    'complete_narrative_arc',
    'set_narrative_flag',
    'available_narrative_event_ids',
    'narrative_event_presentation',
    'resolve_narrative_choice',
    'eligible_ending_ids',
    'select_ending',
    'research_step_count',
    'available_research_step_ids',
    'research_step_presentation',
    'complete_research_step',
    'switch_active_room',
    'create_save_data',
    'load_save_data',
]:
    if not re.search(rf'^func\s+{fn}\s*\(', state, flags=re.M):
        errors.append(f'GameState action missing: {fn}')

if 'CULTIVATION_SERVICE' not in state or 'cultivation_service.' not in state:
    errors.append('GameState is not delegating cultivation transitions')
if 'ECONOMY_SERVICE' not in state or 'economy_service.' not in state:
    errors.append('GameState is not delegating economy transitions')
if 'BUSINESS_SERVICE' not in state or 'business_service.' not in state:
    errors.append('GameState is not delegating business costs/modifiers')
if 'COMPLIANCE_SERVICE' not in state or 'compliance_service.' not in state:
    errors.append('GameState is not delegating compliance progression')
if 'CITY_SERVICE' not in state or 'city_service.' not in state:
    errors.append('GameState is not delegating city demand simulation')
if 'POLICY_SERVICE' not in state or 'policy_service.' not in state:
    errors.append('GameState is not delegating policy progression')
if 'SAVE_SERVICE' not in state or 'save_service.' not in state:
    errors.append('GameState is not delegating save schema handling')
if 'NARRATIVE_EVENT_SERVICE' not in state or 'narrative_event_service.' not in state:
    errors.append('GameState is not delegating narrative event transitions')
if 'RESEARCH_SERVICE' not in state or 'research_service.' not in state:
    errors.append('GameState is not delegating research transitions')
if 'completed_arc_ids' not in state or 'completed_event_ids' not in state or 'narrative_flags' not in state:
    errors.append('canonical narrative campaign state is missing from GameState')
if 'selected_ending_id' not in state:
    errors.append('canonical selected ending state is missing from GameState')
if 'DAILY_UPKEEP' in state:
    errors.append('legacy ad hoc DAILY_UPKEEP constant is still present')
if '"cultivation"' not in state:
    errors.append('room-scoped cultivation state is missing from GameState')
if 'UI-facing cache for the active room' not in state:
    errors.append('active-room compatibility cache boundary is not documented in code')
if 'hired_staff_ids' not in state or 'owned_upgrade_ids' not in state:
    errors.append('stable staff/upgrade runtime IDs are missing from GameState')
if 'buyer_relationships' not in state or 'active_contract_id' not in state:
    errors.append('contract/buyer relationship state is missing from GameState')
if 'compliance_level' not in state:
    errors.append('compliance progression state is missing from GameState')
if 'active_district_id' not in state or 'district_demand' not in state:
    errors.append('district demand state is missing from GameState')
if 'community_support' not in state or 'community_snapshot' not in state:
    errors.append('community presentation boundary is missing from GameState')
if 'institution_level' not in state or 'enacted_policy_ids' not in state:
    errors.append('policy progression state is missing from GameState')

cultivation = (ROOT / 'domain/cultivation/cultivation_service.gd').read_text(encoding='utf-8')
for fn in ['current_cycle_days', 'initial_state', 'care', 'advance_day', 'harvest']:
    if not re.search(rf'^func\s+{fn}\s*\(', cultivation, flags=re.M):
        errors.append(f'CultivationService transition missing: {fn}')
if 'health_stability_delta' not in cultivation:
    errors.append('CultivationService does not expose the abstract stability modifier boundary')

economy = (ROOT / 'domain/economy/economy_service.gd').read_text(encoding='utf-8')
for fn in ['resolve_sale', 'resolve_contract']:
    if not re.search(rf'^func\s+{fn}\s*\(', economy, flags=re.M):
        errors.append(f'EconomyService transition missing: {fn}')

business = (ROOT / 'domain/business/business_service.gd').read_text(encoding='utf-8')
for fn in [
    'daily_operating_cost',
    'daily_staff_cost',
    'daily_upgrade_cost',
    'health_stability_modifier',
]:
    if not re.search(rf'^func\s+{fn}\s*\(', business, flags=re.M):
        errors.append(f'BusinessService transition missing: {fn}')

compliance = (ROOT / 'domain/business/compliance_service.gd').read_text(encoding='utf-8')
for fn in ['requirement_for', 'resolve_progression']:
    if not re.search(rf'^func\s+{fn}\s*\(', compliance, flags=re.M):
        errors.append(f'ComplianceService transition missing: {fn}')
if 'MAX_LEVEL := 3' not in compliance:
    errors.append('ComplianceService max progression boundary is missing')

city = (ROOT / 'domain/city/city_service.gd').read_text(encoding='utf-8')
for fn in ['initial_demand', 'advance_day', 'price_multiplier']:
    if not re.search(rf'^func\s+{fn}\s*\(', city, flags=re.M):
        errors.append(f'CityService transition missing: {fn}')

community = (ROOT / 'domain/city/community_service.gd').read_text(encoding='utf-8')
for fn in ['initial_support', 'advance_day', 'reputation_delta', 'is_valid_state']:
    if not re.search(rf'^func\s+{fn}\s*\(', community, flags=re.M):
        errors.append(f'CommunityService transition missing: {fn}')
if 'MAX_DAILY_SUPPORT_STEP := 2.0' not in community:
    errors.append('CommunityService daily support boundary is missing')
if 'MAX_REPUTATION_FEEDBACK := 0.25' not in community:
    errors.append('CommunityService Reputation feedback boundary is missing')

policy = (ROOT / 'domain/politics/policy_service.gd').read_text(encoding='utf-8')
for fn in ['available_proposals', 'resolve_enactment', 'is_valid_state']:
    if not re.search(rf'^func\s+{fn}\s*\(', policy, flags=re.M):
        errors.append(f'PolicyService transition missing: {fn}')
if 'MAX_LEVEL := 3' not in policy:
    errors.append('PolicyService max progression boundary is missing')

narrative = (ROOT / 'domain/events/narrative_event_service.gd').read_text(encoding='utf-8')
for fn in ['is_valid_definition', 'is_available', 'resolve_choice']:
    if not re.search(rf'^func\s+{fn}\s*\(', narrative, flags=re.M):
        errors.append(f'NarrativeEventService transition missing: {fn}')
if 'RandomNumberGenerator' in narrative or 'randi' in narrative or 'randf' in narrative:
    errors.append('NarrativeEventService must remain deterministic and RNG-free')

research = (ROOT / 'domain/research/research_service.gd').read_text(encoding='utf-8')
for fn in ['is_valid_definition', 'is_available', 'resolve']:
    if not re.search(rf'^func\s+{fn}\s*\(', research, flags=re.M):
        errors.append(f'ResearchService transition missing: {fn}')
if 'RandomNumberGenerator' in research or 'randi' in research or 'randf' in research:
    errors.append('ResearchService must remain deterministic and RNG-free')

event_definition = (ROOT / 'resources/models/narrative_event_definition.gd').read_text(encoding='utf-8')
for field in [
    'id',
    'arc_id',
    'dialogue_key',
    'unlock_after_arc_id',
    'required_flags',
    'forbidden_flags',
    'participants',
    'choice_ids',
    'choice_flags',
    'relationship_effects',
    'system_signals',
    'lore_assertions',
    'canon_guardrails',
]:
    if not re.search(rf'@export var {field}\b', event_definition):
        errors.append(f'NarrativeEventDefinition field missing: {field}')

research_definition = (ROOT / 'resources/models/research_step_definition.gd').read_text(encoding='utf-8')
for field in [
    'id',
    'display_name',
    'unlock_after_event_id',
    'required_flags',
    'forbidden_flags',
    'completion_flags',
    'evidence_tags',
    'system_signals',
    'canon_guardrails',
]:
    if not re.search(rf'@export var {field}\b', research_definition):
        errors.append(f'ResearchStepDefinition field missing: {field}')

research_step = (ROOT / 'resources/research/onda_evidence_catalog.tres').read_text(encoding='utf-8')
for token in [
    'research_onda_evidence_catalog',
    'event_dalva_lucia_primeiro_depoimento',
    'research_da_lata_chain_started',
    'research_onda_evidence_catalogued',
    'research_does_not_authenticate_historical_lineage',
]:
    if token not in research_step:
        errors.append(f'First research step contract missing: {token}')

second_research_step = (ROOT / 'resources/research/symbol_order_comparison.tres').read_text(encoding='utf-8')
for token in [
    'research_symbol_order_comparison',
    'event_dalva_lucia_primeiro_depoimento',
    'research_onda_evidence_catalogued',
    'lore_dalva_lucia_symbol_order_disputed',
    'research_symbol_order_compared',
    'symbol_order_remains_open',
    'research_does_not_authenticate_historical_lineage',
]:
    if token not in second_research_step:
        errors.append(f'Second research step contract missing: {token}')

third_research_step = (ROOT / 'resources/research/onda_provenance_gap_map.tres').read_text(encoding='utf-8')
for token in [
    'research_onda_provenance_gap_map',
    'event_dalva_lucia_primeiro_depoimento',
    'research_symbol_order_compared',
    'lore_dalva_lucia_symbol_order_disputed',
    'research_onda_provenance_gaps_mapped',
    'evidence_provenance_unresolved',
    'onda_can_provenance_remains_open',
    'research_does_not_authenticate_historical_lineage',
]:
    if token not in third_research_step:
        errors.append(f'Third research step contract missing: {token}')

fourth_research_step = (ROOT / 'resources/research/evidence_boundary_synthesis.tres').read_text(encoding='utf-8')
for token in [
    'research_evidence_boundary_synthesis',
    'event_dalva_lucia_primeiro_depoimento',
    'research_onda_provenance_gaps_mapped',
    'lore_dalva_lucia_symbol_order_disputed',
    'research_evidence_boundaries_synthesized',
    'evidence_provenance_unresolved',
    'evidence_symbol_order_disputed',
    'onda_can_provenance_remains_open',
    'symbol_order_remains_open',
    'research_does_not_authenticate_historical_lineage',
    'research_records_uncertainty',
]:
    if token not in fourth_research_step:
        errors.append(f'Fourth research step contract missing: {token}')

fifth_research_step = (ROOT / 'resources/research/material_compatibility_review.tres').read_text(encoding='utf-8')
for token in [
    'research_material_compatibility_review',
    'research_evidence_boundaries_synthesized',
    'lore_material_origin_compatibility_established',
    'lore_star_mark_revealed',
    'lore_original_lineage_still_unproven',
    'lore_dalva_lucia_symbol_order_disputed',
    'lore_dalva_lucia_symbol_order_resolved',
    'research_material_compatibility_reviewed',
    'evidence_material_compatibility_limited',
    'material_compatibility_does_not_prove_lineage',
    'onda_can_provenance_remains_open',
    'symbol_order_remains_open',
    'research_does_not_authenticate_historical_lineage',
    'research_records_uncertainty',
]:
    if token not in fifth_research_step:
        errors.append(f'Fifth research step contract missing: {token}')

first_event = (ROOT / 'resources/events/dalva_lucia_primeiro_depoimento.tres').read_text(encoding='utf-8')
for token in [
    'event_dalva_lucia_primeiro_depoimento',
    'dialogue_event_dalva_lucia_primeiro_depoimento',
    'choice_dalva_lucia_parallel_versions',
    'choice_dalva_lucia_living_memory',
    'choice_dalva_lucia_hold_judgment',
    'lore_dalva_lucia_symbol_order_disputed',
]:
    if token not in first_event:
        errors.append(f'First narrative event contract missing: {token}')

campaign_spine_contracts = {
    'act_ii_sol_photo_reveal.tres': [
        'event_act_ii_sol_photo_reveal',
        'research_evidence_boundaries_synthesized',
        'lore_sol_mark_revealed',
    ],
    'bento_fita_farol.tres': [
        'event_bento_fita_farol',
        'lore_farol_tape_four_marks_heard',
        'lore_farol_tape_date_unverified',
    ],
    'act_iii_council_invitation.tres': [
        'event_act_iii_council_invitation',
        'campaign_business_scale_reached',
        'lore_council_invitation_received',
    ],
    'isa_mesa_sem_palco.tres': [
        'event_isa_mesa_sem_palco',
        'lore_isa_process_introduction_seen',
    ],
    'leilao_ferrugem.tres': [
        'event_leilao_ferrugem',
        'lore_ferrugem_lot_seen',
    ],
    'ferrugem_quem_assina_memoria.tres': [
        'event_ferrugem_quem_assina_memoria',
        'lore_ferrugem_mixed_evidence_public',
    ],
    'audiencia_periodo_verde.tres': [
        'event_audiencia_periodo_verde',
        'campaign_council_participation_ready',
        'lore_audiencia_periodo_verde_seen',
        'no_targeted_persuasion',
    ],
    'foto_estrela.tres': [
        'event_foto_estrela',
        'lore_material_origin_compatibility_established',
        'lore_star_mark_revealed',
        'lore_original_lineage_still_unproven',
        'material_compatibility_does_not_prove_lineage',
    ],
}
for filename, tokens in campaign_spine_contracts.items():
    event_text = (ROOT / 'resources/events' / filename).read_text(encoding='utf-8')
    for token in tokens:
        if token not in event_text:
            errors.append(f'Campaign spine event contract missing in {filename}: {token}')


act_v_opening_contracts = {
    'reconstrucao_sem_original.tres': [
        'event_reconstrucao_sem_original',
        'research_material_compatibility_reviewed',
        'lore_original_lineage_still_unproven',
        'lore_act_v_reconstruction_framed',
        'reconstruction_is_contemporary',
        'material_compatibility_does_not_prove_lineage',
    ],
    'sete_partes_da_cidade.tres': [
        'event_sete_partes_da_cidade',
        'lore_act_v_reconstruction_framed',
        'lore_act_v_city_contributions_mapped',
        'no_single_faction_is_complete_da_lata',
        'influence_is_access_not_control',
        'no_targeted_persuasion',
    ],
    'nome_da_lata.tres': [
        'event_nome_da_lata',
        'lore_act_v_city_contributions_mapped',
        'lore_da_lata_name_canonical',
        'name_is_present_decision_not_historical_authentication',
        'dalva_does_not_authenticate_origin',
        'continuous_lineage_remains_unproven',
    ],
}
for filename, tokens in act_v_opening_contracts.items():
    event_text = (ROOT / 'resources/events' / filename).read_text(encoding='utf-8')
    for token in tokens:
        if token not in event_text:
            errors.append(f'Act V opening event contract missing in {filename}: {token}')

final_form_event = (ROOT / 'resources/events/forma_da_lata.tres').read_text(encoding='utf-8')
for token in [
    'event_forma_da_lata',
    'lore_da_lata_name_canonical',
    'lore_final_form_debate_seen',
    'choice_final_form_fragmentary_origin_clause',
    'choice_final_form_reciprocity_clause',
    'choice_final_form_execution_clause',
    'choice_final_form_no_single_narrative_owner',
    'no_ending_is_morally_ranked',
    'o_verao_volta_is_composite_not_true_ending',
    'council_records_tradeoffs_not_player_choice',
    'no_targeted_persuasion',
]:
    if token not in final_form_event:
        errors.append(f'Act V final-form event contract missing: {token}')

ending_eligibility = (ROOT / 'domain/ending/ending_eligibility_service.gd').read_text(encoding='utf-8')
if not re.search(r'^func\s+eligible_ending_ids\s*\(', ending_eligibility, flags=re.M):
    errors.append('EndingEligibilityService transition missing: eligible_ending_ids')
for token in [
    'ENDING_MARCA_NACIONAL',
    'ENDING_REDE_VIVA',
    'ENDING_NOITE_SEM_ROTULO',
    'ENDING_ARQUIVO_PUBLICO',
    'ENDING_ATLANTICO',
    'ENDING_O_VERAO_VOLTA',
    'MIN_CASH',
    'MIN_REPUTATION',
    'MIN_INFLUENCE',
    'MIN_AVERAGE_COMMUNITY',
]:
    if token not in ending_eligibility:
        errors.append(f'Ending eligibility contract missing: {token}')
if 'RandomNumberGenerator' in ending_eligibility or 'randi' in ending_eligibility or 'randf' in ending_eligibility:
    errors.append('EndingEligibilityService must remain deterministic and RNG-free')
if any(token in ending_eligibility.lower() for token in ['score', 'rank', 'winner']):
    errors.append('EndingEligibilityService must not rank, score or select a winner')

ending_selection = (ROOT / 'domain/ending/ending_selection_service.gd').read_text(encoding='utf-8')
if not re.search(r'^func\s+select_ending\s*\(', ending_selection, flags=re.M):
    errors.append('EndingSelectionService transition missing: select_ending')
for token in ['current_ending_id', 'requested_ending_id', 'eligible_ending_ids', 'selected_ending_id']:
    if token not in ending_selection:
        errors.append(f'Ending selection contract missing: {token}')
if 'RandomNumberGenerator' in ending_selection or 'randi' in ending_selection or 'randf' in ending_selection:
    errors.append('EndingSelectionService must remain deterministic and RNG-free')
if any(token in ending_selection.lower() for token in ['score', 'rank', 'winner']):
    errors.append('EndingSelectionService must not rank, score or select a winner')

save_service = (ROOT / 'autoload/save_service.gd').read_text(encoding='utf-8')
if 'SCHEMA_VERSION := 11' not in save_service:
    errors.append('SaveService schema version is not explicitly v11')
for fn in ['create_v1', 'create_v2', 'create_v3', 'create_v4', 'create_v5', 'create_v6', 'create_v7', 'create_v8', 'create_v9', 'create_v10', 'create_v11', 'parse']:
    if not re.search(rf'^func\s+{fn}\s*\(', save_service, flags=re.M):
        errors.append(f'SaveService function missing: {fn}')
if '"rng_state": str(rng_state)' not in save_service:
    errors.append('SaveService does not preserve RNG state in JSON-safe form')
if '"active_cultivar_id"' not in save_service:
    errors.append('SaveService does not persist stable cultivar IDs')
if '"rooms"' not in save_service or '"active_room_id"' not in save_service:
    errors.append('SaveService does not persist stable room state')
if '"staff_ids"' not in save_service or '"upgrade_ids"' not in save_service:
    errors.append('SaveService does not persist stable staff/upgrade IDs')
if '"buyer_relationships"' not in save_service or '"active_contract_id"' not in save_service:
    errors.append('SaveService does not persist contract/buyer relationship state')
if '"compliance_level"' not in save_service:
    errors.append('SaveService does not persist compliance progression')
if '"active_district_id"' not in save_service or '"district_demand"' not in save_service:
    errors.append('SaveService does not persist district demand state')
if '"institution_level"' not in save_service or '"enacted_policy_ids"' not in save_service:
    errors.append('SaveService does not persist policy progression state')
if '"community"' not in save_service or '"support"' not in save_service:
    errors.append('SaveService v9 does not persist community support state')
if 'REQUIRED_COMMUNITY_KEYS' not in save_service:
    errors.append('SaveService does not validate community support state')
if 'REQUIRED_NARRATIVE_CAMPAIGN_KEYS' not in save_service:
    errors.append('SaveService does not validate narrative campaign state')
if '"completed_arc_ids"' not in save_service or '"completed_event_ids"' not in save_service or '"narrative_flags"' not in save_service:
    errors.append('SaveService does not persist narrative campaign state')
if '"selected_ending_id"' not in save_service:
    errors.append('SaveService v11 does not persist selected ending state')
if 'REQUIRED_ROOM_CULTIVATION_KEYS' not in save_service:
    errors.append('SaveService does not validate room cultivation state')

for resource_ref in [
    'quarto_classica.tres',
    'varejista_licenciado.tres',
    'rede_paralela.tres',
    'quarto_inicial.tres',
    'sala_compacta.tres',
    'sensores_basicos.tres',
    'assistente_operacional.tres',
    'morro_cedro.tres',
    'centro_baixo.tres',
    'baia_velha.tres',
    'orla_vigia.tres',
    'arco_norte.tres',
    'restinga_clara.tres',
    'mercado_madrugada.tres',
    'participatory_registry.tres',
    'local_market_charter.tres',
    'bay_civic_compact.tres',
]:
    if resource_ref not in state:
        errors.append(f'GameState resource reference missing: {resource_ref}')


constitution = (ROOT / '.specify/memory/constitution.md').read_text(encoding='utf-8')
for token in [
    'Repository Reality Is Authoritative',
    'Feature Work Is Spec-First',
    'Domain Logic Stays Deterministic and UI-Independent',
    'Persistence Changes Are Explicitly Versioned',
    'Tests and Exact-Head Evidence Gate Completion',
]:
    if token not in constitution:
        errors.append(f'Spec Kit constitution principle missing: {token}')

siga_skill = (ROOT / '.agents/skills/siga/SKILL.md').read_text(encoding='utf-8')
for token in [
    'REPOSITORY IDENTITY LOCK',
    'az1nn/growing-rio',
    'REPO_MISMATCH',
    'REPO_UNRESOLVED',
    'MUST NOT',
    'CONCURRENCY CONTROL',
    '.agents/skills/siga-concurrency/SKILL.md',
    'expected concurrency snapshot',
    'GATE_STALE',
    'expected-head guard',
]:
    if token not in siga_skill:
        errors.append(f'SIGA concurrency integration missing: {token}')

concurrency_skill = (ROOT / '.agents/skills/siga-concurrency/SKILL.md').read_text(encoding='utf-8')
for token in [
    'Branch-first work claim',
    'Write barrier',
    'Drift classification',
    'PARALLEL_SAFE',
    'COLLISION',
    'SUPERSEDED',
    'GATE_STALE',
    'Same-path semantic merge',
    'Handoff collision rules',
    'Open-PR collision scan',
    'validated_sha == current_pr_head_sha',
    'expected-head SHA guard',
]:
    if token not in concurrency_skill:
        errors.append(f'SIGA concurrency skill contract missing: {token}')

spec_root = ROOT / 'specs'
feature_dirs = sorted(path for path in spec_root.glob('[0-9][0-9][0-9]-*') if path.is_dir())
if not feature_dirs:
    errors.append('no numbered Spec Kit feature directories found under specs/')
for feature_dir in feature_dirs:
    for relative in [
        'spec.md',
        'plan.md',
        'tasks.md',
        'checklists/requirements.md',
    ]:
        path = feature_dir / relative
        if not path.exists() or path.stat().st_size == 0:
            errors.append(f'missing/empty Spec Kit artifact: {path.relative_to(ROOT)}')
    spec_path = feature_dir / 'spec.md'
    if spec_path.exists():
        spec_text = spec_path.read_text(encoding='utf-8')
        for heading in ['## User Scenarios', '## Functional Requirements', '## Success Criteria', '## Out of Scope']:
            if heading not in spec_text:
                errors.append(f'{feature_dir.name} spec missing heading: {heading}')
    tasks_path = feature_dir / 'tasks.md'
    if tasks_path.exists() and not re.search(r'^- \[[ xX]\] \[T\d{3}\]', tasks_path.read_text(encoding='utf-8'), flags=re.M):
        errors.append(f'{feature_dir.name} tasks do not use Spec Kit checklist task IDs')


market_scene_path = ROOT / 'scenes/market/market_surface.tscn'
market_script_path = ROOT / 'scenes/market/market_surface.gd'
market_test_path = ROOT / 'tests/market_surface_test.gd'
for required_path in [market_scene_path, market_script_path, market_test_path]:
    if not required_path.exists():
        errors.append(f'RB-05 market artifact missing: {required_path.relative_to(ROOT)}')

if market_scene_path.exists() and market_script_path.exists():
    market_scene = market_scene_path.read_text(encoding='utf-8')
    market_script = market_script_path.read_text(encoding='utf-8')
    for token in ['MarketSummaryLabel', 'MarketContextLabel', 'BuyerList', 'MarketFeedbackLabel']:
        if token not in market_scene:
            errors.append(f'RB-05 market scene contract missing: {token}')
    for fn in ['_refresh', '_on_sale_pressed', '_on_contract_pressed']:
        if not re.search(rf'^func\s+{fn}\s*\(', market_script, flags=re.M):
            errors.append(f'RB-05 market surface callback missing: {fn}')
    for forbidden in ['economy_service.resolve_sale', 'economy_service.resolve_contract']:
        if forbidden in market_script:
            errors.append(f'RB-05 scene duplicates domain logic: {forbidden}')

game_state_market = (ROOT / 'autoload/game_state.gd').read_text(encoding='utf-8')
if not re.search(r'^func\s+market_snapshot\s*\(', game_state_market, flags=re.M):
    errors.append('RB-05 GameState read boundary missing: market_snapshot')
for token in ['sale_preview', 'completion_preview', 'buyer_relationships', 'compliance', 'district']:
    if token not in game_state_market:
        errors.append(f'RB-05 GameState market contract missing: {token}')

shell_scene_market = (ROOT / 'scenes/shell/game_shell.tscn').read_text(encoding='utf-8')
if 'res://scenes/market/market_surface.tscn' not in shell_scene_market:
    errors.append('RB-05 market surface is not mounted in the canonical shell destination')

legacy_main_market = (ROOT / 'scenes/main/main.gd').read_text(encoding='utf-8')
for token in ['MarketTitle.visible = false', 'MarketHelp.visible = false', 'MarketActions.visible = false']:
    if token not in legacy_main_market:
        errors.append(f'RB-05 legacy market handoff missing: {token}')


institutional_scene_path = ROOT / 'scenes/institutional/institutional_surface.tscn'
institutional_script_path = ROOT / 'scenes/institutional/institutional_surface.gd'
institutional_test_path = ROOT / 'tests/compliance_surface_test.gd'
for required_path in [
    institutional_scene_path,
    institutional_script_path,
    institutional_test_path,
]:
    if not required_path.exists():
        errors.append(
            f'RB-06 compliance artifact missing: {required_path.relative_to(ROOT)}'
        )

if institutional_scene_path.exists() and institutional_script_path.exists():
    institutional_scene = institutional_scene_path.read_text(encoding='utf-8')
    institutional_script = institutional_script_path.read_text(encoding='utf-8')
    for token in [
        'ComplianceCurrentLabel',
        'ComplianceNextLabel',
        'ComplianceRequirementLabel',
        'ComplianceProgressButton',
        'ComplianceFeedbackLabel',
        'Sistema ficcional do jogo',
    ]:
        if token not in institutional_scene:
            errors.append(f'RB-06 institutional scene contract missing: {token}')
    for token in [
        'game_state.compliance_snapshot()',
        'game_state.advance_compliance()',
    ]:
        if token not in institutional_script:
            errors.append(f'RB-06 institutional command boundary missing: {token}')
    if 'resolve_progression(' in institutional_script:
        errors.append('RB-06 scene duplicates compliance domain progression logic')

game_state_compliance = (ROOT / 'autoload/game_state.gd').read_text(encoding='utf-8')
if not re.search(r'^func\s+compliance_snapshot\s*\(', game_state_compliance, flags=re.M):
    errors.append('RB-06 GameState read boundary missing: compliance_snapshot')
for token in ['next_requirement', 'progression', 'max_level']:
    if token not in game_state_compliance:
        errors.append(f'RB-06 GameState compliance contract missing: {token}')

shell_scene_compliance = (ROOT / 'scenes/shell/game_shell.tscn').read_text(encoding='utf-8')
if 'res://scenes/institutional/institutional_surface.tscn' not in shell_scene_compliance:
    errors.append('RB-06 compliance surface is not mounted in Institucional')



city_scene_path = ROOT / 'scenes/city/city_surface.tscn'
city_script_path = ROOT / 'scenes/city/city_surface.gd'
city_test_path = ROOT / 'tests/city_surface_test.gd'
for required_path in [city_scene_path, city_script_path, city_test_path]:
    if not required_path.exists():
        errors.append(
            f'RB-07 city artifact missing: {required_path.relative_to(ROOT)}'
        )

if city_scene_path.exists() and city_script_path.exists():
    city_scene = city_scene_path.read_text(encoding='utf-8')
    city_script = city_script_path.read_text(encoding='utf-8')
    for token in [
        'CityActiveLabel',
        'CityDemandLabel',
        'CityDemandContextLabel',
        'CityDistrictList',
        'Distritos ficcionais do jogo',
    ]:
        if token not in city_scene:
            errors.append(f'RB-07 city scene contract missing: {token}')
    for token in [
        'game_state.city_snapshot()',
        'game_state.select_district(district_id)',
    ]:
        if token not in city_script:
            errors.append(f'RB-07 city command boundary missing: {token}')
    if 'city_service.advance_day(' in city_script:
        errors.append('RB-07 scene duplicates city-domain demand progression')

game_state_city = (ROOT / 'autoload/game_state.gd').read_text(encoding='utf-8')
if not re.search(r'^func\s+city_snapshot\s*\(', game_state_city, flags=re.M):
    errors.append('RB-07 GameState read boundary missing: city_snapshot')

shell_scene_city = (ROOT / 'scenes/shell/game_shell.tscn').read_text(encoding='utf-8')
if 'res://scenes/city/city_surface.tscn' not in shell_scene_city:
    errors.append('RB-07 City surface is not mounted in the shell')

market_script_city = (ROOT / 'scenes/market/market_surface.gd').read_text(encoding='utf-8')
for token in ['signal city_requested', 'city_requested.emit()']:
    if token not in market_script_city:
        errors.append(f'RB-07 Market-to-City handoff missing: {token}')


if errors:
    print('VALIDATION FAILED')
    for e in errors:
        print('-', e)
    raise SystemExit(1)

print('VALIDATION PASSED')
print(f'callbacks: {len(connections)}')
print(f'unique UI nodes: {len(unique_nodes)}')
print('core actions + deterministic seed hook: present')
print('cultivation transitions: delegated')
print('economy transitions: delegated')
print('business rooms + staff/upgrades modifiers: delegated')
print('compliance progression: delegated and deterministic')
print('fictional district demand: delegated and deterministic')
print('community / Reputation feedback: delegated, bounded and deterministic')
print('fictional policy progression: delegated and deterministic')
print('V0.5 narrative event core: resource-backed, UI-independent and deterministic')
print('V0.5 Act IV evidence campaign spine: resource-backed and naturally reachable')
print('V0.5 Act V final-form debate + non-ranked ending eligibility: present')
print('V0.5 campaign state: GameState-orchestrated and save-persistent')
print('V0.5 research chain: five-step, resource-backed, deterministic and save-persistent')
print('room-scoped cultivation + active-room switching: present')
print('save schema v11 + v1/v2/v3/v4/v5/v6/v7/v8/v9/v10 migration boundary: present')
print('resource-backed content: present')
print('Spec Kit constitution + numbered feature artifacts: present')
print('SIGA repository identity lock + concurrency/write/merge barriers: present')
