# DA LATA — Architecture v0.5 (campaign core in progress)

## Target
- Godot 4.7.2 stable.
- GDScript.
- Mobile-first portrait UI, with Web/Desktop compatibility.
- Data-driven content as the project expands.

## Current slice
GameState is an Autoload that owns canonical simulation state and emits UI-facing signals.

UI (GameShell -> staged Main surface)
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

## Persistent game shell (RB-02)

RB-02 replaces product-level boot through the monolithic Main scene with `scenes/shell/game_shell.tscn`. The shell owns presentation routing only and reads canonical state through the existing GameState boundary.

The canonical destination IDs are:

- `operation` — Operação;
- `market` — Mercado;
- `city` — Cidade;
- `institutional` — Institucional;
- `archive` — Arquivo.

The shell owns the persistent Day/Cash/Heat/Reputation/Influence status layer, one surface host, one modal overlay host and responsive primary navigation. Portrait layouts use a bottom navigation bar; wide landscape layouts use the same destination semantics in a side rail.

Top-level navigation, responsive layout changes and overlay open/close/back transitions are presentation-only. While an overlay owns input, top-level navigation is suspended. Back closes that overlay and restores the exact pre-overlay destination; at a surface root, Back is left to the platform rather than inventing a navigation-history mutation.

During staged migration, the existing `scenes/main/main.tscn` remains embedded beneath Operação through the explicit `embedded_in_shell` presentation boundary. This keeps all pre-RB-02 playable actions reachable while RB-03..RB-11 move each capability to its canonical owner.

`tests/game_shell_navigation_test.gd` proves that routing across all five destinations, rejected unknown routes, overlay/back and portrait/wide switching leave `GameState.create_save_data()` byte-for-byte equivalent at the Dictionary boundary, including persisted RNG state. `tools/validate_project.py` also rejects known gameplay mutation calls from the shell script.

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

## Research chain

The DA LATA research chain is UI-independent, deterministic and ordered through persisted campaign evidence rather than scene state.

ResearchStepDefinition Resources describe stable research-step IDs, narrative-event prerequisites, required/forbidden campaign flags, completion flags, evidence tags, semantic system signals and canon guardrails. ResearchService checks availability and resolves completion without consuming RNG or mutating caller-owned state.

The first step, `research_onda_evidence_catalog`, unlocks only after `event_dalva_lucia_primeiro_depoimento` is completed and the campaign still carries the Onda object plus the unresolved symbol-order dispute. Completing it records `research_da_lata_chain_started` and `research_onda_evidence_catalogued`.

The second step, `research_symbol_order_comparison`, requires the persisted first-step result plus `lore_dalva_lucia_symbol_order_disputed`. It compares the parallel versions as evidence without selecting a historical winner, records `research_symbol_order_compared`, and keeps `symbol_order_remains_open` plus the no-lineage-authentication guardrail explicit.

The third step, `research_onda_provenance_gap_map`, requires the persisted symbol-order comparison plus the still-present Onda object/dispute evidence. It maps gaps in provenance and material context without authenticating the can's exact origin or date, records `research_onda_provenance_gaps_mapped`, and keeps both Onda provenance and historical/genetic lineage unresolved.

The fourth step, `research_evidence_boundary_synthesis`, requires the completed provenance-gap map and consolidates what the current dossier still cannot prove. It records `research_evidence_boundaries_synthesized` while explicitly preserving unresolved Onda provenance, disputed symbol order and the absence of authenticated continuous historical/genetic lineage. This is a chronology boundary: it does not import the later Ato IV material-compatibility conclusion or Ato V reconstruction framing.

The fifth step, `research_material_compatibility_review`, is deliberately deferred until canonical campaign evidence records the Ato IV conclusions `lore_material_origin_compatibility_established`, `lore_star_mark_revealed` and `lore_original_lineage_still_unproven`. It reviews that limited material compatibility without treating it as exact Onda provenance, original four-mark order/common origin or historical/genetic lineage authentication. The Resource is a future-campaign integration seam: the current runtime still does not implement `event_foto_estrela`, so this step is not yet naturally reachable through playable narrative progression.

GameState owns orchestration through `available_research_step_ids()` and `complete_research_step()`. All five completions and the Act IV evidence prerequisites persist inside the existing v10 `campaign.narrative_flags` contract, so the research chain still requires no save-schema bump or duplicate campaign state. The V0.5 research-chain roadmap item remains open until playable campaign progression can produce the later evidence gate and the chain is explicitly closed.

