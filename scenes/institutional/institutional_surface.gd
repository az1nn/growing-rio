extends Control

@onready var game_state = get_node("/root/GameState")
@onready var current_label: Label = %ComplianceCurrentLabel
@onready var next_label: Label = %ComplianceNextLabel
@onready var requirement_label: Label = %ComplianceRequirementLabel
@onready var progress_button: Button = %ComplianceProgressButton
@onready var institution_level_label: Label = %InstitutionLevelLabel
@onready var institution_context_label: Label = %InstitutionContextLabel
@onready var civic_label: Label = %CivicEngagementLabel
@onready var civic_button: Button = %CivicEngagementButton
@onready var policy_select: OptionButton = %PolicySelect
@onready var policy_state_label: Label = %PolicyStateLabel
@onready var policy_requirement_label: Label = %PolicyRequirementLabel
@onready var policy_effect_label: Label = %PolicyEffectLabel
@onready var policy_enact_button: Button = %PolicyEnactButton
@onready var feedback_label: Label = %ComplianceFeedbackLabel

var policy_ids: Array = []

func _ready() -> void:
    game_state.state_changed.connect(_refresh)
    game_state.message_posted.connect(_on_message)
    _refresh()

func _refresh() -> void:
    _refresh_compliance()
    _refresh_institutional()

func _refresh_compliance() -> void:
    var snapshot: Dictionary = game_state.compliance_snapshot()
    var level := int(snapshot.get("level", 0))
    var max_level := int(snapshot.get("max_level", 0))
    var complete := bool(snapshot.get("complete", false))
    var requirement: Dictionary = Dictionary(
        snapshot.get("next_requirement", {})
    )
    var progression: Dictionary = Dictionary(
        snapshot.get("progression", {})
    )

    current_label.text = "Compliance ficcional: nível %d / %d" % [
        level,
        max_level,
    ]

    if complete:
        next_label.text = "Progressão concluída no limite atual do sistema."
        requirement_label.text = (
            "Não há próxima etapa de compliance configurada para esta campanha."
        )
        progress_button.text = "Compliance concluída"
        progress_button.disabled = true
        progress_button.tooltip_text = String(
            progression.get("message", "")
        )
        return

    next_label.text = "Próxima etapa: %s" % String(
        requirement.get("label", "Etapa seguinte")
    )
    requirement_label.text = (
        "Requisitos do jogo: Caixa R$%d • Reputação %.0f • "
        + "Influence %.0f • Heat ≤ %.0f\n"
        + "Efeito conhecido: Reputação +%.0f • Heat %+.0f"
    ) % [
        int(requirement.get("cash_cost", 0)),
        float(requirement.get("reputation_min", 0.0)),
        float(requirement.get("influence_min", 0.0)),
        float(requirement.get("heat_max", 0.0)),
        float(requirement.get("reputation_gain", 0.0)),
        float(requirement.get("heat_delta", 0.0)),
    ]
    progress_button.text = "Avançar compliance"
    progress_button.disabled = not bool(
        progression.get("available", false)
    )
    progress_button.tooltip_text = String(
        progression.get("message", "")
    )

func _refresh_institutional() -> void:
    var snapshot: Dictionary = game_state.institutional_snapshot()
    var level := int(snapshot.get("institution_level", 0))
    var max_level := int(snapshot.get("max_level", 0))
    var compliance: Dictionary = Dictionary(snapshot.get("compliance", {}))
    var community: Dictionary = Dictionary(snapshot.get("community", {}))
    var participation: Dictionary = Dictionary(
        snapshot.get("participation", {})
    )

    institution_level_label.text = "Instituição ficcional: nível %d / %d" % [
        level,
        max_level,
    ]
    institution_context_label.text = (
        "Influence %.0f • Compliance %d • Comunidade em %s: %.0f • "
        + "Reputação %.0f"
    ) % [
        float(snapshot.get("influence", 0.0)),
        int(compliance.get("level", 0)),
        String(community.get("active_district_name", "distrito ativo")),
        float(community.get("support", 0.0)),
        float(community.get("reputation", 0.0)),
    ]

    civic_label.text = (
        "Participação cívica ficcional: Caixa R$%d → "
        + "Influence +%.0f • Reputação +%.0f"
    ) % [
        int(participation.get("cash_cost", 0)),
        float(participation.get("influence_gain", 0.0)),
        float(participation.get("reputation_gain", 0.0)),
    ]
    civic_button.disabled = not bool(
        participation.get("available", false)
    )
    civic_button.tooltip_text = String(
        participation.get("message", "")
    )

    var selected_id := ""
    var selected_index := policy_select.selected
    if selected_index >= 0 and selected_index < policy_ids.size():
        selected_id = String(policy_ids[selected_index])

    policy_ids = []
    policy_select.clear()
    var policies: Array = Array(snapshot.get("policies", []))
    for policy_value in policies:
        var policy: Dictionary = Dictionary(policy_value)
        var policy_id := String(policy.get("id", ""))
        policy_ids.append(policy_id)
        policy_select.add_item(
            "%s — %s" % [
                _policy_state_display(String(policy.get("state", ""))),
                String(policy.get("display_name", policy_id)),
            ]
        )

    var target_index := 0
    if not selected_id.is_empty():
        var remembered_index := policy_ids.find(selected_id)
        if remembered_index >= 0:
            target_index = remembered_index

    if not policy_ids.is_empty():
        policy_select.select(target_index)
    _render_selected_policy(snapshot)

