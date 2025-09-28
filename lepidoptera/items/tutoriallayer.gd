extends CanvasLayer

var tutorial_sprites: Array[Node] = []
var current_index := 0

func _ready():
	# collect all the children sprites
	tutorial_sprites = [
		$tutorialart1,
		$tutorialart2,
		$tutorialart3
	]
	# hide them all just in case
	for s in tutorial_sprites:
		s.visible = false

func start_tutorial():
	visible = true
	current_index = 0
	_show_current()

func _process(_delta):
	if visible and Input.is_action_just_pressed("closememory"):
		_next_step()

func _next_step():
	tutorial_sprites[current_index].visible = false
	current_index += 1

	if current_index < tutorial_sprites.size():
		_show_current()
	else:
		visible = false
		current_index = 0
		get_node("/root/Control/SubViewport/Player").enable_player() # unlock player

func _show_current():
	tutorial_sprites[current_index].visible = true
