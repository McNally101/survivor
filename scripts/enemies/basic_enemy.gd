extends CharacterBody2D

@export var projectile: PackedScene

var speed = 50.0
var attack_cooldown = 0.0

func _ready() -> void:
	$Area2D.area_entered.connect(on_area_entered)


func _physics_process(delta: float) -> void:
	var space_state = get_world_2d().direct_space_state
	var query = PhysicsRayQueryParameters2D.create(Vector2(0, 0), Vector2(50, 100))
	var result = space_state.intersect_ray(query)
	if result:
		print("Hit at point: ", result.position)
	
	
	var player_position = get_direction_to_player()
	var distance = distance_from_player()
	velocity = player_position * speed
	if distance <= 100:
		attack_player()
		velocity = (player_position * speed) / 2
	
	move_and_slide()


# Get the player position and return it as a Vector2
func get_direction_to_player():
	var player = get_tree().get_first_node_in_group("player")
	if player != null:
		return global_position.direction_to(player.position)
	return Vector2.ZERO


func on_area_entered(other_area: Area2D):
	queue_free()


func distance_from_player():
	var player = get_tree().get_first_node_in_group("player")
	if player == null:
		return
	
	return (player.position - global_position).length()


func attack_player():
	var player = get_tree().get_first_node_in_group("player") as Node2D
	if player == null:
		return
	
	if attack_cooldown <= 0.0:
		attack_cooldown = 0.35
		var projectile_instance = projectile.instantiate() as Node2D
		player.get_parent().add_child(projectile_instance)
		
		projectile_instance.global_position = global_position
		projectile_instance.reset_physics_interpolation()
		
		var direction = (player.global_position - global_position).normalized()
		projectile_instance.velocity = direction * 150
