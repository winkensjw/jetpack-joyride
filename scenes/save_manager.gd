extends Node

const save_location = "user://jetpack_joyride.save"

func _ready() -> void:
	loadData()

func saveData(data : Dictionary) -> void:
	writeSaveFile(data)

func loadData() -> Dictionary:
	return loadSaveFile()
	
func writeSaveFile(data : Dictionary) -> void:
	var save_file = FileAccess.open(save_location, FileAccess.WRITE)
	var json_string = JSON.stringify(data)
	save_file.store_line(json_string)
	
func loadSaveFile() -> Dictionary:
	if not FileAccess.file_exists(save_location):
		return {}
	
	var save_file = FileAccess.open(save_location, FileAccess.READ)
	var json_string = save_file.get_line()
	var json = JSON.new()
	var parse_result = json.parse(json_string)
	if not parse_result == OK:
		print("JSON Parse Error: ", json.get_error_message(), " in ", json_string, " at line ", json.get_error_line())
		return {}
	return json.data
