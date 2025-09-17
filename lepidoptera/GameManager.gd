extends Node

var butterflies: int = 0
var label: Label = null

@onready var sfx_player: AudioStreamPlayer = $butterflynoisess

func add_butterfly():	
	butterflies += 1
	if label:
		label.text = "Butterflies collected: " + str(butterflies)
#broetfasthtshdjhjdhsajhdjshja
