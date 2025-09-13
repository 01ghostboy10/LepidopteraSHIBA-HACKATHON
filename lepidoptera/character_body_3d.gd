extends CharacterBody3D

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var speed = 5
var jump_speed = 5
var mouse_sensitivity = 0.002

#rotation n movement i believe
func _physics_process(delta):
	# apply gravity
	velocity.y -= gravity * delta   # minimal change

	# movement input
	var input = Input.get_vector("left", "right", "forward", "back")
	var movement_dir = transform.basis * Vector3(input.x, 0, input.y)
	velocity.x = movement_dir.x * speed
	velocity.z = movement_dir.z * speed

	# move character (Godot 4 style) because why the FREAK do all tutorials use ye olde ancient Godot versions
	move_and_slide()  # minimal change

	# jump
	if is_on_floor() and Input.is_action_just_pressed("jump"):
		velocity.y = jump_speed

#mouse character
func _input(event):
	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		# rotate body left/right
		rotate_y(-event.relative.x * mouse_sensitivity)

		# rotate camera up/down using rotation_degrees
		var cam_rot = $Camera3D.rotation_degrees
		cam_rot.x -= event.relative.y * mouse_sensitivity * 180 / PI  # convert rad to deg
		cam_rot.x = clamp(cam_rot.x, -70, 70)
		$Camera3D.rotation_degrees = cam_rot
