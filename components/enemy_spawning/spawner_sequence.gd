extends Node
class_name SpawnerSequence

@export var summon_sprite: Sprite2D
@export var entity_sprite: Sprite2D

@export var spawn_circle_delay: float = randf_range(0, 3)
@export var spawn_circle_countdown: float = 2.0
@export var spawn_delay: float = 0.2

var spawned: bool = false


func _physics_process(delta: float) -> void:
	spawn_circle_delay -= delta
	summon_sprite.visible = false
	
	if spawn_circle_delay >= 0:
		return
	
	summon_sprite.visible = true
	spawn_circle_countdown -= delta
	
	if spawn_circle_countdown >= 0:
		return
		
	summon_sprite.visible = false
	entity_sprite.visible = true
	spawn_delay -= delta
	
	if spawn_delay <= 0:
		spawned = true
		set_physics_process(false)
