extends RefCounted

const STORAGE_VERSION := 1
const DEFAULT_SLOT_ID := "campaign-1"
const DEFAULT_ROOT_DIR := "user://campaigns"

var root_dir := DEFAULT_ROOT_DIR

func _init(root_directory: String = DEFAULT_ROOT_DIR) -> void:
    root_dir = root_directory.trim_suffix("/")

func has_slot(slot_id: String = DEFAULT_SLOT_ID) -> bool:
    var path := slot_path(slot_id)
    return not path.is_empty() and FileAccess.file_exists(path)

func slot_path(slot_id: String = DEFAULT_SLOT_ID) -> String:
    var normalized := _normalized_slot_id(slot_id)
    if normalized.is_empty():
        return ""
    return "%s/%s.json" % [root_dir, normalized]

func save_slot(
    payload: Dictionary,
    slot_id: String = DEFAULT_SLOT_ID,
) -> Dictionary:
    var normalized := _normalized_slot_id(slot_id)
    if normalized.is_empty():
        return _error("Identificador de campanha inválido.")

    var directory_error := DirAccess.make_dir_recursive_absolute(
        ProjectSettings.globalize_path(root_dir)
    )
    if directory_error != OK:
        return _error("Não foi possível preparar o armazenamento local.")

    var path := slot_path(normalized)
    var file := FileAccess.open(path, FileAccess.WRITE)
    if file == null:
        return _error("Não foi possível abrir o slot para gravação.")

    var envelope := {
        "storage_version": STORAGE_VERSION,
        "slot_id": normalized,
        "payload": payload.duplicate(true),
    }
    file.store_string(JSON.stringify(envelope, "", true, true))
    var write_error := file.get_error()
    file.close()

    if write_error != OK:
        return _error("Falha ao gravar a campanha no armazenamento local.")

    return {
        "ok": true,
        "slot_id": normalized,
    }

func load_slot(slot_id: String = DEFAULT_SLOT_ID) -> Dictionary:
    var normalized := _normalized_slot_id(slot_id)
    if normalized.is_empty():
        return _error("Identificador de campanha inválido.")

    var path := slot_path(normalized)
    if not FileAccess.file_exists(path):
        return _error("Nenhuma campanha salva foi encontrada.")

    var file := FileAccess.open(path, FileAccess.READ)
    if file == null:
        return _error("Não foi possível abrir a campanha salva.")

    var source := file.get_as_text()
    var read_error := file.get_error()
    file.close()
    if read_error != OK:
        return _error("Falha ao ler a campanha salva.")

    var parsed = JSON.parse_string(source)
    if typeof(parsed) != TYPE_DICTIONARY:
        return _error("Arquivo de campanha corrompido ou JSON inválido.")

    var envelope: Dictionary = parsed
    if int(envelope.get("storage_version", -1)) != STORAGE_VERSION:
        return _error("Formato de armazenamento da campanha não suportado.")
    if String(envelope.get("slot_id", "")) != normalized:
        return _error("Metadados do slot de campanha são inválidos.")
    if typeof(envelope.get("payload")) != TYPE_DICTIONARY:
        return _error("Payload da campanha salva é inválido.")

    return {
        "ok": true,
        "slot_id": normalized,
        "payload": Dictionary(envelope["payload"]).duplicate(true),
    }

func delete_slot(slot_id: String = DEFAULT_SLOT_ID) -> Dictionary:
    var normalized := _normalized_slot_id(slot_id)
    if normalized.is_empty():
        return _error("Identificador de campanha inválido.")

    var path := slot_path(normalized)
    if not FileAccess.file_exists(path):
        return {
            "ok": true,
            "slot_id": normalized,
        }

    var remove_error := DirAccess.remove_absolute(
        ProjectSettings.globalize_path(path)
    )
    if remove_error != OK:
        return _error("Não foi possível remover a campanha salva.")

    return {
        "ok": true,
        "slot_id": normalized,
    }

func _normalized_slot_id(slot_id: String) -> String:
    var normalized := slot_id.strip_edges()
    if normalized.is_empty():
        return ""
    if normalized.validate_filename() != normalized:
        return ""
    return normalized

func _error(message: String) -> Dictionary:
    return {
        "ok": false,
        "error": message,
    }
