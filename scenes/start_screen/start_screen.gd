extends CanvasLayer

@onready var start_label = %StartLabel
@onready var menu_coins_label = %MenuCoinsLabel
@onready var settings_dialog = %SettingsDialog

func _ready() -> void:
	Events.connect("settings_window_closed", Callable(self, "hideSettingsDialog"))
	updateCoins()
	
func _unhandled_input(event: InputEvent) -> void:
	if event.is_pressed():
		close_start_screen()
		
func close_start_screen() -> void:
		Events.emit_signal("start_screen_closed")

func _on_settings_button_pressed() -> void:
	showSettingsDialog()
		
func showSettingsDialog() -> void:
	settings_dialog.show()
	
func hideSettingsDialog() -> void:
	settings_dialog.hide()
	Globals.saveData()
		
func updateCoins() -> void:
	menu_coins_label.text = str(Globals.coins)
