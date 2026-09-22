extends SceneTree

const ECONOMY_SERVICE := preload("res://domain/economy/economy_service.gd")
const LICENSED_BUYER := preload("res://resources/buyers/varejista_licenciado.tres")
const PARALLEL_BUYER := preload("res://resources/buyers/rede_paralela.tres")

func _init() -> void:
    call_deferred("_run")

func _run() -> void:
    var service := ECONOMY_SERVICE.new()

    var empty: Dictionary = service.resolve_sale(0, 0.4, LICENSED_BUYER)
    if empty["changed"] or empty["message"] != "Não há estoque disponível.":
        _fail("Empty inventory guard changed.")
        return

    var licensed: Dictionary = service.resolve_sale(10, 0.4, LICENSED_BUYER)
    if not _valid_sale(licensed):
        _fail("Licensed sale did not resolve.")
        return
    if licensed["cash_delta"] != 250:
        _fail("Licensed revenue regression.")
        return
    if not is_equal_approx(licensed["reputation_delta"], 6.6):
        _fail("Licensed reputation regression.")
        return
    if not is_equal_approx(licensed["influence_delta"], 1.0):
        _fail("Licensed influence regression.")
        return
    if not is_equal_approx(licensed["heat_delta"], -2.0):
        _fail("Licensed heat regression.")
        return

    var parallel: Dictionary = service.resolve_sale(10, 0.4, PARALLEL_BUYER)
    if not _valid_sale(parallel):
        _fail("Parallel sale did not resolve.")
        return
    if parallel["cash_delta"] != 370:
        _fail("Parallel revenue regression.")
        return
    if not is_equal_approx(parallel["reputation_delta"], -1.0):
        _fail("Parallel reputation regression.")
        return
    if not is_equal_approx(parallel["influence_delta"], 0.0):
        _fail("Parallel influence regression.")
        return
    if not is_equal_approx(parallel["heat_delta"], 16.0):
        _fail("Parallel heat regression.")
        return

    print("ECONOMY SERVICE TEST PASSED")
    quit(0)

func _valid_sale(result: Dictionary) -> bool:
    return (
        result["changed"]
        and result["inventory"] == 0
        and is_equal_approx(result["batch_quality"], 0.0)
    )

func _fail(message: String) -> void:
    push_error(message)
    quit(1)
