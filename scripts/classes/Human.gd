extends Node
class_name Human

var LEVEL = 1
var WEIGHT:int
var SIZEF: int
var SIZEI: int
var PULL_LVL: int
var WORTH: int

static func create(level:int):
	var instance = Human.new()
	instance.LEVEL = level
	instance.calc_params()
	return instance

func calc_params():
	WEIGHT = randi() % 100 + LEVEL*100 #100lb to 400lb
	SIZEF = randi() % 4 + (LEVEL + 1) #4ft to 8ft
	SIZEI = randi() % 13 #inches
	PULL_LVL = (randi() % GameManager.MAX_LVL+1)
	WORTH = ((randi()%10)+4)*LEVEL
	
	
#if they can't pull in, give 1/4 of money
func pull()->int:
	if GameManager.fins < PULL_LVL:
		GameManager.add_money(int(WORTH/4))
		return int(WORTH/4)
	GameManager.catch_human(self)
	return WORTH
