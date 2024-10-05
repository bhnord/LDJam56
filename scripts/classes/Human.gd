extends Node
class_name Human

var WEIGHT:int = randi()%300 + 100 #100lb to 400lb
var SIZEF: int = randi() % 4 + 4 #4ft to 8ft
var SIZEI: int = randi() % 13 #inches
var PULL_LVL: int = randi() % GameManager.MAX_LVL+1
var WORTH: int = (WEIGHT+(SIZEF*10))*PULL_LVL / 100

#if they can't pull in, give 1/4 of money
func pull()->int:
	if GameManager.fins < PULL_LVL:
		GameManager.add_money(int(WORTH/4))
		return int(WORTH/4)
	GameManager.catch_human(self)
	return WORTH
		
