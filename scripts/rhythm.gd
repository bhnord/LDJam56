extends Node2D

const GRACE_PERIOD = 2
var elapsed_time = 0;

enum Action {
	HIT,
	MISS,
	TOO_EARLY
}

# TODO
# LOSING SCREEN
# WINNING SCREEN
# BETTER BEAT DETECTION AND GAMEPLAY
# PROGRESS BAR - how close you are
const HIT_ZONE_SIZE = 30;
 
# RIGHT NOW 
# This is dealing with two beats at the same time so the hits and mistakes are doubled
# This is not a big deal but just needs to be accounted for when calculating failure
var beat_scene = preload("res://sprites/Beat.tscn")
var hit_miss_scene = preload("res://scenes/rhythm/HitMissIndicator.tscn")
const MIN_SPAWN_INTERVAL = .5;

var beat_speed_initial

var spawn_beat_timer = 0.0 
var spawn_beat_interval_ramp_timer = 0.0
var beat_speed_interval_ramp_timer = 0.0
var spawn_chance_interval_ramp_timer = 0.0

#Not using a basic score so we can tune line snapping and such
var mistakes = 0;
var hits = 0;

var settings;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	settings = adjust_settings_by_upgrades(GameManager.level_settings)
	$Fish/AnimatedFish.play("default")

#TODO
func adjust_settings_by_upgrades(settings):
	return settings

func _process(delta: float) -> void:
	elapsed_time += delta;
	# This really just ends the game
	$Fish.is_game_over()
	
	handle_beat_spawn(delta)
	handle_beat_spawn_interval_ramp(delta)
	handle_spawn_chance_interval_ramp(delta)
	handle_beat_speed_interval_ramp(delta)
		
	if Input.is_action_just_pressed("rhythm_key"):
		check_hit()

func handle_beat_spawn(delta: float):
	spawn_beat_timer += delta;
	if spawn_beat_timer > settings.beat_spawn_speed:
		if randf() <= settings.spawn_chance:
			spawn_beats();

		spawn_beat_timer = 0.0

func handle_beat_speed_interval_ramp(delta: float):
	beat_speed_interval_ramp_timer += delta;
	if beat_speed_interval_ramp_timer > settings.beat_speed_ramp_interval:
		var new_speed = min(settings.beat_speed + settings.beat_speed_ramp_amount, settings.beat_speed_max);
		beat_speed_interval_ramp_timer = 0.0
		settings.beat_speed = new_speed;

	
func handle_beat_spawn_interval_ramp(delta: float):
	spawn_beat_interval_ramp_timer += delta;
	if spawn_beat_interval_ramp_timer > settings.beat_spawn_speed_ramp_interval:
		var new_spawn_speed = max(settings.beat_spawn_speed - settings.beat_spawn_speed_ramp_amount, settings.beat_spawn_speed_min);
		spawn_beat_interval_ramp_timer = 0.0
		settings.beat_spawn_speed = new_spawn_speed;

func handle_spawn_chance_interval_ramp(delta: float):
	spawn_chance_interval_ramp_timer += delta;
	if spawn_beat_interval_ramp_timer > settings.beat_spawn_speed_ramp_interval:
		var new_spawn_chance = min(settings.spawn_chance - settings.spawn_chance_ramp_amount, settings.spawn_chance_max);
		print("RAMPING SPAWN CHANCE - FROM:", settings.spawn_chance, " TO:", new_spawn_chance)
		settings.spawn_chanced = new_spawn_chance
		spawn_beat_interval_ramp_timer = 0.0
	pass;

func spawn_beats():
	spawn_beat(true)
	spawn_beat(false)
	
func spawn_beat(left: bool):
	var beat = beat_scene.instantiate()
	beat.speed = settings.beat_speed;
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
		handle_action(Action.TOO_EARLY)
		return;
		
	var nearest_beat_indicator = beat_nodes[0]
	#We know this is safe
	var nearest_beat_clone = get_tree().get_nodes_in_group("hidden_beats")[0]
	if nearest_beat_indicator.position.distance_to(center) < HIT_ZONE_SIZE:
		handle_action(Action.HIT)
	else:
		handle_action(Action.TOO_EARLY)
		
	nearest_beat_indicator.queue_free()
	nearest_beat_clone.queue_free()

func _on_beat_finished():
	handle_action(Action.MISS)

func spawn_text(action: Action):
	var text = hit_miss_scene.instantiate()
	
	var hit_state
	#CURSED TOO LAZY TOO DO IT RIGHT
	match action:
		Action.MISS:
			hit_state = text.HitState.MISS
		Action.HIT:
			hit_state = text.HitState.HIT
		Action.TOO_EARLY:
			hit_state = text.HitState.TOO_EARLY
	
	var viewport_size = get_viewport_rect().size
	var spawn_position = Vector2(viewport_size.x / 2, viewport_size.y - 80)
	
	text.init(spawn_position, hit_state)
	add_child(text)

func handle_action(action: Action):
	print(action)
	spawn_text(action)
	match action:
		Action.HIT:
			$Fish.handle_hit()
		Action.MISS, Action.TOO_EARLY:
			if elapsed_time > GRACE_PERIOD:
				$Fish.handle_miss()
