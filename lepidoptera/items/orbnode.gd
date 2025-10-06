extends Node3D


@export var orb_proximity_radius: float = 5.0          # safe zone radius
@export var threat_min_time: float = 10.0             # minimum seconds outside safe zone
@export var threat_max_time: float = 30.0             # maximum seconds outside safe zone
@export var orb_area_path: NodePath                   # assign your actual OrbArea3D here
@export var threat_color_rect_path: NodePath          # assign your ColorRect here
@export var threat_label_path: NodePath               # assign your Label here
@export var player_path: NodePath                     # assign Player (CharacterBody3D) inside SubViewport

var player: Node3D
var orb_area: Node3D
var threat_timer: float = 0.0
var threat_threshold: float = 0.0
var threat_color_rect: ColorRect
var threat_label: RichTextLabel
var in_safe_zone_flag: bool = false

func _ready():
	player = get_node(player_path)
	orb_area = get_node(orb_area_path)
	threat_color_rect = get_node(threat_color_rect_path)
	threat_label = get_node(threat_label_path)
	reset_threat_timer()

func _process(delta):
	if not player or not orb_area:
		return

	# distance check from player to actual orb
	var distance = orb_area.global_position.distance_to(player.global_position)
	var is_in_safe = distance < orb_proximity_radius

	# entering/exiting safe zone
	if is_in_safe and not in_safe_zone_flag:
		in_safe_zone_flag = true
		threat_timer = 0.0
		print("Entered safe zone!")

	elif not is_in_safe and in_safe_zone_flag:
		in_safe_zone_flag = false
		print("Exited safe zone!")

	# threat timer + UI updates
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
	if threat_color_rect:
		var alpha = clamp(threat_timer / threat_threshold, 0.0, 1.0)
		if threat_color_rect.material:
			threat_color_rect.material.set_shader_parameter("threat_alpha", alpha)

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
			shake_rate = 5.0
			shake_level = 3.0
		elif time_left > 5:
			label_text = "UNSAFE"
			color = Color(0.904, 0.482, 0.207, 1.0)
			shake_rate = 11.0
			shake_level = 7.0
		elif time_left > 0:
			label_text = "VERY UNSAFE"
			color = Color(0.792, 0.229, 0.17, 1.0)
			shake_rate = 14.0
			shake_level = 13.0
		else:
			label_text = "SPIRITS ARE HERE"
			color = Color(1, 0, 0, 1)
			shake_rate = 17.0
			shake_level = 17.0

		# Apply shake and color
		var color_hex = color.to_html()  # Convert to HTML color code
		if shake_rate > 0:
			threat_label.bbcode_enabled = true
			threat_label.bbcode_text = "[color=%s][shake rate=%f level=%f]%s[/shake][/color]" % [color_hex, shake_rate, shake_level, label_text]
		else:
			threat_label.bbcode_enabled = true
			threat_label.bbcode_text = "[color=%s]%s[/color]" % [color_hex, label_text]
