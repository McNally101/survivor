extends Node

@export var enemy_scene: PackedScene
@export var walls: TileMapLayer

@onready var player = get_tree().get_first_node_in_group("player")
@onready var player_position = player.global_position

var safe_zone: float = 50.0
var spawn_margin: float = 32.0


func _ready() -> void:
	for i in range(10):
		spawn_enemy()

func spawn_enemy() -> void:
	if enemy_scene == null:
		return
	var enemy: Node2D = enemy_scene.instantiate()
	enemy.global_position = get_spawn_position()
	get_parent().add_child.call_deferred(enemy)
	enemy.reset_physics_interpolation()


func get_spawn_position():
	if !enemy_scene or !walls:
		return
		
	var arena = get_arena_rect()

	for i in range(10):
		var point = Vector2(
			randf_range(arena.position.x, arena.end.x),
			randf_range(arena.position.y, arena.end.y)
		)
		
		if player == null:
			return point
		if point.distance_squared_to(player.global_position) >= safe_zone:
			return point
	
	return arena.get_center()


func get_arena_rect():
	var cell_rect = walls.get_used_rect()
	var tile_size = walls.tile_set.tile_size
	
	var local_rect := Rect2(
		Vector2(cell_rect.position * tile_size),
		Vector2(cell_rect.size * tile_size)
	)
	
	return local_rect.grow(-spawn_margin)