func _render_selected_policy(snapshot: Dictionary) -> void:
    var index := policy_select.selected
    var policies: Array = Array(snapshot.get("policies", []))
    if index < 0 or index >= policies.size():
        policy_state_label.text = "Nenhuma proposta institucional configurada."
        policy_requirement_label.text = ""
        policy_effect_label.text = ""
        policy_enact_button.disabled = true
        return

    var policy: Dictionary = Dictionary(policies[index])
    var policy_state := String(policy.get("state", "unavailable"))
    policy_state_label.text = "%s — %s\n%s" % [
        String(policy.get("display_name", "Proposta institucional")),
        _policy_state_display(policy_state),
        String(policy.get("message", "")),
    ]
    policy_requirement_label.text = (
        "Pré-requisitos do jogo: Instituição nível %d • Compliance nível %d • "
        + "Caixa R$%d • Influence %.0f"
    ) % [
        int(policy.get("required_institution_level", 0)),
        int(policy.get("min_compliance_level", 0)),
        int(policy.get("cash_cost", 0)),
        float(policy.get("influence_cost", 0.0)),
    ]
    policy_effect_label.text = (
        "Efeito conhecido: Reputação +%.0f • Heat %+.0f. "
        + "A descrição é informativa e não recomenda uma proposta."
    ) % [
        float(policy.get("reputation_gain", 0.0)),
        float(policy.get("heat_delta", 0.0)),
    ]
    policy_enact_button.disabled = not bool(
        policy.get("available", false)
    )
    policy_enact_button.text = (
        "Proposta aprovada"
        if policy_state == "enacted"
        else "Aprovar proposta"
    )
    policy_enact_button.tooltip_text = String(
        policy.get("message", "")
    )

func _policy_state_display(policy_state: String) -> String:
    match policy_state:
        "enacted":
            return "Aprovada"
        "available":
            return "Disponível"
        _:
            return "Indisponível"

func _on_progress_pressed() -> void:
    if not game_state.advance_compliance():
        feedback_label.text = String(
            Dictionary(
                game_state.compliance_snapshot().get("progression", {})
            ).get(
                "message",
                "A progressão de compliance não pôde ser concluída.",
            )
        )

func _on_civic_engagement_pressed() -> void:
    if not game_state.civic_engagement():
        feedback_label.text = String(
            Dictionary(
                game_state.civic_engagement_snapshot()
            ).get(
                "message",
                "A participação institucional não pôde ser concluída.",
            )
        )

func _on_policy_selected(_index: int) -> void:
    _render_selected_policy(game_state.institutional_snapshot())

func _on_policy_enact_pressed() -> void:
    var index := policy_select.selected
    if index < 0 or index >= policy_ids.size():
        return
    var policy_id := String(policy_ids[index])
    if not game_state.enact_policy(policy_id):
        var snapshot: Dictionary = game_state.institutional_snapshot()
        var policies: Array = Array(snapshot.get("policies", []))
        for policy_value in policies:
            var policy: Dictionary = Dictionary(policy_value)
            if String(policy.get("id", "")) == policy_id:
                feedback_label.text = String(
                    policy.get(
                        "message",
                        "A proposta institucional não pôde ser aprovada.",
                    )
                )
                return

func _on_message(text: String) -> void:
    feedback_label.text = text
