# DA LATA — Architecture v0.4

## Target
- Godot 4.7.2 stable.
- GDScript.
- Mobile-first portrait UI, with Web/Desktop compatibility.
- Data-driven content as the project expands.

## Current slice
GameState is an Autoload that owns canonical simulation state and emits UI-facing signals.

UI (Main scene)
  -> GameState Autoload
     -> CultivationService: cycle, care, harvest and abstract stability application
     -> EconomyService: buyer pricing, contracts and relationship modifiers
     -> BusinessService: room/staff/upgrade costs and abstract modifiers
     -> ComplianceService: deterministic fictional compliance gates and transitions
     -> CityService: deterministic fictional district demand and price modifiers
     -> SaveService: schema dispatch, migration and JSON-safe snapshots
     -> Heat / Reputation / Influence / random events

Cultivation, economy and business calculations live behind domain services. GameState remains the orchestration boundary and owns canonical runtime state.

## Room model
V0.3 has explicit room-scoped cultivation state.

Each room stores primitive, save-safe state:

- instance_id: unique runtime/save identity, for example room_1.
- definition_id: stable room content identity, for example quarto_inicial.
- cultivation.active_cultivar_id: stable cultivar content identity.
- cultivation.grow_day.
- cultivation.grow_health.
- cultivation.cared_today.
- cultivation.inventory.
- cultivation.batch_quality.

active_room_id selects which room the existing UI surface renders and commands. GameState keeps a UI-facing compatibility cache for the active room, but rooms[].cultivation is canonical. Switching rooms only changes that projection; it does not copy cultivation state between rooms.

The default state still contains one quarto_inicial room with R$ 15/day operating cost, preserving V0.2 behavior. New rooms begin with the default abstract cultivation state. next_day advances every room independently in stable array order using the shared deterministic RNG stream.

## Staff and upgrades
Staff and upgrades are content-backed business modifiers, not UI state.

Canonical runtime state stores only stable IDs:
- hired_staff_ids[]
- owned_upgrade_ids[]

The first staff definition is assistente_operacional. The existing sensores_basicos UpgradeDefinition is reused directly rather than introducing a parallel upgrade model.

BusinessService resolves:
- staff daily cost;
- upgrade daily upkeep;
- one clamped health_stability_modifier composed from owned staff/upgrades.

CultivationService accepts that modifier as an explicit input to advance_day. No extra random draw is introduced, so identical seeds and modifier state remain deterministic. The modifier is intentionally abstract and does not encode real cultivation parameters.

## Contracts and buyer relationships
Contract offers remain attached to BuyerDefinition resources, which are the stable content identity boundary for both licensed and parallel abstract channels.

Canonical runtime state stores:
- buyer_relationships{buyer_id -> 0..100};
- active_contract_id, empty when no contract is accepted.

EconomyService resolves contract completion deterministically from inventory, quality, buyer content and the current relationship score. Successful contracts consume only the abstract units required by the offer, grant a configured cash bonus, increase that buyer relationship and clear the active contract. Relationship score contributes a small deterministic unit-price bonus on later sales. The contract path consumes no RNG draws.

## Compliance progression
Compliance is a fictional, abstract business progression surface. It is not tied to real agencies, politicians, parties or real-world influence campaigns.

Canonical runtime state stores one integer compliance_level from 0..3. ComplianceService owns deterministic transitions between levels. Each transition checks only abstract Cash, Reputation, Influence and Heat gates, applies configured deltas and consumes no RNG draws. UI may query the next requirement and request a transition, but does not own progression state.

## City districts and demand
V0.4 introduces seven fictional districts using the canonical IDs from `docs/lore/DISTRICTS.md`: Morro do Cedro, Centro Baixo, Baía Velha, Orla da Vigia, Arco Norte, Restinga Clara and Mercado da Madrugada.

DistrictDefinition resources hold stable IDs, display names, abstract base demand, a bounded price-modifier amplitude and a deterministic phase offset. GameState stores the selected active_district_id plus district_demand{id -> 0..100}. CityService advances demand from day/state without consuming RNG and derives a bounded multiplier used by existing EconomyService sale and contract pricing. UI may select and render districts but does not own city state. The system does not model real trafficking routes, jurisdictions or evasion.

## Save schema v7
Schema v7 adds a separate city snapshot while retaining the complete v6 business snapshot.

schema_version: 7
state:
  day / cash / heat / reputation / influence / game_over
business:
  active_room_id
  rooms[]:
    instance_id
    definition_id
    cultivation:
      active_cultivar_id
      grow_day / grow_health / cared_today
      inventory / batch_quality
  staff_ids[]
  upgrade_ids[]
  buyer_relationships{buyer_id -> score}
  active_contract_id
  compliance_level
city:
  active_district_id
  district_demand{district_id -> score}
simulation:
  seed
  rng_state

Rules:
1. Content is referenced by stable IDs, never serialized Resource objects.
2. rng_state remains a decimal string so JSON cannot lose 64-bit precision.
3. V7 restores the exact RNG position, every room cultivation snapshot, owned staff/upgrades, buyer relationships, the active contract, compliance_level, the active district and all district demand state.
4. V6 preserves its complete business/compliance state and migrates city state to the canonical default district/demand values.
5. V5 preserves its complete contract/relationship state and migrates with compliance_level 0 and default city state.
6. V4 preserves room/staff/upgrade state and migrates with zero buyer relationships, no active contract, compliance_level 0 and default city state.
7. V3 preserves room cultivation state and migrates with empty staff/upgrades, zero buyer relationships, no active contract, compliance_level 0 and default city state.
8. V2 preserves its room list, migrates the legacy global cultivation snapshot into the saved active room, initializes other rooms with default cultivation state and starts newer business/city state at defaults.
9. V1 migrates its single legacy cultivation snapshot into room_1 and starts newer business/city state at defaults.
10. Unknown schema versions, room definitions, cultivars, staff IDs, upgrade IDs, buyer IDs, contract IDs, district IDs, out-of-range demand values and out-of-range compliance levels are rejected.
11. Filesystem/cloud save slots remain outside the domain snapshot contract.

## Planned extraction
res://
  autoload/
    game_state.gd
    event_bus.gd
    save_service.gd
  domain/
    cultivation/
    economy/
    business/
    city/
    politics/
    events/
  resources/
    cultivars/
    buyers/
    rooms/
    staff/
    policies/
    upgrades/
    events/
  scenes/
    main/
    grow_room/
    market/
    city/
    policy/

## State rules
1. Domain state never depends on UI nodes.
2. UI sends commands and renders emitted state.
3. Randomness lives in simulation services, not presentation code.
4. Persistent state changes enter through an explicit versioned save boundary.
5. Content IDs are stable StringName values in Resources and plain strings in serialized state.
6. Room switching changes the active projection, never another room's canonical cultivation state.
7. Staff/upgrades apply through deterministic domain modifiers rather than scene-specific behavior.
8. Contract acceptance/resolution and buyer relationships remain domain state; UI may only command and render them.
9. Compliance progression remains deterministic domain state, is fictional/abstract and consumes no RNG draws.
10. District demand remains fictional, deterministic domain state; UI selection does not mutate demand and the city system consumes no RNG draws.
11. Market pricing may read a bounded district demand multiplier but city simulation never encodes real routes, sourcing, concealment or evasion.

## Next architecture milestone
Continue V0.4 City systems with fictional policy proposals and institutional progression, keeping all institutions and political actors fictional.
