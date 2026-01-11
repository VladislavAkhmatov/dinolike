extends CharacterBody2D

@export var SPEED := 0
@export var direction := Vector2.DOWN
const DEATH_DELAY = 0.3
var exploded = false

func _ready():
	$AnimatedSprite2D.rotation = direction.angle() + deg_to_rad(225)

func _physics_process(delta):
	if exploded:
		return
		
	var collision = move_and_collide(direction * SPEED * delta)
	if collision:
		var collider = collision.get_collider()
		if collider.has_method("take_damage"):
			collider.take_damage()

		exploded = true
		velocity = Vector2.ZERO
		$AnimatedSprite2D.play("explosion")
		await get_tree().create_timer(DEATH_DELAY).timeout
		queue_free()
