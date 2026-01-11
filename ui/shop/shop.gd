extends CanvasLayer

func _ready():
	get_tree().paused = false
	

func _on_play_pressed():
	Globals.save_game(0.1)
	get_tree().change_scene_to_file("res://game/game.tscn")
