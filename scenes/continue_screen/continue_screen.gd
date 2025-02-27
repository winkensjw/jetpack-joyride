extends CanvasLayer

const CONTINUE_COST = 150

@onready var continueButton = $ContinueScreen/ContinueButton

func _ready() -> void:
	if Globals.coins < CONTINUE_COST:
		continueButton.disabled = true

func _on_continue_button_pressed() -> void:
	if Globals.coins < CONTINUE_COST:
		return
	Globals.coins -= CONTINUE_COST
	Events.emit_signal("continue_game")
	queue_free()


func _on_back_to_menu_button_pressed() -> void:
	Events.emit_signal("back_to_menu")
	queue_free()
