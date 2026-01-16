extends Node2D

const GAME_OVER = preload("res://ui/game_over/game_over.tscn")
@onready var DINO = preload("res://elements/dino/dino.tscn")
var METEOR_SPAWNER_ZONE = preload("res://elements/meteor/meteor_spawner.tscn")
var TILEMAP_ZONE = preload("res://elements/tilemap/tile_map.tscn")
var IN_GAME_MENU = preload("res://ui/menu/in_game_menu.tscn")
var last_spawn_right = 0.0
var last_spawn_left = 0.0
var spawn_zone_width = 640

var dino_instantiate

func _ready():
	get_tree().paused = false
	Events.lives_changed.connect(func(lives): check_game_over())
	dino_instantiate = DINO.instantiate()
	dino_instantiate.position.y = 300.0
	dino_instantiate.position.x = 360.0
	add_child(dino_instantiate)
	
func _process(delta):
	if dino_instantiate.position.x > last_spawn_right + 320:
		var new_meteor_spawner_zone = METEOR_SPAWNER_ZONE.instantiate()
		var new_tilemap_zone = TILEMAP_ZONE.instantiate()
		new_meteor_spawner_zone.position = Vector2(last_spawn_right + spawn_zone_width, 0)
		new_tilemap_zone.position = Vector2(last_spawn_right + spawn_zone_width, 0)
		add_child(new_meteor_spawner_zone)
		add_child(new_tilemap_zone)
		last_spawn_right += spawn_zone_width
		
	if dino_instantiate.position.x < last_spawn_left - -320:
		var new_meteor_spawner_zone = METEOR_SPAWNER_ZONE.instantiate()
		var new_tilemap_zone = TILEMAP_ZONE.instantiate()
		new_meteor_spawner_zone.position = Vector2(last_spawn_left - spawn_zone_width, 0)
		new_tilemap_zone.position = Vector2(last_spawn_left - spawn_zone_width, 0)
		add_child(new_meteor_spawner_zone)
		add_child(new_tilemap_zone)
		last_spawn_left -= spawn_zone_width
		
	if Input.is_action_just_pressed("ui_cancel"):
		var enable_in_game_menu = IN_GAME_MENU.instantiate()
		add_child(enable_in_game_menu)
		
	Globals.points += 1.0 * Globals.multiplier * delta
	Events.points_changed.emit(Globals.points)
	
func check_game_over():
	if Globals.lives <= 0:
		await get_tree().create_timer(0.05).timeout
		add_child(GAME_OVER.instantiate())
		get_tree().paused = true
		Globals.reset_lives()
		Globals.save_game(0.1)
