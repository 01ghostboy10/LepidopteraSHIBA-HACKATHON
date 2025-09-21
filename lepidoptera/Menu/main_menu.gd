extends Control


func _on_start_pressed() -> void:
	$soundeffectclick.play()
	#pass # Replace with function body.
	get_tree().change_scene_to_file("res://items/main.tscn")


func _on_about_pressed() -> void:
	$soundeffectclick.play()
	#pass # Replace with function body.
	get_tree().change_scene_to_file("res://about.tscn")


func _on_exit_pressed() -> void:
	$soundeffectclick.play()
	get_tree().quit()


#ff9d8fd98fdifsfjsfjsdjfkjs
func _process(_delta):
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()
#shjdjahjshdjahjasdjshdjhaj
#ff9d8fd98fdifsfjsfjsdjfkjs
func _input(event):
	if event.is_action_pressed("startgame"):
		get_tree().change_scene_to_file("res://items/main.tscn")

#shjdjahjshdjahjasdjshdjhaj

#hoverstuff

func _on_startbutton_mouse_entered() -> void:
	$soundeffecthover.play()
	#pass # Replace with function body.


func _on_aboutbutton_mouse_entered() -> void:
	$soundeffecthover.play()
	#pass # Replace with function body.


func _on_exitbutton_mouse_entered() -> void:
	$soundeffecthover.play()
	#pass # Replace with function body.
