extends Area3D

func interact():
#memory showing up yYEYEEEEYEEY
	$"../CREDITSLAYER".visible = true
	
func _process(_delta):
	if Input.is_action_just_pressed("closememory"):
		$"../CREDITSLAYER".visible = false
