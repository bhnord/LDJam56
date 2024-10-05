extends Node2D

# RIGHT NOW 
# This is dealing with two beats at the same time so the hits and mistakes are doubled
# This is not a big deal but just needs to be accounted for when calculating failure

const MIN_SPAWN_INTERVAL = .3;

var beat_scene = preload("res://sprites/Beat.tscn")
var spawn_timer = 0.0
var spawn_interval_timer = 0.0;
var spawn_interval = 1.0;

var spawn_interval_ramp_speed = 10.0;
var current_speed = 200.0

var total_beats = 0;
#Not using a basic score so we can tune line snapping and such
var mistakes = 0;
var hits = 0;


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	spawn_timer += delta;
	spawn_interval_timer += delta; 
	
	if spawn_timer > spawn_interval:
		spawn_beats()
		spawn_timer = 0.0;
	
	if spawn_interval_timer > spawn_interval_ramp_speed:
		print("Ramping up speed")
		spawn_interval = max(spawn_interval - .2, MIN_SPAWN_INTERVAL)
		spawn_interval_timer = 0.0
		
	if Input.is_action_just_pressed("rhythm_key"):
		check_hit()

func spawn_beats():
	total_beats += 2 #TODO This is set to two to justify the double hits and misses issue	
	spawn_beat(true)
	spawn_beat(false)
	
func spawn_beat(left: bool):
	var beat = beat_scene.instantiate()
	beat.position = Vector2(0 if left else get_viewport().size.x, get_viewport_rect().size[1] - 50)
	beat.connect("beat_finished", _on_beat_finished)
	add_child(beat)

func check_hit():
	var center = Vector2(get_viewport_rect().size[0]/2, get_viewport_rect().size[1] - 50) 
	var hit_area = 50  # Adjust this value to change the hit area size
	
	for beat in get_tree().get_nodes_in_group("beats"):
		if beat.position.distance_to(center) < hit_area:
			hits += 1
			beat.queue_free()
			print("HIT")
			#update_score()
			#return
	return
	# If no beat was hit
	mistakes -= 1
	print("MISSED")
	#update_score()

func _on_beat_finished():
	print("MISSED - NO HIT")
	mistakes += 1
	#update_score()
