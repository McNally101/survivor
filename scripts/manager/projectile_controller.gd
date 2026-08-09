extends Node

@export var projectile: PackedScene

var mouse_position
var direction_to_mouse
var attack_cooldown: float = 0.0
var knockback: float = 100.0

func _ready() -> void:
	print("I'm here")


func _process(delta: float) -> void:
	attack_cooldown -= delta
	get_cursor_position()
	if Input.is_action_pressed("left_click"):
		is_fire_clicked()


func is_fire_clicked():
	var player = get_tree().get_first_node_in_group("player") as Node2D
	if player == null or projectile == null:
		return
	
	if attack_cooldown <= 0.0:
		attack_cooldown = 0.35
		var projectile_instance = projectile.instantiate() as Node2D
		player.get_parent().add_child(projectile_instance)
		
		projectile_instance.global_position = player.global_position
		projectile_instance.reset_physics_interpolation()
		
		var direction = (player.get_global_mouse_position() - player.global_position).normalized()
		projectile_instance.velocity = direction * projectile_instance.speed
		player.velocity -= direction * knockback


func get_cursor_position() -> void:
	var player = get_tree().get_first_node_in_group("player") as Node2D
	if player == null:
		return
	
	mouse_position = player.get_global_mouse_position()
	direction_to_mouse = player.global_position.direction_to(mouse_position)
