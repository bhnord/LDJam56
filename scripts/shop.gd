extends Node2D

func _ready() -> void:
	$Strength/StrengthCost.text = "Strength Cost: " + str(update_cost(GameManager.strength))

func _on_strength_pressed() -> void:
	GameManager.subtract_money(10 * GameManager.strength)
	GameManager.strength += 1
	update_label()
	
func update_label() -> void:
	$Money.text = str(GameManager.money)
	$Strength/StrengthCost.text = "Strength Cost: " + str(update_cost(GameManager.strength))

func _on_third_more_sinister_thing_pressed() -> void:
	pass # Replace with function body.


func _on_agility_pressed() -> void:
	pass # Replace with function body.

func update_cost(level : int) -> int: 
	return (level + 1) * 10
