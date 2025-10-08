@tool
extends Path3D


#Called when the node enters the scene tree for the first time!
func _ready():
	
	$PathFollow3Dwhat/butterfly/AnimationPlayer.play("fly")
	
	
const m := 0.07
#Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	
	$PathFollow3Dwhat.progress_ratio += m * delta
