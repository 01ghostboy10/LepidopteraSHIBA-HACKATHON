extends Area3D

var already_played := false

func _ready():
	connect("body_entered", Callable(self, "_on_body_entered"))

func _on_body_entered(body):
	if body.name == "Player" and not already_played:
		$AudioStreamPlayer3D.play()
		already_played = true
