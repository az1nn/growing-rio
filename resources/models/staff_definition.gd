class_name StaffDefinition
extends Resource

@export var id: StringName = &""
@export var display_name: String = ""
@export_multiline var description: String = ""
@export_range(0, 100000, 1) var hire_cost: int = 0
@export_range(0, 10000, 1) var daily_cost: int = 0
@export_range(-0.20, 0.20, 0.01) var health_stability_delta: float = 0.0
