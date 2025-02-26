extends CharacterBody2D


@onready var sprite = $BarrySprite
@onready var particles = $GPUParticles2D
@onready var bulletspawn = $BulletSpawn

@onready var machineGunAudio = $MachineGunAudio
@onready var laserAudio = $LaserAudio


var idle_sprite = preload("res://resources/sprites/barry-flying-idle.png")
var boost_sprite  = preload("res://resources/sprites/barry-flying-boost.png")
var bullet_scene = preload("res://scenes/bullet/bullet.tscn")

const BOOST_VELOCITY = -2000.0
const SPEED = 300.0

func _ready() -> void:
	pass
	
func _process(_delta: float) -> void:
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
	#if not Globals.game_running:
	#	return FIXME
	velocity += get_gravity()  * delta
	velocity.x = SPEED
	
	if Input.is_action_pressed("boost"):
		velocity.y = clampf(velocity.y + BOOST_VELOCITY * delta, -10000, 10000)
	
	move_and_slide()
	
func _fireBullet() -> void:
	var bullet = bullet_scene.instantiate()
	get_tree().root.add_child(bullet)
	bullet.global_position = bulletspawn.global_position
	if Globals.sound_effects_enabled:
		laserAudio.play()
