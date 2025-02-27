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

# settings
signal settings_window_closed
signal settings_music_changed
signal settings_sound_effects_changed

# game
signal player_died
signal coin_collected(value:int)

# game over
signal continue_game
signal back_to_menu
