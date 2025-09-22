extends Area3D

#
func disable_interact():
	$".".monitoring = false
#
func interact():
	$"../../orbnoise".play()
