extends CharacterBody2D


@onready var sprite = $BarrySprite
@onready var collider = $CollisionShape2D
@onready var particles = $GPUParticles2D
@onready var bulletspawn = $BulletSpawn

@onready var machineGunAudio = $MachineGunAudio
@onready var laserAudio = $LaserAudio


var idle_sprite = preload("res://resources/sprites/barry-flying-idle.png")
var boost_sprite  = preload("res://resources/sprites/barry-flying-boost.png")
var bullet_scene = preload("res://scenes/bullet/bullet.tscn")

const BOOST_VELOCITY = -2500.0
const SPEED = 600.0
const POWER_UP_SPEED = 20000.0

var current_speed = SPEED
var is_power_up_mode = false

func _ready() -> void:
	Events.connect("power_up", Callable(self, "_on_power_up"))
	
func _process(_delta: float) -> void:
	if not Globals.game_running:
		machineGunAudio.stop()
		particles.emitting = false
		return
	if Input.is_action_pressed("boost"):
		sprite.texture = boost_sprite
		particles.emitting = true
		if not machineGunAudio.playing and Globals.sound_effects_enabled:
			machineGunAudio.play()
	else:
		sprite.texture = idle_sprite
		particles.emitting = false
		machineGunAudio.stop()
	
	if Input.is_action_just_pressed("shoot"):
		_fireBullet()

func _physics_process(delta: float) -> void:
	if not Globals.game_running:
		return
	velocity.x = current_speed
	
	if not is_power_up_mode:
		velocity += get_gravity()  * delta
		if Input.is_action_pressed("boost"):
			velocity.y = clampf(velocity.y + BOOST_VELOCITY * delta, -10000, 10000)
	else:
		velocity.y = 0
	
	move_and_slide()
	
func _fireBullet() -> void:
	if is_power_up_mode:
		return
	var bullet = bullet_scene.instantiate()
	get_tree().get_first_node_in_group("bullets").add_child(bullet)
	bullet.add_to_group("bullets")
	bullet.global_position = bulletspawn.global_position
	if Globals.sound_effects_enabled:
		laserAudio.play()

func _on_power_up() -> void:
	#collider.set_deferred("monitorable", false)
	#collider.set_deferred("monitoring", false)
	collider.set_deferred("disabled", true)
	is_power_up_mode = true
	current_speed = POWER_UP_SPEED
	await get_tree().create_tween().tween_interval(5).finished
	is_power_up_mode = false
	current_speed = SPEED
	await get_tree().create_tween().tween_interval(1.5).finished
	collider.set_deferred("disabled", false)
	
