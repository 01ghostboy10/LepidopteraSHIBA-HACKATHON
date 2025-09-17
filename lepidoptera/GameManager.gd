extends Node

var butterflies: int = 0
var label: Label = null

func add_butterfly():
	butterflies += 1
	if label:
		label.text = "butterflies: " + str(butterflies)
