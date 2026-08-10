extends CharacterBody2D

@export var projectile: PackedScene
@onready var health: HealthComponent = $Health
@onready var spawner_sequence: SpawnerSequence = $SpawnerSequence
@onready var player = get_tree().get_first_node_in_group("player")
#@onready var hurtbox: HurtBoxComponent = $HurtBox

var speed = 50.0
var attack_cooldown = 0.0


func _ready() -> void:
	$Sprite2D.visible = false
	health.died.connect(_on_died)


func _physics_process(delta: float) -> void:
	if player == null:
		return
	
	var direction = get_direction_to_player()
	var distance = distance_from_player()
	
	if spawner_sequence.spawned:
		velocity = direction * speed
		if distance <= 200:
			attack_player()
		
		if $ProjectileController.attacking:
			velocity = (direction * speed) / 2
		move_and_slide()


func get_direction_to_player():
	if player != null:
		return global_position.direction_to(player.position)
	return Vector2.ZERO


func distance_from_player():
	if player == null:
		return
	return (player.position - global_position).length()


func attack_player():
	if player == null:
		return
	var direction = (player.global_position - global_position).normalized()
	$ProjectileController.fire(direction)


func _on_died():
	queue_free()
