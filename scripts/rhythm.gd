extends Node2D

# TODO
# BEAT_SPEED_INITIAL - Inital 
# BEAT_SPEED_RAMP_INTERVAL - How often to ramp up the speed
# BEAT_SPEED_MAX

# SPAWN_CHANCE - How often beats spawn
# SPAWN_CHANCE_RAMP_INTERVAL - 
# SPAWN_CHANCE_MAX - 

# PROGRESS BAR - how close you are
const HIT_ZONE_SIZE = 30;


# RIGHT NOW 
# This is dealing with two beats at the same time so the hits and mistakes are doubled
# This is not a big deal but just needs to be accounted for when calculating failure
var beat_scene = preload("res://sprites/Beat.tscn")
var hit_miss_scene = preload("res://scenes/rhythm/HitMissIndicator.tscn")
const MIN_SPAWN_INTERVAL = .5;

var spawn_timer = 0.0
var spawn_interval_timer = 0.0;
var spawn_interval = 1.0;

var spawn_interval_ramp_speed = 10.0;

var total_beats = 0;
#Not using a basic score so we can tune line snapping and such
var mistakes = 0;
var hits = 0;
var central_beat


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	setup_central_beat()
	pass # Replace with function body.

func setup_central_beat():
	central_beat = $CentralBeat
	central_beat.position = Vector2(get_viewport().get_visible_rect().size.x / 2, get_viewport_rect().size[1] - 50)
	central_beat.z_index = 10;
	add_child(central_beat)

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
	beat.init(left)
	beat.position = Vector2(0 if left else get_viewport().size.x, get_viewport_rect().size[1] - 50)
	if left:
		beat.connect("beat_finished", _on_beat_finished)
	add_child(beat)

func clear_nearest_beat():
	get_tree().get_nodes_in_group("beats")[0].queue_free()


func check_hit():
	var center = Vector2(get_viewport_rect().size[0]/2, get_viewport_rect().size[1] - 50) 
	
	var beat_nodes = get_tree().get_nodes_in_group("beats");
	if(beat_nodes.size() == 0):
		spawn_too_early_text()
		mistakes -= 1;
		
		return;
		
	var nearest_beat_indicator = beat_nodes[0]
	#We know this is safe
	var nearest_beat_clone = get_tree().get_nodes_in_group("hidden_beats")[0]
	
	if nearest_beat_indicator.position.distance_to(center) < HIT_ZONE_SIZE:
		hits += 1
		$Fish.position.x -= 10;
		spawn_hit_text()
		print("HIT")
	else:
		mistakes -= 1
		$Fish.position.x += 10;
		#TODO MAKE TOO EARLY
		spawn_too_early_text()
		print("TOO EARLY")
		
	nearest_beat_indicator.queue_free()
	nearest_beat_clone.queue_free()
	#update_score()

func spawn_miss_text():
	var text = hit_miss_scene.instantiate()
	text.init(Vector2(get_viewport_rect().size[0]/2, get_viewport_rect().size[1] - 80), text.HitState.MISS)
	add_child(text)

func spawn_too_early_text():
	var text = hit_miss_scene.instantiate()
	text.init(Vector2(get_viewport_rect().size[0]/2, get_viewport_rect().size[1] - 80), text.HitState.TOO_EARLY)
	add_child(text)

func spawn_hit_text():
	var text = hit_miss_scene.instantiate()
	text.init(Vector2(get_viewport_rect().size[0]/2, get_viewport_rect().size[1] - 80), text.HitState.HIT)
	add_child(text)

func _on_beat_finished():
	print("MISSED")
	$Fish.position.x += 10;
	spawn_miss_text()

	mistakes += 1
	#update_score()
