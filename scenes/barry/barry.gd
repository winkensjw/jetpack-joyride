extends CharacterBody2D


@onready var sprite = $BarrySprite
@onready var particles = $GPUParticles2D
@onready var bulletspawn = $BulletSpawn

@onready var idle_sprite = _loadImageTexture("res://resources/sprites/barry-flying-idle.png")
@onready var boost_sprite  = _loadImageTexture("res://resources/sprites/barry-flying-boost.png")

var bullet_scene = preload("res://scenes/bullet/bullet.tscn")


const BOOST_VELOCITY = -250.0
const SPEED = 100.0

func _ready() -> void:
	pass
	
func _process(_delta: float) -> void:
	if Input.is_action_pressed("boost"):
		sprite.texture = boost_sprite
		particles.emitting = true
	else:
		sprite.texture = idle_sprite
		particles.emitting = false
	
	if Input.is_action_just_pressed("shoot"):
		_fireBullet()

func _physics_process(delta: float) -> void:
	#if not Globals.game_running:
	#	return FIXME
	velocity += get_gravity() * delta
	velocity.x = SPEED
	
	if Input.is_action_pressed("boost"):
		velocity.y = BOOST_VELOCITY
	
	move_and_slide()
	
func _fireBullet() -> void:
	var bullet = bullet_scene.instantiate()
	get_tree().root.add_child(bullet)
	bullet.global_position = bulletspawn.global_position
	
func _loadImageTexture(path:String) -> ImageTexture:
	var image = Image.load_from_file(path)
	return ImageTexture.create_from_image(image)
