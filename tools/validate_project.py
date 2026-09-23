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
    ROOT / 'scenes/main/main.gd',
    ROOT / 'scenes/main/main.tscn',
    ROOT / 'docs/GDD.md',
    ROOT / 'docs/ARCHITECTURE.md',
    ROOT / 'resources/models/cultivar_definition.gd',
    ROOT / 'resources/models/buyer_definition.gd',
    ROOT / 'resources/models/upgrade_definition.gd',
    ROOT / 'resources/models/staff_definition.gd',
    ROOT / 'resources/models/room_definition.gd',
    ROOT / 'resources/cultivars/quarto_classica.tres',
    ROOT / 'resources/buyers/varejista_licenciado.tres',
    ROOT / 'resources/buyers/rede_paralela.tres',
    ROOT / 'resources/upgrades/sensores_basicos.tres',
    ROOT / 'resources/staff/assistente_operacional.tres',
    ROOT / 'resources/rooms/quarto_inicial.tres',
    ROOT / 'resources/rooms/sala_compacta.tres',
    ROOT / 'tests/simulation_seed_test.gd',
    ROOT / 'tests/economy_service_test.gd',
    ROOT / 'tests/business_service_test.gd',
    ROOT / 'tests/room_cultivation_state_test.gd',
    ROOT / 'tests/staff_upgrades_test.gd',
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

cultivation = (ROOT / 'domain/cultivation/cultivation_service.gd').read_text(encoding='utf-8')
for fn in ['current_cycle_days', 'initial_state', 'care', 'advance_day', 'harvest']:
    if not re.search(rf'^func\s+{fn}\s*\(', cultivation, flags=re.M):
        errors.append(f'CultivationService transition missing: {fn}')
if 'health_stability_delta' not in cultivation:
    errors.append('CultivationService does not expose the abstract stability modifier boundary')

economy = (ROOT / 'domain/economy/economy_service.gd').read_text(encoding='utf-8')
if not re.search(r'^func\s+resolve_sale\s*\(', economy, flags=re.M):
    errors.append('EconomyService transition missing: resolve_sale')

business = (ROOT / 'domain/business/business_service.gd').read_text(encoding='utf-8')
for fn in [
    'daily_operating_cost',
    'daily_staff_cost',
    'daily_upgrade_cost',
    'health_stability_modifier',
]:
    if not re.search(rf'^func\s+{fn}\s*\(', business, flags=re.M):
        errors.append(f'BusinessService transition missing: {fn}')

save_service = (ROOT / 'autoload/save_service.gd').read_text(encoding='utf-8')
if 'SCHEMA_VERSION := 4' not in save_service:
    errors.append('SaveService schema version is not explicitly v4')
for fn in ['create_v1', 'create_v2', 'create_v3', 'create_v4', 'parse']:
    if not re.search(rf'^func\s+{fn}\s*\(', save_service, flags=re.M):
        errors.append(f'SaveService function missing: {fn}')
if '"rng_state": str(rng_state)' not in save_service:
    errors.append('SaveService does not preserve RNG state in JSON-safe form')
if '"active_cultivar_id"' not in save_service:
    errors.append('SaveService does not persist stable cultivar IDs')
if '"rooms"' not in save_service or '"active_room_id"' not in save_service:
    errors.append('SaveService does not persist stable room state')
if '"staff_ids"' not in save_service or '"upgrade_ids"' not in save_service:
    errors.append('SaveService v4 does not persist stable staff/upgrade IDs')
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
print('room-scoped cultivation + active-room switching: present')
print('save schema v4 + v1/v2/v3 migration boundary: present')
print('resource-backed content: present')
