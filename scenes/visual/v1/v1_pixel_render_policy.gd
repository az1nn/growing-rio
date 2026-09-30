class_name V1PixelRenderPolicy
extends RefCounted

## Shared ARTIST V1 scene-only pixel rendering policy.
##
## The 3D scene is rendered inside its existing SubViewport at a reduced
## internal resolution, then upscaled by the SubViewportContainer with
## nearest filtering. UI remains outside this boundary at full resolution.
const DEFAULT_SHRINK := 2
const MIN_SHRINK := 1
const MAX_SHRINK := 4

static func apply(
    container: SubViewportContainer,
    viewport: SubViewport,
    shrink: int = DEFAULT_SHRINK,
) -> void:
    assert(container != null)
    assert(viewport != null)

    var normalized_shrink := clampi(shrink, MIN_SHRINK, MAX_SHRINK)
    container.stretch = true
    container.stretch_shrink = normalized_shrink
    container.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
    viewport.render_target_update_mode = SubViewport.UPDATE_ALWAYS

static func internal_size(container_size: Vector2, shrink: int = DEFAULT_SHRINK) -> Vector2i:
    var normalized_shrink := clampi(shrink, MIN_SHRINK, MAX_SHRINK)
    return Vector2i(
        maxi(1, int(floor(container_size.x / normalized_shrink))),
        maxi(1, int(floor(container_size.y / normalized_shrink))),
    )
