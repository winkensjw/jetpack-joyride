extends Node2D

var enemy_scene = preload("res://scenes/enemy/enemy.tscn")
var spinner_scene = preload("res://scenes/spinner/spinner.tscn")
var coin_group_scene = preload("res://scenes/coins/coin_group.tscn")
var alert_scene = preload("res://scenes/alert/alert.tscn")
var rocket_scene = preload("res://scenes/rocket/rocket.tscn")
var continue_screen_scene = preload("res://scenes/continue_screen/continue_screen.tscn")

@onready var player = get_tree().get_first_node_in_group("barry")
@onready var currentlabel = %CurrentLabel;
@onready var bestlabel = %BestLabel;
@onready var coinslabel = %CoinLabel;
@onready var ui_canvas = %UI;

func _process(_delta: float) -> void:
	update_distance()
	update_best()
	update_coins(0)
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Events.connect("player_died", Callable(self, "_on_player_died"))
	Events.connect("coin_collected", Callable(self, "_on_coin_collected"))
	Events.connect("continue_game", Callable(self, "_on_continue_game"))
	Globals.game_running = true
	
func _on_player_died() -> void:
	Globals.game_running = false
	if Globals.distance > Globals.best_distance:
		Globals.best_distance = Globals.distance
	Globals.saveData()
	var continue_screen = continue_screen_scene.instantiate()
	get_tree().root.add_child(continue_screen)

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
	if randi_range(0, 100) < 25:
		return
	var spinner = spinner_scene.instantiate()
	spinner.position.x = player.position.x + 1280
	spinner.position.y = randi() % 350 + 150
	get_tree().get_first_node_in_group("obstacles").add_child(spinner)
	spinner.add_to_group("obstacles")

func update_distance() -> void:
	Globals.distance = int(player.global_position.x / 150)
	currentlabel.text = str(Globals.distance) + "m"

func update_best() -> void:
	bestlabel.text = str(Globals.best_distance) + "m"

func _on_coin_collected(value : int) -> void:
	update_coins(value)
	
func update_coins(value : int) -> void:
	Globals.coins += value
	coinslabel.text = str(Globals.coins)

func _on_coin_spawn_timer_timeout() -> void:
	if not Globals.game_running:
		return
	_spawn_coins()

func _spawn_coins() -> void:
	if randi_range(0, 100) < 30:
		return
	var coin_group = coin_group_scene.instantiate()
	coin_group.position.x = player.position.x + 1280
	coin_group.position.y = randi() % 350 + 150
	get_tree().get_first_node_in_group("coins").add_child(coin_group)
	coin_group.add_to_group("coins")

func _on_rocket_spawn_timer_timeout() -> void:
	if not Globals.game_running:
		return
	_spawn_rocket()

func _spawn_rocket() -> void:
	if randi_range(0, 100) < 50:
		return
	var rocket_y = randi() % 350 + 150
	
	var alert = alert_scene.instantiate()
	alert.position.x = 1200
	alert.position.y =  rocket_y
	ui_canvas.add_child(alert)
	
	await get_tree().create_tween().tween_interval(1.5).finished
	
	var rocket = rocket_scene.instantiate()
	rocket.position.x = player.position.x + 1280
	rocket.position.y = rocket_y
	get_tree().get_first_node_in_group("enemies").add_child(rocket)
	rocket.add_to_group("enemies")
	
func _on_continue_game() -> void:
	_remove_all_childs_from_group("enemies")
	_remove_all_childs_from_group("obstacles")
	_remove_all_childs_from_group("bullets")
	_remove_all_childs_from_group("coins")
	Globals.game_running = true
	
func _remove_all_childs_from_group(group : String) -> void:
	for nodes in get_tree().get_first_node_in_group(group).get_children():
		nodes.queue_free()
