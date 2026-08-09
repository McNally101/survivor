extends Node2D

var speed: float = 400.0
var velocity: Vector2 = Vector2.ZERO


func _process(delta: float) -> void:
	global_position += velocity * delta
