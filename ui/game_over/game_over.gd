extends CanvasLayer

@onready var click = $Click

func _on_button_pressed():
	click.play()
	await click.finished
	SpawnManager.reset_spawn()
	get_tree().change_scene_to_file("res://game/game.tscn")

func _on_magazine_pressed():
	click.play()
	await click.finished
	get_tree().change_scene_to_file("res://ui/shop/shop.tscn")


func _on_main_menu_pressed():
	get_tree().paused = false
	click.play()
	await click.finished
	get_tree().change_scene_to_file("res://ui/menu/main_menu.tscn")
