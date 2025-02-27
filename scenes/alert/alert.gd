extends Node2D

@onready var sprite = $Sprite2D

func _ready() -> void:
	var tween = get_tree().create_tween()
	tween.set_loops(3)
	tween.tween_interval(0.1)
	tween.tween_callback(sprite.hide)
	tween.tween_interval(0.1)
	tween.tween_callback(sprite.show)
	
	tween.finished.connect(_on_alert_animation_finished)

func _on_alert_animation_finished() -> void:
	var tween = get_tree().create_tween()
	tween.tween_interval(1)
	tween.tween_callback(queue_free)
