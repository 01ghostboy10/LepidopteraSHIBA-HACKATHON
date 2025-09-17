extends Control


func _on_start_pressed() -> void:
	#pass # Replace with function body.
	get_tree().change_scene_to_file("res://items/main.tscn")


func _on_about_pressed() -> void:
	#pass # Replace with function body.
	get_tree().change_scene_to_file("res://about.tscn")


func _on_exit_pressed() -> void:
	get_tree().quit()
