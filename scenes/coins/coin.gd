extends Node2D

const VALUE = 1

@onready var coinAudio = $CoinAudio

func _process(delta: float) -> void:
	#coinAudio.play()
	pass

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("barry"):
		Events.emit_signal("coin_collected", VALUE)
		if Globals.sound_effects_enabled:
			coinAudio.play()
		_queue_free()


func _on_visible_checker_screen_exited() -> void:
	_queue_free()

## wait for sound to be played before freeing the node, else the sound will be
## interruped. Its probably best to have a global audio manager that plays
## sounds, but its too much work to change it this deep into the project
func _queue_free() -> void:
	if coinAudio.playing:
		hide()
		await coinAudio.finished
	queue_free()
	
