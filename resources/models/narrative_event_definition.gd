extends Resource
class_name NarrativeEventDefinition

@export var id: StringName
@export var arc_id: StringName
@export var dialogue_key: StringName
@export var unlock_after_arc_id: StringName
@export var required_flags: PackedStringArray = []
@export var forbidden_flags: PackedStringArray = []
@export var participants: PackedStringArray = []
@export var choice_ids: PackedStringArray = []
@export var choice_flags: Dictionary = {}
@export var relationship_effects: Dictionary = {}
@export var system_signals: Dictionary = {}
@export var lore_assertions: PackedStringArray = []
@export var canon_guardrails: PackedStringArray = []
