extends SceneTree

const OPERATION_DIORAMA := preload("res://scenes/visual/operation_diorama.tscn")

var _activation_context := ""
var _activation_object := ""

func _init() -> void:
    call_deferred("_run")

func _run() -> void:
    var scene = OPERATION_DIORAMA.instantiate()
    root.add_child(scene)
    await process_frame

    var required_paths := [
        "Viewport/World/Camera3D",
        "Viewport/World/WorldEnvironment",
        "Viewport/World/InteractivePlantCluster/CollisionShape3D",
        "Viewport/World/ManagementStorageInteraction/CollisionShape3D",
        "Viewport/World/WorkbenchInteraction/CollisionShape3D",
        "Viewport/World/OperationV1AcceptedRebuild",
        "Viewport/World/OperationV1AcceptedRebuild/AcceptedFloor",
        "Viewport/World/OperationV1AcceptedRebuild/AcceptedBackWall",
        "Viewport/World/OperationV1AcceptedRebuild/AcceptedSideWall",
        "Viewport/World/OperationV1AcceptedRebuild/GardenShelf_02",
        "Viewport/World/OperationV1AcceptedRebuild/GardenLeaf_01_02_03",
        "Viewport/World/OperationV1AcceptedRebuild/WorkbenchTop",
        "Viewport/World/OperationV1AcceptedRebuild/SupplyShelf_03",
        "Viewport/World/OperationV1AcceptedRebuild/SupplyProp_02_03",
        "Viewport/World/OperationV1AcceptedRebuild/CrownBase",
        "Viewport/World/OperationV1AcceptedRebuild/CrownPeakMiddle",
        "Viewport/World/OperationV1AcceptedRebuild/AcceptedShutterField",
        "Viewport/World/OperationV1AcceptedRebuild/GraffitiStrokeCyan",
        "Viewport/World/OperationV1AcceptedRebuild/GraffitiStrokeMagenta",
        "Viewport/World/OperationV1AcceptedRebuild/WorkbenchWarmPool",
        "Viewport/World/OperationV1AcceptedRebuild/FloorPatch_02_03",
        "Viewport/World/OperationV1AcceptedRebuild/PendantLightLeft",
        "ObjectActionButton",
        "ManagementActionButton",
    ]
    for path in required_paths:
        if scene.get_node_or_null(path) == null:
            _fail("Feature 012 R04 structural rebase missing required node: %s" % path)
            return

    if scene.get_node_or_null("Viewport/World/V1ProductionDressing") != null:
        _fail("Feature 012 R04 structural rebase restored rejected additive dressing.")
        return

    var viewport := scene.get_node("Viewport") as SubViewport
    var camera := scene.get_node("Viewport/World/Camera3D") as Camera3D
    if scene.stretch_shrink != 3 or scene.texture_filter != CanvasItem.TEXTURE_FILTER_NEAREST:
        _fail("Feature 012 R04 lost the scene-only nearest-neighbour pixel contract.")
        return
    if viewport.render_target_update_mode != SubViewport.UPDATE_ALWAYS:
        _fail("Feature 012 R04 V1 viewport is not continuously rendering.")
        return
    if camera.projection != Camera3D.PROJECTION_ORTHOGONAL or camera.size < 4.55 or camera.size > 4.85:
        _fail("Feature 012 R04 lost Candidate-5 portrait zoom framing.")
        return
    if camera.position.y < 6.80 or camera.position.y > 7.05:
        _fail("Feature 012 R04 Candidate-5 vertical framing regressed.")
        return

    for legacy_path in [
        "Viewport/World/Floor",
        "Viewport/World/BackWall",
        "Viewport/World/SideWall",
        "Viewport/World/MetalDoor",
        "Viewport/World/CounterTop",
        "Viewport/World/StorageBinMid",
        "Viewport/World/V1GraffitiCrownBase",
    ]:
        var legacy := scene.get_node(legacy_path) as MeshInstance3D
        if legacy.visible:
            _fail("Feature 012 R04 left rejected legacy visual mesh visible: %s" % legacy_path)
            return

    var rebuild := scene.get_node("Viewport/World/OperationV1AcceptedRebuild") as Node3D
    if rebuild.get_child_count() < 188:
        _fail("Feature 012 R04 accepted-concept rebuild regressed below detail floor.")
        return

    var floor := scene.get_node("Viewport/World/OperationV1AcceptedRebuild/AcceptedFloor") as MeshInstance3D
    var floor_mesh := floor.mesh as BoxMesh
    if floor_mesh == null or floor_mesh.size.z > 3.7:
        _fail("Feature 012 R04 foreground floor regressed to long-stage footprint.")
        return

    var wall := scene.get_node("Viewport/World/OperationV1AcceptedRebuild/AcceptedBackWall") as MeshInstance3D
    var crown := scene.get_node("Viewport/World/OperationV1AcceptedRebuild/CrownBase") as MeshInstance3D
    var garden := scene.get_node("Viewport/World/OperationV1AcceptedRebuild/GardenLeaf_01_02_03") as MeshInstance3D
    if not _has_textured_material(wall) or not _has_textured_material(crown) or not _has_textured_material(garden):
        _fail("Feature 012 R04 structural rebase regressed to color-only macro primitives.")
        return
    if not _has_v1_color(crown, "E7AD48") or not _has_v1_color(garden, "536E54"):
        _fail("Feature 012 R04 accepted crown/garden palette contract changed.")
        return

    var shutter := scene.get_node("Viewport/World/OperationV1AcceptedRebuild/AcceptedShutterField") as MeshInstance3D
    var crown_tip_middle := scene.get_node("Viewport/World/OperationV1AcceptedRebuild/CrownTipMiddle") as MeshInstance3D
    var shutter_mesh := shutter.mesh as BoxMesh
    var crown_field := scene.get_node("Viewport/World/OperationV1AcceptedRebuild/CrownField") as MeshInstance3D
    var graffiti_cyan := scene.get_node("Viewport/World/OperationV1AcceptedRebuild/GraffitiStrokeCyan") as MeshInstance3D
    var graffiti_magenta := scene.get_node("Viewport/World/OperationV1AcceptedRebuild/GraffitiStrokeMagenta") as MeshInstance3D
    var crown_peak_middle := scene.get_node("Viewport/World/OperationV1AcceptedRebuild/CrownPeakMiddle") as MeshInstance3D
    var shutter_box := shutter_mesh
    var graffiti_cyan_box := graffiti_cyan.mesh as BoxMesh
    var graffiti_magenta_box := graffiti_magenta.mesh as BoxMesh
    var crown_base_box := crown.mesh as BoxMesh
    var crown_peak_middle_box := crown_peak_middle.mesh as BoxMesh
    var crown_tip_middle_box := crown_tip_middle.mesh as BoxMesh
    # Candidate 8 guards the actual player-visible corridor instead of raw
    # geometry area. The focal field must stay between garden and supply so it
    # cannot be structurally valid while hidden behind either silhouette.
    if shutter.position.x < -0.12 or shutter.position.x > 0.04 or shutter.position.y < 2.40 or shutter.position.y > 2.60:
        _fail("Feature 012 R04 Candidate-8 shutter field drifted out of the exposed back-wall corridor.")
        return
    if shutter_box == null or shutter_box.size.x < 1.30 or shutter_box.size.x > 1.42 or shutter_box.size.y < 1.60:
        _fail("Feature 012 R04 Candidate-8 shutter field lost bounded corridor coverage.")
        return
    var shutter_left_edge := shutter.position.x - shutter_box.size.x * 0.5
    var shutter_right_edge := shutter.position.x + shutter_box.size.x * 0.5
    if shutter_left_edge <= -0.78 or shutter_right_edge >= 0.68:
        _fail("Feature 012 R04 Candidate-8 focal field overlaps garden/supply occlusion zones.")
        return
    if graffiti_cyan_box == null or graffiti_magenta_box == null:
        _fail("Feature 012 R04 Candidate-8 graffiti meshes are missing.")
        return
    if graffiti_cyan_box.size.x * graffiti_cyan_box.size.y < 0.24 or graffiti_magenta_box.size.x * graffiti_magenta_box.size.y < 0.24:
        _fail("Feature 012 R04 Candidate-8 graffiti strokes regressed below portrait-readable area.")
        return
    if absf(graffiti_cyan.position.x) > 0.30 or absf(graffiti_magenta.position.x) > 0.30:
        _fail("Feature 012 R04 Candidate-8 graffiti escaped the unobstructed focal corridor.")
        return
    if crown_base_box == null or crown_base_box.size.x * crown_base_box.size.y < 0.24:
        _fail("Feature 012 R04 Candidate-8 crown base regressed below portrait-readable area.")
        return
    if crown_peak_middle_box == null or crown_peak_middle_box.size.x < 0.19 or crown_peak_middle_box.size.y < 0.82:
        _fail("Feature 012 R04 Candidate-8 crown peak regressed below portrait-readable thickness.")
        return
    if crown_tip_middle_box == null or crown_tip_middle_box.size.x < 0.22 or crown_tip_middle_box.size.y < 0.22:
        _fail("Feature 012 R04 Candidate-8 crown tip regressed below portrait-readable size.")
        return
    if crown.position.x < -0.12 or crown.position.x > 0.04 or crown.position.y < 2.15 or crown.position.y > 2.40 or crown_tip_middle.position.y > 3.10:
        _fail("Feature 012 R04 Candidate-8 crown drifted out of the player-visible wall pocket.")
        return
    if crown.position.z <= crown_field.position.z or graffiti_cyan.position.z <= crown_field.position.z:
        _fail("Feature 012 R04 Candidate-8 crown/graffiti depth order is occluding the focal signature.")
        return
    var crown_material := crown.material_override as StandardMaterial3D
    var crown_field_material := crown_field.material_override as StandardMaterial3D
    if crown_material == null or crown_field_material == null:
        _fail("Feature 012 R04 Candidate-9 focal materials are missing.")
        return
    if crown_material.shading_mode != BaseMaterial3D.SHADING_MODE_UNSHADED or crown_material.emission_enabled:
        _fail("Feature 012 R04 Candidate-9 amber crown color-stability contract regressed.")
        return
    if crown_field_material.shading_mode != BaseMaterial3D.SHADING_MODE_UNSHADED or crown_field_material.emission_enabled:
        _fail("Feature 012 R04 Candidate-9 dark focal field contrast regressed.")
        return
    var pendant_left := scene.get_node("Viewport/World/OperationV1AcceptedRebuild/PendantShadeLeft") as MeshInstance3D
    var pendant_right := scene.get_node("Viewport/World/OperationV1AcceptedRebuild/PendantShadeRight") as MeshInstance3D
    if pendant_left.position.x > -1.20 or pendant_right.position.x < 1.60:
        _fail("Feature 012 R04 Candidate-9 pendants re-entered the crown sightline.")
        return
    if not _has_emissive_material(garden):
        _fail("Feature 012 R04 Candidate-7 garden lost its local foliage separation treatment.")
        return

    var plant_focus := scene.get_node("Viewport/World/InteractivePlantCluster") as Area3D
    var storage_focus := scene.get_node("Viewport/World/ManagementStorageInteraction") as Area3D
    var workbench_focus := scene.get_node("Viewport/World/WorkbenchInteraction") as Area3D
    var expected_plant_focus := Vector3(-1.63, 2.05, -1.82)
    var expected_storage_focus := Vector3(1.50, 1.95, -1.47)
    var expected_workbench_focus := Vector3(0.18, 0.84, -0.20)
    if plant_focus.position.distance_to(expected_plant_focus) > 0.05:
        _fail("Feature 012 R04 plant hotspot drifted away from accepted-rebuild garden.")
        return
    if storage_focus.position.distance_to(expected_storage_focus) > 0.05:
        _fail("Feature 012 R04 management hotspot drifted away from visible accepted-rebuild storage.")
        return
    if workbench_focus.position.distance_to(expected_workbench_focus) > 0.05:
        _fail("Feature 012 R04 workbench hotspot drifted away from center bench.")
        return
    if workbench_focus.position.distance_to(plant_focus.position) < 1.4 or workbench_focus.position.distance_to(storage_focus.position) < 1.4:
        _fail("Feature 012 R04 focal anchors are not spatially distinct.")
        return

    var environment := (scene.get_node("Viewport/World/WorldEnvironment") as WorldEnvironment).environment
    if environment == null or environment.ambient_light_energy < 1.55 or environment.ambient_light_energy > 1.85:
        _fail("Feature 012 R04 Candidate-6 cool ambient hierarchy regressed.")
        return
    var cool_key := scene.get_node("Viewport/World/CoolKey") as DirectionalLight3D
    var warm_practical := scene.get_node("Viewport/World/WarmPractical") as OmniLight3D
    var garden_warm := scene.get_node("Viewport/World/OperationV1AcceptedRebuild/GardenWarmPool") as OmniLight3D
    var workbench_warm := scene.get_node("Viewport/World/OperationV1AcceptedRebuild/WorkbenchWarmPool") as OmniLight3D
    var crown_warm := scene.get_node("Viewport/World/OperationV1AcceptedRebuild/CrownGlow") as OmniLight3D
    if cool_key.light_energy < 0.85:
        _fail("Feature 012 R04 Candidate-7 lost the strengthened cool-night counter-tone.")
        return
    if warm_practical.light_energy > 6.50:
        _fail("Feature 012 R04 Candidate-7 restored global amber flattening.")
        return
    if garden_warm.light_energy < 7.0 or workbench_warm.light_energy < 7.8:
        _fail("Feature 012 R04 Candidate-7 local amber garden/workbench hierarchy regressed.")
        return
    if crown_warm.light_energy < 3.8 or crown_warm.light_energy > 4.8:
        _fail("Feature 012 R04 Candidate-9 crown halo escaped its bounded contrast range.")
        return
    if not scene.has_pointer_interaction() or not scene.has_secondary_pointer_interaction() or not scene.has_workbench_pointer_interaction():
        _fail("Feature 012 R04 lost pointer/touch hotspot picking.")
        return
    if not scene.has_accessible_button_fallback() or not scene.has_secondary_accessible_button_fallback():
        _fail("Feature 012 R04 lost accessible hotspot fallback.")
        return

    scene.object_activated.connect(_on_object_activated)
    scene.activate_primary_object()
    await process_frame
    if _activation_context != "operation" or _activation_object != "plant_cluster":
        _fail("Feature 012 R04 primary activation contract changed.")
        return

    _activation_context = ""
    _activation_object = ""
    scene.activate_management_object()
    await process_frame
    if _activation_context != "operation" or _activation_object != "management_storage":
        _fail("Feature 012 R04 management activation contract changed.")
        return

    var source := FileAccess.get_file_as_string("res://scenes/visual/operation_diorama.gd")
    for forbidden in ["/root/GameState", "care_for_room(", "harvest(", "next_day("]:
        if source.contains(forbidden):
            _fail("Feature 012 R04 visual diorama gained forbidden domain reference: %s" % forbidden)
            return

    print("OPERATION V1 STRUCTURAL REBASE TEST PASSED")
    quit(0)

func _has_textured_material(mesh: MeshInstance3D) -> bool:
    var material := mesh.material_override as StandardMaterial3D
    return material != null and material.albedo_texture != null

func _has_emissive_material(mesh: MeshInstance3D) -> bool:
    var material := mesh.material_override as StandardMaterial3D
    return material != null and material.emission_enabled and material.emission_energy_multiplier >= 0.55


func _has_v1_color(mesh: MeshInstance3D, expected_hex: String) -> bool:
    var material := mesh.material_override as StandardMaterial3D
    if material == null:
        return false
    return material.albedo_color.to_html(false).to_upper() == expected_hex

func _on_object_activated(context_id: String, object_id: String) -> void:
    _activation_context = context_id
    _activation_object = object_id

func _fail(message: String) -> void:
    push_error(message)
    quit(1)
