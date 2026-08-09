extends Area2D
class_name DamageComponent

@export var damage_value:float = 20
@export var number_of_hits:int = 1

func hit_entity():
	number_of_hits -= 1
	if number_of_hits <= 0:
		var parent = get_parent()
		parent.queue_free()
