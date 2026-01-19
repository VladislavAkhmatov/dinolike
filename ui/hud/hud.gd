extends CanvasLayer

@onready var lives_label = $MarginContainer/Lives/Label
@onready var points_label = $MarginContainer/Points/Label

var IN_GAME_MENU = preload("res://ui/menu/in_game_menu.tscn")

func _ready():
	Events.lives_changed.connect(func(lives): update_lives(lives))
	Events.points_changed.connect(func(points): update_points(points))
	update_lives(Globals.max_lives)
	update_points(Globals.points)

func update_lives(lives):
	lives_label.text = str(lives)
	
func update_points(points):
	points_label.text = str(tr("POINTS"), ": ", round(points))

func _on_button_pressed() -> void:
	Globals.gameplay_stop()
	var enable_in_game_menu = IN_GAME_MENU.instantiate()
	add_child(enable_in_game_menu)
