extends Node2D

@onready var damage: DamageComponent = $Damage

var speed: float = 400.0
var velocity: Vector2 = Vector2.ZERO


func _process(delta: float) -> void:
	global_position += velocity * delta


func configure(faction: Faction.Type) -> void:
	damage.collision_layer = Faction.attack_layer(faction)
