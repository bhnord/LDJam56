extends CharacterBody2D
class_name Fish

@export var move_speed: float=100

var money = 0
var upgrades = null
var nearby_hooks: Array[Hook] = []


const SPEED = 300.0
const JUMP_VELOCITY = -400.0


func _physics_process(delta: float) -> void:
	var input_direction = Vector2(
		Input.get_action_strength("right")-Input.get_action_strength("left"),
		Input.get_action_strength("down")-Input.get_action_strength("up")
	)
	velocity=input_direction*move_speed
	move_and_slide()

func _process(_delta):
	if Input.is_action_just_pressed("ui_accept"):
		var hook = nearby_hooks.pop_front()
		if hook:
			hook.interact()
	
	
	
func add_hook(hook:Hook):
	nearby_hooks.push_front(hook)
	
func remove_hook(hook:Hook):
	nearby_hooks.erase(hook)
