extends Control

@onready var game_state = get_node("/root/GameState")
@onready var active_label: Label = %CityActiveLabel
@onready var demand_label: Label = %CityDemandLabel
@onready var context_label: Label = %CityDemandContextLabel
@onready var district_list: VBoxContainer = %CityDistrictList
@onready var feedback_label: Label = %CityFeedbackLabel
@onready var community_support_label: Label = %CommunitySupportLabel
@onready var community_reputation_label: Label = %CommunityReputationLabel
@onready var community_context_label: Label = %CommunityContextLabel
@onready var community_transition_label: Label = %CommunityTransitionLabel

var _last_community_snapshot: Dictionary = {}

func _ready() -> void:
    game_state.state_changed.connect(_refresh)
    _refresh()

func _refresh() -> void:
    var snapshot: Dictionary = game_state.city_snapshot()
    var active := _active_district(snapshot)

    active_label.text = "Distrito ativo: %s" % String(
        active.get("display_name", "—")
    )
    demand_label.text = "Demanda atual: %d / 100" % int(
        round(float(active.get("demand", 0.0)))
    )
    context_label.text = (
        "Base: %d • Multiplicador de mercado: x%.2f"
        % [
            int(round(float(active.get("base_demand", 0.0)))),
            float(active.get("price_multiplier", 1.0)),
        ]
    )

    _refresh_community(game_state.community_snapshot())

    _clear_district_list()
    for district_value in Array(snapshot.get("districts", [])):
        _append_district_button(Dictionary(district_value))

func _refresh_community(snapshot: Dictionary) -> void:
    var district_id := String(snapshot.get("active_district_id", ""))
    var district_name := String(snapshot.get("active_district_name", district_id))
    var support := float(snapshot.get("support", 0.0))
    var reputation := float(snapshot.get("reputation", 0.0))

    community_support_label.text = (
        "Apoio comunitário em %s: %d / 100"
        % [district_name, int(round(support))]
    )
    community_reputation_label.text = (
        "Reputação global: %d / 100" % int(round(reputation))
    )
    community_context_label.text = (
        "Apoio comunitário pertence ao distrito ativo; Reputação é um sinal global da campanha. "
        + "Os valores vêm do estado canônico e esta tela não reproduz as fórmulas que os alteram."
    )

    if _last_community_snapshot.is_empty():
        community_transition_label.text = (
            "Leitura atual carregada. Mudanças futuras serão mostradas sem atribuir causa não registrada."
        )
    else:
        var previous_district_id := String(
            _last_community_snapshot.get("active_district_id", "")
        )
        if previous_district_id != district_id:
            community_transition_label.text = (
                "Contexto comunitário atualizado para %s; o distrito anterior não permanece como leitura atual."
                % district_name
            )
        else:
            var support_delta := (
                support - float(_last_community_snapshot.get("support", support))
            )
            var reputation_delta := (
                reputation - float(_last_community_snapshot.get("reputation", reputation))
            )
            if is_zero_approx(support_delta) and is_zero_approx(reputation_delta):
                community_transition_label.text = (
                    "Nenhuma mudança observada desde a última leitura deste distrito."
                )
            else:
                community_transition_label.text = (
                    "Mudança observada desde a última leitura: %s; %s. "
                    + "A tela registra consequência de estado, não uma causa não documentada."
                ) % [
                    _format_delta("apoio local", support_delta),
                    _format_delta("Reputação global", reputation_delta),
                ]

    _last_community_snapshot = snapshot.duplicate(true)

func _format_delta(label: String, value: float) -> String:
    if is_zero_approx(value):
        return "%s estável" % label
    return "%s %s%.1f" % [label, "+" if value > 0.0 else "", value]

func _active_district(snapshot: Dictionary) -> Dictionary:
    for district_value in Array(snapshot.get("districts", [])):
        var district := Dictionary(district_value)
        if bool(district.get("active", false)):
            return district
    return {}

func _append_district_button(district: Dictionary) -> void:
    var district_id := String(district.get("id", ""))
    var button := Button.new()
    button.custom_minimum_size = Vector2(0, 56)
    button.size_flags_horizontal = Control.SIZE_EXPAND_FILL
    button.text = "%s • demanda %d%s" % [
        String(district.get("display_name", district_id)),
        int(round(float(district.get("demand", 0.0)))),
        " • ATIVO" if bool(district.get("active", false)) else "",
    ]
    button.disabled = bool(district.get("active", false))
    button.tooltip_text = (
        "Seleciona este distrito como contexto canônico da campanha."
    )
    button.pressed.connect(_on_district_pressed.bind(district_id))
    district_list.add_child(button)

func _clear_district_list() -> void:
    for child in district_list.get_children():
        child.queue_free()

func _on_district_pressed(district_id: String) -> void:
    if game_state.select_district(district_id):
        feedback_label.text = (
            "Distrito ativo atualizado. Mercado e Comunidade usam o mesmo contexto canônico."
        )
        return
    feedback_label.text = "Distrito desconhecido; nenhuma alteração foi aplicada."
