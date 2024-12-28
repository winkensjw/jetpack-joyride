extends Node

var game_running = false
var sound_effects_enabled = true
var music_enabled = true

var distance = 0
var best_distance = 0
var coins = 0

func _ready() -> void:
	loadData()

func saveData() -> void:
	SaveManager.saveData(exportData())

func loadData() -> void:
	importData(SaveManager.loadData())

func exportData() -> Dictionary:
	return {
		"best_distance": best_distance,
		"coins": coins,
		"sound_effects_enabled": sound_effects_enabled,
		"music_enabled": music_enabled
	}
	
func importData(data : Dictionary) -> void:
	if data.is_empty():
		print("No data to import")
		return
	best_distance = data["best_distance"]
	coins = data["coins"]
	sound_effects_enabled = data["sound_effects_enabled"]
	music_enabled = data["music_enabled"]
