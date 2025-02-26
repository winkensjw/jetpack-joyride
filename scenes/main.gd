extends Node2D

@onready var background_music = $BackgroundMusic

var current_scene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Events.connect("load_complete", Callable(self, "_on_scene_changed"))
	Events.connect("start_screen_closed", Callable(self, "_on_start_screen_closed"))
	Events.connect("settings_music_changed", Callable(self, "updateMusic"))
	updateMusic()
	# call this deferred as root node is not ready yet and scene manager is adding to that node
	call_deferred("_add_start_screne")
	
func _add_start_screne() -> void:
	SceneManager.change_scenes("res://scenes/start_screen/start_screen.tscn", self, null, "no_transition")
	
func _on_scene_changed(loaded_scene:Node) -> void:
	current_scene = loaded_scene

func _on_start_screen_closed() -> void:
	SceneManager.change_scenes("res://scenes/game/game.tscn", self, current_scene)
	
func updateMusic() -> void:
	var music_enabled = Globals.music_enabled
	var isPlaying = background_music.playing
	if(music_enabled && !isPlaying):
		background_music.play()
	elif(!music_enabled && isPlaying):
		background_music.stop()
