extends Area2D

const SPEED = 1000.0

func _process(delta: float) -> void:
	if not Globals.game_running:
		return;
	position.x += SPEED * delta

func _on_visible_checker_screen_exited() -> void:
		queue_free()

func _on_area_entered(_area: Area2D) -> void:
	# remove bullet if it hits something
	queue_free()
