extends CanvasLayer


func _on_gui_input(event: InputEvent) -> void:
	if event.is_pressed():
		close_start_screen()

func _unhandled_input(event: InputEvent) -> void:
	if event.is_pressed():
		close_start_screen()
		
func close_start_screen() -> void:
		# TODO Fade the screen to black, fade out the audio, then emit signal to load main menu 
		# TODO Create some kind of scene manager that handles transitions and loading
		Events.emit_signal("start_screen_closed")
