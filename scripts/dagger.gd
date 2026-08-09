extends Node2D

var speed: float = 400.0
var velocity: Vector2 = Vector2.ZERO


func _ready() -> void:
	print('area 2d = ', $Area2D)
	$Area2D.area_entered.connect(on_area_entered)


func _process(delta: float) -> void:
	global_position += velocity * delta


func on_area_entered(other_area: Node2D):
	print('have ui been entered?')
	queue_free()
