extends Node2D

func _ready() -> void:
	$Strength/StrengthCost.text = "Strength Cost: " + str(get_upgrade_cost(GameManager.strength))
	$Money.text = str(GameManager.money)

func _on_strength_pressed() -> void:
	if GameManager.purchase_item(get_upgrade_cost(GameManager.strength)):
		GameManager.strength += 1
		update_label()
	else:
		$ErrorLabel.text = "Not Enough Money"
	
func update_label() -> void:
	$Money.text = str(GameManager.money)
	$Strength/StrengthCost.text = "Strength Cost: " + str(get_upgrade_cost(GameManager.strength))
	$ErrorLabel.text = ""

func _on_third_more_sinister_thing_pressed() -> void:
	pass # Replace with function body.

func _on_agility_pressed() -> void:
	pass # Replace with function body.

func _on_next_day_pressed() -> void:
	pass # Replace with function body.

func get_upgrade_cost(level : int) -> int: 
	return (level + 1) * 10
