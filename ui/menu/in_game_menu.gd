extends CanvasLayer

@onready var click = $Click

func _ready():
	get_tree().paused = true

func _on_quit_pressed():
	click.play()
	await click.finished
	get_tree().quit()

func _on_play_pressed():
	click.play()
	Globals.gameplay_start()
	get_tree().paused = false
	queue_free()

func _on_magazine_pressed():
	Globals.gameplay_stop()
	click.play()
	if OS.has_feature("web"):
		await YandexSdk.show_ad_after_click()
	get_tree().change_scene_to_file("res://ui/shop/shop.tscn")

func _on_main_menu_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://ui/menu/main_menu.tscn")
