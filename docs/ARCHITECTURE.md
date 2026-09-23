# DA LATA — Architecture v0.5 (campaign core in progress)

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

## Narrative event core

V0.5 begins with a UI-independent, deterministic narrative-event boundary derived from the canonical lore library.

NarrativeEventDefinition Resources hold stable event/arc IDs, availability flags, participants, choice IDs, lore flags, relationship semantics, abstract system signals, lore assertions and canon guardrails. NarrativeEventService validates definitions, checks availability and resolves one choice without consuming RNG or mutating caller-owned state.

The first implemented event is `event_dalva_lucia_primeiro_depoimento`. Its three canonical choices preserve the unresolved symbol-order dispute and return semantic consequences rather than hardcoded balance numbers.

The second V0.5 slice integrates canonical campaign state through GameState while keeping NarrativeEventService pure and UI-independent. GameState now owns completed narrative arcs, completed event IDs and persistent narrative flags, exposes event availability/resolution commands, and validates saved campaign IDs against the Resource-backed catalog. Narrative transitions remain deterministic and consume no RNG.

The third V0.5 slice adds the first presentation surface in the Main scene. The UI renders Resource-backed title/body/choice labels only for IDs returned by `GameState.available_narrative_event_ids()`, submits choices exclusively through `GameState.resolve_narrative_choice()`, and renders semantic result state without reimplementing eligibility or consequence rules.

The fourth V0.5 slice connects Ato I -> Ato II progression to ordinary play. The first successful completed sale, through either licensed or parallel abstract channels, closes `arc_o_quarto` and emits the three prerequisite campaign facts for the first narrative event. This transition lives in GameState orchestration, consumes no RNG, survives save schema v10, and is covered end-to-end from cultivation -> harvest -> sale -> event availability for both channels.

With natural unlock covered, the narrative-event roadmap slice is complete and the next V0.5 architecture milestone is the fictional DA LATA research chain.

## Research chain foundation

The first DA LATA research slice is UI-independent and deterministic.

ResearchStepDefinition Resources describe stable research-step IDs, narrative-event prerequisites, required/forbidden campaign flags, completion flags, evidence tags, semantic system signals and canon guardrails. ResearchService checks availability and resolves completion without consuming RNG or mutating caller-owned state.

The first step is `research_onda_evidence_catalog`. It unlocks only after `event_dalva_lucia_primeiro_depoimento` is completed and the campaign still carries the Onda object plus the unresolved symbol-order dispute. Completing the step records `research_da_lata_chain_started` and `research_onda_evidence_catalogued` while explicitly preserving unresolved provenance and prohibiting any claim of continuous historical/genetic lineage.

GameState owns orchestration through `available_research_step_ids()` and `complete_research_step()`. Research completion is persisted inside the existing v10 `campaign.narrative_flags` contract, so this slice does not introduce a new save schema or duplicate campaign state.

## Save schema v10
Schema v10 adds a separate narrative campaign snapshot while retaining the complete v9 community, v8 policy, v7 city and v6 business snapshots.

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
campaign:
  completed_arc_ids[]
  completed_event_ids[]
  narrative_flags{flag_id -> bool}
simulation:
  seed
  rng_state

Rules:
1. Content is referenced by stable IDs, never serialized Resource objects.
2. rng_state remains a decimal string so JSON cannot lose 64-bit precision.
3. V10 restores the exact RNG position plus business/cultivation, district, policy, community and narrative campaign state.
4. V9 preserves community state and migrates narrative campaign state to empty canonical defaults.
5. V8 preserves policy progression and migrates community support to neutral 50.0 plus empty narrative campaign state.
6. V7 preserves city state and migrates policy/community/campaign state to canonical defaults.
7. V6 preserves business/compliance state and migrates city/policy/community/campaign state to defaults.
8. V5 preserves contract/relationship state and migrates newer compliance/city/policy/community/campaign state to defaults.
9. V4 preserves room/staff/upgrade state and migrates newer relationship/compliance/city/policy/community/campaign state to defaults.
10. V3 preserves room cultivation state and migrates newer staff/upgrade/relationship/compliance/city/policy/community/campaign state to defaults.
11. V2 preserves its room list, migrates legacy global cultivation into the saved active room and starts newer state at defaults.
12. V1 migrates its single legacy cultivation snapshot into room_1 and starts newer state at defaults.
13. Unknown schema versions, content IDs and narrative event/arc/flag IDs are rejected at the appropriate save/GameState validation boundary.
14. Filesystem/cloud save slots remain outside the domain snapshot contract.

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
Build the first V0.5 research-chain slice against the persisted campaign contract, keeping research fictional/abstract and preserving the established lore uncertainty before finale work.
