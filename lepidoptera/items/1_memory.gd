extends CanvasLayer

func _process(_delta):
	if Input.is_action_just_pressed("closememory"):
		$Sprite2D.visible = false
