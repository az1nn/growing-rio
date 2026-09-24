extends Control

@onready var game_state = get_node("/root/GameState")
@onready var current_label: Label = %ComplianceCurrentLabel
@onready var next_label: Label = %ComplianceNextLabel
@onready var requirement_label: Label = %ComplianceRequirementLabel
@onready var progress_button: Button = %ComplianceProgressButton
@onready var feedback_label: Label = %ComplianceFeedbackLabel

func _ready() -> void:
    game_state.state_changed.connect(_refresh)
    game_state.message_posted.connect(_on_message)
    _refresh()

func _refresh() -> void:
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

func _on_message(text: String) -> void:
    feedback_label.text = text
