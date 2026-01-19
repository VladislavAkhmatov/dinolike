extends CanvasLayer

@onready var points = $Points
@onready var click = $Click

func _ready():
	get_tree().paused = false

func _process(delta):
	points.text = str(tr("POINTS"), ": ", round(Globals.points))

func _on_play_pressed():
	await get_tree().process_frame
	Globals.gameplay_start()
	click.play()
	Globals.save_game(0.1)
	SpawnManager.SPAWN_DELAY = 1.0
	get_tree().change_scene_to_file("res://game/game.tscn")

func _on_main_menu_pressed():
	click.play()
	get_tree().change_scene_to_file("res://ui/menu/main_menu.tscn")
