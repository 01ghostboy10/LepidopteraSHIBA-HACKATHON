extends CanvasLayer

func _process(_delta):
	if Input.is_action_just_pressed("closepopup"):
		queue_free()
