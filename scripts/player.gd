extends CharacterBody2D

@export var move_speed: float=100

var money = 0
var upgrades = null



const SPEED = 300.0
const JUMP_VELOCITY = -400.0


func _physics_process(delta: float) -> void:
	var input_direction = Vector2(
		Input.get_action_strength("right")-Input.get_action_strength("left"),
		Input.get_action_strength("down")-Input.get_action_strength("up")
	)
	print(input_direction)
	velocity=input_direction*move_speed
	move_and_slide()

func spend(amt:int)->bool:
	if amt > money:
		return false
	money-=amt
	return true
