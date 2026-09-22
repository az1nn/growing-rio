class_name UpgradeDefinition
extends Resource

@export var id: StringName = &""
@export var display_name: String = ""
@export_multiline var description: String = ""
@export var cost: int = 0
@export_range(-0.20, 0.20, 0.01) var health_stability_delta: float = 0.0
@export var daily_upkeep_delta: int = 0
