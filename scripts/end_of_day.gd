extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$HumansCaught.text = "You Caught " + str(len(GameManager.humans_caught)) + " Humans"
	$MoneyEarned.text = "Gained $" + str(GameManager.money_day)

func _on_button_pressed() -> void:
	SceneManager.switch_to_scene(SceneManager.Scene.SHOP)
