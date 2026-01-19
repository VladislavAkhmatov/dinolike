extends CanvasLayer

@onready var click = $Click
@onready var music = $VBoxContainer/Music
@onready var sfx = $VBoxContainer/SFX

func _ready():
	var config = ConfigFile.new()
	var err = config.load("user://config.cfg")
	var music_value = 1.0
	var sfx_value = 1.0
	if err == OK:
		music_value = config.get_value("audio", "music", 1.0)
		sfx_value = config.get_value("audio", "sfx", 1.0)
	music.value = music_value
	sfx.value = sfx_value

func _on_button_pressed():
	click.play()
	get_tree().change_scene_to_file("res://ui/menu/main_menu.tscn")

func _on_music_value_changed(value):
	Globals.apply_sounds_settings("music", value)

func _on_sfx_value_changed(value):
	Globals.apply_sounds_settings("sfx", value)
