from pathlib import Path
import re

ROOT = Path(__file__).resolve().parents[1]
errors = []

required = [
    ROOT / 'project.godot',
    ROOT / 'autoload/game_state.gd',
    ROOT / 'domain/cultivation/cultivation_service.gd',
    ROOT / 'scenes/main/main.gd',
    ROOT / 'scenes/main/main.tscn',
    ROOT / 'docs/GDD.md',
    ROOT / 'docs/ARCHITECTURE.md',
    ROOT / 'resources/models/cultivar_definition.gd',
    ROOT / 'resources/models/buyer_definition.gd',
    ROOT / 'resources/models/upgrade_definition.gd',
    ROOT / 'resources/cultivars/quarto_classica.tres',
    ROOT / 'resources/buyers/varejista_licenciado.tres',
    ROOT / 'resources/buyers/rede_paralela.tres',
    ROOT / 'resources/upgrades/sensores_basicos.tres',
    ROOT / 'tests/simulation_seed_test.gd',
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
]:
    if not re.search(rf'^func\s+{fn}\s*\(', state, flags=re.M):
        errors.append(f'GameState action missing: {fn}')

if 'CULTIVATION_SERVICE' not in state or 'cultivation_service.' not in state:
    errors.append('GameState is not delegating cultivation transitions')

cultivation = (ROOT / 'domain/cultivation/cultivation_service.gd').read_text(encoding='utf-8')
for fn in ['current_cycle_days', 'initial_state', 'care', 'advance_day', 'harvest']:
    if not re.search(rf'^func\s+{fn}\s*\(', cultivation, flags=re.M):
        errors.append(f'CultivationService transition missing: {fn}')

for resource_ref in [
    'quarto_classica.tres',
    'varejista_licenciado.tres',
    'rede_paralela.tres',
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
print('resource-backed content: present')
