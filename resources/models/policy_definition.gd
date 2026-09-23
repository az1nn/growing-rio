extends Resource
class_name PolicyDefinition

@export var id: StringName
@export var display_name: String
@export_range(0, 2, 1) var required_institution_level := 0
@export_range(0, 3, 1) var min_compliance_level := 0
@export_range(0, 1000, 1) var cash_cost := 0
@export_range(0.0, 100.0, 0.5) var influence_cost := 0.0
@export_range(0.0, 100.0, 0.5) var reputation_gain := 0.0
@export_range(-100.0, 100.0, 0.5) var heat_delta := 0.0
