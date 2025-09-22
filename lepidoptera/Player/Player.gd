extends CharacterBody3D



var gravity = 30        # increased from default so jump feels heavier
var speed = 7
#crouching stuff again
var crouch_speed = 2.5
var jump_speed = 12      # slightly higher so player can still jump
var mouse_sensitivity = 0.002

# crouch height
var crouch_height = 0.5
var crouching = false
var stand_height = 2.0
var collision_shape: CapsuleShape3D  # added minimal variable

func _ready():
	# capture the mouse so input works
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	# get a reference to the collision shape
	collision_shape = $CollisionShape3D.shape as CapsuleShape3D

#ff9d8fd98fdifsfjsfjsdjfkjs
func _process(_delta):
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()
#shjdjahjshdjahjasdjshdjhaj


# crouching
func crouch():
	if Input.is_action_just_pressed("crouch"):
		crouching = !crouching
		if crouching:
			collision_shape.height = crouch_height
		else:
			collision_shape.height = stand_height

# rotation n movement i believe
func _physics_process(delta):
	#bruh whyy
	%InteractText.hide()
	if %SeeCast.is_colliding():
		var target = %SeeCast.get_collider()
		if target != null and target.has_method("interact"):
			%InteractText.show()
			if Input.is_action_just_pressed("interact"):
				target.interact()
			
	#IDK IF THIS IS THE RIGHT PLACE
	
	crouch()
	# apply gravity
	velocity.y -= gravity * delta

	# get movement input
	var input = Input.get_vector("left","right","forward","back")
	var movement = transform.basis * Vector3(input.x,0,input.y)
	#crouching speed n stuff
	if !crouching:
		velocity.x = movement.x * speed
		velocity.z = movement.z * speed
	elif crouching:
		velocity.x = movement.x * crouch_speed
		velocity.z = movement.z * speed

	# move character
	move_and_slide()
	
	# jump
	if is_on_floor() and Input.is_action_just_pressed("jump"):
		velocity.y = jump_speed
		
	#footsteps
	if velocity.length() > 0:
		if not $"../../../AudioStreamPlayer2".playing:
			$"../../../AudioStreamPlayer2".play()
	else:
		$"../../../AudioStreamPlayer2".stop()

#
# mouse character whY IS THIS SO fdhfjdh OVERVOMPLICATED
func _input(event):
	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		# rotate body left/right
		rotate_y(-event.relative.x * mouse_sensitivity)
		
		# rotate camera up/down using pivot
		var pivot_rot = $CameraPivot.rotation_degrees
		pivot_rot.x -= event.relative.y * mouse_sensitivity * 180 / PI  # convert rad to deg
		pivot_rot.x = clamp(pivot_rot.x, -70, 70)  # clamp vertical angle
		$CameraPivot.rotation_degrees = pivot_rot
