extends Node

@export var money : int = 0

# store player stats here
@export var booster : int = 0
@export var mouth : int = 0
@export var fins : int = 0
@export var MAX_ENERGY : int = 3
@export var energy : int = MAX_ENERGY
var level_settings = {
	# Pixels per second of beat moving
	beat_speed = 200,
	# The max speed
	beat_speed_max = 500,
	# Every x seconds the beat speed will increase
	beat_speed_ramp_interval = 1.0,
	# Beat speed increases by X every ramp cycle
	beat_speed_ramp_amount = 1,


	# Every X seconds a beat will spawn
	beat_spawn_speed =  .5,
	# Every X seconds the beat spawn speed will increase
	beat_spawn_speed_ramp_interval = 10.0,
	# Beat spawn speed increases by X every ramp cycle
	beat_spawn_speed_ramp_amount = .1,
	# The min bound for beats spawned
	beat_spawn_speed_min =  .1,
	
	# Every spawn attempt this is the chance
	spawn_chance = .6,
	#  Inceaase the spawn chance every X seconds
	spawn_chance_ramp_interval = 10.0,
	# Increase the spawn chance by this ammount every ramp cycle
	spawn_chance_ramp_amount = .05,
	# The max spawn chance
	spawn_chance_max = .9,


# BEAT_SPEED_RAMP_INTERVAL - How often to ramp up the speed
# BEAT_SPEED_MAX

# SPAWN_CHANCE - How often beats spawn
# SPAWN_CHANCE_RAMP_INTERVAL - 
# SPAWN_CHANCE_MAX - 
}

var MAX_LVL : int = 5
var human_opponent: Human = null
var money_day : int = 0
var humans_caught : Array[Human] = []
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# use these to interact with money
func add_money(amount : int) -> void:
	money+=amount
	
func subtract_money(amount : int) -> void:
	money = clamp(money-amount, 0, money)
	
func catch_human(human: Human):
	money_day+=human.WORTH
	humans_caught.append(human)


func end_day():
	money += money_day
	money_day = 0
	humans_caught = []

# purchasing upgrades
func purchase_item(cost : int) -> bool:
	var success = false
	if(money - cost >= 0):
		money -= cost
		success = true
	return success

func decrease_energy():
	energy-=1
	if energy <= 0:
		SceneManager.switch_to_scene(SceneManager.Scene.END_OF_DAY)
		
func set_opponent(human: Human):
	self.human_opponent = human
	var level = human.LEVEL
	level_settings = {
		
	# Pixels per second of beat moving
	beat_speed = 300 + (75 * level) - (booster * 15),
	
	# The max speed
	beat_speed_max = 600 + (150 * level) - (booster * 20),
	
	# Every x seconds the beat speed will increase
	beat_speed_ramp_interval = 1.25 + (level * 2) - (booster * .11),
	
	# Beat speed increases by X every ramp cycle
	beat_speed_ramp_amount = 5 - (level * .5),


	# Every X seconds a beat will spawn
	beat_spawn_speed =  .50 - (level * .08) + (fins * .05),
	
	# Every X seconds the beat spawn speed will increase
	beat_spawn_speed_ramp_interval = 10.0 - (level * 2) - (fins * .05),
	
	# Beat spawn speed increases by X every ramp cycle
	beat_spawn_speed_ramp_amount = .009 * level,
	
	# The min bound for beats spawned
	beat_spawn_speed_min =  .1,
	
	
	
	# Every spawn attempt this is the chance
	spawn_chance = .25 + (level * .12) - (fins * .07),
	
	#  Inceaase the spawn chance every X seconds
	spawn_chance_ramp_interval = (10.0 - (level * 1.5)) + booster,
	
	# Increase the spawn chance by this amount every ramp cycle
	spawn_chance_ramp_amount = .05 + (level * .03) - (booster * .01),
	
	# The max spawn chance
	spawn_chance_max = .9,
}
