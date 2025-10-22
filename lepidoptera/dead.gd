extends Control


func _on_button_mouse_entered() -> void:
	$soundeffecthover.play()

func _on_button_pressed() -> void:
	$soundeffectclick.play()
	#pass # Replace with function body.
	get_tree().change_scene_to_file("res://items/main.tscn")
