extends Node

@export var money : int = 0

# store player stats here
@export var booster : int = 0
@export var mouth : int = 0
@export var fins : int = 0
@export var MAX_ENERGY : int = 3
@export var energy : int = MAX_ENERGY
var level_settings = {
	beat_spawn_speed =  1.0,
	beat_spawn_speed_ramp_interval = 10.0,
	beat_spawn_speed_ramp_amount = .1,
	beat_spawn_speed_min =  .3,
	
	spawn_chance = .6,
	spawn_chance_ramp_interval = 10.0,
	spawn_chance_ramp_amount = .05,
	spawn_chance_max = .9,


# BEAT_SPEED_RAMP_INTERVAL - How often to ramp up the speed
# BEAT_SPEED_MAX

# SPAWN_CHANCE - How often beats spawn
# SPAWN_CHANCE_RAMP_INTERVAL - 
# SPAWN_CHANCE_MAX - 
}

var MAX_LVL : int = 5

var money_day : int = 0
var humans_caught : Array[Human] = []
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# use these to interact with money
func add_money(amount : int) -> void:
	money_day+=amount
	
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
