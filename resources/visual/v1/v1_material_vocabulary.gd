class_name V1MaterialVocabulary
extends RefCounted

const VOCABULARY_PATH := "res://resources/visual/v1/material-vocabulary.json"

static func load_vocabulary() -> Dictionary:
    var file := FileAccess.open(VOCABULARY_PATH, FileAccess.READ)
    assert(file != null)
    var parsed = JSON.parse_string(file.get_as_text())
    assert(parsed is Dictionary)
    return parsed as Dictionary

static func make_standard(role: StringName) -> StandardMaterial3D:
    var vocabulary := load_vocabulary()
    var roles: Dictionary = vocabulary["roles"]
    var key := String(role)
    assert(roles.has(key))

    var spec: Dictionary = roles[key]
    var material := StandardMaterial3D.new()
    material.albedo_color = Color.from_string(String(spec["albedo"]), Color.WHITE)
    material.roughness = float(spec.get("roughness", 0.9))
    material.metallic = float(spec.get("metallic", 0.0))
    if spec.has("emission"):
        material.emission_enabled = true
        material.emission = Color.from_string(String(spec["emission"]), material.albedo_color)
        material.emission_energy_multiplier = float(spec.get("emission_energy", 1.0))
    return material
