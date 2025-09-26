extends Area3D

@onready var orb2 = $"../../../../orbnode/orb2"	

func interact():
	print("2:: Hello, you itneracted with me!")
	$"../../../../butterflynoisess".play()
	await $"../../../../butterflynoisess".finished
	GameManager.add_butterfly()
	queue_free()
	orb2.visible = true
