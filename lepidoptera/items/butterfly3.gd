extends Area3D

@onready var orb = $"../../../../orbnode/orb3"
func interact():
	print("2:: Hello, you itneracted with me!")
	$"../../../../butterflynoisess".play()
	await $"../../../../butterflynoisess".finished
	GameManager.add_butterfly()
	queue_free()
	orb.visible = true
	print("orb visible after change:", orb.visible)
