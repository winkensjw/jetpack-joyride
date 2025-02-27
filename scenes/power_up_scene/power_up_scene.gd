extends CanvasLayer

const POWER_UP_COST = 0

@onready var powerUpButton = $Control/PowerUpButton

func _ready() -> void:
	if Globals.coins < POWER_UP_COST:
		powerUpButton.disabled = true

func _on_power_up_button_pressed() -> void:
	if Globals.coins < POWER_UP_COST:
		return
	Globals.coins -= POWER_UP_COST
	Events.emit_signal("power_up")
	queue_free()
