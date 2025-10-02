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

#orb crouchy thingy hdajhdjsahdjhashdjashd
var player  # <- declare the player here so it exists in scope
@export var shy_distance := 3.0
#
#shy waywaysyaysyaysyaysyayshsjdhajhdjshjdhajd
func _shy_away():
	var orb_node = get_node_or_null("../orb2")
	if not orb_node:
		return

	var new_pos = orb_node.global_transform.origin
	new_pos.x += randf() * shy_distance * 2 - shy_distance
	new_pos.z += randf() * shy_distance * 2 - shy_distance
	new_pos.y += 0.5  # optional: float up slightly

	var tween = get_tree().create_tween()
	tween.tween_property(orb_node, "global_transform:origin", new_pos, 1.0)\
		.set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)

	print("Orb shies away!")

#hsjdahjdhashdhsdjahjdhjsjshdjdjshdjhsjdhjsd

func _ready():
	monitoring = true  # Start enabled because we want body detection

	var orb = get_node_or_null("../orb2")
	if not orb or not orb.visible:
		print("Orb is not visible or not found")

	# connect to body_entered to make orb shy automatically
	connect("body_entered", Callable(self, "_on_body_entered"))

#orb automatically reacts if player is standing
func _on_body_entered(body):
	if body.name != "Player":
		return
	player = body
	if not player.crouching:
		_shy_away()

func interact():
	#START ADDED STUFF FOR ORB CROUCH THINGY
	# === ADDED: get player reference ===
	player = get_node_or_null("../../Control/SubViewportContainer/SubViewport/Player")
	if not player:
		print("Player not found")
		return

	# === ADDED: crouch check ===
	if not player.crouching:
		print("You need to be crouching to collect this orb!")
		return
	# === END ADDED ===
	#END ADDED STUFF FOR ORB CROUCH THINGY

	#orb noise and memory showing up yYEYEEEEYEEY
	var orb_noise = get_node_or_null("../orbnoise")
	if orb_noise:
		orb_noise.play()
		print("Orb noise is playing thank god")

	var memory_sprite = get_node_or_null("../../1_memory/memory2")
	if memory_sprite:
		memory_sprite.visible = true
		var anim = memory_sprite.get_node_or_null("AnimationPlayer")
		if anim:
			anim.play("M_fadein")

	#hide orb after collection so you can't spam it
	var orb_node = get_node_or_null("../orb2")
	if orb_node:
		orb_node.visible = false
