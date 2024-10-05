extends Node

@export var money : int = 0

# store player stats here e.g. strength
@export var strength : int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func add_money(amount : int) -> void:
	money += amount
	
func subtract_money(amount : int) -> void:
	money = clamp(money-amount, 0, money)
	
func purchase_item(cost : int) -> bool:
	var success = false
	if(money - cost >= 0):
		money -= cost
		success = true
	return success
