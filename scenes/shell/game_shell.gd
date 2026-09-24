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

@onready var operation_button: Button = %OperationButton
@onready var market_button: Button = %MarketButton
@onready var city_button: Button = %CityButton
@onready var institutional_button: Button = %InstitutionalButton
@onready var archive_button: Button = %ArchiveButton

var current_destination := DESTINATION_OPERATION

func _ready() -> void:
    game_state.state_changed.connect(_refresh_global_status)
    _refresh_global_status()
    _apply_destination()

func destination_ids() -> Array:
    return DESTINATION_IDS.duplicate()

func navigate_to(destination_id: String) -> bool:
    if not DESTINATION_IDS.has(destination_id):
        return false
    if current_destination == destination_id:
        return true

    current_destination = destination_id
    _apply_destination()
    return true

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

    operation_button.disabled = operation_surface.visible
    market_button.disabled = market_surface.visible
    city_button.disabled = city_surface.visible
    institutional_button.disabled = institutional_surface.visible
    archive_button.disabled = archive_surface.visible

    destination_label.text = _destination_display_name(current_destination)

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
