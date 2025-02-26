extends Node2D

var enemy_scene = load("res://scenes/enemy/enemy.tscn")
var spinner_scene = load("res://scenes/spinner/spinner.tscn")

@onready var player = get_tree().get_first_node_in_group("barry")
@onready var scorelabel = %Label;
@onready var coinslabel = %CoinsLabel;

func _process(delta: float) -> void:
	update_distance()
	update_coins(0)
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Events.connect("player_died", Callable(self, "_on_player_died"))
	Globals.game_running = true
	_spawn_enemy()
	
func _on_player_died() -> void:
	Globals.game_running = false


func _on_enemy_spawn_timer_timeout() -> void:
	if not Globals.game_running:
		return
	_spawn_enemy()

func _spawn_enemy() -> void:
	if randi_range(0, 100) < 80:
		return
	var enemy = enemy_scene.instantiate()
	enemy.position.x = player.position.x + 1280
	enemy .position.y = randi() % 30 + 640
	get_tree().get_first_node_in_group("enemies").add_child(enemy)
	enemy.add_to_group("enemies")

func _on_spinner_spawn_timer_timeout() -> void:
	if not Globals.game_running:
		return
	_spawn_spinner()

func _spawn_spinner() -> void:
	if randi_range(0, 100) < 10:
		return
	var spinner = spinner_scene.instantiate()
	spinner.position.x = player.position.x + 1280
	spinner.position.y = randi() % 350 + 150
	get_tree().get_first_node_in_group("obstacles").add_child(spinner)
	spinner.add_to_group("obstacles")

func update_distance() -> void:
	Globals.distance = int(player.global_position.x / 150)
	scorelabel.text = "Score:" + str(Globals.distance) + "m"

func update_coins(value : int) -> void:
	Globals.coins += value
	coinslabel.text = "Coins:"  + str(Globals.coins)
