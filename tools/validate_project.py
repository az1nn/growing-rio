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
    ROOT / 'scenes/main/main.gd',
    ROOT / 'scenes/main/main.tscn',
    ROOT / 'docs/GDD.md',
    ROOT / 'docs/ARCHITECTURE.md',
    ROOT / 'resources/models/cultivar_definition.gd',
    ROOT / 'resources/models/buyer_definition.gd',
    ROOT / 'resources/models/upgrade_definition.gd',
    ROOT / 'resources/models/staff_definition.gd',
    ROOT / 'resources/models/room_definition.gd',
    ROOT / 'resources/models/district_definition.gd',
    ROOT / 'resources/models/policy_definition.gd',
    ROOT / 'resources/models/narrative_event_definition.gd',
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
    ROOT / 'tests/simulation_seed_test.gd',
    ROOT / 'tests/economy_service_test.gd',
    ROOT / 'tests/business_service_test.gd',
    ROOT / 'tests/room_cultivation_state_test.gd',
    ROOT / 'tests/staff_upgrades_test.gd',
    ROOT / 'tests/contracts_relationships_test.gd',
    ROOT / 'tests/compliance_progression_test.gd',
    ROOT / 'tests/district_demand_test.gd',
    ROOT / 'tests/policy_progression_test.gd',
    ROOT / 'tests/community_feedback_test.gd',
    ROOT / 'tests/narrative_event_service_test.gd',
    ROOT / 'tests/save_schema_test.gd',
]
for path in required:
    if not path.exists() or path.stat().st_size == 0:
        errors.append(f'missing/empty: {path.relative_to(ROOT)}')

project = (ROOT / 'project.godot').read_text(encoding='utf-8')
if 'run/main_scene="res://scenes/main/main.tscn"' not in project:
    errors.append('main scene is not configured')
if 'GameState="*res://autoload/game_state.gd"' not in project:
    errors.append('GameState autoload is not configured')

gd = (ROOT / 'scenes/main/main.gd').read_text(encoding='utf-8')
tscn = (ROOT / 'scenes/main/main.tscn').read_text(encoding='utf-8')
connections = re.findall(r'method="([^"]+)"', tscn)
functions = set(re.findall(r'^func\s+([A-Za-z0-9_]+)\s*\(', gd, flags=re.M))
for callback in connections:
    if callback not in functions:
        errors.append(f'connected callback missing from main.gd: {callback}')

unique_nodes = set(re.findall(r'\[node name="([^"]+)"[^\]]*\]\nunique_name_in_owner = true', tscn))
for node in re.findall(r'=\s*%([A-Za-z][A-Za-z0-9_]*)', gd):
    if node not in unique_nodes:
        errors.append(f'%{node} used in script but not unique in scene')

state = (ROOT / 'autoload/game_state.gd').read_text(encoding='utf-8')
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
    'select_district',
    'district_price_multiplier',
    'policy_count',
    'available_policy_ids',
    'enact_policy',
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

event_definition = (ROOT / 'resources/models/narrative_event_definition.gd').read_text(encoding='utf-8')
for field in [
    'id',
    'arc_id',
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

first_event = (ROOT / 'resources/events/dalva_lucia_primeiro_depoimento.tres').read_text(encoding='utf-8')
for token in [
    'event_dalva_lucia_primeiro_depoimento',
    'choice_dalva_lucia_parallel_versions',
    'choice_dalva_lucia_living_memory',
    'choice_dalva_lucia_hold_judgment',
    'lore_dalva_lucia_symbol_order_disputed',
]:
    if token not in first_event:
        errors.append(f'First narrative event contract missing: {token}')

save_service = (ROOT / 'autoload/save_service.gd').read_text(encoding='utf-8')
if 'SCHEMA_VERSION := 9' not in save_service:
    errors.append('SaveService schema version is not explicitly v9')
for fn in ['create_v1', 'create_v2', 'create_v3', 'create_v4', 'create_v5', 'create_v6', 'create_v7', 'create_v8', 'create_v9', 'parse']:
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
print('room-scoped cultivation + active-room switching: present')
print('save schema v9 + v1/v2/v3/v4/v5/v6/v7/v8 migration boundary: present')
print('resource-backed content: present')
