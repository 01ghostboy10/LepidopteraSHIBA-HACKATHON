extends Area3D

func interact():
	$"../to-be-continued".visible = true
	
func _process(_delta):
	if Input.is_action_just_pressed("closememory"):
		$"../to-be-continued".visible = false