The research presentation surface queries only canonical availability, obtains display-safe metadata through the read-only `research_step_presentation()` boundary and submits completion exclusively through `complete_research_step()`. The Main scene renders semantic evidence, system signals and canon guardrails returned by the domain result; it does not own prerequisite, ordering or consequence rules.

## Spec-driven delivery boundary

Engineering feature delivery is now governed by `.specify/memory/constitution.md` plus bounded feature artifacts under `specs/`.

SIGA reconciles those artifacts against live repository/CI state. Specs define observable behavior and acceptance; plans define technical design; tasks define dependency-ordered implementation. UI/domain, deterministic simulation, persistence and canon constraints remain architectural rules rather than per-session prompt conventions.

The first Spec Kit feature, `specs/001-research-presentation/`, implemented the playable research presentation surface over the original two-step chain. `specs/002-onda-provenance-research/` extends that same canonical boundary with a third Resource-backed provenance-gap step without adding UI-owned progression rules. `specs/003-research-evidence-synthesis/` adds a fourth synthesis step that records the limits of current evidence without pulling later Ato IV/V conclusions into the early chain. `specs/004-research-material-compatibility-review/` adds a fifth deferred step whose availability depends on explicit Act IV evidence flags rather than importing that conclusion into early research.

## Save schema v11
Schema v11 extends the narrative campaign snapshot with the immutable selected ending ID while retaining the complete v10 narrative, v9 community, v8 policy, v7 city and v6 business snapshots.

schema_version: 11
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
  selected_ending_id
simulation:
  seed
  rng_state

Rules:
1. Content is referenced by stable IDs, never serialized Resource objects.
2. `rng_state` remains a decimal string so JSON cannot lose 64-bit precision.
3. V11 restores the exact RNG position, complete canonical campaign/business/city/policy/community state and `campaign.selected_ending_id`.
4. V10 preserves its full narrative campaign snapshot and migrates selected ending to the empty canonical default; no ending is inferred from eligibility.
5. V9 preserves community state and migrates narrative campaign state plus selected ending to canonical defaults.
6. V8 preserves policy progression and migrates community/campaign/finale-selection state to canonical defaults.
7. V7 preserves city state and migrates policy/community/campaign/finale-selection state to defaults.
8. V6 preserves business/compliance state and migrates city/policy/community/campaign/finale-selection state to defaults.
9. V5 preserves contract/relationship state and migrates newer compliance/city/policy/community/campaign/finale-selection state to defaults.
10. V4 preserves room/staff/upgrade state and migrates newer relationship/compliance/city/policy/community/campaign/finale-selection state to defaults.
11. V3 preserves room cultivation state and migrates newer staff/upgrade/relationship/compliance/city/policy/community/campaign/finale-selection state to defaults.
12. V2 preserves its room list, migrates legacy global cultivation into the saved active room and starts newer state at defaults.
13. V1 migrates its single legacy cultivation snapshot into room_1 and starts newer state at defaults.
14. Unknown schema versions, content IDs and narrative event/arc/flag/ending IDs are rejected at the appropriate save/GameState validation boundary.
15. Filesystem/cloud save slots remain outside the domain snapshot contract.

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
Close RB-02 with exact-head delivery evidence and guarded merge. Once the persistent shell/navigation contract is canonical on `master`, the next bounded product milestone is **RB-03 — Operation Management Surface**, which moves the existing operation controls out of the staged monolithic Main ownership without changing canonical simulation rules.

Finale expansion remains frozen until RB-14 revalidates campaign progression and explicitly records PASS/unfreeze.


## V0.5 Act IV evidence campaign spine

Feature 005 materializes the smallest playable canonical spine required to connect the existing early research dossier to the deferred Act IV material-compatibility review.

Runtime sequence:

```text
first sustainable sale
  -> arc_o_quarto
  -> event_dalva_lucia_primeiro_depoimento
  -> research steps 1..4
  -> event_act_ii_sol_photo_reveal
  -> arc_o_negocio
  -> event_bento_fita_farol
  -> second successful sale on either market route
  -> campaign_business_scale_reached
  -> event_act_iii_council_invitation
  -> arc_dois_mercados
  -> event_isa_mesa_sem_palco
  -> event_leilao_ferrugem
  -> event_ferrugem_quem_assina_memoria
  -> fictional council participation readiness
  -> event_audiencia_periodo_verde
  -> event_foto_estrela
  -> arc_o_sistema
  -> research_material_compatibility_review
```

Two bridge events wrap closing beats already present in `docs/lore/CAMPAIGN.md`; they introduce no new historical claims. Detailed optional Ato II/Ato III events remain outside this technical wave.

