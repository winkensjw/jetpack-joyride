extends Node2D

@onready var start_screen = preload("res://scenes/start_screen/start_screen.tscn")
# is there some kind of bean manager to hold these references without the hassle?
var start_screen_instance

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Events.connect("start_screen_closed", Callable(self, "_on_start_screen_closed"))
	start_screen_instance = start_screen.instantiate()
	add_child(start_screen_instance)

func _on_start_screen_closed() -> void:
	start_screen_instance.queue_free()
