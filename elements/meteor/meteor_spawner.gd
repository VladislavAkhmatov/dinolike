extends Node2D

const METEOR_SCENE = preload("res://elements/meteor/meteor.tscn")
const DELAY_STEP = 0.010

var rect_size = 0

func _ready():
	randomize()
	var collision_size = $CollisionShape2D.shape
	rect_size = collision_size.extents * 2
	spawn_loop()

func spawn_loop():
	while is_inside_tree():
		if get_tree().paused:
			await get_tree().process_frame
			continue
		spawn_meteor()
		await get_tree().create_timer(SpawnManager.SPAWN_DELAY).timeout
		
func spawn_meteor():
	var meteor = METEOR_SCENE.instantiate()
	
	var pos_x = randf_range(0, rect_size.x)
	meteor.position = Vector2(pos_x, 0)
	
	var angle = randf_range(-45, 45)
	meteor.direction = Vector2(sin(deg_to_rad(angle)), 1).normalized()
	
	meteor.SPEED = randf_range(100.0, 500.0)
		
	add_child(meteor)
