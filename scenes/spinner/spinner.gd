extends Node2D

const ROTATION_SPEED = 1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not Globals.game_running:
		return
	rotation = rotation + ROTATION_SPEED * delta


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("barry"):
		Events.emit_signal("player_died")


func _on_visible_checker_screen_exited() -> void:
	queue_free()
