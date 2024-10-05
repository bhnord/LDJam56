extends Node2D

var base_scale = Vector2(1.0, 1.0)
var pulse_scale = Vector2(1.2, 1.2)
var overshoot_scale = Vector2(0.9, 0.9)
var detection_radius = 200
var current_tween: Tween
var last_intensity = 0.0
var beat_radius: float  # Radius of the central beat sprite

func _ready():
	# Assuming the Sprite2D is circular. Adjust if it's not.
	beat_radius = $Sprite2D.texture.get_width() * scale.x / 2

func _process(delta: float) -> void:
	var intensity = check_for_nearby_beats()
	update_pulse(intensity)

func check_for_nearby_beats() -> float:
	var beats = get_tree().get_nodes_in_group("beats")
	var max_intensity = 0.0
	
	for beat in beats:
		var distance = global_position.distance_to(beat.global_position)
		var adjusted_distance = max(0, distance - beat_radius)  # Subtract the central beat's radius
		var intensity = 1.0 - (adjusted_distance / detection_radius)
		intensity = clamp(intensity, 0.0, 1.0)
		max_intensity = max(max_intensity, intensity)
	
	return max_intensity

func update_pulse(intensity: float):
	if abs(intensity - last_intensity) < 0.05:
		return  # Skip small changes to reduce jitter
	
	last_intensity = intensity
	
	if current_tween:
		current_tween.kill()
	
	if intensity > 0:
		pulse_up(intensity)
	else:
		pulse_down()

func pulse_up(intensity: float):
	var target_scale = base_scale.lerp(pulse_scale, intensity)
	current_tween = create_tween()
	current_tween.tween_property($Sprite2D, "scale", target_scale, 0.05).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CUBIC)

func pulse_down():
	current_tween = create_tween()
	current_tween.tween_property($Sprite2D, "scale", overshoot_scale, 0.02).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_CUBIC)
	current_tween.tween_property($Sprite2D, "scale", base_scale, 0.03).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_ELASTIC)

func pulse_on_beat():
	if current_tween:
		current_tween.kill()
	
	current_tween = create_tween()
	current_tween.tween_property($Sprite2D, "scale", pulse_scale, 0.03).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CUBIC)
	current_tween.tween_property($Sprite2D, "scale", overshoot_scale, 0.03).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_CUBIC)
	current_tween.tween_property($Sprite2D, "scale", base_scale, 0.05).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_ELASTIC)

# Call this if the central beat's size changes during gameplay
func update_beat_radius():
	beat_radius = $Sprite2D.texture.get_width() * scale.x / 2
