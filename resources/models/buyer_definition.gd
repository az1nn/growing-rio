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
