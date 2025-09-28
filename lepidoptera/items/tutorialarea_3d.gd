extends Area3D

@export var tutorial_layer_path: NodePath
var tutorial_layer: CanvasLayer
var tutorial_sprites: Array
var current_index := 0
var tutorial_active := false

func _ready():
	tutorial_layer = get_node(tutorial_layer_path)
	tutorial_sprites = [
		tutorial_layer.get_node("tutorialart1"),
		tutorial_layer.get_node("tutorialart2"),
		tutorial_layer.get_node("tutorialart3"),
	]
	# hide all tutorial arts at the start
	for sprite in tutorial_sprites:
		sprite.visible = false
	tutorial_layer.visible = false

	connect("body_entered", Callable(self, "_on_body_entered"))

func _on_body_entered(body):
	if body.name == "Player" and not tutorial_active:
		tutorial_active = true
		tutorial_layer.visible = true
		current_index = 0
		tutorial_sprites[current_index].visible = true
		body.set_process_input(false) # disable player input (or use your own flag)


func _input(event):
	if tutorial_active and event.is_action_pressed("closememory"):
		tutorial_sprites[current_index].visible = false
		current_index += 1

		if current_index < tutorial_sprites.size():
			tutorial_sprites[current_index].visible = true
		else:
			tutorial_layer.visible = false
			tutorial_active = false
			current_index = 0
			# re-enable player movement here:
			var player = get_tree().get_first_node_in_group("player")
			if player:
				player.set_process_input(true)
