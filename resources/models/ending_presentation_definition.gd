extends Resource
class_name EndingPresentationDefinition

@export var id: StringName
@export var display_name: String
@export_multiline var handoff_text: String
@export_multiline var coda_text: String
@export var canon_guardrails: PackedStringArray = []
