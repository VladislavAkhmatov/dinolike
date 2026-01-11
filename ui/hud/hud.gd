extends CanvasLayer

@onready var lives_label = $MarginContainer/Lives/Label
@onready var points_label = $MarginContainer/Points/Label

func _ready():
	Events.lives_changed.connect(func(lives): update_lives(lives))
	Events.points_changed.connect(func(points): update_points(points))
	update_lives(Globals.lives)
	update_points(Globals.points)

func update_lives(lives):
	lives_label.text = str(lives)
	
func update_points(points):
	points_label.text = str("points: ", points)
	
