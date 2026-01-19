extends CanvasLayer

@onready var click = $Click

func _on_button_pressed():
	get_tree().paused = false
	await get_tree().process_frame
	Globals.gameplay_start()
	click.play()
	SpawnManager.reset_spawn()
	get_tree().change_scene_to_file("res://game/game.tscn")

func _on_magazine_pressed():
	click.play()
	if OS.has_feature("web"):
		await YandexSdk.show_ad_after_click()
	get_tree().change_scene_to_file("res://ui/shop/shop.tscn")

func _on_main_menu_pressed():
	get_tree().paused = false
	click.play()
	get_tree().change_scene_to_file("res://ui/menu/main_menu.tscn")
