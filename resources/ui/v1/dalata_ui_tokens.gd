extends RefCounted
class_name DalataUITokens

const SPACE_1 := 4
const SPACE_2 := 8
const SPACE_3 := 12
const SPACE_4 := 16
const SPACE_5 := 20
const SPACE_6 := 24
const SPACE_8 := 32

const TOUCH_TARGET_MIN := 48
const BUTTON_HEIGHT := 52
const NAV_HEIGHT := 56
const BORDER_WIDTH := 2
const FOCUS_BORDER_WIDTH := 3
const CORNER_RADIUS := 2

const INK_950 := Color(0.027, 0.031, 0.031, 0.98)
const INK_800 := Color(0.082, 0.094, 0.091, 0.98)
const TEXT_PRIMARY := Color(0.94, 0.92, 0.84, 1.0)
const TEXT_MUTED := Color(0.63, 0.67, 0.62, 1.0)
const AMBER_PRIMARY := Color(0.95, 0.61, 0.17, 1.0)
const CYAN_SYSTEM := Color(0.18, 0.78, 0.84, 1.0)
const TEAL_SECONDARY := Color(0.14, 0.48, 0.45, 1.0)
const MAGENTA_EVENT := Color(0.86, 0.23, 0.52, 1.0)
const OXIDE_RISK := Color(0.82, 0.28, 0.16, 1.0)
const LOCKED_GREY := Color(0.37, 0.40, 0.38, 1.0)

static func role_palette(role: int) -> Dictionary:
    match role:
        0:
            return {
                "surface": AMBER_PRIMARY,
                "surface_hover": AMBER_PRIMARY.lightened(0.10),
                "border": Color(0.18, 0.13, 0.07, 1.0),
                "text": Color(0.08, 0.07, 0.05, 1.0),
            }
        2:
            return {
                "surface": INK_950,
                "surface_hover": INK_800,
                "border": CYAN_SYSTEM,
                "text": TEXT_PRIMARY,
            }
        3:
            return {
                "surface": INK_950,
                "surface_hover": INK_800,
                "border": OXIDE_RISK,
                "text": TEXT_PRIMARY,
            }
        4:
            return {
                "surface": INK_950,
                "surface_hover": INK_800,
                "border": CYAN_SYSTEM,
                "text": TEXT_PRIMARY,
            }
        _:
            return {
                "surface": INK_950,
                "surface_hover": INK_800,
                "border": TEAL_SECONDARY,
                "text": TEXT_PRIMARY,
            }
