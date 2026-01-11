extends Node

var max_lives := 1
var lives := max_lives
var points := 0
var multiplier = 1.0;
var SAVE_PATH := "user://save.json"

func _ready():
	save_game(5)
	change_points(1)
	load_game()

func change_lives(value):
	lives -= value
	Events.lives_changed.emit(lives)

func reset_lives():
	lives = max_lives

func change_points(value):
	while true: 
		await get_tree().create_timer(1).timeout
		if get_tree().paused:
			continue
		points += value * multiplier
		Events.points_changed.emit(points)

func save_game(second):
	while true: 
		await get_tree().create_timer(second).timeout
		var data = {
			"points": points,
			"multiplier": multiplier
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
			
