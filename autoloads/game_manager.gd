extends Node

@export var money : int = 0

# store player stats here
@export var booster : int = 0
@export var mouth : int = 0
@export var fins : int = 0
@export var MAX_ENERGY : int = 3
@export var energy : int = MAX_ENERGY

var money_day : int = 0
var humans_caught : Array[Human] = []
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# use these to interact with money
func add_money(amount : int) -> void:
	money += amount
	
func subtract_money(amount : int) -> void:
	money = clamp(money-amount, 0, money)
	
func catch_human(worth: int, human: Human):
	money_day+=worth
	humans_caught.append(human)

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
