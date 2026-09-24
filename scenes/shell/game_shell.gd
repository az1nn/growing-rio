extends Control

const DESTINATION_OPERATION := "operation"
const DESTINATION_MARKET := "market"
const DESTINATION_CITY := "city"
const DESTINATION_INSTITUTIONAL := "institutional"
const DESTINATION_ARCHIVE := "archive"
const DESTINATION_IDS := [
    DESTINATION_OPERATION,
    DESTINATION_MARKET,
    DESTINATION_CITY,
    DESTINATION_INSTITUTIONAL,
    DESTINATION_ARCHIVE,
]

@onready var game_state = get_node("/root/GameState")
@onready var day_label: Label = %ShellDayLabel
@onready var cash_label: Label = %ShellCashLabel
@onready var heat_label: Label = %ShellHeatLabel
@onready var reputation_label: Label = %ShellReputationLabel
@onready var influence_label: Label = %ShellInfluenceLabel
@onready var destination_label: Label = %DestinationLabel

@onready var operation_surface: Control = %OperationSurface
@onready var market_surface: Control = %MarketSurface
@onready var city_surface: Control = %CitySurface
@onready var institutional_surface: Control = %InstitutionalSurface
@onready var archive_surface: Control = %ArchiveSurface

@onready var portrait_nav: HBoxContainer = %PortraitNav
@onready var wide_nav: VBoxContainer = %WideNav

@onready var operation_button: Button = %OperationButton
@onready var market_button: Button = %MarketButton
@onready var city_button: Button = %CityButton
@onready var institutional_button: Button = %InstitutionalButton
@onready var archive_button: Button = %ArchiveButton

@onready var wide_operation_button: Button = %WideOperationButton
@onready var wide_market_button: Button = %WideMarketButton
@onready var wide_city_button: Button = %WideCityButton
@onready var wide_institutional_button: Button = %WideInstitutionalButton
@onready var wide_archive_button: Button = %WideArchiveButton

@onready var overlay_host: PanelContainer = %OverlayHost
@onready var overlay_title: Label = %OverlayTitle
@onready var overlay_body: Label = %OverlayBody

var current_destination := DESTINATION_OPERATION
var active_overlay_id := ""
var overlay_return_destination := DESTINATION_OPERATION
var wide_layout := false

func _ready() -> void:
    game_state.state_changed.connect(_refresh_global_status)
    if market_surface.has_signal("city_requested"):
        market_surface.connect(
            "city_requested",
            Callable(self, "_on_market_city_requested"),
        )
    get_viewport().size_changed.connect(_on_viewport_size_changed)
    _refresh_global_status()
    apply_layout_for_size(get_viewport_rect().size)
    _apply_destination()

func destination_ids() -> Array:
    return DESTINATION_IDS.duplicate()

func navigate_to(destination_id: String) -> bool:
    if not active_overlay_id.is_empty():
        return false
    if not DESTINATION_IDS.has(destination_id):
        return false
    if current_destination == destination_id:
        return true

    current_destination = destination_id
    _apply_destination()
    return true

func open_overlay(
    overlay_id: String,
    title: String = "",
    body: String = "",
) -> bool:
    if overlay_id.is_empty() or not active_overlay_id.is_empty():
        return false

    active_overlay_id = overlay_id
    overlay_return_destination = current_destination
    overlay_title.text = title if not title.is_empty() else "DA LATA"
    overlay_body.text = body
    overlay_host.visible = true
    _refresh_nav_state()
    return true

func close_overlay() -> bool:
    if active_overlay_id.is_empty():
        return false

    active_overlay_id = ""
    overlay_host.visible = false
    if DESTINATION_IDS.has(overlay_return_destination):
        current_destination = overlay_return_destination
    overlay_return_destination = current_destination
    _apply_destination()
    return true

func handle_back_request() -> bool:
    if not active_overlay_id.is_empty():
        return close_overlay()
    return false

func apply_layout_for_size(viewport_size: Vector2) -> void:
    wide_layout = viewport_size.x >= 900.0 and viewport_size.x > viewport_size.y
    wide_nav.visible = wide_layout
    portrait_nav.visible = not wide_layout
    _refresh_nav_state()

func _refresh_global_status() -> void:
    day_label.text = "DIA %d / %d" % [game_state.day, game_state.MAX_DAYS]
    cash_label.text = "Caixa\nR$ %d" % game_state.cash
    heat_label.text = "Heat\n%d" % int(round(game_state.heat))
    reputation_label.text = "Reputação\n%d" % int(round(game_state.reputation))
    influence_label.text = "Influence\n%d" % int(round(game_state.influence))

func _apply_destination() -> void:
    operation_surface.visible = current_destination == DESTINATION_OPERATION
    market_surface.visible = current_destination == DESTINATION_MARKET
    city_surface.visible = current_destination == DESTINATION_CITY
    institutional_surface.visible = current_destination == DESTINATION_INSTITUTIONAL
    archive_surface.visible = current_destination == DESTINATION_ARCHIVE

    destination_label.text = _destination_display_name(current_destination)
    _refresh_nav_state()

func _refresh_nav_state() -> void:
    var modal_active := not active_overlay_id.is_empty()

    operation_button.disabled = modal_active or current_destination == DESTINATION_OPERATION
    market_button.disabled = modal_active or current_destination == DESTINATION_MARKET
    city_button.disabled = modal_active or current_destination == DESTINATION_CITY
    institutional_button.disabled = (
        modal_active or current_destination == DESTINATION_INSTITUTIONAL
    )
    archive_button.disabled = modal_active or current_destination == DESTINATION_ARCHIVE

    wide_operation_button.disabled = (
        modal_active or current_destination == DESTINATION_OPERATION
    )
    wide_market_button.disabled = modal_active or current_destination == DESTINATION_MARKET
    wide_city_button.disabled = modal_active or current_destination == DESTINATION_CITY
    wide_institutional_button.disabled = (
        modal_active or current_destination == DESTINATION_INSTITUTIONAL
    )
    wide_archive_button.disabled = modal_active or current_destination == DESTINATION_ARCHIVE

func _destination_display_name(destination_id: String) -> String:
    match destination_id:
        DESTINATION_OPERATION:
            return "Operação"
        DESTINATION_MARKET:
            return "Mercado"
        DESTINATION_CITY:
            return "Cidade"
        DESTINATION_INSTITUTIONAL:
            return "Institucional"
        DESTINATION_ARCHIVE:
            return "Arquivo"
        _:
            return destination_id

func _unhandled_input(event: InputEvent) -> void:
    if event.is_action_pressed("ui_cancel") and handle_back_request():
        get_viewport().set_input_as_handled()

func _on_viewport_size_changed() -> void:
    apply_layout_for_size(get_viewport_rect().size)

func _on_overlay_close_pressed() -> void:
    close_overlay()

func _on_operation_pressed() -> void:
    navigate_to(DESTINATION_OPERATION)

func _on_market_pressed() -> void:
    navigate_to(DESTINATION_MARKET)

func _on_city_pressed() -> void:
    navigate_to(DESTINATION_CITY)

func _on_institutional_pressed() -> void:
    navigate_to(DESTINATION_INSTITUTIONAL)

func _on_archive_pressed() -> void:
    navigate_to(DESTINATION_ARCHIVE)


func _on_market_city_requested() -> void:
    navigate_to(DESTINATION_CITY)
