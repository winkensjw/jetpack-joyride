extends Node2D

@onready var move_speed = -50-(randi() % 150)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not Globals.game_running:
		return
	position.x = position.x + move_speed * delta

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("barry"):
		Events.emit_signal("player_died")


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("bullets"):
		queue_free()

func _on_visible_checker_screen_exited() -> void:
	queue_free()
