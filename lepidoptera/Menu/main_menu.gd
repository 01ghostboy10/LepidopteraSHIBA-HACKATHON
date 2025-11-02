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





#TRANSLATIONS HHHHHH

func _on_en_pressed():
	TranslationServer.set_locale("en")
	update_labels()

func _on_jp_pressed():
	TranslationServer.set_locale("jp")
	update_labels()

func update_labels():
	# refresh any UI labels so they show the new language
	# if you are using tr() in Label.text it updates automatically
	for label in get_tree().get_nodes_in_group("translatable"):
		label.text = tr(label.name)
