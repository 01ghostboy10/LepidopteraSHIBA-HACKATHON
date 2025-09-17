extends CanvasLayer  # or Control, whatever your UI root is

@onready var butterfly_label: Label = $ButterflyLabel

func _ready():
	GameManager.label = butterfly_label
