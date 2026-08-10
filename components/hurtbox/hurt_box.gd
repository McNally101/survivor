extends Area2D
class_name HurtBoxComponent

@export var health:HealthComponent
@export var faction: Faction.Type 

func _ready() -> void:
	collision_mask = Faction.hurt_mask(faction)
	area_entered.connect(hurtbox_entered)


func hurtbox_entered(other_area: Area2D) -> void:
	if other_area is DamageComponent:
		health.take_damage(other_area.damage_value)
		other_area.hit_entity()
