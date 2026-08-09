extends CharacterBody2D

var cursor = load("res://icon.svg")

const SPEED = 125.0
const ACCELERATION_SMOOTHING = 25

var attack_radius: float = 100.00


# Animations are handled in here 
func _process(delta: float) -> void:
	handle_animations()


# Determines player movement
func _physics_process(delta: float) -> void:
	var direction = get_movement_vector()
	var target_velocity = direction * SPEED
	velocity = velocity.lerp(target_velocity, 1 - exp(-delta * ACCELERATION_SMOOTHING))
	get_cursor_position()
	move_and_slide()


# This function will return a normailzed vector2 of the players movement
func get_movement_vector() -> Vector2:
	var movement_vector = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	return movement_vector.normalized()


# The handle animations function will check the players movement and
func handle_animations() -> void:
	var movement_vector = get_movement_vector()
	
	if movement_vector != Vector2.ZERO:
		$AnimatedSprite2D.play("walking")
	else:
		$AnimatedSprite2D.play("idle")
	
	if movement_vector.x != 0:
		$AnimatedSprite2D.flip_h = movement_vector.x < 0


func get_cursor_position() -> void:
	var mouse_position = get_global_mouse_position()
	var distance_from_player = (position - mouse_position).length()
	var direction_to_mouse = position.direction_to(mouse_position)
	if distance_from_player < attack_radius:
		$Target.global_position = mouse_position
	else:
		$Target.global_position = position + direction_to_mouse * attack_radius
	
