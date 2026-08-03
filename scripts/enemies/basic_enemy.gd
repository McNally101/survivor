extends CharacterBody2D

var speed = 30.0


func _physics_process(delta: float) -> void:
	var player_position = get_direction_to_player()
	velocity = player_position * speed
	move_and_slide()


# Get the player position and return it as a Vector2
func get_direction_to_player():
	var player = get_tree().get_first_node_in_group("player")
	if player != null:
		# This can be achieved with the function below
		#return (player.position - global_position).normalized()
		return global_position.direction_to(player.position)
	return Vector2.ZERO
