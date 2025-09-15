extends Area3D

var chest_count = 0

func interact(player):
	chest_count += 1
	print("Butterflies collected in chest: ", chest_count)

	# update UI label
	var label = get_tree().get_root().get_node("Main/CanvasLayer/ButterflyLabel")
	label.text = "Butterflies: %d" % chest_count
