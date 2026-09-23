class_name BuyerDefinition
extends Resource

@export var id: StringName = &""
@export var display_name: String = ""
@export_enum("Licensed", "Parallel") var channel: int = 0
@export var base_unit_price: float = 18.0
@export var quality_unit_bonus: float = 18.0
@export var reputation_flat: float = 0.0
@export var reputation_quality_bonus: float = 0.0
@export var influence_delta: float = 0.0
@export var heat_flat: float = 0.0
@export var heat_per_unit: float = 0.0

@export var contract_id: StringName = &""
@export_range(0, 1000, 1) var contract_units: int = 0
@export_range(0.0, 1.0, 0.01) var contract_min_quality: float = 0.0
@export_range(0, 100000, 1) var contract_cash_bonus: int = 0
@export_range(0.0, 100.0, 1.0) var contract_relationship_gain: float = 0.0
@export_range(0.0, 10.0, 0.1) var relationship_unit_bonus_per_10: float = 0.0
