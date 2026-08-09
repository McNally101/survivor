extends Area2D
class_name HurtBoxComponent

@export var health:HealthComponent

func _ready() -> void:
	area_entered.connect(hurtbox_entered)


func hurtbox_entered(other_area: Area2D) -> void:
	if other_area is DamageComponent:
		health.take_damage(other_area.damage_value)
		other_area.hit_entity()
