extends Node

@export var money : int = 0


# store player stats here e.g. strength


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func add_money(amount : int) -> void:
	money += amount
	
func subtract_money(amount : int) -> void:
	money -= amount

func _on_item_purchase_pressed() -> void:
	add_money(10)
	print(money)
