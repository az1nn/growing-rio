extends "res://scenes/ui/v1/dalata_button.gd"
class_name DalataNavTab

func _ready() -> void:
    role = Role.NAVIGATION_TAB
    toggle_mode = true
    super._ready()
