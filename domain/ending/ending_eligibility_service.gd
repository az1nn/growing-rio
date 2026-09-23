extends RefCounted
class_name EndingEligibilityService

const ENDING_MARCA_NACIONAL := "ending_marca_nacional"
const ENDING_REDE_VIVA := "ending_rede_viva"
const ENDING_NOITE_SEM_ROTULO := "ending_noite_sem_rotulo"
const ENDING_ARQUIVO_PUBLICO := "ending_arquivo_publico"
const ENDING_ATLANTICO := "ending_atlantico"
const ENDING_O_VERAO_VOLTA := "ending_o_verao_volta"

# Readiness floors are implementation/balance constants, not narrative rankings.
const MIN_CASH := 250
const MIN_REPUTATION := 5.0
const MIN_INFLUENCE := 1.0
const MIN_AVERAGE_COMMUNITY := 50.0
const LICENSED_BUYER_ID := "varejista_licenciado"
const PARALLEL_BUYER_ID := "rede_paralela"

func eligible_ending_ids(snapshot: Dictionary) -> PackedStringArray:
    var flags: Dictionary = snapshot.get("narrative_flags", {})
    if not bool(flags.get("lore_final_form_debate_seen", false)):
        return PackedStringArray()

    var eligible := PackedStringArray()
    var cash := int(snapshot.get("cash", 0))
    var reputation := float(snapshot.get("reputation", 0.0))
    var influence := float(snapshot.get("influence", 0.0))
    var community_support: Dictionary = snapshot.get("community_support", {})
    var buyer_relationships: Dictionary = snapshot.get("buyer_relationships", {})
    var community_average := _average_community(community_support)
    var licensed_participation := _has_market_participation(
        buyer_relationships,
        LICENSED_BUYER_ID,
    )
    var parallel_participation := _has_market_participation(
        buyer_relationships,
        PARALLEL_BUYER_ID,
    )
    var research_complete := bool(
        flags.get("research_material_compatibility_reviewed", false)
    )
    var uncertainty_preserved := (
        bool(flags.get("lore_original_lineage_still_unproven", false))
        and (
            bool(flags.get("choice_reconstruction_public_uncertainty", false))
            or bool(flags.get("choice_name_evidence_forward", false))
            or bool(flags.get("choice_final_form_fragmentary_origin_clause", false))
        )
    )
    var autonomy_signal := (
        bool(flags.get("choice_city_contributions_distributed", false))
        or bool(flags.get("choice_final_form_no_single_narrative_owner", false))
    )
    var execution_signal := (
        bool(flags.get("choice_city_contributions_central_coordination", false))
        or bool(flags.get("choice_final_form_execution_clause", false))
    )

    if cash >= MIN_CASH and reputation >= MIN_REPUTATION and licensed_participation:
        eligible.append(ENDING_MARCA_NACIONAL)
    if community_average >= MIN_AVERAGE_COMMUNITY and reputation >= MIN_REPUTATION:
        eligible.append(ENDING_REDE_VIVA)
    if parallel_participation and autonomy_signal:
        eligible.append(ENDING_NOITE_SEM_ROTULO)
    if research_complete and uncertainty_preserved:
        eligible.append(ENDING_ARQUIVO_PUBLICO)
    if cash >= MIN_CASH and influence >= MIN_INFLUENCE and execution_signal:
        eligible.append(ENDING_ATLANTICO)
    if (
        research_complete
        and community_average >= MIN_AVERAGE_COMMUNITY
        and reputation >= MIN_REPUTATION
        and influence >= MIN_INFLUENCE
        and licensed_participation
        and parallel_participation
    ):
        eligible.append(ENDING_O_VERAO_VOLTA)

    return eligible

func _average_community(values: Dictionary) -> float:
    if values.is_empty():
        return 0.0
    var total := 0.0
    for value in values.values():
        total += float(value)
    return total / float(values.size())

func _has_market_participation(relationships: Dictionary, buyer_id: String) -> bool:
    return float(relationships.get(buyer_id, 0.0)) > 0.0
