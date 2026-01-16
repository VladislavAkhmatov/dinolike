extends CanvasLayer

@onready var click = $Click

func _ready():
	get_tree().paused = true

func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().paused = false
		queue_free()

func _on_quit_pressed():
	click.play()
	await click.finished
	get_tree().quit()

func _on_play_pressed():
	click.play()
	await click.finished
	get_tree().paused = false
	queue_free()

func _on_magazine_pressed():
	click.play()
	await click.finished
	get_tree().change_scene_to_file("res://ui/shop/shop.tscn")
