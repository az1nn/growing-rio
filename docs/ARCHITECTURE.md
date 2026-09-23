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
     -> CommunityService: deterministic district support and Reputation feedback
     -> PolicyService: deterministic fictional proposal availability and institutional progression
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

## Fictional policy proposals and institutional progression
V0.4 represents institutional change as a deterministic, fictional strategy system. PolicyDefinition resources expose stable proposal IDs plus abstract compliance, Cash and Influence gates. PolicyService owns proposal availability, enactment and the 0..3 institutional progression boundary; UI scenes may only query and command this service through GameState.

Canonical runtime state stores:
- institution_level: deterministic progression from 0..3;
- enacted_policy_ids[]: stable proposal IDs in enactment order.

The initial policy chain is entirely fictional: Registro Cívico Participativo, Carta de Mercado Local and Pacto Cívico da Baía. Enactment applies only abstract Cash, Influence, Reputation and Heat deltas, consumes no RNG draws and does not model real politicians, parties, elections or targeted persuasion.

## Community / Reputation feedback

V0.4 closes the city-system loop with one aggregate support score per fictional district. CommunityService is UI-independent and deterministic. It computes bounded daily support movement from three already-canonical inputs: global Reputation, fictional institutional progression and district demand. The active district's resulting support then contributes a very small bounded delta back into Reputation.

Canonical runtime state stores:
- community_support{district_id -> 0..100}.

All districts start at neutral support 50.0. A daily support transition moves by at most 2 points and the Reputation feedback contribution is capped at +/-0.25 per day. The service consumes no RNG draws and models no identifiable demographic, party, candidate, election, persuasion target or real political actor.

## Save schema v9
Schema v9 adds a separate community snapshot while retaining the complete v8 policy, v7 city and v6 business snapshots.

schema_version: 9
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
policy:
  institution_level
  enacted_policy_ids[]
community:
  support{district_id -> score}
simulation:
  seed
  rng_state

Rules:
1. Content is referenced by stable IDs, never serialized Resource objects.
2. rng_state remains a decimal string so JSON cannot lose 64-bit precision.
3. V9 restores the exact RNG position, business/cultivation state, district demand, policy progression and community support.
4. V8 preserves policy progression and migrates community support to neutral 50.0 for every canonical district.
5. V7 preserves city state and migrates policy/community state to canonical defaults.
6. V6 preserves business/compliance state and migrates city/policy/community state to defaults.
7. V5 preserves contract/relationship state and migrates newer compliance/city/policy/community state to defaults.
8. V4 preserves room/staff/upgrade state and migrates newer relationship/compliance/city/policy/community state to defaults.
9. V3 preserves room cultivation state and migrates newer staff/upgrade/relationship/compliance/city/policy/community state to defaults.
10. V2 preserves its room list, migrates legacy global cultivation into the saved active room and starts newer state at defaults.
11. V1 migrates its single legacy cultivation snapshot into room_1 and starts newer state at defaults.
12. Unknown schema versions, room definitions, cultivars, staff IDs, upgrade IDs, buyer IDs, contract IDs, district IDs, policy IDs and out-of-range progression/demand/community values are rejected.
13. Filesystem/cloud save slots remain outside the domain snapshot contract.

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
11. Policy progression remains fictional, deterministic domain state; proposal enactment consumes no RNG draws and applies only abstract state deltas.
12. Market pricing may read a bounded district demand multiplier but city simulation never encodes real routes, sourcing, concealment or evasion.
13. Institutional gameplay never targets real politicians, parties, elections or identifiable groups for persuasion.
14. Community support remains aggregate fictional district state, consumes no RNG draws and may only feed Reputation through bounded abstract effects.

## Next architecture milestone
Begin V0.5 Campaign with narrative events and historical/cultural references while preserving the established lore boundary between sourced real history and fictional gameplay.
