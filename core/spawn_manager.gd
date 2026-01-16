extends Node

@export var SPAWN_DELAY = 1.0
var MIN_SPAWN_DELAY = 0.1
var DELAY_STEP = 0.010

func _ready():
	delay_spawn()

func delay_spawn():
	while SPAWN_DELAY > MIN_SPAWN_DELAY:
		await get_tree().create_timer(2.0).timeout
		SPAWN_DELAY -= DELAY_STEP

func reset_spawn():
	SPAWN_DELAY = 1.0
	MIN_SPAWN_DELAY = 0.1
	DELAY_STEP = 0.010
