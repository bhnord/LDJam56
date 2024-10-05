extends Node2D

func _ready() -> void:
	$Booster/BoosterCost.text = "Booster Cost: " + str(get_upgrade_cost(GameManager.booster))
	$ReinforcedMouth/ReinforcedMouthCost.text = "Reinforce Mouth Cost: " + str(get_upgrade_cost(GameManager.mouth))
	$Fins/FinsCost.text = "Fins Cost: " + str(get_upgrade_cost(GameManager.fins))
	$Money.text = str(GameManager.money)

func _on_booster_pressed() -> void:  	
	if GameManager.purchase_item(get_upgrade_cost(GameManager.booster)):
		GameManager.booster += 1
		update_label()
	else:
		$ErrorLabel.text = "Not Enough Money"

func _on_fins_pressed() -> void:
	if GameManager.purchase_item(get_upgrade_cost(GameManager.fins)):
		GameManager.fins += 1
		update_label()
	else:
		$ErrorLabel.text = "Not Enough Money"

func _on_mouth_pressed() -> void:
	if GameManager.purchase_item(get_upgrade_cost(GameManager.mouth)):
		GameManager.mouth += 1
		update_label()
	else:
		$ErrorLabel.text = "Not Enough Money"

func _on_next_day_pressed() -> void:
	pass # Replace with function body.

func get_upgrade_cost(level : int) -> int: 
	return (level + 1) * 10

func update_label() -> void:
	$Money.text = str(GameManager.money)
	$Booster/BoosterCost.text = "Booster Cost: " + str(get_upgrade_cost(GameManager.booster))
	$Fins/FinsCost.text = "Fins Cost: " + str(get_upgrade_cost(GameManager.fins))
	$ReinforcedMouth/ReinforcedMouthCost.text = "Reinforced Mouth Cost: " + str(get_upgrade_cost(GameManager.mouth))
	$ErrorLabel.text = ""
