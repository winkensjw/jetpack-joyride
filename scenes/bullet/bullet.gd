extends Area2D

const SPEED = 1000.0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.x += SPEED * delta


func _on_visible_checker_screen_exited() -> void:
		queue_free()
