extends Node2D

func _ready() -> void:
	update_label()

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
	$Booster.text = "Booster " + str(GameManager.booster)
	$Fins.text = "Fins " + str(GameManager.fins)
	$ReinforcedMouth.text = "Reinforced Mouth " + str(GameManager.mouth)
	$Booster/BoosterCost.text = "Booster Cost: " + str(get_upgrade_cost(GameManager.booster))
	$Fins/FinsCost.text = "Fins Cost: " + str(get_upgrade_cost(GameManager.fins))
	$ReinforcedMouth/ReinforcedMouthCost.text = "Reinforced Mouth Cost: " + str(get_upgrade_cost(GameManager.mouth))
	$ErrorLabel.text = ""
