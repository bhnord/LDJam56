extends Node2D

func _ready() -> void:
	pass

func _process(delta):
	pass

func _on_strength_pressed() -> void:
	GameManager.subtract_money(10)
	update_label()
	
func update_label() -> void:
	$Money.text = str(GameManager.money)
