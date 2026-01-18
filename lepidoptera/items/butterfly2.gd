extends Area3D

@onready var orb2 = $"../../../../orbnode/orb2"	

func interact():
	$"../../../../butterflynoisess".play()
	await $"../../../../butterflynoisess".finished
	GameManager.add_butterfly()
	queue_free()
	orb2.visible = true
