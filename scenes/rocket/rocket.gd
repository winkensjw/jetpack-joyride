extends Node2D

@onready var rocketAudio = $RocketAudio
@onready var rocketSprite = $RocketSprite
@onready var rocketCollisionArea = $Area2D
@onready var rocketParticles = $GPUParticles2D

const MOVE_SPEED = -400

func _ready() -> void:
	if Globals.sound_effects_enabled:
			rocketAudio.play()

func _process(delta: float) -> void:
	if not Globals.game_running:
		return
	position.x = position.x + MOVE_SPEED * delta


func _on_visible_checker_screen_exited() -> void:
	_queue_free(true)


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("barry"):
		Events.emit_signal("player_died")


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("bullets"):
		_queue_free(false)

func _queue_free(fade: bool) -> void:
	rocketSprite.hide()
	rocketCollisionArea.set_deferred("monitoring", false)
	rocketParticles.emitting = false
	var tween = get_tree().create_tween()
	if fade:
		tween.tween_property(rocketAudio, "volume_db", 0, 2)
	else:
		rocketAudio.stop()
		tween.tween_interval(2)
	tween.tween_interval(3 if fade else 5)
	tween.tween_callback(rocketAudio.queue_free)
