extends Resource
class_name ResearchStepDefinition

@export var id: StringName
@export var display_name: String
@export var unlock_after_event_id: StringName
@export var required_flags: PackedStringArray = []
@export var forbidden_flags: PackedStringArray = []
@export var completion_flags: PackedStringArray = []
@export var evidence_tags: PackedStringArray = []
@export var system_signals: PackedStringArray = []
@export var canon_guardrails: PackedStringArray = []
