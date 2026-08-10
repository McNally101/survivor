extends Node
class_name ProjectileController

@export var projectile: PackedScene
@export var projectile_speed:float = 150.0
@export var attack_rate:float = 0.5
@export var attack_recovery:float = 0.2
@export var faction: Faction.Type

var attacking:bool = false
var attack_cooldown:float = 0.0
var recovery_timer:float = 0.0

func _physics_process(delta: float) -> void:
	if attack_cooldown >= 0.0:
		attack_cooldown -= delta
	
	if recovery_timer > 0.0:
		recovery_timer -= delta
		if recovery_timer <= 0.0:
			attacking = false


func fire(direction: Vector2) -> void:
	if projectile == null or attack_cooldown > 0.0:
		return
	
	attacking = true
	attack_cooldown = attack_rate
	recovery_timer = attack_recovery
	
	var instance = projectile.instantiate() as Node2D
	get_tree().current_scene.add_child(instance)
	instance.global_position = owner.global_position
	instance.reset_physics_interpolation()
	instance.configure(faction)
	instance.velocity = direction.normalized() * projectile_speed
	
