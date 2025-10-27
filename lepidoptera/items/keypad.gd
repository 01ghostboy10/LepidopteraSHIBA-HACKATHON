extends CanvasLayer
#NOTE TO SELF EDIT EDITE DITIEIOOEDIEDEOA AAAAAAA *screaming*
#correct passwor dnand onready to call the input thing lineedit or whatever~
#
var correct_password = "1331331"
@onready var input = $Panel/LineEdit

func _process(_delta):
	# check if the "closememory" key/action was pressed
	if Input.is_action_just_pressed("closememory"):
		_check_password()

func _check_password():
	var user_input = input.text
	if user_input == correct_password:
		print("u may go thru")
		_unlock_door()
	else:
		print("away thou art banisheeeeeeed")
		input.text = ""  # clears input for retry


func _unlock_door():
	# example: get y setup)
	var door = get_node("/root/MainScene/Door")
	if door:
		door.open() # your custom function
