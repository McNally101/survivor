extends Node

const SPAWN_RADIUS = 600

@export var basic_enemy_scene: PackedScene


func _ready() -> void:
	print('WE GETTING ENEMIES BAI')
	$Timer.timeout.connect(on_timer_timeout)
	pass

func on_timer_timeout():
	var player: Node2D = get_tree().get_first_node_in_group("player")
	if player == null:
		return
	
	var viewport = get_viewport().size.y
	var random_direction = Vector2.RIGHT.rotated(randf_range(0, TAU))
	var spawn_position = player.global_position + (random_direction * viewport/2)
	print('spawn position = ', viewport)
	var enemy: Node2D = basic_enemy_scene.instantiate()
	enemy.global_position = spawn_position
	get_parent().add_child(enemy)
	enemy.reset_physics_interpolation()
