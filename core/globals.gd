extends Node

var points := 0.0

var max_lives := 1
var lives := max_lives
var max_lives_step = 1

var multiplier = 1.0
var multiplier_step = 1

var dash = false

var SAVE_PATH := "user://save.json"

func _ready():
	save_game(5)
	load_game()
	reset_lives()
	load_sounds()
	
func change_lives(value):
	lives -= value
	Events.lives_changed.emit(lives)

func reset_lives():
	lives = max_lives

func save_game(second):
	while true: 
		await get_tree().create_timer(second).timeout
		var data = {
			"points": points,
			"multiplier": multiplier,
			"multiplier_step": multiplier_step,
			"max_lives": max_lives,
			"max_lives_step": max_lives_step,
			"dash": dash
		}
		
		var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
		if file:
			file.store_string(JSON.stringify(data))
			file.close()
			
func load_game():
	if !FileAccess.file_exists(SAVE_PATH):
		points = 0
		multiplier = 1.0
		return
		
	var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
	if file:
		var text = file.get_as_text()
		file.close()
		
		var result = JSON.parse_string(text)
		if typeof(result) == TYPE_DICTIONARY:
			points = result.get("points", 0)
			multiplier = result.get("multiplier", 1.0)
			multiplier_step = result.get("multiplier_step", 1)
			max_lives = result.get("max_lives", 1)
			max_lives_step = result.get("max_lives_step", 1)
			dash = result.get("dash", false)
			
func apply_sounds_settings(bus_name: String, value: float):
	var bus = AudioServer.get_bus_index(bus_name)
	AudioServer.set_bus_volume_db(bus, linear_to_db(value))
	save_sounds_settings(bus_name, value)
	
func save_sounds_settings(bus_name: String, value: float):
	var config = ConfigFile.new()
	var err = config.load("user://config.cfg")
	if err != OK:
		print("creating cfg file")
		
	config.set_value("audio", bus_name, value)
	config.save("user://config.cfg")
	
func load_sounds():
	var config = ConfigFile.new()
	var err = config.load("user://config.cfg")
	if err != OK:
		return

	for bus_name in config.get_section_keys("audio"):
		var value = config.get_value("audio", bus_name, 1.0)
		var bus = AudioServer.get_bus_index(bus_name)
		AudioServer.set_bus_volume_db(bus, linear_to_db(value))
	
func game_ready():
	if OS.has_feature("web"):
		JavaScriptBridge.eval("yg_game_ready()", true)

func gameplay_start():
	if OS.has_feature("web"):
		JavaScriptBridge.eval("yg_gameplay_start()", true)

func gameplay_stop():
	if OS.has_feature("web"):
		JavaScriptBridge.eval("yg_gameplay_stop()", true)
