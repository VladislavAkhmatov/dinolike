extends CanvasLayer

@onready var play_btn = $VBoxContainer/Play
@onready var click = $Click

func _ready():
	await get_tree().process_frame
	Globals.game_ready()
	#load_language()
	
func _on_magazine_pressed():
	click.play()
	if OS.has_feature("web"):
		await YandexSdk.show_ad_after_click()
	get_tree().change_scene_to_file("res://ui/shop/shop.tscn")
	
func _on_play_pressed():
	await get_tree().process_frame
	Globals.gameplay_start()
	click.play()
	get_tree().change_scene_to_file("res://game/game.tscn")

func _on_quit_pressed():
	click.play()
	get_tree().quit()

func _on_russian_pressed():
	click.play()
	YandexSdk.set_locale("ru")

func _on_english_pressed():
	click.play()
	YandexSdk.set_locale("en")
	
#func change_language(locale: String):
	#TranslationServer.set_locale(locale)
	#save_language(locale)
	
#func save_language(locale: String):
	#var config = ConfigFile.new()
	#var err = config.load("user://config.cfg")
	#if err != OK:
		#print("creating cfg file")
		#
	#config.set_value("settings", "language", locale)
	#config.save("user://config.cfg")
	#
#func load_language():
	#var config = ConfigFile.new()
	#var err = config.load("user://config.cfg")
	#if err == OK:
		#var locale = config.get_value("settings", "language", "en")
		#TranslationServer.set_locale(locale)

func _on_settings_pressed():
	click.play()
	await click.finished
	get_tree().change_scene_to_file("res://ui/menu/settings.tscn")
