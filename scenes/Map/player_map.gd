extends CharacterBody2D
class_name MapFish

@export var move_speed = 125.0

var loc_close: MapLocation= null;


func _process(_delta):
	if Input.is_action_just_pressed("ui_accept"):
		print("Accept Command")
		if(loc_close != null):
			print("loc is " + loc_close.name)
			print("Entering Scene")
			loc_close.interact()



func add_hovering(loc: MapLocation):
	remove_hovering(loc)
	loc_close = loc
	loc.handleEntered()

func remove_hovering(loc: MapLocation):
	if(loc == loc_close):
		if(loc_close != null):
			loc_close.handleExited()
		loc_close = null
	
func _physics_process(delta: float) -> void:
	var input_direction = Vector2(
		Input.get_action_strength("right")-Input.get_action_strength("left"),
		Input.get_action_strength("down")-Input.get_action_strength("up")
	)
	velocity=input_direction*move_speed
	move_and_collide(velocity * delta)
