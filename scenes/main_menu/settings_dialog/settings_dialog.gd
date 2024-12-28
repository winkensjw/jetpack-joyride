extends Control

signal settings_cancel_button_pressed
signal settings_music_button_pressed
signal settings_sound_effect_button_pressed

@onready var musicButton = %MusicButton
@onready var soundEffectsButton = %SoundEffectsButton

func _ready() -> void:
	updateButtonLabel(musicButton, Globals.music_enabled)
	updateButtonLabel(soundEffectsButton, Globals.sound_effects_enabled)

func _on_close_button_pressed() -> void:
	emit_signal("settings_cancel_button_pressed")


func _on_music_button_pressed() -> void:
	Globals.music_enabled = !Globals.music_enabled
	updateButtonLabel(musicButton, Globals.music_enabled)
	emit_signal("settings_music_button_pressed")

func updateButtonLabel(button : Button, value : bool) -> void:
	button.text = "On" if value else "Off"

func _on_sound_effects_button_pressed() -> void:
	Globals.sound_effects_enabled = !Globals.sound_effects_enabled
	updateButtonLabel(soundEffectsButton, Globals.sound_effects_enabled)
	emit_signal("settings_sound_effect_button_pressed")
