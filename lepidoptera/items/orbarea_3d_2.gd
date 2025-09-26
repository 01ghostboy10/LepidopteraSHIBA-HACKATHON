#extends Area3D
#func _ready():
#	$Area3D.monitoring = false
#if get_node("../Orb").visible == true:
#	get_node("../Area3D").monitoring = true
#func interact():
#	$"../orbnoise".play()
#	print("orbnoises are playing")
#fdddfdfdjahdhajhdjahdjashdjahdjhsaj


extends Area3D

func _ready():
	monitoring = false  # Start disabled

	var orb = get_node_or_null("../orb2")
	if orb and orb.visible:
		monitoring = true  # Enable interaction if Orb is visible
	else:
		print("Orb is not visible or not found")

func interact():
	var orb_noise = get_node_or_null("../orbnoise")
	if orb_noise:
		orb_noise.play()
		print("Orb noise is playing thank god")
		#memory showing up yYEYEEEEYEEY
		var _memory_layer = get_node("../../1_memory")
		$"../../1_memory/Sprite2D".visible = true
		$"../../1_memory/Sprite2D/AnimationPlayer".play("M_fadein")  # Replace "fade_in" with your actual animation name

	else:
		print("orbnoise not found euuggh")