The business-scale gate is monotonic and route-neutral: the first successful sale already closes Ato I, while the second successful sale records `campaign_business_scale_reached`. The Audience uses `campaign_council_participation_ready`, reached through the existing abstract Influence action. These are gameplay progression facts, not real-world institutional or political claims.

`NarrativeEventService` remains pure and RNG-free. `GameState` owns the explicit event-to-arc transition map for the Sol closing beat, Conselho invitation and Estrela closing beat. `Main` renders whichever event the canonical catalog makes available through `narrative_event_presentation()`; it no longer owns a hardcoded first-event Resource.

All new state continues to reuse schema-v10 `completed_arc_ids`, `completed_event_ids` and `narrative_flags`. `event_foto_estrela` establishes only limited material compatibility, the Estrela reveal and the explicit fact that historical/genetic lineage remains unproven. It does not authenticate Onda provenance, common mark origin/order, the Caderno as a whole or a recoverable original lineage.


## Ato V reconstruction opening (feature 006)

Feature 006 extends the Resource-driven campaign spine from the completed Ato IV evidence review into the first bounded Ato V slice.

Sequence:

```text
research_material_compatibility_reviewed
        |
        v
event_reconstrucao_sem_original
        |
        v
lore_act_v_reconstruction_framed
        |
        v
event_sete_partes_da_cidade
        |
        v
lore_act_v_city_contributions_mapped
        |
        v
event_nome_da_lata
        |
        v
lore_da_lata_name_canonical
```

All three events remain `NarrativeEventDefinition` Resources. Availability and consequence application stay in the existing narrative domain/GameState boundary; Main only renders the currently available Resource and submits stable choice IDs.

The opening explicitly preserves DA LATA as a contemporary reconstruction. It does not authenticate continuous historical/genetic lineage, Caderno authorship, Fita chronology, Onda provenance or a historical order/common origin of the four marks.

Feature 006 itself stops at naming. Feature 007 continues from that exact handoff into `event_forma_da_lata`; neither feature selects an ending, runs `event_da_lata_handoff`, renders a coda or completes `arc_da_lata`.

## Ato V final-form eligibility (feature 007)

`event_forma_da_lata` is a fourth Resource-backed Ato V event. It opens only after `lore_da_lata_name_canonical` and records one of four intervention postures while always setting `lore_final_form_debate_seen`. The intervention changes the campaign record; it never stores an ending choice.

Ending readiness is derived by `EndingEligibilityService`, a pure RNG-free domain service called through `GameState.eligible_ending_ids()`. The service receives a snapshot of Cash, Reputation, Influence, Community support, buyer relationships and narrative flags, then returns zero, one or multiple stable ending-family IDs. Stable output order is an API convention only; there is no score, rank, preferred ending or moral winner.

The six families remain the canonically documented Marca Nacional, Rede Viva, Noite Sem Rótulo, Arquivo Público, Atlântico and O Verão Volta. Their numeric maturity floors are named implementation constants rather than lore claims, so later balancing can move the thresholds without rewriting narrative canon.

Eligibility remains derived under save schema v10. Feature 007 adds no selected-ending field and no event-to-arc completion mapping. Ending selection, `event_da_lata_handoff`, ending-specific codas and completion of `arc_da_lata` remain a later bounded feature.

## Ato V ending selection persistence (feature 008)

Feature 008 adds the smallest canonical state transition after ending eligibility: selecting exactly one currently eligible ending family.

`EndingSelectionService` is a pure RNG-free domain boundary. It receives the current selected ending, the requested stable ending ID and the already-derived eligible set. It may accept the first eligible request or reject the transition; it never recomputes eligibility, scores endings, ranks them or names a preferred outcome.

`GameState.select_ending()` remains the orchestration boundary. It delegates readiness to the existing `eligible_ending_ids()` path, delegates the immutable transition to `EndingSelectionService`, then stores `selected_ending_id` only when the transition succeeds. Selection does not complete `arc_da_lata`, execute `event_da_lata_handoff` or render a coda.

Because `selected_ending_id` is canonical persisted state rather than a derived value, the save boundary advances to schema v11. Schema v11 extends campaign state with one stable string field:

```text
campaign.selected_ending_id
```

Schema v10 remains a supported migration input and restores an empty selected ending rather than inferring one from the eligible set. Schemas v1-v9 retain their existing migration behavior. GameState rejects an unknown non-empty ending ID after schema parsing so content identity validation remains owned by the runtime catalog boundary.

The ending picker UI, finale handoff event, ending-specific codas and `arc_da_lata` completion remain future bounded work.

