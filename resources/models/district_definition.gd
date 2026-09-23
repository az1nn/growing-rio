class_name DistrictDefinition
extends Resource

@export var id: StringName = &""
@export var display_name: String = ""
@export_range(0.0, 100.0, 1.0) var base_demand: float = 50.0
@export_range(0.0, 0.5, 0.01) var max_price_modifier: float = 0.15
@export_range(0, 20, 1) var demand_phase_offset: int = 0
