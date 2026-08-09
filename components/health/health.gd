extends Node
class_name HealthComponent

@export var max_health: float

var current_health: float

signal hit
signal died
signal health_changed(current: float, max: float)

func _ready() -> void:
	current_health = max_health


func take_damage(amount: float):
	hit.emit()
	current_health -= amount
	print('health = ', current_health)
	health_changed.emit(current_health, max_health)
	if current_health <= 0:
		died.emit()
