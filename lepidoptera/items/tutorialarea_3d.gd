extends Area3D

var triggered := false

var tutorial_active := false

var art1
var art2
var art3
var step := 0

func _ready():
	art1 = get_node("../tutoriallayer/tutorialart1")
	art2 = get_node("../tutoriallayer/tutorialart2")
	art3 = get_node("../tutoriallayer/tutorialart3")

	connect("body_entered", Callable(self, "_on_body_entered"))

	art1.visible = false
	art2.visible = false
	art3.visible = false

var player  # reference to player

func _on_body_entered(body):
	if triggered:
		return  # already done, ignore
	if body.name == "Player":
		triggered = true  # mark as done
		player = body
		step = 1
		art1.visible = true
		player.tutorial_active = true




func _input(_event):
	if not player:
		return

	if Input.is_action_just_pressed("closememory"):
		match step:
			1:
				art1.visible = false
				art2.visible = true
				step = 2
			2:
				art2.visible = false
				art3.visible = true
				step = 3
			3:
				art3.visible = false
				step = 0
				player.tutorial_active = false  # unfreeze
