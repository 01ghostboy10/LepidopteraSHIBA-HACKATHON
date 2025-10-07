extends RigidBody3D

func _ready():
	var target = get_node("../wooden_crate_02_1k2")
	global_position.x = target.global_position.x
	global_position.y = target.global_position.y
