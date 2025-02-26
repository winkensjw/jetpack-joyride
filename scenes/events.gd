extends Node

# scene manager
signal load_start(loading_screen)
signal scene_added(loaded_scene:Node,loading_screen)
signal load_complete(loaded_scene:Node)

signal _scene_finished_loading(scene)
signal _scene_invalid(scene_path:String)
signal _scene_failed_to_load(scene_path:String)

# start screen
signal start_screen_closed
