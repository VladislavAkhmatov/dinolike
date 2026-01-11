extends Node2D

const GAME_OVER = preload("res://ui/game_over/game_over.tscn")
@onready var DINO = preload("res://elements/dino/dino.tscn")
var METEOR_SPAWNER_ZONE = preload("res://elements/meteor/meteor_spawner.tscn")
var TILEMAP_ZONE = preload("res://elements/tilemap/tile_map.tscn")
var last_spawn_right = 0.0
var last_spawn_left = 0.0
var spawn_zone_width = 480

var dino_instantiate

func _ready():
	get_tree().paused = false
	Events.lives_changed.connect(func(lives): check_game_over())
	dino_instantiate = DINO.instantiate()
	dino_instantiate.position.y = 250.0
	dino_instantiate.position.x = 240.0
	add_child(dino_instantiate)

func _process(delta):
	if dino_instantiate.position.x > last_spawn_right + 240:
		var new_meteor_spawner_zone = METEOR_SPAWNER_ZONE.instantiate()
		var new_tilemap_zone = TILEMAP_ZONE.instantiate()
		new_meteor_spawner_zone.position = Vector2(last_spawn_right + spawn_zone_width, 0)
		new_tilemap_zone.position = Vector2(last_spawn_right + spawn_zone_width, -48)
		add_child(new_meteor_spawner_zone)
		add_child(new_tilemap_zone)
		last_spawn_right += spawn_zone_width
		
	if dino_instantiate.position.x < last_spawn_left - -240:
		var new_meteor_spawner_zone = METEOR_SPAWNER_ZONE.instantiate()
		var new_tilemap_zone = TILEMAP_ZONE.instantiate()
		new_meteor_spawner_zone.position = Vector2(last_spawn_left - spawn_zone_width, 0)
		new_tilemap_zone.position = Vector2(last_spawn_left - spawn_zone_width, -48)
		add_child(new_meteor_spawner_zone)
		add_child(new_tilemap_zone)
		last_spawn_left -= spawn_zone_width
		
func check_game_over():
	if Globals.lives <= 0:
		get_tree().paused = true
		add_child(GAME_OVER.instantiate())
		Globals.reset_lives()
		SpawnManager.SPAWN_DELAY = 1.0
		Globals.save_game(0.1)
		
