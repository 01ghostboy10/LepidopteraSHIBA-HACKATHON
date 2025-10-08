extends Node3D

@export var orb_proximity_radius: float = 5.0
@export var threat_min_time: float = 10.0
@export var threat_max_time: float = 30.0

# 🔵 CHANGED: now supports multiple orbs instead of one
@export var orb_area_paths: Array[NodePath] = []

@export var threat_color_rect_path: NodePath
@export var threat_color_rect_2_path: NodePath
@export var threat_label_path: NodePath
@export var player_path: NodePath

var player: Node3D
# 🔵 CHANGED: remove single orb var, replace with array
var orb_areas: Array[Node3D] = []

var threat_timer: float = 0.0
var threat_threshold: float = 0.0
var threat_color_rect: ColorRect
var threat_color_rect_2: ColorRect
var threat_label: RichTextLabel
var in_safe_zone_flag: bool = false

func _ready():
	player = get_node(player_path)

	# 🔵 CHANGED: populate the orb_areas array from orb_area_paths
	for path in orb_area_paths:
		var orb = get_node_or_null(path)
		if orb:
			orb_areas.append(orb)

	threat_color_rect = get_node(threat_color_rect_path)
	threat_color_rect_2 = get_node(threat_color_rect_2_path)
	threat_label = get_node(threat_label_path)
	reset_threat_timer()

func _process(delta):
	if not player or orb_areas.is_empty():
		return

	# 🔵 CHANGED: check all orbs — player is safe if near *any* orb
	var is_in_safe = false
	for orb in orb_areas:
		if orb.global_position.distance_to(player.global_position) < orb_proximity_radius:
			is_in_safe = true
			break

	if is_in_safe and not in_safe_zone_flag:
		in_safe_zone_flag = true
		threat_timer = 0.0
		print("Entered safe zone!")

	elif not is_in_safe and in_safe_zone_flag:
		in_safe_zone_flag = false
		print("Exited safe zone!")

	if not in_safe_zone_flag:
		threat_timer += delta
		threat_timer = min(threat_timer, threat_threshold)
		if threat_timer >= threat_threshold:
			print("⚠️ SPIRITS ARE HERE!")
		update_threat_ui(false)
	else:
		update_threat_ui(true)

func reset_threat_timer():
	threat_timer = 0.0
	threat_threshold = randf_range(threat_min_time, threat_max_time)
	update_threat_ui(true)

func update_threat_ui(is_safe_zone: bool):
	var alpha = clamp(threat_timer / threat_threshold, 0.0, 1.0)

	# 🔵 both ColorRects update
	if threat_color_rect and threat_color_rect.material:
		threat_color_rect.material.set_shader_parameter("threat_alpha", alpha)
	if threat_color_rect_2 and threat_color_rect_2.material:
		threat_color_rect_2.material.set_shader_parameter("threat_alpha", alpha)

	if threat_label:
		if is_safe_zone:
			threat_label.bbcode_enabled = true
			threat_label.bbcode_text = "[color=white]VERY SAFE[/color]"
			return

		var time_left = threat_threshold - threat_timer
		var label_text := ""
		var color := Color.WHITE
		var shake_rate := 0.0
		var shake_level := 0.0

		if time_left > 20:
			label_text = "VERY SAFE"
			color = Color(1,1,1,1)
		elif time_left > 10:
			label_text = "SAFE"
			color = Color(0.924, 0.713, 0.283, 1.0)
			shake_rate = 3.0
			shake_level = 1.0
		elif time_left > 5:
			label_text = "UNSAFE"
			color = Color(0.904, 0.482, 0.207, 1.0)
			shake_rate = 4.0
			shake_level = 2.0
		elif time_left > 0:
			label_text = "VERY UNSAFE"
			color = Color(0.792, 0.229, 0.17, 1.0)
			shake_rate = 5.0
			shake_level = 3.0
		else:
			label_text = "SPIRITS ARE HERE"
			color = Color(1, 0, 0, 1)
			shake_rate = 15.0
			shake_level = 10.0

		var color_hex = color.to_html()
		threat_label.bbcode_enabled = true
		if shake_rate > 0:
			threat_label.bbcode_text = "[color=%s][shake rate=%f level=%f]%s[/shake][/color]" % [color_hex, shake_rate, shake_level, label_text]
		else:
			threat_label.bbcode_text = "[color=%s]%s[/color]" % [color_hex, label_text]
