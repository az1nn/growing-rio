extends RefCounted
class_name EndingSelectionService

func select_ending(
    current_ending_id: String,
    requested_ending_id: String,
    eligible_ending_ids: Array,
) -> Dictionary:
    if not current_ending_id.is_empty():
        return {
            "changed": false,
            "selected_ending_id": current_ending_id,
            "message": "Uma família de final já foi registrada.",
        }

    if requested_ending_id.is_empty() or not eligible_ending_ids.has(requested_ending_id):
        return {
            "changed": false,
            "selected_ending_id": current_ending_id,
            "message": "Família de final indisponível.",
        }

    return {
        "changed": true,
        "selected_ending_id": requested_ending_id,
        "message": "Família de final registrada.",
    }
