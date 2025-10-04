extends Node3D

#
func _on_orbproximityarea_3d_body_entered(body: Node3D) -> void:
	pass # Replace with function body.


func _on_orbproximityarea_3d_body_exited(body: Node3D) -> void:
	pass # Replace with function body.

# --- CONFIG ---
@export var threat_min_time: float = 10.0
@export var threat_max_time: float = 30.0
@export var threat_color_rect_path: NodePath
@export var threat_label_path: NodePath

# --- INTERNAL ---
var player: Node3D
var threat_timer: float = 0.0
var threat_threshold: float = 0.0
var threat_color_rect: ColorRect
var threat_label: Label
var in_safe_zone_flag: bool = false

func _ready():
	player = get_node("../Control/SubViewportContainer/SubViewport/Player")
	print("Player node:", player)
	threat_color_rect = get_node(threat_color_rect_path)
	threat_label = get_node(threat_label_path)
	reset_threat_timer()

func _process(delta):
	if not player:
		return

	if not in_safe_zone_flag:
		threat_timer += delta
		threat_timer = min(threat_timer, threat_threshold)
		update_threat_ui(in_safe_zone_flag)

		if threat_timer >= threat_threshold:
			print("⚠️ SPIRITS ARE HERE!")
	else:
		update_threat_ui(in_safe_zone_flag)

# --- SIGNALS ---
func _on_orbproximityarea3d_body_entered(body):
	if body == player:
		in_safe_zone_flag = true
		threat_timer = 0.0
		print("Entered safe zone!")
		update_threat_ui(in_safe_zone_flag)

func _on_orbproximityarea3d_body_exited(body):
	if body == player:
		in_safe_zone_flag = false
		print("Exited safe zone!")

func reset_threat_timer():
	threat_timer = 0.0
	threat_threshold = randf_range(threat_min_time, threat_max_time)
	update_threat_ui(true)

func update_threat_ui(is_safe_zone: bool):
	if threat_color_rect:
		var alpha = clamp(threat_timer / threat_threshold, 0.0, 1.0)
		print("Alpha:", alpha)
		if threat_color_rect.material:
			threat_color_rect.material.set_shader_parameter("threat_alpha", alpha)

	if threat_label:
		if is_safe_zone:
			threat_label.text = "VERY SAFE"
			threat_label.modulate = Color(1,1,1,1)
			return
		var time_left = threat_threshold - threat_timer
		if time_left > 20:
			threat_label.text = "VERY SAFE"
			threat_label.modulate = Color(1,1,1,1)
		elif time_left > 10:
			threat_label.text = "SAFE"
			threat_label.modulate = Color(0.924, 0.713, 0.283, 1.0)
		elif time_left > 5:
			threat_label.text = "UNSAFE"
			threat_label.modulate = Color(0.904, 0.482, 0.207, 1.0)
		elif time_left > 0:
			threat_label.text = "VERY UNSAFE"
			threat_label.modulate = Color(0.792, 0.229, 0.17, 1.0)
		else:
			threat_label.text = "SPIRITS ARE HERE"
			threat_label.modulate = Color(1,0,0,1)

# if threat_label:
#     var t_ratio = threat_timer / threat_threshold
#     if t_ratio <= 0.33:
#         threat_label.text = "VERY SAFE"
#         threat_label.add_color_override("font_color", Color(1.0, 1.0, 1.0, 1.0))
#     elif t_ratio <= 0.66:
#         threat_label.text = "SAFE"
#         threat_label.add_color_override("font_color", Color(0.924, 0.713, 0.283, 1.0))  # yellow-green
#     elif t_ratio <= 0.8:
#         threat_label.text = "UNSAFE"
#         threat_label.add_color_override("font_color", Color(0.904, 0.482, 0.207, 1.0))
#     elif t_ratio <= 0.95:
#         threat_label.text = "VERY UNSAFE"
#         threat_label.add_color_override("font_color", Color(0.792, 0.229, 0.17, 1.0))
#     else:
#         threat_label.text = "SPIRITS ARE HERE"
#         threat_label.add_color_override("font_color", Color(1,0,0))
