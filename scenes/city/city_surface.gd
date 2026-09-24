extends Control

@onready var game_state = get_node("/root/GameState")
@onready var active_label: Label = %CityActiveLabel
@onready var demand_label: Label = %CityDemandLabel
@onready var context_label: Label = %CityDemandContextLabel
@onready var district_list: VBoxContainer = %CityDistrictList
@onready var feedback_label: Label = %CityFeedbackLabel

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

    _clear_district_list()
    for district_value in Array(snapshot.get("districts", [])):
        _append_district_button(Dictionary(district_value))

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
            "Distrito ativo atualizado. Mercado usa a mesma demanda canônica."
        )
        return
    feedback_label.text = "Distrito desconhecido; nenhuma alteração foi aplicada."
