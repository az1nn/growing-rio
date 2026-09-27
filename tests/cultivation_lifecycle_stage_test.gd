extends SceneTree

const CULTIVATION_SERVICE_SCRIPT := preload("res://domain/cultivation/cultivation_service.gd")

func _init() -> void:
    call_deferred("_run")

func _run() -> void:
    var service := CULTIVATION_SERVICE_SCRIPT.new()
    var cases: Array[Dictionary] = [
        {"day": -4, "expected": &"seedling"},
        {"day": 0, "expected": &"seedling"},
        {"day": 21, "expected": &"seedling"},
        {"day": 22, "expected": &"Vega"},
        {"day": 44, "expected": &"Vega"},
        {"day": 45, "expected": &"flora"},
        {"day": 67, "expected": &"flora"},
        {"day": 68, "expected": &"late flowering"},
        {"day": 89, "expected": &"late flowering"},
        {"day": 90, "expected": &"pronta"},
        {"day": 120, "expected": &"pronta"},
    ]

    for entry in cases:
        var day := int(entry["day"])
        var expected := StringName(entry["expected"])
        var actual := service.lifecycle_stage(day, 90)
        if actual != expected:
            _fail("Day %d expected %s but got %s." % [day, expected, actual])
            return

        for repeat in range(8):
            if service.lifecycle_stage(day, 90) != actual:
                _fail("Lifecycle derivation is not deterministic at day %d." % day)
                return

    if service.lifecycle_stage(29, 30) != &"Vega":
        _fail("Noncanonical cycle readiness changed before cycle completion.")
        return
    if service.lifecycle_stage(30, 30) != &"pronta":
        _fail("Lifecycle did not become pronta at cycle completion.")
        return

    print("CULTIVATION LIFECYCLE STAGE TEST PASSED")
    quit(0)

func _fail(message: String) -> void:
    push_error(message)
    quit(1)
