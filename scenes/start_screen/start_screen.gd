extends CanvasLayer

@onready var start_label = %StartLabel
@onready var menu_coins_label = %MenuCoinsLabel
@onready var settings_dialog = %SettingsDialog
@onready var start_screen_music = $StartScreenMusic

func _ready() -> void:
	updateCoins()
	updateMusic()
	
func _unhandled_input(event: InputEvent) -> void:
	if event.is_pressed():
		close_start_screen()
		
func close_start_screen() -> void:
		# TODO Fade the screen to black, fade out the audio, then emit signal to load main menu 
		# TODO Create some kind of scene manager that handles transitions and loading
		Events.emit_signal("start_screen_closed")

func _on_settings_button_pressed() -> void:
	showSettingsDialog()
		
func showSettingsDialog() -> void:
	settings_dialog.show()

func _on_settings_dialog_settings_cancel_button_pressed() -> void:
	hideSettingsDialog()
	
func hideSettingsDialog() -> void:
	settings_dialog.hide()
	Globals.saveData()

func _on_settings_dialog_settings_music_button_pressed() -> void:
	updateMusic()
		
func updateMusic() -> void:
	var music_enabled = Globals.music_enabled
	var isPlaying = start_screen_music.playing
	if(music_enabled && !isPlaying):
		start_screen_music.play()
	elif(!music_enabled && isPlaying):
		start_screen_music.stop()
		
func updateCoins() -> void:
	menu_coins_label.text = str(Globals.coins)
