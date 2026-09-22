class_name CultivarDefinition
extends Resource

@export var id: StringName = &""
@export var display_name: String = ""
@export_range(1, 60, 1) var cycle_days: int = 8
@export_range(0.5, 2.0, 0.01) var yield_scale: float = 1.0
@export_range(-0.20, 0.20, 0.01) var health_bias: float = 0.0
