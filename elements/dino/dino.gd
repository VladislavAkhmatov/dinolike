extends CharacterBody2D

const SPEED = 100.0
const JUMP_VELOCITY = -400.0
@onready var hit = $Hit
@export var DASH_SPEED := 300.0
var DASH_TIME := 0.25
var DASH_COOLDOWN := 1.0
var DOUBLE_TAP_WINDOW := 0.25
var is_dashing := false
var last_dash_time := -999.0
var last_left_tap := -999.0
var last_right_tap := -999.0
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
	
	if not is_dashing:
		var direction = Input.get_axis("ui_left", "ui_right")
		if direction:
			velocity.x = direction * SPEED
			$AnimatedSprite2D.flip_h = direction < 0
			$AnimatedSprite2D.play("run")
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
			$AnimatedSprite2D.play("idle")
			
	move_and_slide()
	
	if Globals.dash:
		dash()
	
func take_damage():
	Globals.change_lives(1)
	flash()
	hit.play()
	await hit.finished

func flash():
	for i in range(2):
		$AnimatedSprite2D.visible = false
		await get_tree().create_timer(0.1).timeout
		$AnimatedSprite2D.visible = true
		await get_tree().create_timer(0.1).timeout

func dash():
	var now = Time.get_ticks_msec() / 1000.0
	if Input.is_action_just_pressed("ui_left"):
		if now - last_left_tap <= DOUBLE_TAP_WINDOW:
			dash_dir(-1)
			last_left_tap = -999.0
			$AnimatedSprite2D.play("dash")
		else:
			last_left_tap = now
	
	if Input.is_action_just_pressed("ui_right"):
		if now - last_right_tap <= DOUBLE_TAP_WINDOW:
			dash_dir(1)
			last_right_tap = -999.0
			$AnimatedSprite2D.play("dash")
		else:
			last_right_tap = now
		
func dash_dir(dir):
	var now = Time.get_ticks_msec() / 1000.0
	
	if is_dashing or (now - last_dash_time < DASH_COOLDOWN):
		return
	
	is_dashing = true
	last_dash_time = now
	velocity.x = dir * DASH_SPEED

	await get_tree().create_timer(DASH_TIME).timeout
	is_dashing = false
	
