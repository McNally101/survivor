extends Camera2D


# make current is not the modern Godot 4 approach. Typically you can set the camera with enabled in the inspector
# BUT make current is useful for switching between multiple different cameras
func _ready() -> void:
	make_current()


func _physics_process(delta: float) -> void:
	acquire_target()


# Find the position of the player by checking the group. In this case grab the first node in the group player
func acquire_target():
	var player = get_tree().get_first_node_in_group("player")
	if player:
		global_position = player.global_position 
